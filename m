Return-Path: <linux-block+bounces-28900-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1FFBFE7E6
	for <lists+linux-block@lfdr.de>; Thu, 23 Oct 2025 01:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0BFA18C7A98
	for <lists+linux-block@lfdr.de>; Wed, 22 Oct 2025 23:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC623090FA;
	Wed, 22 Oct 2025 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Xam4zb5r"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-lf1-f100.google.com (mail-lf1-f100.google.com [209.85.167.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B567306D58
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 23:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761174825; cv=none; b=aZZBNnvY4HyTZkS61iPpwlj5lTrDWUJguWK81tm4pw6jae1ElUzBnghd4QQkNsmvOySxx38e/kwrfiqeve3UERmzAGGkPA9Vz7buyLw/z57NLJQmen/3gJOdd91mGFzExZvyrKZRZ+UEAwMDn8RhPlDf99GbZUajIe9cgagxobg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761174825; c=relaxed/simple;
	bh=1OFERuWCzicdiztTF/q7QW5F9IVu0Slo/TPxet3gSrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsOTuvk4Nyc2kCBLNYvNMWWJeisJBbWFdzdrbuv35HotE2vf47qe92aAoZkedeEkk9qprxmXcedDNRjvyz4BCfq44Ne3jJbsYVhzlNcB4hxOW0xzfmdRiFDnXpvbO/dXOHW+89J9FODeWamydNB95MPFsvMZNVE4NgnIXMk2y7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Xam4zb5r; arc=none smtp.client-ip=209.85.167.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lf1-f100.google.com with SMTP id 2adb3069b0e04-591b99cb0c4so18941e87.2
        for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 16:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761174820; x=1761779620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYyTEOzXOC/G6qb7jIG39TqesYubyS/P5gHR3qDN/K4=;
        b=Xam4zb5r16Y/IKCWvP6QITJYoF7heFJEsed8B8UaZanQH8/Vewr+LukGzqTyZt/+oz
         7+V26lZY/FyKcX4U4BcWRvwLwazfXkLMm48UCoJwW6ztXSgfCNKFE+CaIINgpfyuJVK+
         xzzxMQYBaAgQXF3rBZ2b6vQYemDhCe39JDVvycZR5FQNriI+FanqPZzQxF07BUEntRBy
         5EQ2yj1jif4Qo7ynIVspsunPeJr/FaLSt23CSyRt1CXTaQJrNnWCV28gZUc9WT+9oUfa
         kJIEOa2OWtw4AlR32nnWWx8T1+SUFiU3M0x685wNVBcosmCIYd71NVC4CNKmK28om9hQ
         RaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761174820; x=1761779620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYyTEOzXOC/G6qb7jIG39TqesYubyS/P5gHR3qDN/K4=;
        b=J6yzlmW9aQ6i76KmPXo50yl92cImFlR8eCJZvzAqabUNG5lKR5SInp97m1QbXJCV/O
         kEmdJHmt24EqwvW7K1YC+/BIX7jMCR6MBrPy3u1fY+NuYmhnr31TgJqODVBBYF7HP9+m
         7fwBBEaGDGBflgGP36iNUwRYZ3u4ee7jFHPgfxkqxui0dTcT/wOf3mjKpKOhtcUpigle
         3xV8/UpFmnyrlWnxWCxoL3MTCkE9Ve9HHEU1h+szZCgnf/wllp7yknbptbvccwIPG9tL
         JNsxMexuntAkHSO3+wiL+KK5czFLC82zt9e+JVsqwYjZcw/MQ4VBUJri4J+s15qXrtzW
         cLCA==
X-Forwarded-Encrypted: i=1; AJvYcCUR+1hzMK0cOGzdPyGWxmF20XB0TN5/ZyU8JwR4Hc2hIaY/mGcLoEtIIFTIoOosgTgNv8Ts0SUsbHZP0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+deg28nzcNnLuiYz1/IaFPXcFQXr2gyUzNoRt/1jvdC4FQw9S
	j6RleqfWHYtpDty/BNONHZ8DeTecnODZ/9fyyGZvYTLjk6bZt8OMas36wLHf1pDvG6x7roQ46jk
	yYBqTVQ9GF+1nJ0QJwzyhxz6mrz790RnIGh7aPg4rrmywfWO8OM/x
X-Gm-Gg: ASbGnctan/IWj8Jd2rdxSW13IAKdDJxCaXYWnehvlJnntYL3gE/j9k0kXHYneu+fkKV
	o4kr9UsngwF6M/hg36b402PFtcms4E02sBxYmNmyiH53oOD13ARw+bskNMRTvtVi2FdBCwdbT9u
	tHTW78Z2/i1GkWM9cxQhct4oMhCu+e1qBRZ54yf0ZMIXXN3opt2ZCqxEKhgzR9wXjI422DxbG6F
	XCLipdc48h6KD65h8BRNJAz55QoVmfUoHaN3gu+5/BMoYE87fTy2Y5m7SArjsOBN/TT1x/yRIlw
	o8xi6WfDmtYKzJCfNVJJoddwtvg1r0labrwPdX0L3Zhbex5HV1mm/A7t1+gboqhTFd8U2MqOkmR
	lsFiBsUmX4WltYX0K
X-Google-Smtp-Source: AGHT+IGpBSpTcUsGiFW1y6xN6RAigIl6sP5f7WQURKVhSLye12F+OPVHcs9jbRx67/PqsX7m7H0LAVn7y4om
X-Received: by 2002:a05:6512:2209:b0:57a:2be1:d766 with SMTP id 2adb3069b0e04-591d854a5a5mr3690398e87.4.1761174820364;
        Wed, 22 Oct 2025 16:13:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-592f4ce7a08sm35160e87.29.2025.10.22.16.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 16:13:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B07D23406A7;
	Wed, 22 Oct 2025 17:13:38 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id AD471E4181C; Wed, 22 Oct 2025 17:13:38 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/3] io_uring/uring_cmd: call io_should_terminate_tw() when needed
Date: Wed, 22 Oct 2025 17:13:25 -0600
Message-ID: <20251022231326.2527838-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251022231326.2527838-1-csander@purestorage.com>
References: <20251022231326.2527838-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most uring_cmd task work callbacks don't check IO_URING_F_TASK_DEAD. But
it's computed unconditionally in io_uring_cmd_work(). Add a helper
io_uring_cmd_should_terminate_tw() and call it instead of checking
IO_URING_F_TASK_DEAD in the one callback, fuse_uring_send_in_task().
Remove the now unused IO_URING_F_TASK_DEAD.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 fs/fuse/dev_uring.c            | 2 +-
 include/linux/io_uring/cmd.h   | 7 ++++++-
 include/linux/io_uring_types.h | 1 -
 io_uring/uring_cmd.c           | 6 +-----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index f6b12aebb8bb..71b0c9662716 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1214,11 +1214,11 @@ static void fuse_uring_send_in_task(struct io_uring_cmd *cmd,
 {
 	struct fuse_ring_ent *ent = uring_cmd_to_ring_ent(cmd);
 	struct fuse_ring_queue *queue = ent->queue;
 	int err;
 
-	if (!(issue_flags & IO_URING_F_TASK_DEAD)) {
+	if (!io_uring_cmd_should_terminate_tw(cmd)) {
 		err = fuse_uring_prepare_send(ent, ent->fuse_req);
 		if (err) {
 			fuse_uring_next_fuse_req(ent, queue, issue_flags);
 			return;
 		}
diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 7509025b4071..b84b97c21b43 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 #ifndef _LINUX_IO_URING_CMD_H
 #define _LINUX_IO_URING_CMD_H
 
 #include <uapi/linux/io_uring.h>
-#include <linux/io_uring_types.h>
+#include <linux/io_uring.h>
 #include <linux/blk-mq.h>
 
 /* only top 8 bits of sqe->uring_cmd_flags for kernel internal use */
 #define IORING_URING_CMD_CANCELABLE	(1U << 30)
 /* io_uring_cmd is being issued again */
@@ -143,10 +143,15 @@ static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
 			io_uring_cmd_tw_t task_work_cb)
 {
 	__io_uring_cmd_do_in_task(ioucmd, task_work_cb, 0);
 }
 
+static inline bool io_uring_cmd_should_terminate_tw(struct io_uring_cmd *cmd)
+{
+	return io_should_terminate_tw(cmd_to_io_kiocb(cmd)->ctx);
+}
+
 static inline struct task_struct *io_uring_cmd_get_task(struct io_uring_cmd *cmd)
 {
 	return cmd_to_io_kiocb(cmd)->tctx->task;
 }
 
diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index c2ea6280901d..278c4a25c9e8 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -37,11 +37,10 @@ enum io_uring_cmd_flags {
 	IO_URING_F_IOPOLL		= (1 << 10),
 
 	/* set when uring wants to cancel a previously issued command */
 	IO_URING_F_CANCEL		= (1 << 11),
 	IO_URING_F_COMPAT		= (1 << 12),
-	IO_URING_F_TASK_DEAD		= (1 << 13),
 };
 
 struct io_wq_work_node {
 	struct io_wq_work_node *next;
 };
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index d1e3ba62ee8e..35bdac35cf4d 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -114,17 +114,13 @@ void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 EXPORT_SYMBOL_GPL(io_uring_cmd_mark_cancelable);
 
 static void io_uring_cmd_work(struct io_kiocb *req, io_tw_token_t tw)
 {
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
-	unsigned int flags = IO_URING_F_COMPLETE_DEFER;
-
-	if (io_should_terminate_tw(req->ctx))
-		flags |= IO_URING_F_TASK_DEAD;
 
 	/* task_work executor checks the deffered list completion */
-	ioucmd->task_work_cb(ioucmd, flags);
+	ioucmd->task_work_cb(ioucmd, IO_URING_F_COMPLETE_DEFER);
 }
 
 void __io_uring_cmd_do_in_task(struct io_uring_cmd *ioucmd,
 			io_uring_cmd_tw_t task_work_cb,
 			unsigned flags)
-- 
2.45.2


