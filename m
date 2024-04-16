Return-Path: <linux-block+bounces-6242-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6188C8A5F7E
	for <lists+linux-block@lfdr.de>; Tue, 16 Apr 2024 02:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1E5AB20F55
	for <lists+linux-block@lfdr.de>; Tue, 16 Apr 2024 00:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AA3523D;
	Tue, 16 Apr 2024 00:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5gZU/NY"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843941879
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 00:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713229029; cv=none; b=vA6WZt9asBGBNsXg+F2LC3e5fcdlBUkK2gBJCjn7Y7uRAwDegIParwtuuC3RjB4xQjpb6Chev0N4a24KVvgjEeDi44SGMSjj8cmFcgPTQ95p09Yf08AIEJqUHcS1vGrDPDwiSgWFSqwSjWST60a1YdTCCHA4DTQj2zdOg9zKuN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713229029; c=relaxed/simple;
	bh=h78k/cMnV9WcZ+oIMMDsbGhDWujQU5+K66BUAeJcoKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cQijabgZChMSDJIV1K4lhe2NlE8tuvy5CS082I6Ffj3UOuEgCv0mPKjv5q6obRA5d9A4a2GUCKFt7/7rZiyMTDBj9DnOmvumPDvO1f6hprFkkZRSWksXLqJFGbi0+ppNkuQbHpA02Y/0vLRXYi5aGPsKxWOc5T971s0zROEUHUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5gZU/NY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713229026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rtfsBGt9nxVZSTBD+9lVdGFyEJvY5tLix3749+nDieY=;
	b=b5gZU/NYyzNq55fbKrntHensc1Q/KjNzJhUhg+F46b75zT/OIkUK/nvNlVbNSZaX+lhdQd
	Lq1d+0NjZ5uA+8MPzc8kQC5nq2L8V/X129jK2A4MwUuptYF1+X35BuE2z5n5rqbW7RZLiw
	XN7qwlfE/EnY8Z0WHg9kXSI4JJAPpMw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-eKWK1bd5MYWmJoObAClQxA-1; Mon,
 15 Apr 2024 20:57:02 -0400
X-MC-Unique: eKWK1bd5MYWmJoObAClQxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 898941C3F0EE;
	Tue, 16 Apr 2024 00:57:01 +0000 (UTC)
Received: from localhost (unknown [10.72.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8E3BA2166B31;
	Tue, 16 Apr 2024 00:57:00 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Mike Snitzer <snitzer@redhat.com>,
	dm-devel@lists.linux.dev
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Zhong Changhui <czhong@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] dm: core: put device mapper block device synchronously
Date: Tue, 16 Apr 2024 08:56:33 +0800
Message-ID: <20240416005633.877153-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

'dmsetup remove_all' actually depends on sync bdev release since
dm_lock_for_deletion() may return -EBUSY if the open count is > 0, and the
open count is dropped in dm_blk_close().

So if dm_blk_close() is delayed because of fput(), this device mapper
device is skipped in remove_all, and cause regression.

Fix the issue by using __fput_sync().

Reported-by: Zhong Changhui <czhong@redhat.com>
Fixes: a28d893eb327 ("md: port block device access to file")
Suggested-by: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/md/dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 56aa2a8b9d71..93f3d28b0f03 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -765,7 +765,7 @@ static struct table_device *open_table_device(struct mapped_device *md,
 	return td;
 
 out_blkdev_put:
-	fput(bdev_file);
+	__fput_sync(bdev_file);
 out_free_td:
 	kfree(td);
 	return ERR_PTR(r);
@@ -778,7 +778,7 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
 {
 	if (md->disk->slave_dir)
 		bd_unlink_disk_holder(td->dm_dev.bdev, md->disk);
-	fput(td->dm_dev.bdev_file);
+	__fput_sync(td->dm_dev.bdev_file);
 	put_dax(td->dm_dev.dax_dev);
 	list_del(&td->list);
 	kfree(td);
-- 
2.44.0


