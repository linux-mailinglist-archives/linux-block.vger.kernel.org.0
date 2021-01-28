Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A453075A0
	for <lists+linux-block@lfdr.de>; Thu, 28 Jan 2021 13:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhA1MMV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 28 Jan 2021 07:12:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25896 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231183AbhA1MMS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 07:12:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611835852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TvEDzpmwICCgnD9J/Pj4N4QzspO+FlLTJrJK9g9h8+Y=;
        b=NCFeiehHbjwqtrOK/pJaIEEbjVnOssW72auY5CTp8VGDf7os8sJCgdwzXKU4KXig6gsVgV
        Bhr+pXje0TcVXuu/d2JFwlhMnnI2Ld2xrLpR/ceu2D/KYDL+UYaH+cttpudIbP9U0imYcL
        M+tfKHHpP39W2VyFhBXlqWonQ3Sh4Zg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-aoPuViIGNZ27TDNE4wjxmQ-1; Thu, 28 Jan 2021 07:10:48 -0500
X-MC-Unique: aoPuViIGNZ27TDNE4wjxmQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80D4080668B;
        Thu, 28 Jan 2021 12:10:47 +0000 (UTC)
Received: from T590 (ovpn-12-191.pek2.redhat.com [10.72.12.191])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E09B6085D;
        Thu, 28 Jan 2021 12:10:41 +0000 (UTC)
Date:   Thu, 28 Jan 2021 20:10:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 2/2] block: add a fast path for seg split of large bio
Message-ID: <20210128121035.GA1495297@T590>
References: <cover.1609875589.git.asml.silence@gmail.com>
 <53b86d4e86c4913658cb0f472dcc3e22ef75396b.1609875589.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53b86d4e86c4913658cb0f472dcc3e22ef75396b.1609875589.git.asml.silence@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 05, 2021 at 07:43:38PM +0000, Pavel Begunkov wrote:
> blk_bio_segment_split() is very heavy, but the current fast path covers
> only one-segment under PAGE_SIZE bios. Add another one by estimating an
> upper bound of sectors a bio can contain.
> 
> One restricting factor here is queue_max_segment_size(), which it
> compare against full iter size to not dig into bvecs. By default it's
> 64KB, and so for requests under 64KB, but for those falling under the
> conditions it's much faster.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  block/blk-merge.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 84b9635b5d57..15d75f3ffc30 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -226,12 +226,12 @@ static bool bvec_split_segs(const struct request_queue *q,
>  static struct bio *__blk_bio_segment_split(struct request_queue *q,
>  					   struct bio *bio,
>  					   struct bio_set *bs,
> -					   unsigned *segs)
> +					   unsigned *segs,
> +					   const unsigned max_sectors)
>  {
>  	struct bio_vec bv, bvprv, *bvprvp = NULL;
>  	struct bvec_iter iter;
>  	unsigned nsegs = 0, sectors = 0;
> -	const unsigned max_sectors = get_max_io_size(q, bio);
>  	const unsigned max_segs = queue_max_segments(q);
>  
>  	bio_for_each_bvec(bv, bio, iter) {
> @@ -295,6 +295,9 @@ static inline struct bio *blk_bio_segment_split(struct request_queue *q,
>  						struct bio_set *bs,
>  						unsigned *nr_segs)
>  {
> +	unsigned int max_sectors, q_max_sectors;
> +	unsigned int bio_segs = bio->bi_vcnt;
> +
>  	/*
>  	 * All drivers must accept single-segments bios that are <=
>  	 * PAGE_SIZE.  This is a quick and dirty check that relies on
> @@ -303,14 +306,32 @@ static inline struct bio *blk_bio_segment_split(struct request_queue *q,
>  	 * are cloned, but compared to the performance impact of cloned
>  	 * bios themselves the loop below doesn't matter anyway.
>  	 */
> -	if (!q->limits.chunk_sectors && bio->bi_vcnt == 1 &&
> +	if (!q->limits.chunk_sectors && bio_segs == 1 &&
>  	    (bio->bi_io_vec[0].bv_len +
>  	     bio->bi_io_vec[0].bv_offset) <= PAGE_SIZE) {
>  		*nr_segs = 1;
>  		return NULL;
>  	}
>  
> -	return __blk_bio_segment_split(q, bio, bs, nr_segs);
> +	q_max_sectors = get_max_io_size(q, bio);
> +	if (!queue_virt_boundary(q) && bio_segs < queue_max_segments(q) &&
> +	    bio->bi_iter.bi_size <= queue_max_segment_size(q)) {

.bi_vcnt is 0 for fast cloned bio, so the above check may become true
when real nr_segment is > queue_max_segments(), especially in case that
max segments limit is small and segment size is big.


-- 
Ming

