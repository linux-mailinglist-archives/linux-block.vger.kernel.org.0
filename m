Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A738E3B13DE
	for <lists+linux-block@lfdr.de>; Wed, 23 Jun 2021 08:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhFWGVi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 23 Jun 2021 02:21:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43480 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFWGVg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 02:21:36 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D5A8B2196E;
        Wed, 23 Jun 2021 06:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624429157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/42xBs/G3bxh3z2V7vWAXTx1dKTcLG9xw0URWP4c2U=;
        b=QGjdD16i7qJ6BHXWYbSyxpHxQMjoLD2hWwivXEAur7m0X2lS2Bpg+QwHTgMt7rLkX987jD
        WSo9hGkk6W9TbsEHXvS5U+DQIkPAj2U0ERmnhSTcn2hi/ePRAsjXYZJxWqhhuVpiXKvoQe
        EC/zEckdmBNLGAB/FMkSoeFTk5/QQLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624429157;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/42xBs/G3bxh3z2V7vWAXTx1dKTcLG9xw0URWP4c2U=;
        b=Q5u2Sbonz/eMLv2mur0pmNj80OjpBe17ZSVsMOan97WAXb3kH3BclluAB2J39yAmSg6ncM
        ybNlzYBihAsQU9BQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 970B211A97;
        Wed, 23 Jun 2021 06:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624429157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/42xBs/G3bxh3z2V7vWAXTx1dKTcLG9xw0URWP4c2U=;
        b=QGjdD16i7qJ6BHXWYbSyxpHxQMjoLD2hWwivXEAur7m0X2lS2Bpg+QwHTgMt7rLkX987jD
        WSo9hGkk6W9TbsEHXvS5U+DQIkPAj2U0ERmnhSTcn2hi/ePRAsjXYZJxWqhhuVpiXKvoQe
        EC/zEckdmBNLGAB/FMkSoeFTk5/QQLM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624429157;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/42xBs/G3bxh3z2V7vWAXTx1dKTcLG9xw0URWP4c2U=;
        b=Q5u2Sbonz/eMLv2mur0pmNj80OjpBe17ZSVsMOan97WAXb3kH3BclluAB2J39yAmSg6ncM
        ybNlzYBihAsQU9BQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id n/3nGGTS0mCzYgAALh3uQQ
        (envelope-from <colyli@suse.de>); Wed, 23 Jun 2021 06:19:16 +0000
Subject: Re: [PATCH 12/14] bcache: support storing bcache journal into NVDIMM
 meta device
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-bcache@vger.kernel.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, Jianpeng Ma <jianpeng.ma@intel.com>,
        Qiaowei Ren <qiaowei.ren@intel.com>
References: <20210615054921.101421-1-colyli@suse.de>
 <20210615054921.101421-13-colyli@suse.de>
 <e27c6d67-7085-ec35-7ad4-f391ac5a2454@suse.de>
From:   Coly Li <colyli@suse.de>
Message-ID: <9c8436c8-a367-c35d-5700-e17aafc2a125@suse.de>
Date:   Wed, 23 Jun 2021 14:19:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e27c6d67-7085-ec35-7ad4-f391ac5a2454@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/22/21 7:03 PM, Hannes Reinecke wrote:
> On 6/15/21 7:49 AM, Coly Li wrote:
>> This patch implements two methods to store bcache journal to,
>> 1) __journal_write_unlocked() for block interface device
>>    The latency method to compose bio and issue the jset bio to cache
>>    device (e.g. SSD). c->journal.key.ptr[0] indicates the LBA on cache
>>    device to store the journal jset.
>> 2) __journal_nvdimm_write_unlocked() for memory interface NVDIMM
>>    Use memory interface to access NVDIMM pages and store the jset by
>>    memcpy_flushcache(). c->journal.key.ptr[0] indicates the linear
>>    address from the NVDIMM pages to store the journal jset.
>>
>> For lagency configuration without NVDIMM meta device, journal I/O is
> legacy?
>
>> handled by __journal_write_unlocked() with existing code logic. If the
>> NVDIMM meta device is used (by bcache-tools), the journal I/O will
>> be handled by __journal_nvdimm_write_unlocked() and go into the NVDIMM
>> pages.
>>
>> And when NVDIMM meta device is used, sb.d[] stores the linear addresses
>> from NVDIMM pages (no more bucket index), in journal_reclaim() the
>> journaling location in c->journal.key.ptr[0] should also be updated by
>> linear address from NVDIMM pages (no more LBA combined by sectors offset
>> and bucket index).
>>
>> Signed-off-by: Coly Li <colyli@suse.de>
>> Cc: Jianpeng Ma <jianpeng.ma@intel.com>
>> Cc: Qiaowei Ren <qiaowei.ren@intel.com>
>> ---
>>  drivers/md/bcache/journal.c   | 119 ++++++++++++++++++++++++----------
>>  drivers/md/bcache/nvm-pages.h |   1 +
>>  drivers/md/bcache/super.c     |  28 +++++++-
>>  3 files changed, 110 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
>> index 32599d2ff5d2..03ecedf813b0 100644
>> --- a/drivers/md/bcache/journal.c
>> +++ b/drivers/md/bcache/journal.c
>> @@ -596,6 +596,8 @@ static void do_journal_discard(struct cache *ca)
>>  		return;
>>  	}
>>  
>> +	BUG_ON(bch_has_feature_nvdimm_meta(&ca->sb));
>> +
>>  	switch (atomic_read(&ja->discard_in_flight)) {
>>  	case DISCARD_IN_FLIGHT:
>>  		return;
>> @@ -661,9 +663,13 @@ static void journal_reclaim(struct cache_set *c)
>>  		goto out;
>>  
>>  	ja->cur_idx = next;
>> -	k->ptr[0] = MAKE_PTR(0,
>> -			     bucket_to_sector(c, ca->sb.d[ja->cur_idx]),
>> -			     ca->sb.nr_this_dev);
>> +	if (!bch_has_feature_nvdimm_meta(&ca->sb))
>> +		k->ptr[0] = MAKE_PTR(0,
>> +			bucket_to_sector(c, ca->sb.d[ja->cur_idx]),
>> +			ca->sb.nr_this_dev);
>> +	else
>> +		k->ptr[0] = ca->sb.d[ja->cur_idx];
>> +
>>  	atomic_long_inc(&c->reclaimed_journal_buckets);
>>  
>>  	bkey_init(k);
>> @@ -729,46 +735,21 @@ static void journal_write_unlock(struct closure *cl)
>>  	spin_unlock(&c->journal.lock);
>>  }
>>  
>> -static void journal_write_unlocked(struct closure *cl)
>> +
>> +static void __journal_write_unlocked(struct cache_set *c)
>>  	__releases(c->journal.lock)
>>  {
>> -	struct cache_set *c = container_of(cl, struct cache_set, journal.io);
>> -	struct cache *ca = c->cache;
>> -	struct journal_write *w = c->journal.cur;
>>  	struct bkey *k = &c->journal.key;
>> -	unsigned int i, sectors = set_blocks(w->data, block_bytes(ca)) *
>> -		ca->sb.block_size;
>> -
>> +	struct journal_write *w = c->journal.cur;
>> +	struct closure *cl = &c->journal.io;
>> +	struct cache *ca = c->cache;
>>  	struct bio *bio;
>>  	struct bio_list list;
>> +	unsigned int i, sectors = set_blocks(w->data, block_bytes(ca)) *
>> +		ca->sb.block_size;
>>  
>>  	bio_list_init(&list);
>>  
>> -	if (!w->need_write) {
>> -		closure_return_with_destructor(cl, journal_write_unlock);
>> -		return;
>> -	} else if (journal_full(&c->journal)) {
>> -		journal_reclaim(c);
>> -		spin_unlock(&c->journal.lock);
>> -
>> -		btree_flush_write(c);
>> -		continue_at(cl, journal_write, bch_journal_wq);
>> -		return;
>> -	}
>> -
>> -	c->journal.blocks_free -= set_blocks(w->data, block_bytes(ca));
>> -
>> -	w->data->btree_level = c->root->level;
>> -
>> -	bkey_copy(&w->data->btree_root, &c->root->key);
>> -	bkey_copy(&w->data->uuid_bucket, &c->uuid_bucket);
>> -
>> -	w->data->prio_bucket[ca->sb.nr_this_dev] = ca->prio_buckets[0];
>> -	w->data->magic		= jset_magic(&ca->sb);
>> -	w->data->version	= BCACHE_JSET_VERSION;
>> -	w->data->last_seq	= last_seq(&c->journal);
>> -	w->data->csum		= csum_set(w->data);
>> -
>>  	for (i = 0; i < KEY_PTRS(k); i++) {
>>  		ca = c->cache;
>>  		bio = &ca->journal.bio;
>> @@ -793,7 +774,6 @@ static void journal_write_unlocked(struct closure *cl)
>>  
>>  		ca->journal.seq[ca->journal.cur_idx] = w->data->seq;
>>  	}
>> -
>>  	/* If KEY_PTRS(k) == 0, this jset gets lost in air */
>>  	BUG_ON(i == 0);
>>  
>> @@ -805,6 +785,73 @@ static void journal_write_unlocked(struct closure *cl)
>>  
>>  	while ((bio = bio_list_pop(&list)))
>>  		closure_bio_submit(c, bio, cl);
>> +}
>> +
>> +#if defined(CONFIG_BCACHE_NVM_PAGES)
>> +
>> +static void __journal_nvdimm_write_unlocked(struct cache_set *c)
>> +	__releases(c->journal.lock)
>> +{
>> +	struct journal_write *w = c->journal.cur;
>> +	struct cache *ca = c->cache;
>> +	unsigned int sectors;
>> +
>> +	sectors = set_blocks(w->data, block_bytes(ca)) * ca->sb.block_size;
>> +	atomic_long_add(sectors, &ca->meta_sectors_written);
>> +
>> +	memcpy_flushcache((void *)c->journal.key.ptr[0], w->data, sectors << 9);
>> +
>> +	c->journal.key.ptr[0] += sectors << 9;
>> +	ca->journal.seq[ca->journal.cur_idx] = w->data->seq;
>> +
>> +	atomic_dec_bug(&fifo_back(&c->journal.pin));
>> +	bch_journal_next(&c->journal);
>> +	journal_reclaim(c);
>> +
>> +	spin_unlock(&c->journal.lock);
>> +}
>> +
>> +#else /* CONFIG_BCACHE_NVM_PAGES */
>> +
>> +static void __journal_nvdimm_write_unlocked(struct cache_set *c) { }
>> +
>> +#endif /* CONFIG_BCACHE_NVM_PAGES */
>> +
>> +static void journal_write_unlocked(struct closure *cl)
>> +{
>> +	struct cache_set *c = container_of(cl, struct cache_set, journal.io);
>> +	struct cache *ca = c->cache;
>> +	struct journal_write *w = c->journal.cur;
>> +
>> +	if (!w->need_write) {
>> +		closure_return_with_destructor(cl, journal_write_unlock);
>> +		return;
>> +	} else if (journal_full(&c->journal)) {
>> +		journal_reclaim(c);
>> +		spin_unlock(&c->journal.lock);
>> +
>> +		btree_flush_write(c);
>> +		continue_at(cl, journal_write, bch_journal_wq);
>> +		return;
>> +	}
>> +
>> +	c->journal.blocks_free -= set_blocks(w->data, block_bytes(ca));
>> +
>> +	w->data->btree_level = c->root->level;
>> +
>> +	bkey_copy(&w->data->btree_root, &c->root->key);
>> +	bkey_copy(&w->data->uuid_bucket, &c->uuid_bucket);
>> +
>> +	w->data->prio_bucket[ca->sb.nr_this_dev] = ca->prio_buckets[0];
>> +	w->data->magic		= jset_magic(&ca->sb);
>> +	w->data->version	= BCACHE_JSET_VERSION;
>> +	w->data->last_seq	= last_seq(&c->journal);
>> +	w->data->csum		= csum_set(w->data);
>> +
>> +	if (!bch_has_feature_nvdimm_meta(&ca->sb))
>> +		__journal_write_unlocked(c);
>> +	else
>> +		__journal_nvdimm_write_unlocked(c);
>>  
>>  	continue_at(cl, journal_write_done, NULL);
>>  }
>> diff --git a/drivers/md/bcache/nvm-pages.h b/drivers/md/bcache/nvm-pages.h
>> index c763bf2e2721..736a661777b7 100644
>> --- a/drivers/md/bcache/nvm-pages.h
>> +++ b/drivers/md/bcache/nvm-pages.h
>> @@ -5,6 +5,7 @@
>>  
>>  #if defined(CONFIG_BCACHE_NVM_PAGES)
>>  #include <linux/bcache-nvm.h>
>> +#include <linux/libnvdimm.h>
>>  #endif /* CONFIG_BCACHE_NVM_PAGES */
>>  
>>  /*
>> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
>> index cce0f6bf0944..4d6666d03aa7 100644
>> --- a/drivers/md/bcache/super.c
>> +++ b/drivers/md/bcache/super.c
>> @@ -1686,7 +1686,32 @@ void bch_cache_set_release(struct kobject *kobj)
>>  static void cache_set_free(struct closure *cl)
>>  {
>>  	struct cache_set *c = container_of(cl, struct cache_set, cl);
>> -	struct cache *ca;
>> +	struct cache *ca = c->cache;
>> +
>> +#if defined(CONFIG_BCACHE_NVM_PAGES)
>> +	/* Flush cache if journal stored in NVDIMM */
>> +	if (ca && bch_has_feature_nvdimm_meta(&ca->sb)) {
>> +		unsigned long bucket_size = ca->sb.bucket_size;
>> +		int i;
>> +
>> +		for (i = 0; i < ca->sb.keys; i++) {
>> +			unsigned long offset = 0;
>> +			unsigned int len = round_down(UINT_MAX, 2);
>> +
>> +			if ((void *)ca->sb.d[i] == NULL)
>> +				continue;
>> +
>> +			while (bucket_size > 0) {
>> +				if (len > bucket_size)
>> +					len = bucket_size;
>> +				arch_invalidate_pmem(
>> +					(void *)(ca->sb.d[i] + offset), len);
>> +				offset += len;
>> +				bucket_size -= len;
>> +			}
>> +		}
>> +	}
>> +#endif /* CONFIG_BCACHE_NVM_PAGES */
>>  
>>  	debugfs_remove(c->debug);
>>  
>> @@ -1698,7 +1723,6 @@ static void cache_set_free(struct closure *cl)
>>  	bch_bset_sort_state_free(&c->sort);
>>  	free_pages((unsigned long) c->uuids, ilog2(meta_bucket_pages(&c->cache->sb)));
>>  
>> -	ca = c->cache;
>>  	if (ca) {
>>  		ca->set = NULL;
>>  		c->cache = NULL;
>>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Thanks for your review.

Coly Li
