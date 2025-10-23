Return-Path: <linux-block+bounces-28936-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B2FC0224B
	for <lists+linux-block@lfdr.de>; Thu, 23 Oct 2025 17:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5C71AA1784
	for <lists+linux-block@lfdr.de>; Thu, 23 Oct 2025 15:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F372459C9;
	Thu, 23 Oct 2025 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKfjA1tn"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB1C2FD1DA
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233645; cv=none; b=QjQu27bcoOmi1cuf6/WsHNqvsouoLmiz4JyzNOAnWZn1K9gjGf8qqkEedY3XqG6TSO3j7lVSc4LhcsPwqfEomF5yxunEI2qIMmUiMRJbdRg/b5NLCLIQQ1IGJ0XO7vMUXpnkwECHRwQmvGpvcBAa0QIo9aqzZaricQiFn1nxRrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233645; c=relaxed/simple;
	bh=W24sPvXLKsWUMmTQYF5re5V1HVlHHFAvi1CEPoSR5Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9wvCRhEyzB8uEDGtcdm+rwp61JWaM8YGFYF8pm1zYvnkgy+MXhwCU6m8HWP87/70m7nsuhiwKXNCBFRZwH493x4KunC13A1wRn4yxGaFhLDdFn7y21Bvil3MhO5QmLdjzkXh1k+8nqBS0s5AnDPaC9R7UjL8Kj+Pc1tyr3i+Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jKfjA1tn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761233642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBz4WFDn1U6Wgd37woEVm5QcxS/1722xZKJHV9Um/4s=;
	b=jKfjA1tn8QOgmzxkVzJQCJBBjjB6beGu/hs0Rl9yNwCW/YR6MHI6DjNZ0qGq9/jq59SWpI
	Vc58R+Aka5wkMY90sj0KWciY5pjN4GNmiZ/1frSdnd/HqAII8SwFgf7R3T741SX8iVCGkB
	fCZbqlQps0FtM3yd8G9iLdLJ8/iQeyU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-715T0c3cN4ujbJGtILEYmg-1; Thu,
 23 Oct 2025 11:33:57 -0400
X-MC-Unique: 715T0c3cN4ujbJGtILEYmg-1
X-Mimecast-MFC-AGG-ID: 715T0c3cN4ujbJGtILEYmg_1761233636
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D7F218002EC;
	Thu, 23 Oct 2025 15:33:56 +0000 (UTC)
Received: from localhost (unknown [10.72.120.30])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D3B5180045B;
	Thu, 23 Oct 2025 15:33:54 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 16/25] ublk: document feature UBLK_F_BATCH_IO
Date: Thu, 23 Oct 2025 23:32:21 +0800
Message-ID: <20251023153234.2548062-17-ming.lei@redhat.com>
In-Reply-To: <20251023153234.2548062-1-ming.lei@redhat.com>
References: <20251023153234.2548062-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Document feature UBLK_F_BATCH_IO.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 Documentation/block/ublk.rst | 60 +++++++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 4 deletions(-)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 8c4030bcabb6..09a5604f8e10 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -260,9 +260,12 @@ The following IO commands are communicated via io_uring passthrough command,
 and each command is only for forwarding the IO and committing the result
 with specified IO tag in the command data:
 
-- ``UBLK_IO_FETCH_REQ``
+Traditional Per-I/O Commands
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-  Sent from the server IO pthread for fetching future incoming IO requests
+- ``UBLK_U_IO_FETCH_REQ``
+
+  Sent from the server I/O pthread for fetching future incoming I/O requests
   destined to ``/dev/ublkb*``. This command is sent only once from the server
   IO pthread for ublk driver to setup IO forward environment.
 
@@ -278,7 +281,7 @@ with specified IO tag in the command data:
   supported by the driver, daemons must be per-queue instead - i.e. all I/Os
   associated to a single qid must be handled by the same task.
 
-- ``UBLK_IO_COMMIT_AND_FETCH_REQ``
+- ``UBLK_U_IO_COMMIT_AND_FETCH_REQ``
 
   When an IO request is destined to ``/dev/ublkb*``, the driver stores
   the IO's ``ublksrv_io_desc`` to the specified mapped area; then the
@@ -293,7 +296,7 @@ with specified IO tag in the command data:
   requests with the same IO tag. That is, ``UBLK_IO_COMMIT_AND_FETCH_REQ``
   is reused for both fetching request and committing back IO result.
 
-- ``UBLK_IO_NEED_GET_DATA``
+- ``UBLK_U_IO_NEED_GET_DATA``
 
   With ``UBLK_F_NEED_GET_DATA`` enabled, the WRITE request will be firstly
   issued to ublk server without data copy. Then, IO backend of ublk server
@@ -322,6 +325,55 @@ with specified IO tag in the command data:
   ``UBLK_IO_COMMIT_AND_FETCH_REQ`` to the server, ublkdrv needs to copy
   the server buffer (pages) read to the IO request pages.
 
+Batch I/O Commands (UBLK_F_BATCH_IO)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ``UBLK_F_BATCH_IO`` feature provides an alternative high-performance
+I/O handling model that replaces the traditional per-I/O commands with
+per-queue batch commands. This significantly reduces communication overhead
+and enables better load balancing across multiple server tasks.
+
+Key differences from traditional mode:
+
+- **Per-queue vs Per-I/O**: Commands operate on queues rather than individual I/Os
+- **Batch processing**: Multiple I/Os are handled in single operations
+- **Multishot commands**: Use io_uring multishot for reduced submission overhead
+- **Flexible task assignment**: Any task can handle any I/O (no per-I/O daemons)
+- **Better load balancing**: Tasks can adjust their workload dynamically
+
+Batch I/O Commands:
+
+- ``UBLK_U_IO_PREP_IO_CMDS``
+
+  Prepares multiple I/O commands in batch. The server provides a buffer
+  containing multiple I/O descriptors that will be processed together.
+  This reduces the number of individual command submissions required.
+
+- ``UBLK_U_IO_COMMIT_IO_CMDS``
+
+  Commits results for multiple I/O operations in batch. The server provides
+  a buffer containing the results of multiple completed I/Os, allowing
+  efficient bulk completion of requests.
+
+- ``UBLK_U_IO_FETCH_IO_CMDS``
+
+  **Multishot command** for fetching I/O commands in batch. This is the key
+  command that enables high-performance batch processing:
+
+  * Uses io_uring multishot capability for reduced submission overhead
+  * Single command can fetch multiple I/O requests over time
+  * Buffer size determines maximum batch size per operation
+  * Multiple fetch commands can be submitted for load balancing
+  * Only one fetch command is active at any time per queue
+  * Supports dynamic load balancing across multiple server tasks
+
+  Each task can submit ``UBLK_U_IO_FETCH_IO_CMDS`` with different buffer
+  sizes to control how much work it handles. This enables sophisticated
+  load balancing strategies in multi-threaded servers.
+
+Migration: Applications using traditional commands (``UBLK_U_IO_FETCH_REQ``,
+``UBLK_U_IO_COMMIT_AND_FETCH_REQ``) cannot use batch mode simultaneously.
+
 Zero copy
 ---------
 
-- 
2.47.0


