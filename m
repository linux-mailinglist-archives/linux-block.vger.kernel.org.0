Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0EB5B3F5B
	for <lists+linux-block@lfdr.de>; Fri,  9 Sep 2022 21:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiIITTj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 9 Sep 2022 15:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiIITTi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Sep 2022 15:19:38 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 515505FA6;
        Fri,  9 Sep 2022 12:19:24 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id C5083DB9;
        Fri,  9 Sep 2022 22:23:08 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com C5083DB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662751390;
        bh=WAHooePitRG2Wrs35vuzbHd8NY3KHdanVqS7QR9FpIU=;
        h=From:To:CC:Subject:Date:From;
        b=iX1wdQ2tkUspgFc45FW4WaEGuHMyax4z91TFFPsyBuNjTD6YjXEsw0tHxAJvtqnSB
         loxA3zfIH2xmTcU1D4Sj6Wg3eS+gwpjCDDhD2DLZdYTcrOMOyN59o6Ke9r9pSWF+0i
         RPP0tKa4w1wrlP2q/CfZU6K5PS33NnM71gu7lKFQ=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 9 Sep 2022 22:19:20 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] block/nvme: Fix DMA-noncoherent platforms support
Date:   Fri, 9 Sep 2022 22:19:14 +0300
Message-ID: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Our SoC doesn't have the CPU caches coherent on DMA's. After getting the
kernel updated to the 6.0-rcX version we've discovered a problem with the
NVME hwmon probe. It turned out that the root cause of it was connected
with the cache-line-unaligned buffer passed to the DMA-engine. Due to the
cache-invalidation performed on the buffer mapping stage a part of the
structure the buffer was embedded to was lost. Here we suggest to fix the
problem just by aligning the buffer accordingly as the
Documentation/core-api/dma-api.rst document requires. (See the
corresponding patch log for more details.)

A potential root of a similar problem has been detected in the sed-opal
driver too. Even though we have not got any difficulties connected with
that part we still suggest to fix that in the same way as it is done for
the NVME hwmon driver.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-nvme@lists.infradead.org
Cc: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (2):
  nvme-hwmon: Cache-line-align the NVME SMART log-buffer
  block: sed-opal: Cache-line-align the cmd/resp buffers

 block/sed-opal.c          | 5 +++--
 drivers/nvme/host/hwmon.c | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.37.2

