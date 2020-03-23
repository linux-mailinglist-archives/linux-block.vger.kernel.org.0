Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 142A518F207
	for <lists+linux-block@lfdr.de>; Mon, 23 Mar 2020 10:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgCWJmF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 23 Mar 2020 05:42:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:40872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbgCWJmF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 05:42:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4DA39AC1D;
        Mon, 23 Mar 2020 09:42:02 +0000 (UTC)
Subject: Re: [PATCH 4/7] bcache: make bch_sectors_dirty_init() to be
 multithreaded
To:     Hannes Reinecke <hare@suse.de>
Cc:     axboe@kernel.dk, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20200322060305.70637-1-colyli@suse.de>
 <20200322060305.70637-5-colyli@suse.de>
 <22475f5c-e8da-f59e-6be5-cd74f04b8216@suse.de>
From:   Coly Li <colyli@suse.de>
Organization: SUSE Labs
Message-ID: <9b6fa5c6-22a9-c4b6-413a-d62260cb3789@suse.de>
Date:   Mon, 23 Mar 2020 17:41:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <22475f5c-e8da-f59e-6be5-cd74f04b8216@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/3/23 3:03 下午, Hannes Reinecke wrote:
> On 3/22/20 7:03 AM, Coly Li wrote:
>> When attaching a cached device (a.k.a backing device) to a cache
>> device, bch_sectors_dirty_init() is called to count dirty sectors
>> and stripes (see what bcache_dev_sectors_dirty_add() does) on the
>> cache device.
>>
>> The counting is done by a single thread recursive function
>> bch_btree_map_keys() to iterate all the bcache btree nodes.
>> If the btree has huge number of nodes, bch_sectors_dirty_init() will
>> take quite long time. In my testing, if the registering cache set has
>> a existed UUID which matches a already registered cached device, the
>> automatical attachment during the registration may take more than
>> 55 minutes. This is too long for waiting the bcache to work in real
>> deployment.
>>
>> Fortunately when bch_sectors_dirty_init() is called, no other thread
>> will access the btree yet, it is safe to do a read-only parallelized
>> dirty sectors counting by multiple threads.
>>
>> This patch tries to create multiple threads, and each thread tries to
>> one-by-one count dirty sectors from the sub-tree indexed by a root
>> node key which the thread fetched. After the sub-tree is counted, the
>> counting thread will continue to fetch another root node key, until
>> the fetched key is NULL. How many threads in parallel depends on
>> the number of keys from the btree root node, and the number of online
>> CPU core. The thread number will be the less number but no more than
>> BCH_DIRTY_INIT_THRD_MAX. If there are only 2 keys in root node, it
>> can only be 2x times faster by this patch. But if there are 10 keys
>> in the root node, with this patch it can be 10x times faster.
>>
>> Signed-off-by: Coly Li <colyli@suse.de>
>> Cc: Christoph Hellwig <hch@infradead.org>
>> ---
>>   drivers/md/bcache/writeback.c | 158 +++++++++++++++++++++++++++++++++-
>>   drivers/md/bcache/writeback.h |  19 ++++
>>   2 files changed, 174 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/md/bcache/writeback.c
>> b/drivers/md/bcache/writeback.c
>> index 4a40f9eadeaf..6673a37c8bd2 100644
>> --- a/drivers/md/bcache/writeback.c
>> +++ b/drivers/md/bcache/writeback.c
>> @@ -785,7 +785,9 @@ static int sectors_dirty_init_fn(struct btree_op
>> *_op, struct btree *b,
>>       return MAP_CONTINUE;
>>   }
>>   -void bch_sectors_dirty_init(struct bcache_device *d)
>> +static int bch_root_node_dirty_init(struct cache_set *c,
>> +                     struct bcache_device *d,
>> +                     struct bkey *k)
>>   {
>>       struct sectors_dirty_init op;
>>       int ret;
>> @@ -796,8 +798,13 @@ void bch_sectors_dirty_init(struct bcache_device *d)
>>       op.start = KEY(op.inode, 0, 0);
>>         do {
>> -        ret = bch_btree_map_keys(&op.op, d->c, &op.start,
>> -                     sectors_dirty_init_fn, 0);
>> +        ret = bcache_btree(map_keys_recurse,
>> +                   k,
>> +                   c->root,
>> +                   &op.op,
>> +                   &op.start,
>> +                   sectors_dirty_init_fn,
>> +                   0);
>>           if (ret == -EAGAIN)
>>               schedule_timeout_interruptible(
>>                   msecs_to_jiffies(INIT_KEYS_SLEEP_MS));
>> @@ -806,6 +813,151 @@ void bch_sectors_dirty_init(struct bcache_device
>> *d)
>>               break;
>>           }
>>       } while (ret == -EAGAIN);
>> +
>> +    return ret;
>> +}
>> +
>> +static int bch_dirty_init_thread(void *arg)
>> +{
>> +    struct dirty_init_thrd_info *info = arg;
>> +    struct bch_dirty_init_state *state = info->state;
>> +    struct cache_set *c = state->c;
>> +    struct btree_iter iter;
>> +    struct bkey *k, *p;
>> +    int cur_idx, prev_idx, skip_nr;
>> +    int i;
>> +
>> +    k = p = NULL;
>> +    i = 0;
>> +    cur_idx = prev_idx = 0;
>> +
>> +    bch_btree_iter_init(&c->root->keys, &iter, NULL);
>> +    k = bch_btree_iter_next_filter(&iter, &c->root->keys, bch_ptr_bad);
>> +    BUG_ON(!k);
>> +
>> +    p = k;
>> +
>> +    while (k) {
>> +        spin_lock(&state->idx_lock);
>> +        cur_idx = state->key_idx;
>> +        state->key_idx++;
>> +        spin_unlock(&state->idx_lock);
>> +
>> +        skip_nr = cur_idx - prev_idx;
>> +
>> +        while (skip_nr) {
>> +            k = bch_btree_iter_next_filter(&iter,
>> +                               &c->root->keys,
>> +                               bch_ptr_bad);
>> +            if (k)
>> +                p = k;
>> +            else {
>> +                atomic_set(&state->enough, 1);
>> +                /* Update state->enough earlier */
>> +                smp_mb();
>> +                goto out;
>> +            }
>> +            skip_nr--;
>> +            cond_resched();
>> +        }
>> +
>> +        if (p) {
>> +            if (bch_root_node_dirty_init(c, state->d, p) < 0)
>> +                goto out;
>> +        }
>> +
>> +        p = NULL;
>> +        prev_idx = cur_idx;
>> +        cond_resched();
>> +    }
>> +
>> +out:
>> +    /* In order to wake up state->wait in time */
>> +    smp_mb();
>> +    if (atomic_dec_and_test(&state->started))
>> +        wake_up(&state->wait);
>> +
>> +    return 0;
>> +}
>> +
>> +static int bch_btre_dirty_init_thread_nr(void)
>> +{
>> +    int n = num_online_cpus()/2;
>> +
>> +    if (n == 0)
>> +        n = 1;
>> +    else if (n > BCH_DIRTY_INIT_THRD_MAX)
>> +        n = BCH_DIRTY_INIT_THRD_MAX;
>> +
>> +    return n;
>> +}
>> +
>> +void bch_sectors_dirty_init(struct bcache_device *d)
>> +{
>> +    int i;
>> +    struct bkey *k = NULL;
>> +    struct btree_iter iter;
>> +    struct sectors_dirty_init op;
>> +    struct cache_set *c = d->c;
>> +    struct bch_dirty_init_state *state;
>> +    char name[32];
>> +
>> +    /* Just count root keys if no leaf node */
>> +    if (c->root->level == 0) {
>> +        bch_btree_op_init(&op.op, -1);
>> +        op.inode = d->id;
>> +        op.count = 0;
>> +        op.start = KEY(op.inode, 0, 0);
>> +
>> +        for_each_key_filter(&c->root->keys,
>> +                    k, &iter, bch_ptr_invalid)
>> +            sectors_dirty_init_fn(&op.op, c->root, k);
>> +        return;
>> +    }
>> +
>> +    state = kzalloc(sizeof(struct bch_dirty_init_state), GFP_KERNEL);
>> +    if (!state) {
>> +        pr_warn("sectors dirty init failed: cannot allocate memory");
>> +        return;
>> +    }
>> +
>> +    state->c = c;
>> +    state->d = d;
>> +    state->total_threads = bch_btre_dirty_init_thread_nr();
>> +    state->key_idx = 0;
>> +    spin_lock_init(&state->idx_lock);
>> +    atomic_set(&state->started, 0);
>> +    atomic_set(&state->enough, 0);
>> +    init_waitqueue_head(&state->wait);
>> +
>> +    for (i = 0; i < state->total_threads; i++) {
>> +        /* Fetch latest state->enough earlier */
>> +        smp_mb();
>> +        if (atomic_read(&state->enough))
>> +            break;
>> +
>> +        state->infos[i].state = state;
>> +        atomic_inc(&state->started);
>> +        snprintf(name, sizeof(name), "bch_dirty_init[%d]", i);
>> +
>> +        state->infos[i].thread =
>> +            kthread_run(bch_dirty_init_thread,
>> +                    &state->infos[i],
>> +                    name);
>> +        if (IS_ERR(state->infos[i].thread)) {
>> +            pr_err("fails to run thread bch_dirty_init[%d]", i);
>> +            for (--i; i >= 0; i--)
>> +                kthread_stop(state->infos[i].thread);
>> +            goto out;
>> +        }
>> +    }
>> +
>> +    wait_event_interruptible(state->wait,
>> +         atomic_read(&state->started) == 0 ||
>> +         test_bit(CACHE_SET_IO_DISABLE, &c->flags));
>> +
>> +out:
>> +    kfree(state);
>>   }
>>     void bch_cached_dev_writeback_init(struct cached_dev *dc)
>> diff --git a/drivers/md/bcache/writeback.h
>> b/drivers/md/bcache/writeback.h
>> index 4e4c6810dc3c..b029843ce5b6 100644
>> --- a/drivers/md/bcache/writeback.h
>> +++ b/drivers/md/bcache/writeback.h
>> @@ -16,6 +16,7 @@
>>     #define BCH_AUTO_GC_DIRTY_THRESHOLD    50
>>   +#define BCH_DIRTY_INIT_THRD_MAX    64
>>   /*
>>    * 14 (16384ths) is chosen here as something that each backing device
>>    * should be a reasonable fraction of the share, and not to blow up
>> @@ -23,6 +24,24 @@
>>    */
>>   #define WRITEBACK_SHARE_SHIFT   14
>>   +struct bch_dirty_init_state;
>> +struct dirty_init_thrd_info {
>> +    struct bch_dirty_init_state    *state;
>> +    struct task_struct        *thread;
>> +};
>> +
>> +struct bch_dirty_init_state {
>> +    struct cache_set        *c;
>> +    struct bcache_device        *d;
>> +    int                total_threads;
>> +    int                key_idx;
>> +    spinlock_t            idx_lock;
>> +    atomic_t            started;
>> +    atomic_t            enough;
>> +    wait_queue_head_t        wait;
>> +    struct dirty_init_thrd_info    infos[BCH_DIRTY_INIT_THRD_MAX];
>> +};
>> +
>>   static inline uint64_t bcache_dev_sectors_dirty(struct bcache_device
>> *d)
>>   {
>>       uint64_t i, ret = 0;
>>

Hi Hannes,

> Same here; why not workqueues?

The major reason is, there are too many kworkers already. I am not able
to tell which one is working the btree nodes checking. And there is no
difference between kthread and workqueue for this condition.

> You could even be extra sneaky and have a workqueue element per node.
> Then you would not descend into the leaf nodes, but rather call the
> workqueue element for the leaf node.
> That way you get automatic parallelism...

I though about kworker, but it cannot be that ideal parallelism. The
whole btree check only happens in bcache registration time, and it is in
strong order from parent node to children nodes. It means if the parent
node is corrupted, its unreliable children node won't be checked.

The only chance is to check sub-tree indexed by each root node element
in parallel, and in each sub-tree, the checking is still in depth-first
order.

In this case, no difference between kworker queue or kthread.

Thanks.
-- 

Coly Li
