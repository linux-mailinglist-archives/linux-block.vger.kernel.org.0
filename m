Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AAD430040
	for <lists+linux-block@lfdr.de>; Sat, 16 Oct 2021 06:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239554AbhJPEeE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 16 Oct 2021 00:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239469AbhJPEeD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 00:34:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC24EC061570
        for <linux-block@vger.kernel.org>; Fri, 15 Oct 2021 21:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8KS4ckXY03on/Co3i3qF2x1mCvY05mjRSKv8kENw0iY=; b=kOzaK6yFcSL9dg4G3hhQW3DZ0h
        behA9kCi2mKOA8C+rYWc8881U4LJ/OCh7fGacwrA6mSXa9r0CYfG35pS/Zmb+nTwNjy4G2JZwu5ZT
        Ki3n7GlJ6OO40C1vqNVq0P4N4w4NDm3dkvHQimFXTon0AAYyDJo7IRQJkJP52qOOWbkd72/Ti4SDZ
        tg/ylXm95wcOxNcRdVYMsze+ZDqyJbDINqWZX4uqU9cu/eY8t9PZKZ4e6XionjArSO7ArLCSiZo7o
        MfTMEiFhx2AY+/FDh6OTDJZdhj5LqKdZDPpHP+AJhn2p/T0QlMinU9uc/2U78/Gu2aw90+nXeE88l
        aP5sHZyg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbbMR-009jGD-CQ; Sat, 16 Oct 2021 04:31:55 +0000
Date:   Fri, 15 Oct 2021 21:31:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v3] block: only check previous entry for plug merge
 attempt
Message-ID: <YWpVuzjbuwUQlVa0@infradead.org>
References: <9222613d-d4d3-7cfb-2e96-1bfa3b5f2d7f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9222613d-d4d3-7cfb-2e96-1bfa3b5f2d7f@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good module the needed comment update:

Reviewed-by: Christoph Hellwig <hch@lst.de>
