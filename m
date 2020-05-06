Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8981B1C730A
	for <lists+linux-block@lfdr.de>; Wed,  6 May 2020 16:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgEFOkj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 6 May 2020 10:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbgEFOkj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 May 2020 10:40:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46366C061A0F;
        Wed,  6 May 2020 07:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IieGVj9Mh3LlaGPlVHA/3gGTPV3gJyGh0mfqCHjfMh4=; b=pUV0VeoXHdwaVQBkEtQDKZiD0s
        c3abF+d6dx0Y4B87RXFDkt0zDpWkFLppT7HQh/bb9V0+MPYnvXwmqsBYiQfl8BAysg9brFpulc6yW
        ctQREzZ7eQosJnOvuhhQH60ajDeG7bV5TgsIJwIdkbbrT0bo5iX8FV77g989uVpsMUWYPMYvsXQMP
        vDTC+l65Z2nA9KyP/qV6T/Nu9IR7FzA+3xw86xqjqZB7eL/bK8wWpT4y2cL5SpITMUcUKeeEmzNsw
        YEm4792CsDFd6dapuOb90JpGj5ROyaIpgP6gw2dLkSs3xKKxcSjgCEAuZxqh81cc7RMe10s0tzH2M
        E8ceRz8w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWLDz-0001ks-4W; Wed, 06 May 2020 14:40:39 +0000
Date:   Wed, 6 May 2020 07:40:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 2/2] fs/direct-io: pass NOWAIT to also for read
 requests
Message-ID: <20200506144039.GC27643@infradead.org>
References: <158860769311.32485.8003552176738816448.stgit@buzz>
 <158860769737.32485.3674517821826063792.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158860769737.32485.3674517821826063792.stgit@buzz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 04, 2020 at 06:54:57PM +0300, Konstantin Khlebnikov wrote:
> For some reason NOWAIT currently is passed only for writes.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Fixes: 03a07c92a9ed ("block: return on congested block device")

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
