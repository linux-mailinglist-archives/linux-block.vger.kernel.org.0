Return-Path: <linux-block+bounces-107-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AB37E8929
	for <lists+linux-block@lfdr.de>; Sat, 11 Nov 2023 05:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A191C20AD9
	for <lists+linux-block@lfdr.de>; Sat, 11 Nov 2023 04:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4261C79D7;
	Sat, 11 Nov 2023 04:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EgyhascA"
X-Original-To: linux-block@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE566FCB
	for <linux-block@vger.kernel.org>; Sat, 11 Nov 2023 04:30:51 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D246448C
	for <linux-block@vger.kernel.org>; Fri, 10 Nov 2023 20:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699677048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4yhU04vpjnU33lo8oVlkUBraK4J7ZGWLAvJ1ibrpDk=;
	b=EgyhascAb+SGN8G+hZrgWVHBJcbTu4NnfJbSBw2LPl2clcOXdoVvCQ6H1fmA05/+ExjZs0
	WuytwFehqvZKN0NpQ9v/xuesnoAQ6bbdfJo2dFe7tPbFOyN/vNSvEQOc6ChYNu0kOVqtcN
	VYAoF9N1GlFASq5/FlxVhvSL2ohnOtI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-KDrI2sqxN36ji8yaw7aPfg-1; Fri, 10 Nov 2023 23:30:46 -0500
X-MC-Unique: KDrI2sqxN36ji8yaw7aPfg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88BE9101A53B;
	Sat, 11 Nov 2023 04:30:46 +0000 (UTC)
Received: from pbitcolo-build-10.permabit.com (pbitcolo-build-10.permabit.lab.eng.bos.redhat.com [10.19.117.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7E79C492BE7;
	Sat, 11 Nov 2023 04:30:46 +0000 (UTC)
Received: by pbitcolo-build-10.permabit.com (Postfix, from userid 1138)
	id 3509B3003D; Fri, 10 Nov 2023 23:30:46 -0500 (EST)
From: Matthew Sakai <msakai@redhat.com>
To: dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>,
	Matthew Sakai <msakai@redhat.com>
Subject: [PATCH 8/8] dm vdo memory-alloc: mark branch unlikely() in uds_allocate_memory()
Date: Fri, 10 Nov 2023 23:30:44 -0500
Message-Id: <1627ae51fd2896d5d24748456f1a2e10ad299e8f.1699675570.git.msakai@redhat.com>
In-Reply-To: <ccd28d21aede15fc56f1ff25b3582ddad5260883.1699675570.git.msakai@redhat.com>
References: <ccd28d21aede15fc56f1ff25b3582ddad5260883.1699675570.git.msakai@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

From: Mike Snitzer <snitzer@kernel.org>

Remove temporary 'duration' variable. And cleanup coding style nit.

Reviewed-by: Susan LeGendre-McGhee <slegendr@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Matthew Sakai <msakai@redhat.com>
---
 drivers/md/dm-vdo/memory-alloc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-vdo/memory-alloc.c b/drivers/md/dm-vdo/memory-alloc.c
index 136a19db33be..e9464d4a1e64 100644
--- a/drivers/md/dm-vdo/memory-alloc.c
+++ b/drivers/md/dm-vdo/memory-alloc.c
@@ -286,13 +286,9 @@ int uds_allocate_memory(size_t size, size_t align, const char *what, void *ptr)
 	if (allocations_restricted)
 		memalloc_noio_restore(noio_flags);
 
-	if (p == NULL) {
-		unsigned int duration = jiffies_to_msecs(jiffies - start_time);
-
+	if (unlikely(p == NULL)) {
 		uds_log_error("Could not allocate %zu bytes for %s in %u msecs",
-			      size,
-			      what,
-			      duration);
+			      size, what, jiffies_to_msecs(jiffies - start_time));
 		return -ENOMEM;
 	}
 
-- 
2.40.0


