Return-Path: <linux-block+bounces-3880-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90DB86D539
	for <lists+linux-block@lfdr.de>; Thu, 29 Feb 2024 21:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 552FEB2750C
	for <lists+linux-block@lfdr.de>; Thu, 29 Feb 2024 20:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5A11683B0;
	Thu, 29 Feb 2024 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7OdlOST"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9811683AB;
	Thu, 29 Feb 2024 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239282; cv=none; b=rKInTouxHGDPmAjD1WDhAV2YdHOoBsdnJhn9mwaWFVzqx70frVdPLQLIP163Ve5BXfgMB7qXVZvEuqBLdtjP/Un8xph5oyyOVqISovvNYNt2AgSAbGz20nuvN5uawC11W9PYo10m4J+uK7OdJ9a0IdFalvdJao99jOrCdS6JtXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239282; c=relaxed/simple;
	bh=/asW2tftmwjIBrAfKoCxa3oRNne3RxOit1L2BaOZ8Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWEuhePjPl3sfHv188ejh6zyTen4nWDXTGWejzD/h2nSkBwrBYHStM2VrEo8+raPUpNTc3dKNZDM9lcZ3FtzIXz9P2UcH9iLkzPlbRG16MbW0nJynCVv6FeNeht/ZsMNIPl5H/RpV38a3B5BHis2ZWDQflVUy+wHLJBE+XbmOQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7OdlOST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44594C433F1;
	Thu, 29 Feb 2024 20:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239282;
	bh=/asW2tftmwjIBrAfKoCxa3oRNne3RxOit1L2BaOZ8Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M7OdlOSTdq9HghYwO3xN5HZ6nTPUHFXVJ7J+dznHc6pGvojLnwJI7L0BDtR9Yr+tq
	 uM/Y1Jd9bND/0IiI9QN92fsvB/o7vZTVMn7pBst8OqpGNBbsnYbkShCY6h9G9WOjiZ
	 hLsToGIsruW8AnmzZ2U+RTINluoTwd9McEGj3bzC9Aw5TqGJJvh+UeBlKjCSMJO/Fb
	 l8Nf43ZvDoBn6ESbFheYXV14hAPana5wEOFZzs+Ys9lHg/JZTp6U8WTtDm6s4Tg/7A
	 Af20lGGvdMmiylObQZYDgT3MnAL7orun292lUPgk2u1POD+7TWWB0m/USTrEqaIIgx
	 bXi2H8Wf3s9Ng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Joyce <gjoyce@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	jonathan.derrick@linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 8/9] block: sed-opal: handle empty atoms when parsing response
Date: Thu, 29 Feb 2024 15:41:04 -0500
Message-ID: <20240229204107.2861780-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229204107.2861780-1-sashal@kernel.org>
References: <20240229204107.2861780-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.149
Content-Transfer-Encoding: 8bit

From: Greg Joyce <gjoyce@linux.ibm.com>

[ Upstream commit 5429c8de56f6b2bd8f537df3a1e04e67b9c04282 ]

The SED Opal response parsing function response_parse() does not
handle the case of an empty atom in the response. This causes
the entry count to be too high and the response fails to be
parsed. Recognizing, but ignoring, empty atoms allows response
handling to succeed.

Signed-off-by: Greg Joyce <gjoyce@linux.ibm.com>
Link: https://lore.kernel.org/r/20240216210417.3526064-2-gjoyce@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/opal_proto.h | 1 +
 block/sed-opal.c   | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index b486b3ec7dc41..a50191bddbc26 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -66,6 +66,7 @@ enum opal_response_token {
 #define SHORT_ATOM_BYTE  0xBF
 #define MEDIUM_ATOM_BYTE 0xDF
 #define LONG_ATOM_BYTE   0xE3
+#define EMPTY_ATOM_BYTE  0xFF
 
 #define OPAL_INVAL_PARAM 12
 #define OPAL_MANUFACTURED_INACTIVE 0x08
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 0ac5a4f3f2261..00e4d23ac49e7 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -895,16 +895,20 @@ static int response_parse(const u8 *buf, size_t length,
 			token_length = response_parse_medium(iter, pos);
 		else if (pos[0] <= LONG_ATOM_BYTE) /* long atom */
 			token_length = response_parse_long(iter, pos);
+		else if (pos[0] == EMPTY_ATOM_BYTE) /* empty atom */
+			token_length = 1;
 		else /* TOKEN */
 			token_length = response_parse_token(iter, pos);
 
 		if (token_length < 0)
 			return token_length;
 
+		if (pos[0] != EMPTY_ATOM_BYTE)
+			num_entries++;
+
 		pos += token_length;
 		total -= token_length;
 		iter++;
-		num_entries++;
 	}
 
 	resp->num = num_entries;
-- 
2.43.0


