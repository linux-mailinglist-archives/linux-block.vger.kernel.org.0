Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36483D9DD9
	for <lists+linux-block@lfdr.de>; Thu, 29 Jul 2021 08:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbhG2Gtu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 29 Jul 2021 02:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbhG2Gtt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jul 2021 02:49:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79365C061757;
        Wed, 28 Jul 2021 23:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=oLa/CMP0SEWh2QjRjiVed2yCZcGeC41TRLsTyHujkxY=; b=lXpK/Lb3tuBCgRBX2qGXZjPy5b
        ZPS3Sm0Le2+0v+ktx8d2nPis5lqhL5nQUyAkMUrW7ExlsoS0OcU88prGJ0tClaQraj+R0wRHsE1MG
        E8SK3/eAvNCgt09n+wN5jSBffGa62jqAqwbRhoPs4AeXiJWzSucuhpDlCkqUDw5e3e3ZZbuqJ1ak/
        rid7Vzd2j2CIz7CzXKS4QBYfO92HzQYGVJbNM6uFtzIGIe5grfU8CQtdk/l7ZkKq1K8VQLqfDNpck
        LV0uPeGrDECisLpc9c+YFAqO9yuGdHO1qxPxlhW2UQpCT6t+l/0naHCe0ANd3ISeXKMWmVIeOwAKE
        HuH1j65w==;
Received: from [2001:4bb8:184:87c5:8c88:c313:79e2:b780] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8zqb-00Gndz-Ka; Thu, 29 Jul 2021 06:49:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: bsg cleanup, part 2
Date:   Thu, 29 Jul 2021 08:48:41 +0200
Message-Id: <20210729064845.1044147-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Martin,

this is the next round of bsg cleanups based on the previous scsi ioctl
changes.  The biggest changes are major simplification of how the bsg
nodes are created and found, and a simplification of the interface
between the frontend in bsg.c and the two backends.

Diffstat:
 block/blk-mq.c             |    2 
 block/bsg-lib.c            |   89 +++++------
 block/bsg.c                |  353 ++++++++++-----------------------------------
 drivers/scsi/scsi_bsg.c    |   72 +++++----
 drivers/scsi/scsi_ioctl.c  |   63 +++-----
 drivers/scsi/scsi_priv.h   |   11 -
 drivers/scsi/scsi_scan.c   |    2 
 drivers/scsi/scsi_sysfs.c  |   24 ++-
 include/linux/blkdev.h     |   14 -
 include/linux/bsg-lib.h    |    1 
 include/linux/bsg.h        |   31 +--
 include/scsi/scsi_device.h |    5 
 12 files changed, 229 insertions(+), 438 deletions(-)
