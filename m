Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630983ADB93
	for <lists+linux-block@lfdr.de>; Sat, 19 Jun 2021 22:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhFSUG3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 19 Jun 2021 16:06:29 -0400
Received: from out0.migadu.com ([94.23.1.103]:55985 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229522AbhFSUG2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jun 2021 16:06:28 -0400
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Jun 2021 16:06:28 EDT
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laumann.xyz; s=key1;
        t=1624132474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+npt0CQB4y19xQf+63x0fCGG5b5+xskF6156N8hrNUM=;
        b=xkuPQmEB6JooiRTqkLLMY1Gr0TmV4w3YecCPHsI6w7TO47DY1hY1B/G1k2U/CQpICwNSEB
        9Do8KM84i0AlHfNNgQzYpHqK/z85Mcbd6sLDamwu1uNkDD5zhY2h9jWgfZgdoPaED+VGz0
        ozInawgkgrB7u4czhrwmLuAj9WWWO8xXyjlXnqxo79ICZ75AKWTMO5QHYpjqHIokNbvE3F
        Qp/poO688/kO0QpSysGIccTmlf36jaZphqBzR4vu31qSk60NsvtUv+Tt9MxLH4hH+KYyJE
        iCxUWQj75+jv4cuhQ71MTlVNCHYEYK05CCc/zQD9JjcHMcTwDdxDYk1IC43xqA==
From:   Thomas Bracht Laumann Jespersen <t@laumann.xyz>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Bracht Laumann Jespersen <t@laumann.xyz>
Subject: [PATCH] block/partitions/msdos: Fix typo inidicator -> indicator
Date:   Sat, 19 Jun 2021 21:51:31 +0200
Message-Id: <20210619195130.19348-1-t@laumann.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: t@laumann.xyz
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just a fix for a small typo in msdos_partition().

Signed-off-by: Thomas Bracht Laumann Jespersen <t@laumann.xyz>
---
Spotted a small typo while reading up on fatfs, thought I'd send it out. This is
based off of Linus' main tree, not sure if that's the right one to send patches
for.

 block/partitions/msdos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/msdos.c b/block/partitions/msdos.c
index 8f2fcc080264..63e4f6f8b6e9 100644
--- a/block/partitions/msdos.c
+++ b/block/partitions/msdos.c
@@ -622,7 +622,7 @@ int msdos_partition(struct parsed_partitions *state)
 	for (slot = 1; slot <= 4; slot++, p++) {
 		if (p->boot_ind != 0 && p->boot_ind != 0x80) {
 			/*
-			 * Even without a valid boot inidicator value
+			 * Even without a valid boot indicator value
 			 * its still possible this is valid FAT filesystem
 			 * without a partition table.
 			 */
-- 
2.31.1

