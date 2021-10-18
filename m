Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D984312A1
	for <lists+linux-block@lfdr.de>; Mon, 18 Oct 2021 10:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhJRJAt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 18 Oct 2021 05:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhJRJAt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 05:00:49 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EC5C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 01:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WXkjWyKzIySeM3KnfgQ+xgQPACblmKcUWrNykAtOqOM=; b=URBCFv6LRRgfLEM6mODoUKooKZ
        tWY7u4SWtdTpNZqWrkg99PuHJQK2tDpQ61labZmlO3UlzlMTecrHQZpBF+MhjbmqeukWEpSQSCbvv
        ZVpICg71vDU5c7OI6hmxHEtFo0Hl+RW6pRfjqGXWegnGx8tLFARyEVzUYqRIcn/UvJWmBa90K9xa4
        VIirS6jWMhU+fbhyT/SYSq57SnxurWFAlo2VEqaopF4h+s1PNjKIh7IpBxw/0ZPuLFgiJz3tdPOWR
        sSHcbJ516EkYAllPvRehufjpvQTLQvZ02Rcviaiz1srQoKK3uzLMt1PmxcE/805Jd5KRDNc42H3V5
        iQZMYEkA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcOTd-00Eizl-Si; Mon, 18 Oct 2021 08:58:37 +0000
Date:   Mon, 18 Oct 2021 01:58:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 06/14] block: store elevator state in request
Message-ID: <YW03PQZa5WYWoYlE@infradead.org>
References: <20211017013748.76461-1-axboe@kernel.dk>
 <20211017013748.76461-7-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017013748.76461-7-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 16, 2021 at 07:37:40PM -0600, Jens Axboe wrote:
>  
>  static inline void blk_mq_sched_requeue_request(struct request *rq)
>  {
> +	if (rq->rq_flags & RQF_ELV) {
> +		struct request_queue *q = rq->q;
> +		struct elevator_queue *e = q->elevator;
>  
> +		if ((rq->rq_flags & RQF_ELVPRIV) && e->type->ops.requeue_request)
> +			e->type->ops.requeue_request(rq);
> +	}

I think we can just kill of RQF_ELVPRIV now.  It is equivalent to
RQF_ELV for !op_is_flush requests.
