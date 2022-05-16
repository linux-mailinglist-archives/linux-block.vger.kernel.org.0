Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAA4527DE0
	for <lists+linux-block@lfdr.de>; Mon, 16 May 2022 08:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240450AbiEPGwt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 16 May 2022 02:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236988AbiEPGwt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 02:52:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCD0C22
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 23:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BozS1yjgE2A7/eDPeLlRtEvpubSE7mKnF2BVs+qKp64=; b=yg2NrU40d7XYgdUg3c4+5eQrAx
        1NkQmklRr9VUTHhlP+rN4aUACVnqvjbzp66ln1XreUKmFppM3ly9Lij2UwbiDKYALRnZh3lloBxeX
        Xg367wXEVq9mBlZZCgRoQwKNFJDnpG3Ts/SaPBsbtI+yNGzoQIMjyVI8zrEXei8iiurfS7ikA8p8I
        1KdE++tptS1NNgS0UKBcH6PpYW3xWRr9adi/4RZdBtEjBuRQD/x81nKQOKI+6441fzoWEuFEhox9L
        +jP6/vllh4QfvO5eslztPl/juvmfOZcU41b8W9hpEJLI56x36upFEZdfJ+h2qEiXQtMiY78p6EGIu
        EBCouM/w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqUb1-006GMw-0F; Mon, 16 May 2022 06:52:47 +0000
Date:   Sun, 15 May 2022 23:52:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <kernel-team@fb.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/3] block: export dma_alignment attribute
Message-ID: <YoH0vuUA4KdcpEAz@infradead.org>
References: <20220513161339.1580042-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513161339.1580042-1-kbusch@fb.com>
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

I'm not against the sysfs file, but for applications this is a
horrible interface.  We really need something that works on the fd.

The XFS_IOC_DIOINFO ioctl from xfs is one, although ugly, option.
The other is to export the alignment requirements through statx.
We had that whole discussion with the inline crypto direct I/O support,
and we really need to tackle it rather sooner than later.

