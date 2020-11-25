Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6050A2C3D05
	for <lists+linux-block@lfdr.de>; Wed, 25 Nov 2020 10:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgKYJwY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 25 Nov 2020 04:52:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37472 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725837AbgKYJwY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 04:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606297942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QvCrHmCCsCHUeW6s4lCe9FBaUHJnsg8uMdOOTg/zfoE=;
        b=KhHROOPMC41V6ymBES2BeJ5g1I5YOE9wludfnd6UExbRPUK9jJ7HZJTf2hy4jGBIcCqlDS
        hFGT0hyQSvQaNrUeHH4lN/QMxLvSDKEg8anFpNFYHEMP9DfuswBhglaKPfH17EIk1pC2xa
        fRYgxSfev9WT3Wc+e5mKnzSoG1T4hKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-8W1m-baTPEC8IxsOciqZTA-1; Wed, 25 Nov 2020 04:52:17 -0500
X-MC-Unique: 8W1m-baTPEC8IxsOciqZTA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86561873116;
        Wed, 25 Nov 2020 09:52:16 +0000 (UTC)
Received: from T590 (ovpn-12-140.pek2.redhat.com [10.72.12.140])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 375D110016FA;
        Wed, 25 Nov 2020 09:52:09 +0000 (UTC)
Date:   Wed, 25 Nov 2020 17:52:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        joseph.qi@linux.alibaba.com, hch@infradead.org
Subject: Re: [PATCH v6] block: disable iopoll for split bio
Message-ID: <20201125095204.GC28463@T590>
References: <20201125064147.25389-1-jefflexu@linux.alibaba.com>
 <20201125082937.GB28463@T590>
 <cf5df115-5e27-6d43-e4f9-0ac680bf0849@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf5df115-5e27-6d43-e4f9-0ac680bf0849@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 25, 2020 at 05:17:07PM +0800, JeffleXu wrote:
> 
> 
> On 11/25/20 4:29 PM, Ming Lei wrote:
> > On Wed, Nov 25, 2020 at 02:41:47PM +0800, Jeffle Xu wrote:
> >> iopoll is initially for small size, latency sensitive IO. It doesn't
> >> work well for big IO, especially when it needs to be split to multiple
> >> bios. In this case, the returned cookie of __submit_bio_noacct_mq() is
> >> indeed the cookie of the last split bio. The completion of *this* last
> >> split bio done by iopoll doesn't mean the whole original bio has
> >> completed. Callers of iopoll still need to wait for completion of other
> >> split bios.
> >>
> >> Besides bio splitting may cause more trouble for iopoll which isn't
> >> supposed to be used in case of big IO.
> >>
> >> iopoll for split bio may cause potential race if CPU migration happens
> >> during bio submission. Since the returned cookie is that of the last
> >> split bio, polling on the corresponding hardware queue doesn't help
> >> complete other split bios, if these split bios are enqueued into
> >> different hardware queues. Since interrupts are disabled for polling
> >> queues, the completion of these other split bios depends on timeout
> >> mechanism, thus causing a potential hang.
> >>
> >> iopoll for split bio may also cause hang for sync polling. Currently
> >> both the blkdev and iomap-based fs (ext4/xfs, etc) support sync polling
> >> in direct IO routine. These routines will submit bio without REQ_NOWAIT
> >> flag set, and then start sync polling in current process context. The
> >> process may hang in blk_mq_get_tag() if the submitted bio has to be
> >> split into multiple bios and can rapidly exhaust the queue depth. The
> >> process are waiting for the completion of the previously allocated
> >> requests, which should be reaped by the following polling, and thus
> >> causing a deadlock.
> >>
> >> To avoid these subtle trouble described above, just disable iopoll for
> >> split bio.
> >>
> >> Suggested-by: Ming Lei <ming.lei@redhat.com>
> >> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> >> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >> ---
> >>  block/bio.c               |  2 ++
> >>  block/blk-merge.c         | 12 ++++++++++++
> >>  block/blk-mq.c            |  3 +++
> >>  include/linux/blk_types.h |  1 +
> >>  4 files changed, 18 insertions(+)
> >>
> >> diff --git a/block/bio.c b/block/bio.c
> >> index fa01bef35bb1..7f7ddc22a30d 100644
> >> --- a/block/bio.c
> >> +++ b/block/bio.c
> >> @@ -684,6 +684,8 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
> >>  	bio_set_flag(bio, BIO_CLONED);
> >>  	if (bio_flagged(bio_src, BIO_THROTTLED))
> >>  		bio_set_flag(bio, BIO_THROTTLED);
> >> +	if (bio_flagged(bio_src, BIO_SPLIT))
> >> +		bio_set_flag(bio, BIO_SPLIT);
> >>  	bio->bi_opf = bio_src->bi_opf;
> >>  	bio->bi_ioprio = bio_src->bi_ioprio;
> >>  	bio->bi_write_hint = bio_src->bi_write_hint;
> >> diff --git a/block/blk-merge.c b/block/blk-merge.c
> >> index bcf5e4580603..a2890cebf99f 100644
> >> --- a/block/blk-merge.c
> >> +++ b/block/blk-merge.c
> >> @@ -279,6 +279,18 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
> >>  	return NULL;
> >>  split:
> >>  	*segs = nsegs;
> >> +
> >> +	/*
> >> +	 * Bio splitting may cause subtle trouble such as hang when doing sync
> >> +	 * iopoll in direct IO routine. Given performance gain of iopoll for
> >> +	 * big IO can be trival, disable iopoll when split needed. We need
> >> +	 * BIO_SPLIT to identify bios need this workaround. Since currently
> >> +	 * only normal IO under mq routine may suffer this issue, BIO_SPLIT is
> >> +	 * only marked here.
> >> +	 */
> >> +	bio->bi_opf &= ~REQ_HIPRI;
> >> +	bio_set_flag(bio, BIO_SPLIT);
> > 
> > You may need to put the above into one helper, and call the helper for
> > other splitted cases(discard, write zero and write same) too.
> It could be, though currently only normal IO could be marked with REQ_HIPRI.

You are right, so far RWF_HIPRI is only applied on RW IO, then no need to
do that for other non-RW split.

Thanks,
Ming

