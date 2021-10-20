Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241C1434DFD
	for <lists+linux-block@lfdr.de>; Wed, 20 Oct 2021 16:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhJTOkl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 20 Oct 2021 10:40:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55060 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhJTOkl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 10:40:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3727F1F770;
        Wed, 20 Oct 2021 14:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634740706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ySO0NWtZIUIpUWMuie7uHAGLlZagMHeoDLXHhNX1Xe0=;
        b=QwXZqs4FZ1S3z4wVDJc97+RutVpavEJ/PgNKHBLETUOY2OaqIMKuV9mPgvwIy61xHhi8Xv
        JShswJVIpdYNtvgYUSXEcu8/bbVnv1Qlm5wc7AL56zmIAY71bEc42phAFLc4AZ09XZIX4y
        ilMgcXQmc4PDdgGB4BlULDmeufUwsqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634740706;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ySO0NWtZIUIpUWMuie7uHAGLlZagMHeoDLXHhNX1Xe0=;
        b=HlCQKFREiuNh/lfeizM4hT2JcvqgZZVpzcRgVw2/jZUwZbiD/zyT3svm4QzcccT+0zTFDK
        ko+l/QAQfa5KtrAg==
Received: from localhost.localdomain (colyli.tcp.ovpn1.nue.suse.de [10.163.16.22])
        by relay2.suse.de (Postfix) with ESMTP id 845B6A3B84;
        Wed, 20 Oct 2021 14:38:24 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 2/8] bcache: reserve never used bits from bkey.high
Date:   Wed, 20 Oct 2021 22:38:06 +0800
Message-Id: <20211020143812.6403-3-colyli@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211020143812.6403-1-colyli@suse.de>
References: <20211020143812.6403-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There sre 3 bits in member high of struct bkey are never used, and no
plan to support them in future,
- HEADER_SIZE, start at bit 58, length 2 bits
- KEY_PINNED,  start at bit 55, length 1 bit

No any kernel code, or user space tool references or accesses the three
bits. Therefore it is possible and feasible to reserve the valuable bits
from bkey.high. They can be used in future for other purpose.

Signed-off-by: Coly Li <colyli@suse.de>
---
 include/uapi/linux/bcache.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bcache.h b/include/uapi/linux/bcache.h
index cf7399f03b71..97413586195b 100644
--- a/include/uapi/linux/bcache.h
+++ b/include/uapi/linux/bcache.h
@@ -43,9 +43,9 @@ static inline void SET_##name(struct bkey *k, unsigned int i, __u64 v)	\
 #define KEY_MAX_U64S		8
 
 KEY_FIELD(KEY_PTRS,	high, 60, 3)
-KEY_FIELD(HEADER_SIZE,	high, 58, 2)
+KEY_FIELD(__PAD0,	high, 58, 2)
 KEY_FIELD(KEY_CSUM,	high, 56, 2)
-KEY_FIELD(KEY_PINNED,	high, 55, 1)
+KEY_FIELD(__PAD1,	high, 55, 1)
 KEY_FIELD(KEY_DIRTY,	high, 36, 1)
 
 KEY_FIELD(KEY_SIZE,	high, 20, KEY_SIZE_BITS)
-- 
2.31.1

