Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13458439075
	for <lists+linux-block@lfdr.de>; Mon, 25 Oct 2021 09:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhJYHio (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 25 Oct 2021 03:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhJYHio (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 03:38:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46F9C061745
        for <linux-block@vger.kernel.org>; Mon, 25 Oct 2021 00:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d7rDqH4nh/dpRuh6Lh6X9+dwt3yfokbwF6bF/+8p+M4=; b=wUhskMvPH1HQMKtotJP5aAEDrx
        eMiePf50eWfw2Mh36TpEAGthOfgxDz4if+hOx+63GNpkno9LSyGnX5FpFAYz2usQPSE22RFNXldto
        Ah7GoF1bzJtoQcn0pU7aHEYryUunrgUTqVqsc5QYLxczrcZHNbfKF5yqdApsfOaF+5bKx+OFrgT2s
        nbh5mvdoclEr0qUIMmwYWlOJLfN2sWtM//aE4WtShVFhupm3DcmoTSELIKOYZWSUA0KRLXglwefe9
        iXMbBb2WllGCQPRwnhXZvTYS36BWUMzP4SYlkW3FaaEunJEMzQkN05Yhnp7TBcUTLimhfDT5x14sf
        XNVBx3mg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1meuWs-00FeGN-Cb; Mon, 25 Oct 2021 07:36:22 +0000
Date:   Mon, 25 Oct 2021 00:36:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 5/5] block: add async version of bio_set_polled
Message-ID: <YXZedoab02jl5GVI@infradead.org>
References: <cover.1635006010.git.asml.silence@gmail.com>
 <b766a125d417b3675f0abcdf32ac038c3c235ce9.1635006010.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b766a125d417b3675f0abcdf32ac038c3c235ce9.1635006010.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 23, 2021 at 05:21:36PM +0100, Pavel Begunkov wrote:
> +static inline void bio_set_polled_async(struct bio *bio, struct kiocb *kiocb)
> +{
> +	bio->bi_opf |= REQ_POLLED | REQ_NOWAIT;
> +}

As mentioned last time I'm a little skeptical of this optimization. But
if you an Jens thing it is worth it just drop this helper and assign
the flags directly.
