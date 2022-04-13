Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589974FEBE8
	for <lists+linux-block@lfdr.de>; Wed, 13 Apr 2022 02:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiDMA0i (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 12 Apr 2022 20:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiDMA03 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Apr 2022 20:26:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2BE37A94
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 17:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=PvgQEVGOj3yHRAJSh95613lBNApR4G1//R4YAdPTUPA=; b=SxkmyRmxsUNvB/31VGoeXlElOB
        kKmzSVfNYR54AVHv2Et1ZXgy70lhOrqBs75KjUJBFCHqds90UY3GfQX554YE3b/KTyiFGSTLB3kyo
        xu7/ahuaOq0plzg0RosWDEv9ZS5rq6Qn2SwRgyjmsbzO4Jj9/ZVbVGWmOuM2epmzbwa5C6h08J8Z+
        ILKXdWW49dGqLxfqNrUO13uv7sq7ES2vsBouopRRw2iBu1bO7TRhrIq4xoqX1Ikb1Irhdbvpk2WS+
        pZogoTuT9Sl6BoTkNljKQNiZtq36JKWAuhghGs1kCDiGIo3VOcNpVJEDPLijn0G/50oSVmtyk9LJx
        CE3+yNqg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neQnk-00GAZp-VK; Wed, 13 Apr 2022 00:24:04 +0000
Date:   Tue, 12 Apr 2022 17:24:04 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     bvanassche@acm.org, yi.zhang@redhat.com, sagi@grimberg.me
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: can't run nvme-mp blktests
Message-ID: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I do have CONFIG_NVME_MULTIPATH=y but I also have:

cat /etc/modprobe.d/nvme.conf 
options nvme_core multipath=N

And yet I always end up booting with:

cat /sys/module/nvme_core/parameters/multipath 
Y

So trying to run:

nvme_trtype=rdma ./check nvmeof-mp

I end up with the warning:

nvmeof-mp/***                                                [not run]
    CONFIG_NVME_MULTIPATH has been set in .config and multipathing has been enabled in the nvme_core kernel module

Are there times where one cannot disable multipath? I'm not using
any nvme drive at boot, but I do use one for a random data parition.

Any tips?

  Luis
