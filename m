Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9278D2C3A01
	for <lists+linux-block@lfdr.de>; Wed, 25 Nov 2020 08:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgKYHUC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 25 Nov 2020 02:20:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28303 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726562AbgKYHUB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 02:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606288800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VU0mN/kH+8zUm5BvoClXo1QWUHq3rUGk63F7dI6EnkQ=;
        b=hxF2NbnsSCyk2On8MihP78VpuZCF/+9Si0v0U5xDbgaLkOIggKzrEwsLoR4B+76Y+M5e7R
        DEUW1NGvHFoyN4BOizcW4MS7SysexrTPAFkB6JQhE3yj1wKtq+vH84Te+ZOQOrTVAevDng
        3waN4MveaKcBWyWuHWYYmtRkTh+1DZg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-uMjrq4bwOq27RMS8YfrMuw-1; Wed, 25 Nov 2020 02:19:57 -0500
X-MC-Unique: uMjrq4bwOq27RMS8YfrMuw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B2EC85C736;
        Wed, 25 Nov 2020 07:19:56 +0000 (UTC)
Received: from T590 (ovpn-12-140.pek2.redhat.com [10.72.12.140])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F3B4960855;
        Wed, 25 Nov 2020 07:19:49 +0000 (UTC)
Date:   Wed, 25 Nov 2020 15:19:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        joseph.qi@linux.alibaba.com, hch@infradead.org
Subject: Re: [PATCH v6] block: disable iopoll for split bio
Message-ID: <20201125071944.GA24725@T590>
References: <20201125064147.25389-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125064147.25389-1-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 25, 2020 at 02:41:47PM +0800, Jeffle Xu wrote:
> iopoll is initially for small size, latency sensitive IO. It doesn't
> work well for big IO, especially when it needs to be split to multiple
> bios. In this case, the returned cookie of __submit_bio_noacct_mq() is
> indeed the cookie of the last split bio. The completion of *this* last
> split bio done by iopoll doesn't mean the whole original bio has
> completed. Callers of iopoll still need to wait for completion of other
> split bios.
> 
> Besides bio splitting may cause more trouble for iopoll which isn't
> supposed to be used in case of big IO.
> 
> iopoll for split bio may cause potential race if CPU migration happens
> during bio submission. Since the returned cookie is that of the last
> split bio, polling on the corresponding hardware queue doesn't help
> complete other split bios, if these split bios are enqueued into
> different hardware queues. Since interrupts are disabled for polling
> queues, the completion of these other split bios depends on timeout
> mechanism, thus causing a potential hang.
> 
> iopoll for split bio may also cause hang for sync polling. Currently
> both the blkdev and iomap-based fs (ext4/xfs, etc) support sync polling
> in direct IO routine. These routines will submit bio without REQ_NOWAIT
> flag set, and then start sync polling in current process context. The
> process may hang in blk_mq_get_tag() if the submitted bio has to be
> split into multiple bios and can rapidly exhaust the queue depth. The
> process are waiting for the completion of the previously allocated
> requests, which should be reaped by the following polling, and thus
> causing a deadlock.
> 
> To avoid these subtle trouble described above, just disable iopoll for
> split bio.
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio.c               |  2 ++
>  block/blk-merge.c         | 12 ++++++++++++
>  block/blk-mq.c            |  3 +++
>  include/linux/blk_types.h |  1 +
>  4 files changed, 18 insertions(+)
> 
> diff --git a/block/bio.c b/block/bio.c
> index fa01bef35bb1..7f7ddc22a30d 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -684,6 +684,8 @@ void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
>  	bio_set_flag(bio, BIO_CLONED);
>  	if (bio_flagged(bio_src, BIO_THROTTLED))
>  		bio_set_flag(bio, BIO_THROTTLED);
> +	if (bio_flagged(bio_src, BIO_SPLIT))
> +		bio_set_flag(bio, BIO_SPLIT);
>  	bio->bi_opf = bio_src->bi_opf;
>  	bio->bi_ioprio = bio_src->bi_ioprio;
>  	bio->bi_write_hint = bio_src->bi_write_hint;
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index bcf5e4580603..a2890cebf99f 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -279,6 +279,18 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
>  	return NULL;
>  split:
>  	*segs = nsegs;
> +
> +	/*
> +	 * Bio splitting may cause subtle trouble such as hang when doing sync
> +	 * iopoll in direct IO routine. Given performance gain of iopoll for
> +	 * big IO can be trival, disable iopoll when split needed. We need
> +	 * BIO_SPLIT to identify bios need this workaround. Since currently
> +	 * only normal IO under mq routine may suffer this issue, BIO_SPLIT is
> +	 * only marked here.
> +	 */
> +	bio->bi_opf &= ~REQ_HIPRI;
> +	bio_set_flag(bio, BIO_SPLIT);
> +
>  	return bio_split(bio, sectors, GFP_NOIO, bs);
>  }
>  
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 55bcee5dc032..ce1f3628e4c2 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2265,6 +2265,9 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
>  		blk_mq_sched_insert_request(rq, false, true, true);
>  	}
>  
> +	if (bio_flagged(bio, BIO_SPLIT))
> +		return BLK_QC_T_NONE;
> +

Not sure the new bio flag is really required for this case, just wondering
why not take the following simple way? BTW we are really going to run
out of bio flag.

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 55bcee5dc032..1139b1efd712 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2157,6 +2157,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 	unsigned int nr_segs;
 	blk_qc_t cookie;
 	blk_status_t ret;
+	struct bio *orig_bio = bio;
 
 	blk_queue_bounce(q, &bio);
 	__blk_queue_split(&bio, &nr_segs);
@@ -2265,6 +2266,10 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 		blk_mq_sched_insert_request(rq, false, true, true);
 	}
 
+	/* don't poll splitted bio */
+	if (orig_bio != bio)
+		return BLK_QC_T_NONE;
+
 	return cookie;
 queue_exit:
 	blk_queue_exit(q);

Thanks,
Ming

