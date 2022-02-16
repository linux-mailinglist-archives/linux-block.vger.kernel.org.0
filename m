Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1554B8ECB
	for <lists+linux-block@lfdr.de>; Wed, 16 Feb 2022 18:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbiBPREt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Feb 2022 12:04:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236878AbiBPREt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 12:04:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B0A2A5983
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 09:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Os1wz78zOnhCLM+qfhENKUxs8C
        0RgWv1BtAiykPuz6LFQUyF+l8xXuTQeymk7+/mxXg0sezoTbN/LPGU/H5iZf7FAeuAWyetDXwl8dt
        56kTXeZJ1gQW43eYRJRrJCacIgKIrUCH9f8Wu3257vX1XRac/elQAAPuPNnGfvsiR0b/6Dc2opg58
        xA0f3P+sXOzJnjfdSzYDQBEBIqwZTS4en4eVDRLgKRH+6AB0l+OYMzERU5CNeOrPIadbIu/2BqkJR
        4fDKKvHFu9KU0VVAU42/vqwG/pcWdjEhCoxWZFUBEySr4VPUn6aNUiURpUpvCn/c6PwFHNK8cYG4Q
        jsVkLFVQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKNjG-007qT8-2z; Wed, 16 Feb 2022 17:04:34 +0000
Date:   Wed, 16 Feb 2022 09:04:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Haimin Zhang <tcs.kernel@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block-map: add __GFP_ZERO flag for alloc_page in
 function bio_copy_kern
Message-ID: <Yg0uooVxJ42KZ6vL@infradead.org>
References: <20220216084038.15635-1-tcs.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216084038.15635-1-tcs.kernel@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
