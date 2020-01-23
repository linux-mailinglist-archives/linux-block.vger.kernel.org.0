Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D70D7146442
	for <lists+linux-block@lfdr.de>; Thu, 23 Jan 2020 10:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgAWJRY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 23 Jan 2020 04:17:24 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36140 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgAWJRX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jan 2020 04:17:23 -0500
Received: from [154.119.55.242] (helo=canonical.com)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <stefan.bader@canonical.com>)
        id 1iuYc5-00076Q-0F; Thu, 23 Jan 2020 09:17:21 +0000
From:   Stefan Bader <stefan.bader@canonical.com>
To:     linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Tyler Hicks <tyler.hicks@canonical.com>
Subject: [PATCH 1/1] blk/core: Gracefully handle unset make_request_fn
Date:   Thu, 23 Jan 2020 11:17:13 +0200
Message-Id: <20200123091713.12623-2-stefan.bader@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200123091713.12623-1-stefan.bader@canonical.com>
References: <20200123091713.12623-1-stefan.bader@canonical.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When device-mapper adapted for multi-queue functionality, they
also re-organized the way the make-request function was set.
Before, this happened when the device-mapper logical device was
created. Now it is done once the mapping table gets loaded the
first time (this also decides whether the block device is request
or bio based).

However in generic_make_request(), the request function gets used
without further checks and this happens if one tries to mount such
a partially set up device.

This can easily be reproduced with the following steps:
 - dmsetup create -n test
 - mount /dev/dm-<#> /mnt

This maybe is something which also should be fixed up in device-
mapper. But given there is already a check for an unset queue
pointer and potentially there could be other drivers which do or
might do the same, it sounds like a good move to add another check
to generic_make_request_checks() and to bail out if the request
function has not been set, yet.

BugLink: https://bugs.launchpad.net/bugs/1860231
Fixes: ff36ab34583a ("dm: remove request-based logic from make_request_fn wrapper")
Signed-off-by: Stefan Bader <stefan.bader@canonical.com>
---
 block/blk-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1075aaff606d..adcd042edd2d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -884,6 +884,13 @@ generic_make_request_checks(struct bio *bio)
 			bio_devname(bio, b), (long long)bio->bi_iter.bi_sector);
 		goto end_io;
 	}
+	if (unlikely(!q->make_request_fn)) {
+		printk(KERN_ERR
+		       "generic_make_request: Trying to access "
+		       "block-device without request function: %s\n",
+		       bio_devname(bio, b));
+		goto end_io;
+	}
 
 	/*
 	 * Non-mq queues do not honor REQ_NOWAIT, so complete a bio
-- 
2.17.1

