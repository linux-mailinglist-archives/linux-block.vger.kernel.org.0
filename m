Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991266C88A1
	for <lists+linux-block@lfdr.de>; Fri, 24 Mar 2023 23:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjCXWyE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 24 Mar 2023 18:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjCXWyD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2023 18:54:03 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0949A7AB9
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 15:53:15 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id jl13so2640197qvb.10
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 15:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679698394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2MpDxOY5RTaPCS6YUqDqZGPOq9SUUHMYR88rSvDxb0=;
        b=ecdooQnHvKERoorgmzEy6YkYxF+wIUWiJfq1bD+RwTKs2eBYVvlm+dENsB8qoEK4K5
         /GDCM9o4/hXt8io/TfjIDBPAcXnPTKyy95uP4jHWr64bpmR3stIB3GJRymlzzEm8Wy9I
         OYaj26xjQh+9qM8Xqj5v1jlOWIkA/JqNXy4RX9iyp1T8SHTM+ueKIlo6FI9lkug+Crew
         QrbxnUDMCZWj2oGXBq1f49pMhpnsAPgcpozkt8DUkDSwRg8OY+AeKltTGNJbuaiH6XyB
         XbxL17/tPDxf3xicYkxNbIt6wTfFufLskOWjl+9om/6JGw0H7jN5HLTZpjolYf73Cxeo
         +39Q==
X-Gm-Message-State: AO0yUKV3ch+iuYD13Xm1JDoTMW1bMG5mzpi7VpvVk3LyZvZE2XTLR94k
        CR5m62q4ymiItk06HW/GyCuWVcYvhMg03xjd7BDP
X-Google-Smtp-Source: AK7set/iYYymePQwRI7TQ++q8v7dFgzltOarcjA35d7r8ahvMsODuUaCYQTHnnEAWIN7XZcX+qpovw==
X-Received: by 2002:a05:6214:509c:b0:56f:8b5:3e94 with SMTP id kk28-20020a056214509c00b0056f08b53e94mr16097821qvb.14.1679698394092;
        Fri, 24 Mar 2023 15:53:14 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id w3-20020a056214012300b005dd8b9345f3sm1027541qvs.139.2023.03.24.15.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 15:53:13 -0700 (PDT)
Date:   Fri, 24 Mar 2023 18:53:12 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, ebiggers@kernel.org, keescook@chromium.org,
        heinzm@redhat.com, nhuck@google.com, linux-block@vger.kernel.org,
        ejt@redhat.com, mpatocka@redhat.com, luomeng12@huawei.com
Subject: Re: [dm-6.4 PATCH v2 3/9] dm bufio: improve concurrent IO performance
Message-ID: <ZB4p2NfwIhh9raxa@redhat.com>
References: <20230324175656.85082-1-snitzer@kernel.org>
 <20230324175656.85082-4-snitzer@kernel.org>
 <a1b8ceb8-0a67-86a1-2222-1625f6ebbe33@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1b8ceb8-0a67-86a1-2222-1625f6ebbe33@kernel.dk>
X-Spam-Status: No, score=0.3 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 24 2023 at  3:34P -0400,
Jens Axboe <axboe@kernel.dk> wrote:

> Just some random drive-by comments.
> 
> > diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
> > index 1de1bdcda1ce..a58f8ac3ba75 100644
> > --- a/drivers/md/dm-bufio.c
> > +++ b/drivers/md/dm-bufio.c
> > +static void lru_destroy(struct lru *lru)
> > +{
> > +	BUG_ON(lru->cursor);
> > +	BUG_ON(!list_empty(&lru->iterators));
> > +}
> 
> Ehm no, WARN_ON_ONCE() for these presumably.

Yeah, I raised concern about the BUG_ONs with Joe. Will try to rid the
code of BUG_ONs as follow-on work.
 
> > @@ -116,9 +366,579 @@ struct dm_buffer {
> >  #endif
> >  };
> >  
> > +/*--------------------------------------------------------------*/
> > +
> > +/*
> > + * The buffer cache manages buffers, particularly:
> > + *  - inc/dec of holder count
> > + *  - setting the last_accessed field
> > + *  - maintains clean/dirty state along with lru
> > + *  - selecting buffers that match predicates
> > + *
> > + * It does *not* handle:
> > + *  - allocation/freeing of buffers.
> > + *  - IO
> > + *  - Eviction or cache sizing.
> > + *
> > + * cache_get() and cache_put() are threadsafe, you do not need to
> > + * protect these calls with a surrounding mutex.  All the other
> > + * methods are not threadsafe; they do use locking primitives, but
> > + * only enough to ensure get/put are threadsafe.
> > + */
> > +
> > +#define NR_LOCKS 64
> > +#define LOCKS_MASK (NR_LOCKS - 1)
> > +
> > +struct tree_lock {
> > +	struct rw_semaphore lock;
> > +} ____cacheline_aligned_in_smp;
> > +
> > +struct dm_buffer_cache {
> > +	/*
> > +	 * We spread entries across multiple trees to reduce contention
> > +	 * on the locks.
> > +	 */
> > +	struct tree_lock locks[NR_LOCKS];
> > +	struct rb_root roots[NR_LOCKS];
> > +	struct lru lru[LIST_SIZE];
> > +};
> 
> This:
> 
> struct foo_tree {
> 	struct rw_semaphore lock;
> 	struct rb_root root;
> 	struct lru lru;
> } ____cacheline_aligned_in_smp;
> 
> would be a lot better.
> 
> And where does this NR_LOCKS come from? Don't make up magic values out
> of thin air. Should this be per-cpu? per-node? N per node? I'll bet you
> that 64 is way too much for most use cases, and too little for others.

I cannot speak to the 64 magic value (other than I think it worked
well for Joe's testbed).  But the point of this exercise is to split
the lock to avoid contention.  Using 64 accomplishes this. Having
there be more or less isn't _that_ critical.  The hash to get the
region index isn't a function of cpu.  We aren't after lockless here.

Now that said, will certainly discuss further with Joe and see if we
can be smarter here.

Your suggestion to combine members certainly makes a lot of sense.  I
ran with it relative to the bio-prison-v1 (patch 9) changes which have
the same layout. Definitely a win on in-core memory as well as
avoiding cacheline thrashing while accessing the lock and then the
rb_root members (as is always expected):

Before:

# pahole -C dm_bio_prison drivers/md/dm-bio-prison.ko
struct dm_bio_prison {
        struct lock                lock[64] __attribute__((__aligned__(64))); /*     0  4096 */
        /* --- cacheline 64 boundary (4096 bytes) --- */
        struct rb_root             cells[64];            /*  4096   512 */
        /* --- cacheline 72 boundary (4608 bytes) --- */
        mempool_t                  cell_pool;            /*  4608    72 */

        /* size: 4736, cachelines: 74, members: 3 */
        /* padding: 56 */
        /* forced alignments: 1 */
} __attribute__((__aligned__(64)));

After:

# pahole -C prison_region drivers/md/dm-bio-prison.ko
struct prison_region {
        spinlock_t                 lock;                 /*     0     4 */

        /* XXX 4 bytes hole, try to pack */

        struct rb_root             cell;                 /*     8     8 */

        /* size: 64, cachelines: 1, members: 2 */
        /* sum members: 12, holes: 1, sum holes: 4 */
        /* padding: 48 */
} __attribute__((__aligned__(64)));

# pahole -C dm_bio_prison drivers/md/dm-bio-prison.ko
struct dm_bio_prison {
        struct prison_region       regions[64] __attribute__((__aligned__(64))); /*     0  4096 */
        /* --- cacheline 64 boundary (4096 bytes) --- */
        mempool_t                  cell_pool;            /*  4096    72 */

        /* size: 4224, cachelines: 66, members: 2 */
        /* padding: 56 */
        /* forced alignments: 1 */
} __attribute__((__aligned__(64)));
 
> > @@ -1141,7 +1904,6 @@ static void *new_read(struct dm_bufio_client *c, sector_t block,
> >  	}
> >  
> >  	*bp = b;
> > -
> >  	return b->data;
> >  }
> >  
> 
> Unrelated change. There are a bunch of these.

I knocked those out, and also the various bracing issues.
 
> I stopped reading here, the patch is just too long. Surely this could be
> split up?
> 
>  1 file changed, 1292 insertions(+), 477 deletions(-)
> 
> That's not a patch, that's a patch series.

I don't want to upset you or the community but saying this but:
in this narrow instance where a sizable percentage of the file got
rewritten: to properly review this work you need to look at the full
scope of the changes in combination.

The effort required by the developer to split the code to ease mail
client based review wasn't worth it to me.  Mikulas and myself bear
the burden of review on dm-bufio.c -- so I gave Joe a pass on
splitting because it is make-work to appease the "thou shalt spoon
feed reviewers on a mailing list" rule (that again, I argue isn't
applicable for more elaborate changes that are in the end
intertwined). It hardly seems like time well spent to now go back and
re-write the code in terms of layered patches.

I'd much rather we spend that time on eliminating the abuse of
BUG_ONs, etc.

(I stopped short of saying this to you in chat because I wasn't
prepared to get into a tight loop with you interactively at that
particular moment.. or maybe ever ;)

But again, like I said in chat: I'll look closer, and of course
discuss with Joe, to see if splitting is worth the investment.

Thanks for your review, very much appreciated.

Mike
