Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE634F59F1
	for <lists+linux-block@lfdr.de>; Wed,  6 Apr 2022 11:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbiDFJa5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 6 Apr 2022 05:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354292AbiDFJZs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 05:25:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736E14767E3
        for <linux-block@vger.kernel.org>; Tue,  5 Apr 2022 22:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=2GBf4ZnnvBSpC2vVaeKLWh6Fik
        jb9DqD5QI2viAIC2x9E6pOAj0PnJKwpE8CztdAxzxN2/76E1RqrKxW9wq5sJfJ156Txhut0UCL6Rf
        fj0067jIm1eDFYCZCYO/hWRRCAoX2k3kHNhwxnzHBzbir62XWq/vb+HwIEpNkDPM+GFhp3qHJrq3h
        wL8ltm/ZxhvrempV78BtKAixfIAXqOGN3RATPtfcoBLb/IRi3P8KHaHqnptJJti2rOxd9PWnBUBVQ
        IFuo/O6eTqFR6sDC3RFZyZJKI3Z/Zc40C8Eh5gTwEuPzrZmytx+M5NqAcGhRGHZdKqFKnxdvv/j+M
        D0Fsw4rg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbxnI-003n2c-JX; Wed, 06 Apr 2022 05:01:24 +0000
Date:   Tue, 5 Apr 2022 22:01:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com, dongli.zhang@oracle.com,
        hch@infradead.org, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v5 2/2] virtio-blk: support mq_ops->queue_rqs()
Message-ID: <Yk0epKFLV6SdO+CM@infradead.org>
References: <20220405150924.147021-1-suwan.kim027@gmail.com>
 <20220405150924.147021-3-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405150924.147021-3-suwan.kim027@gmail.com>
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
