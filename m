Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446C83D6F6D
	for <lists+linux-block@lfdr.de>; Tue, 27 Jul 2021 08:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhG0G1M (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 27 Jul 2021 02:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbhG0G1L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 02:27:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6436EC061757
        for <linux-block@vger.kernel.org>; Mon, 26 Jul 2021 23:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=odQ3xSbMIRAQLrbU/wMaQORrGs56KpLER3cHtFA9MoM=; b=aQI3o5SWyKPVq6p2PTbozqq++S
        mmnrU04LhovotXIswwKZh8reCzxC0BXlspwZK5A4e4RrJrab9rC1uT3E/HIihu1BFAQHyUg/+of4H
        PL689faeAIwIBqLyh0bb+unBfekwE7GZytqr52UN3mq/obCOLkgjrRYcppfLcrbnB0bzN64arqO92
        pz8R3D50cNwH35MnAq/oL3QtdlBPLUt6tMTOQRNPMgp1TINXCHiEvuSFit9Dc5KpnHn0a2HREG+j+
        8AHZHI5ML5Uhqgl61RHPrBOrjjz2cuwXaTxao3heBtL73u7XVzMSUuKkC4WqdYVK8pDsaDf4k78VK
        c1k1Cq/g==;
Received: from [2001:4bb8:184:87c5:b7fb:1299:a9e5:ff56] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8GWk-00EkDF-Us; Tue, 27 Jul 2021 06:26:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
        linux-block@vger.kernel.org
Subject: remove disk_name()
Date:   Tue, 27 Jul 2021 08:25:12 +0200
Message-Id: <20210727062518.122108-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series removes the obsolete disk_name helper in favor of using the
%pg format specifier.

Diffstat:
 blk-settings.c    |   12 +++---------
 blk.h             |    1 -
 genhd.c           |   35 +++++++++++++++--------------------
 partitions/core.c |    2 +-
 4 files changed, 19 insertions(+), 31 deletions(-)
