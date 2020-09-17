Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB24B26E95C
	for <lists+linux-block@lfdr.de>; Fri, 18 Sep 2020 01:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgIQXSt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 17 Sep 2020 19:18:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgIQXSt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Sep 2020 19:18:49 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 525CE20838;
        Thu, 17 Sep 2020 23:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600384728;
        bh=o6h0uQcYxT8hDqeNxh4o4wx37bxZ8o2tWkPFDlaL3Zg=;
        h=From:To:Cc:Subject:Date:From;
        b=Uc7H8rbAxkFA478xseYdETekhlX/hB2v82QZ4iNoLiXGkRD11mrqAaabA2QiKquuY
         8VwmF3jiTF6zasq2aqtiK2ORXVhES/zwYqzg7b/ebE+E0TeKoaSiderK9l9+WVx5nk
         YYC6vVoWY9YnPfiXa2bLzF/W5nmmI4QgV64adKtk=
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/4] zoned block device specific errors
Date:   Thu, 17 Sep 2020 16:18:37 -0700
Message-Id: <20200917231841.4029747-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Zone block devices may have some limits that require special handling.
This series provides a way for drivers to notify of these conditions.

v2->v3:

  Split status for max open vs max active errors (Christoph)

  Include scsi use for the new status (Damien)

  Update documentation for the new status inline with the request_queue
  properties they relate to

Damien Le Moal (2):
  scsi: update additional sense codes list
  scsi: handle zone resources errors

Keith Busch (2):
  block: add zone specific block statuses
  nvme: translate zone resource errors

 Documentation/block/queue-sysfs.rst |  8 +++++
 block/blk-core.c                    |  4 +++
 drivers/nvme/host/core.c            |  4 +++
 drivers/scsi/scsi_lib.c             |  9 +++++
 drivers/scsi/sense_codes.h          | 54 ++++++++++++++++++++++++++++-
 include/linux/blk_types.h           | 18 ++++++++++
 6 files changed, 96 insertions(+), 1 deletion(-)

-- 
2.24.1

