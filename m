Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC701FB8B3
	for <lists+linux-block@lfdr.de>; Tue, 16 Jun 2020 17:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbgFPP6M (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 16 Jun 2020 11:58:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729560AbgFPP6L (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 11:58:11 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ED57207C4;
        Tue, 16 Jun 2020 15:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592323091;
        bh=7B1Oq/wPqwjii5Pi5zqyh44tNTY6gqKXDYqHG5+rbYg=;
        h=From:To:Cc:Subject:Date:From;
        b=owf6l94X7+9HROQ9bdkp1jlCFqu4PMqucapvp5vAS83OUF+Enb8lkK32Q0XY2f+We
         zz/wh1u70SKDQ6KEqH/9yl6tAsQbuIFJpEzY68bppneKTFFTLdDfM65xhGZI2LEnbj
         56Rz1enUe0d8TIgqD5dpdGXV3CeBzZh8iUP19zGo=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org
Cc:     Satya Tangirala <satyat@google.com>
Subject: [PATCH] block/keyslot-manager: use kvfree_sensitive()
Date:   Tue, 16 Jun 2020 08:56:54 -0700
Message-Id: <20200616155654.191263-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Make blk_ksm_destroy() use the kvfree_sensitive() function (which was
introduced in v5.8-rc1) instead of open-coding it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 block/keyslot-manager.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index c2ef41b3147b..35abcb1ec051 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -374,8 +374,7 @@ void blk_ksm_destroy(struct blk_keyslot_manager *ksm)
 	if (!ksm)
 		return;
 	kvfree(ksm->slot_hashtable);
-	memzero_explicit(ksm->slots, sizeof(ksm->slots[0]) * ksm->num_slots);
-	kvfree(ksm->slots);
+	kvfree_sensitive(ksm->slots, sizeof(ksm->slots[0]) * ksm->num_slots);
 	memzero_explicit(ksm, sizeof(*ksm));
 }
 EXPORT_SYMBOL_GPL(blk_ksm_destroy);
-- 
2.27.0.290.gba653c62da-goog

