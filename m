Return-Path: <linux-block+bounces-10933-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C48960271
	for <lists+linux-block@lfdr.de>; Tue, 27 Aug 2024 08:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9F41C204FA
	for <lists+linux-block@lfdr.de>; Tue, 27 Aug 2024 06:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F5B1494DB;
	Tue, 27 Aug 2024 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lg59uPG5"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B416D148302;
	Tue, 27 Aug 2024 06:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741506; cv=none; b=Duoj/BPPFGID4P58pbuBU08d/zSEbWWvl0xMLirLvEb8beUQ0RPcNagCXPeSjJuORoYFAKgv03nL8CLwLhCM5AQY5bIQJ+6btMXeUWpjVCAkf1Fe+0yz/vYiGOGORGyGSFpvgj5v6dwaRSc75ZYzoc8rZMSNkWQPthJNFJuFLx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741506; c=relaxed/simple;
	bh=NfsUmb0FFYcRiilsybc0zMaPYMckdg0NKbGXwdEKHHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKBqlW4upyFm7+md0gihfooaEQnIla98Zi1cgX5mXYi5G9SEsxwKXw597hmVFunklhAP0VimyARLMFsa49uOABzPQZyB2p/yrAcUzMruq4n6wgVaRITPpKpyCKtjmQbJ8wb81xi9J+YPrfqZw5tmuqZ07chNVluDuTJnn+ZxHAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lg59uPG5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vU0kWYfABuwka6VI88n56wkqORAR2MTSaeAFqfvEHnk=; b=Lg59uPG5eq40QDvQwTnPpdsgi4
	+MEvWz7QkRVrIvAiam21Z47zhKA47RaEck4OqEkzbxW4xyh9CSW9RrV3CA0xTLSW2WOh2oI3mbJyp
	taPEZM6TVC0dkTg2Nq4H4mxQRbYJata3DWKqSlX/v2SNSg3fQ1fQ5dIg0YZnH+p4qVHvx7XD8COfd
	PdKSppCV4S04Mne1xcwX2LZb2qhxBR5FA0y/g774nJUN3zjTaRyBKTRoQAzp+ryrG3qa7OBKR0dcn
	VB0O/JlgTLicRm+rGdtlSXrrK8XC6nDBf1jltOShY+WVtayM00GeQDIbyLbX/KyX/0Z2GL8zXRvcj
	DTLLjliQ==;
Received: from 2a02-8389-2341-5b80-0483-5781-2c2b-8fb4.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:483:5781:2c2b:8fb4] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siq3I-0000000A6Hc-2K1S;
	Tue, 27 Aug 2024 06:51:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>
Cc: Brian Foster <bfoster@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 5/6] xfs: move the xfs_is_always_cow_inode check into xfs_alloc_file_space
Date: Tue, 27 Aug 2024 08:50:49 +0200
Message-ID: <20240827065123.1762168-6-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827065123.1762168-1-hch@lst.de>
References: <20240827065123.1762168-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Move the xfs_is_always_cow_inode check from the caller into
xfs_alloc_file_space to prepare for refactoring of xfs_file_fallocate.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_bmap_util.c | 3 +++
 fs/xfs/xfs_file.c      | 8 +++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 187a0dbda24fc4..e9fdebaa40ea59 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -653,6 +653,9 @@ xfs_alloc_file_space(
 	xfs_bmbt_irec_t		imaps[1], *imapp;
 	int			error;
 
+	if (xfs_is_always_cow_inode(ip))
+		return 0;
+
 	trace_xfs_alloc_file_space(ip);
 
 	if (xfs_is_shutdown(mp))
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 5b9e49da06013c..489bc1b173c268 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -987,11 +987,9 @@ xfs_file_fallocate(
 			}
 		}
 
-		if (!xfs_is_always_cow_inode(ip)) {
-			error = xfs_alloc_file_space(ip, offset, len);
-			if (error)
-				goto out_unlock;
-		}
+		error = xfs_alloc_file_space(ip, offset, len);
+		if (error)
+			goto out_unlock;
 	}
 
 	/* Change file size if needed */
-- 
2.43.0


