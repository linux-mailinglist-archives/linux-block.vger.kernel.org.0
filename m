Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF531C7308
	for <lists+linux-block@lfdr.de>; Wed,  6 May 2020 16:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgEFOkW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 6 May 2020 10:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgEFOkW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 May 2020 10:40:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E655C061A0F;
        Wed,  6 May 2020 07:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=alxxahcj4iESF8ov7d+8sOyxRFpCu7vgx3KmajpgLF0=; b=dNrfWf80MZTU3BZOGe8/XReKX8
        cbibgJtg/3T1VZBgv11FXwgQJvNKf9IkMAC8gKV4EFuk+WFPu0XChccv2oKDeDzD4pmqgXwTahPBR
        yrXw1mLDdIK+qJ+6FFDw39Q8V057p7y/GHVGbHW5a3QU/kJtUlmrYKBaLzGMBuCzVMTrFz7RYRwEq
        MFQAeOwOuEc+ihLlaEH4vUXLkwr3VJe4GDgLqgUJpOJ6AwMIofKyoOFOZqNe5tEVz7qnrwRKXE6ze
        mYJC/FyV2vQiCinSQwFfHig6gMQUErHEIFlzYXS+OUu6abUb9ROnmDqO4cvjXICceJQeL3xk985jq
        I8jKKgKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWLDi-0001id-7z; Wed, 06 May 2020 14:40:22 +0000
Date:   Wed, 6 May 2020 07:40:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 1/2] fs/iomap/direct-io: pass NOWAIT to bio flags
Message-ID: <20200506144022.GB27643@infradead.org>
References: <158860769311.32485.8003552176738816448.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158860769311.32485.8003552176738816448.stgit@buzz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 04, 2020 at 06:54:53PM +0300, Konstantin Khlebnikov wrote:
> This is required to avoid waiting in lower layers.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
