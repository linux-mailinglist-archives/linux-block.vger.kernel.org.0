Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2963170A3D1
	for <lists+linux-block@lfdr.de>; Sat, 20 May 2023 02:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjETAEh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 19 May 2023 20:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjETADy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 20:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FEC1BC0
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 17:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684540932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xweayQ6b4+yKTogEWKPvOcFVzWq2Z7yytw9vgW43n8c=;
        b=fqGiAR5LxDOn7Oyq0CHvwKYEtcuqzcspw/TDWa8KIk2iEx+q/JcvEGd+eaHpHq4qq/3Uex
        5lCBPUW6Z4sImfUDPiFPtMXlOIHO6iWQguQb7zuHFHGEacX4tRtWDzDYtAjTwrOltc2io8
        sJmBer7Cos42mYkvebdfEPxsf5AxTsk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-5lqrDGK7M6yCYGGKczU41Q-1; Fri, 19 May 2023 20:02:09 -0400
X-MC-Unique: 5lqrDGK7M6yCYGGKczU41Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72A7438035AA;
        Sat, 20 May 2023 00:02:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43E827C52;
        Sat, 20 May 2023 00:02:06 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: [PATCH v21 24/30] xfs: Provide a splice-read stub
Date:   Sat, 20 May 2023 01:00:43 +0100
Message-Id: <20230520000049.2226926-25-dhowells@redhat.com>
In-Reply-To: <20230520000049.2226926-1-dhowells@redhat.com>
References: <20230520000049.2226926-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Provide a splice_read stub for XFS.  This does a stat count and a shutdown
check before proceeding, then emits a new trace line and locks the inode
across the call to filemap_splice_read() and adds to the stats afterwards.
Splicing from direct I/O or DAX is handled by the caller.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Darrick J. Wong <djwong@kernel.org>
cc: linux-xfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/xfs/xfs_file.c  | 30 +++++++++++++++++++++++++++++-
 fs/xfs/xfs_trace.h |  2 +-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index aede746541f8..08d632668e94 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -306,6 +306,34 @@ xfs_file_read_iter(
 	return ret;
 }
 
+STATIC ssize_t
+xfs_file_splice_read(
+	struct file		*in,
+	loff_t			*ppos,
+	struct pipe_inode_info	*pipe,
+	size_t			len,
+	unsigned int		flags)
+{
+	struct inode		*inode = file_inode(in);
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+	ssize_t			ret = 0;
+
+	XFS_STATS_INC(mp, xs_read_calls);
+
+	if (xfs_is_shutdown(mp))
+		return -EIO;
+
+	trace_xfs_file_splice_read(ip, *ppos, len);
+
+	xfs_ilock(ip, XFS_IOLOCK_SHARED);
+	ret = filemap_splice_read(in, ppos, pipe, len, flags);
+	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
+	if (ret > 0)
+		XFS_STATS_ADD(mp, xs_read_bytes, ret);
+	return ret;
+}
+
 /*
  * Common pre-write limit and setup checks.
  *
@@ -1423,7 +1451,7 @@ const struct file_operations xfs_file_operations = {
 	.llseek		= xfs_file_llseek,
 	.read_iter	= xfs_file_read_iter,
 	.write_iter	= xfs_file_write_iter,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= xfs_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.iopoll		= iocb_bio_iopoll,
 	.unlocked_ioctl	= xfs_file_ioctl,
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index cd4ca5b1fcb0..4db669203149 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1445,7 +1445,6 @@ DEFINE_RW_EVENT(xfs_file_direct_write);
 DEFINE_RW_EVENT(xfs_file_dax_write);
 DEFINE_RW_EVENT(xfs_reflink_bounce_dio_write);
 
-
 DECLARE_EVENT_CLASS(xfs_imap_class,
 	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count,
 		 int whichfork, struct xfs_bmbt_irec *irec),
@@ -1535,6 +1534,7 @@ DEFINE_SIMPLE_IO_EVENT(xfs_zero_eof);
 DEFINE_SIMPLE_IO_EVENT(xfs_end_io_direct_write);
 DEFINE_SIMPLE_IO_EVENT(xfs_end_io_direct_write_unwritten);
 DEFINE_SIMPLE_IO_EVENT(xfs_end_io_direct_write_append);
+DEFINE_SIMPLE_IO_EVENT(xfs_file_splice_read);
 
 DECLARE_EVENT_CLASS(xfs_itrunc_class,
 	TP_PROTO(struct xfs_inode *ip, xfs_fsize_t new_size),

