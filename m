Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545ED700A5C
	for <lists+linux-block@lfdr.de>; Fri, 12 May 2023 16:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240975AbjELOeF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 12 May 2023 10:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbjELOeF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 10:34:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265A11BF
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 07:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PXG9YnxMrsLQOqo7/gcCrtxEMxeS++ss525O0ypeW/Y=; b=e5zMYzvcKQWIXDDF4noHKSo1gM
        p3jYXjAY9Yih3AljY1QTAMsZczRu6oi2oT4Vpasup08csW1SByZwNWc9RUeRsxBN96M/j9+DaPrto
        M8VCBSiwiuS1K1PjQIeAWQuJdIdA/BLzviWkzchPcUPM5wxzal1nXgpMGMWzaL1ESrHmFnmSaycbT
        KunnOe/Xj79iJ89Jdl6X6PIJ+P78OMQyOs/t8Y5Nhp8t7klPEdQ3/gkkktbwITpvrVD8tbHSmesn6
        kfE5zlBpXNLhby9W73UxcqdDIq0M2iGqjYXlsfmvwQfMo2wzUjSgO2xsVVGB2EsZz9lHAMFiuUuiI
        EUQjloXg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pxTqK-00CBmw-2z;
        Fri, 12 May 2023 14:34:00 +0000
Date:   Fri, 12 May 2023 07:34:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] zram: add flush_dcache_page() call for write
Message-ID: <ZF5OWEltMexIa0cp@infradead.org>
References: <20230512082958.6550-1-kch@nvidia.com>
 <20230512082958.6550-4-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512082958.6550-4-kch@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 12, 2023 at 01:29:58AM -0700, Chaitanya Kulkarni wrote:
> Just like we have a call flush_dcache_read() after zrma_bvec_read(), add
> missing flush_dcache_page() call before zram_bdev_write() in order to
> handle the cache congruency of the kernel and userspace mappings of
> page for REQ_OP_WRITE handling.

And why do you think this should be required?
