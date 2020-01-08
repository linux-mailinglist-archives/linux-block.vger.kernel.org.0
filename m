Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC4A13447C
	for <lists+linux-block@lfdr.de>; Wed,  8 Jan 2020 15:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgAHOCt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 8 Jan 2020 09:02:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54458 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgAHOCt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jan 2020 09:02:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PJ62hC68HsIpJ1iBXLGxygN8S3VRsNwZoQYd6ozo4MI=; b=K38Bsu/d/Lih2YM/EQW9RoKTG
        sU0a4l9fwtBQyVz5PnmIkdg1x3Sf00I+rv2xY09yAtiWmm2hlesi+nNjhzzunw1a6jHZbl7p8E4Ao
        G6pq9dqi5pXNSIPn8/7SE7TZUGkBD6AXQmkt2zwlJOcwKUcFME7QSr8l67i32QNbLPMGfe7yItUas
        U7zNHR3xm+yWxE+oKAPyXHFQGuw++yYKDreqHXPM+B1PIfUZaaHXRecjHpI6FY4lqLA6QmGwJbjC6
        YJbrBQLa4K+5Tf/+e30jZSD6jXwVbW2uKJZ7An/uPlxXHF/GHCc7crSzjNUKXLNrWgufkpZ6r/0rU
        KrMJd1yrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipBv6-0006eO-2D; Wed, 08 Jan 2020 14:02:48 +0000
Date:   Wed, 8 Jan 2020 06:02:48 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: fix splitting segments
Message-ID: <20200108140248.GA2896@infradead.org>
References: <20191229023230.28940-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191229023230.28940-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static inline unsigned get_max_segment_size(const struct request_queue *q,
> +					    const struct page *start_page,
> +					    unsigned long offset)
>  {
>  	unsigned long mask = queue_segment_boundary(q);
>  
> -	/* default segment boundary mask means no boundary limit */
> -	if (mask == BLK_SEG_BOUNDARY_MASK)
> -		return queue_max_segment_size(q);
> -
> -	return min_t(unsigned long, mask - (mask & offset) + 1,
> +	offset = mask & (page_to_phys(start_page) + offset);

This looks weird and potentionaly incorrect - once you add the offset
to page_phys it really isn't an offset anymore and should be in a
variable named paddr or similar.  And that needs to use a phys_addr_t
as we can have 32-bit architectures that use 64-bit physical addresses.

I'd also pass in the actual phys_addr_t instead of the page and offset.
