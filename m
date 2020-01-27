Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB1214A699
	for <lists+linux-block@lfdr.de>; Mon, 27 Jan 2020 15:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgA0OyL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 27 Jan 2020 09:54:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:36786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728760AbgA0OyL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jan 2020 09:54:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BB06EABED;
        Mon, 27 Jan 2020 14:54:09 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Omar Sandoval <osandov@fb.com>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests] nvme/018: Ignore message generated by nvme read
Date:   Mon, 27 Jan 2020 15:53:53 +0100
Message-Id: <20200127145353.52129-1-dwagner@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nvme-cli writes 'CAP_EXCEEDED' message also on stdout not just
stderr. This lets the test fail as well.

Fixes: 1aee5f430b30 ("nvme/018: Ignore error message generated by nvme read")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/018 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/018 b/tests/nvme/018
index 0a5b4c2ab019..d0f15db23538 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -43,7 +43,7 @@ test() {
 	sectors="$(blockdev --getsz "/dev/${nvmedev}n1")"
 	bs="$(blockdev --getbsz "/dev/${nvmedev}n1")"
 
-	nvme read "/dev/${nvmedev}n1" -s "$sectors" -c 0 -z "$bs" 2>"$FULL" \
+	nvme read "/dev/${nvmedev}n1" -s "$sectors" -c 0 -z "$bs" &>"$FULL" \
 		&& echo "ERROR: Successfully read out of device lba range"
 
 	nvme disconnect -n "${subsys_name}"
-- 
2.16.4

