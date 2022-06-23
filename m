Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F5A557D56
	for <lists+linux-block@lfdr.de>; Thu, 23 Jun 2022 15:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiFWNyp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 23 Jun 2022 09:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiFWNyo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 09:54:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0843467E
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 06:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=yAJsgZfwIrPKN4iqCGUhyr4AtIjVIzzNDmwO9f0/lT8=; b=4r1hJ9scgfNHmUTt4eBtCz72bk
        zErqPo8sXK8QGqAPZMEvXDTcpyuL79SpephKUJdZR8YlJsr4lqm/8wrT7uQqilshrKcsAJuaxN9Yp
        kfC/wkfYJnzhZBpaxRIAfqOaiB79xjPXWdfG7e+DqKsEX4hMVi3HCz+jxuFfpFHxkvZ1nnI+LMymd
        L/G0n3WXPWI2ROpQHyBeDS6LbcKkuvarUhGBueY3aeXeN2FqqsVB9TZuQigGtCxueJ1gCpVfk9FWC
        G6Txtr5TvTURTvHbruGyzBKHtw88QhPtO6vntLOwChTRa1kaeBcGT+jVceSFaOAFltVTrf7LNrkYF
        VgSliMmA==;
Received: from [2001:4bb8:189:7251:9e7:d0ec:8481:b319] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4NI9-00FQs5-JQ; Thu, 23 Jun 2022 13:54:42 +0000
Date:   Thu, 23 Jun 2022 15:54:39 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvmes fixes for Linux 5.19
Message-ID: <YrRwn7dWdJcI9DSL@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 2645672ffe21f0a1c139bfbc05ad30fd4e4f2583:

  block: pop cached rq before potentially blocking rq_qos_throttle() (2022-06-21 10:59:58 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.19-2022-06-23

for you to fetch changes up to e6487833182a8a0187f0292aca542fc163ccd03e:

  nvme: move the Samsung X5 quirk entry to the core quirks (2022-06-23 15:22:22 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.19

 - fix the mixed up CRIMS/CRWMS constants (Joel Granados)
 - add another broken identifier quirk (Leo Savernik)
 - fix up a quirk because Samsung reuses PCI IDs over different products
   (me)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: move the Samsung X5 quirk entry to the core quirks

Joel Granados (1):
      nvme: fix the CRIMS and CRWMS definitions to match the spec

Leo Savernik (1):
      nvme: add a bogus subsystem NQN quirk for Micron MTFDKBA2T0TFH

 drivers/nvme/host/core.c | 14 ++++++++++++++
 drivers/nvme/host/pci.c  |  6 ++----
 include/linux/nvme.h     |  4 ++--
 3 files changed, 18 insertions(+), 6 deletions(-)
