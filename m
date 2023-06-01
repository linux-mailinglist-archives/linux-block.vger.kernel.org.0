Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5AF71A182
	for <lists+linux-block@lfdr.de>; Thu,  1 Jun 2023 17:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbjFAPAm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 1 Jun 2023 11:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbjFAPAM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Jun 2023 11:00:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D789DE6E;
        Thu,  1 Jun 2023 07:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+TlwHQVmCcfSC9sL9si103D1qv7dfudCnmtDuQc976U=; b=yIATEWuIAieoRWEpSxfntSFM82
        D+6jfMT4RQR3K25Sc8qxUL3xmhBQEZes7Zhlyb8ubufcv1k8qbQva3Oe6nISgXoPjgL30hb7xLxJ+
        uZqMsD5J2azG/uOjx0fdrb6/BRFzfBzZ76dbKDHHLdWrosxPBlXV2r5DQ+ViMhKg9IHFswYO4OFpX
        3cL38j2lR+fVSkaafjR6sb/+/aMQTfObjF1aCBNYyxDUyYbKpXHNbprk22T+YX9mpEUebqgGMIj19
        2DV9Ornvu0Ao7dkRQ5oR4MaV/TVC/AaODDqXImZSmmjuQAmvJ8FcuvW6KrYWbIE7yi7iNO/XLAoiu
        GJYCm/Xg==;
Received: from [2001:4bb8:182:6d06:eacb:c751:971:73eb] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4jlv-003w8I-0Z;
        Thu, 01 Jun 2023 14:59:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 08/12] iomap: use kiocb_write_and_wait and kiocb_invalidate_pages
Date:   Thu,  1 Jun 2023 16:59:00 +0200
Message-Id: <20230601145904.1385409-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601145904.1385409-1-hch@lst.de>
References: <20230601145904.1385409-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the common helpers for direct I/O page invalidation instead of
open coding the logic.  This leads to a slight reordering of checks
in __iomap_dio_rw to keep the logic straight.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/direct-io.c | 55 ++++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 35 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 0795c54a745bca..6bd14691f96e07 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -472,7 +472,6 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before)
 {
-	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct iomap_iter iomi = {
 		.inode		= inode,
@@ -481,11 +480,11 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		.flags		= IOMAP_DIRECT,
 		.private	= private,
 	};
-	loff_t end = iomi.pos + iomi.len - 1, ret = 0;
 	bool wait_for_completion =
 		is_sync_kiocb(iocb) || (dio_flags & IOMAP_DIO_FORCE_WAIT);
 	struct blk_plug plug;
 	struct iomap_dio *dio;
+	loff_t ret = 0;
 
 	trace_iomap_dio_rw_begin(iocb, iter, dio_flags, done_before);
 
@@ -509,31 +508,29 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	dio->submit.waiter = current;
 	dio->submit.poll_bio = NULL;
 
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		iomi.flags |= IOMAP_NOWAIT;
+
 	if (iov_iter_rw(iter) == READ) {
 		if (iomi.pos >= dio->i_size)
 			goto out_free_dio;
 
-		if (iocb->ki_flags & IOCB_NOWAIT) {
-			if (filemap_range_needs_writeback(mapping, iomi.pos,
-					end)) {
-				ret = -EAGAIN;
-				goto out_free_dio;
-			}
-			iomi.flags |= IOMAP_NOWAIT;
-		}
-
 		if (user_backed_iter(iter))
 			dio->flags |= IOMAP_DIO_DIRTY;
+
+		ret = kiocb_write_and_wait(iocb, iomi.len);
+		if (ret)
+			goto out_free_dio;
 	} else {
 		iomi.flags |= IOMAP_WRITE;
 		dio->flags |= IOMAP_DIO_WRITE;
 
-		if (iocb->ki_flags & IOCB_NOWAIT) {
-			if (filemap_range_has_page(mapping, iomi.pos, end)) {
-				ret = -EAGAIN;
+		if (dio_flags & IOMAP_DIO_OVERWRITE_ONLY) {
+			ret = -EAGAIN;
+			if (iomi.pos >= dio->i_size ||
+			    iomi.pos + iomi.len > dio->i_size)
 				goto out_free_dio;
-			}
-			iomi.flags |= IOMAP_NOWAIT;
+			iomi.flags |= IOMAP_OVERWRITE_ONLY;
 		}
 
 		/* for data sync or sync, we need sync completion processing */
@@ -549,31 +546,19 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			if (!(iocb->ki_flags & IOCB_SYNC))
 				dio->flags |= IOMAP_DIO_WRITE_FUA;
 		}
-	}
-
-	if (dio_flags & IOMAP_DIO_OVERWRITE_ONLY) {
-		ret = -EAGAIN;
-		if (iomi.pos >= dio->i_size ||
-		    iomi.pos + iomi.len > dio->i_size)
-			goto out_free_dio;
-		iomi.flags |= IOMAP_OVERWRITE_ONLY;
-	}
 
-	ret = filemap_write_and_wait_range(mapping, iomi.pos, end);
-	if (ret)
-		goto out_free_dio;
-
-	if (iov_iter_rw(iter) == WRITE) {
 		/*
 		 * Try to invalidate cache pages for the range we are writing.
 		 * If this invalidation fails, let the caller fall back to
 		 * buffered I/O.
 		 */
-		if (invalidate_inode_pages2_range(mapping,
-				iomi.pos >> PAGE_SHIFT, end >> PAGE_SHIFT)) {
-			trace_iomap_dio_invalidate_fail(inode, iomi.pos,
-							iomi.len);
-			ret = -ENOTBLK;
+		ret = kiocb_invalidate_pages(iocb, iomi.len);
+		if (ret) {
+			if (ret != -EAGAIN) {
+				trace_iomap_dio_invalidate_fail(inode, iomi.pos,
+								iomi.len);
+				ret = -ENOTBLK;
+			}
 			goto out_free_dio;
 		}
 
-- 
2.39.2

