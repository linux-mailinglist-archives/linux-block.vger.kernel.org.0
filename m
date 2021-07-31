Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3FD3DC47B
	for <lists+linux-block@lfdr.de>; Sat, 31 Jul 2021 09:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhGaHl1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 31 Jul 2021 03:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhGaHl0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 31 Jul 2021 03:41:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A09C06175F;
        Sat, 31 Jul 2021 00:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=+xiYSt7Sw/4MUBsawzLzy+aOpabAH8dYrZjhJ5bltLI=; b=Wvvuudz4KJOCc6OHr1ixuBR24+
        eUz5csMeWjyzrmCClMZ4FjymCV6tNhCSK6TzD8jYZfBDRA7E9N5rYDG2mRuf1fTiMDY7b9HXUdBBR
        p+IyPIx6ghUkt0NHIMeyaFuJsw5hqGmzXdtEizbWDUa4/WeoWRgEDwvrr2gXU7MKxi67l0O9fUQl4
        KdXfsWbL+D2b5de3C7yOlb+RMCsoZX4YejWGz6a8JSYloUdnlIYtCCnz8JwqMttkHugnBrJiXDGBK
        klUi/pvlagAUdGpzgMgJV1P+xtPcCk1SiktQ4MBOo0rMIGNrIeOE5dmP7LAtvv9cm0HpkIt+0rk2c
        CO5H+08w==;
Received: from 213-225-38-220.nat.highway.a1.net ([213.225.38.220] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m9jbg-001V6I-VF; Sat, 31 Jul 2021 07:40:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: two bsg fixes
Date:   Sat, 31 Jul 2021 09:40:25 +0200
Message-Id: <20210731074027.1185545-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Martin,

this series contains two small fixes for commands without data transfer
for the recent bsg changes.
