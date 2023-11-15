Return-Path: <linux-block+bounces-108-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2544E7E892A
	for <lists+linux-block@lfdr.de>; Sat, 11 Nov 2023 05:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917BF1F20F7D
	for <lists+linux-block@lfdr.de>; Sat, 11 Nov 2023 04:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3D5C8F1;
	Sat, 11 Nov 2023 04:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCiOEHH2"
X-Original-To: linux-block@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5C47466
	for <linux-block@vger.kernel.org>; Sat, 11 Nov 2023 04:30:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379773C15
	for <linux-block@vger.kernel.org>; Fri, 10 Nov 2023 20:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699677049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJGv7czmve/4N5vgtBzX0SHAYuE9ldyzoQNEtjPUmck=;
	b=TCiOEHH2S7GO02KQK8lTf5MpuMGUBEup/d3GJSvlJKYCErl0CCsOXYCzzKGNJZ1q30aFBr
	2PsOXDO0P25JVAScwExNoBZV8TxCIhLXhp7CxTngi1jxM4jY6lzZchGAEVZSLpiDbKn+WU
	cEXDL6455pBVnNiPigrv5GwfRCWUMws=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-rUox_AV-P4qd4JP5T48g-A-1; Fri,
 10 Nov 2023 23:30:45 -0500
X-MC-Unique: rUox_AV-P4qd4JP5T48g-A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E87A3816C82;
	Sat, 11 Nov 2023 04:30:45 +0000 (UTC)
Received: from pbitcolo-build-10.permabit.com (pbitcolo-build-10.permabit.lab.eng.bos.redhat.com [10.19.117.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7E11E40C6EB9;
	Sat, 11 Nov 2023 04:30:45 +0000 (UTC)
Received: by pbitcolo-build-10.permabit.com (Postfix, from userid 1138)
	id 2F7B03003C; Fri, 10 Nov 2023 23:30:44 -0500 (EST)
From: Matthew Sakai <msakai@redhat.com>
To: dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>,
	Matthew Sakai <msakai@redhat.com>
Subject: [PATCH 1/8] dm vdo memory-alloc: remove UDS_ALLOCATE_NOWAIT macro
Date: Fri, 10 Nov 2023 23:30:37 -0500
Message-Id: <ccd28d21aede15fc56f1ff25b3582ddad5260883.1699675570.git.msakai@redhat.com>
In-Reply-To: <cover.1699676411.git.msakai@redhat.com>
References: <cover.1699676411.git.msakai@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

From: Mike Snitzer <snitzer@kernel.org>

Only caller can easily open-code call to uds_allocate_memory_nowait().

Reviewed-by: Susan LeGendre-McGhee <slegendr@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Matthew Sakai <msakai@redhat.com>
---
 drivers/md/dm-vdo/flush.c        | 2 +-
 drivers/md/dm-vdo/memory-alloc.h | 8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-vdo/flush.c b/drivers/md/dm-vdo/flush.c
index 8c77337e5262..f5b96f9f76ab 100644
--- a/drivers/md/dm-vdo/flush.c
+++ b/drivers/md/dm-vdo/flush.c
@@ -104,7 +104,7 @@ static void *allocate_flush(gfp_t gfp_mask, void *pool_data)
 	struct vdo_flush *flush;
 
 	if ((gfp_mask & GFP_NOWAIT) == GFP_NOWAIT) {
-		flush = UDS_ALLOCATE_NOWAIT(struct vdo_flush, __func__);
+		flush = uds_allocate_memory_nowait(sizeof(struct vdo_flush), __func__);
 	} else {
 		int result = UDS_ALLOCATE(1, struct vdo_flush, __func__, &flush);
 
diff --git a/drivers/md/dm-vdo/memory-alloc.h b/drivers/md/dm-vdo/memory-alloc.h
index 1f0ac0500334..d6bf5e3dae2a 100644
--- a/drivers/md/dm-vdo/memory-alloc.h
+++ b/drivers/md/dm-vdo/memory-alloc.h
@@ -141,18 +141,16 @@ static inline int __must_check uds_allocate_cache_aligned(size_t size, const cha
 	return uds_allocate_memory(size, L1_CACHE_BYTES, what, ptr);
 }
 
-void *__must_check uds_allocate_memory_nowait(size_t size, const char *what);
-
 /*
  * Allocate one element of the indicated type immediately, failing if the required memory is not
  * immediately available.
  *
- * @TYPE: The type of objects to allocate
- * @WHAT: What is being allocated (for error logging)
+ * @size: The number of bytes to allocate
+ * @what: What is being allocated (for error logging)
  *
  * Return: pointer to the memory, or NULL if the memory is not available.
  */
-#define UDS_ALLOCATE_NOWAIT(TYPE, WHAT) uds_allocate_memory_nowait(sizeof(TYPE), WHAT)
+void *__must_check uds_allocate_memory_nowait(size_t size, const char *what);
 
 int __must_check uds_duplicate_string(const char *string, const char *what, char **new_string);
 
-- 
2.40.0


