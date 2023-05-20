Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB89B70A3C8
	for <lists+linux-block@lfdr.de>; Sat, 20 May 2023 02:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjETADm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 19 May 2023 20:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjETADa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 20:03:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676B9171F
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 17:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684540912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zZb+7DwI4egZIrF5pxcV1ZQbliPAo6greLJudpvGjhA=;
        b=IpyLMx7vXnGdD0L9DZc568zv4blahMptjpuvQZgDY8D+L5ZuliYaKJQ/+Plq3/cAswkBu2
        /RaWfebc+6yGC6Aq/dJqK20K1UbsPCGj2Ez1hWPPuIHRt97skXkRnJx3kXld0XRF2Y0+qZ
        vTvI3Wc5zhK+aLab1UtySxIDkeJCJVw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-G93-k9ToPbKP465srY7iiw-1; Fri, 19 May 2023 20:01:48 -0400
X-MC-Unique: G93-k9ToPbKP465srY7iiw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F2AC85A5A8;
        Sat, 20 May 2023 00:01:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 00F7E4F2DE0;
        Sat, 20 May 2023 00:01:44 +0000 (UTC)
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
        Christoph Hellwig <hch@lst.de>, Tyler Hicks <code@tyhicks.com>,
        ecryptfs@vger.kernel.org
Subject: [PATCH v21 17/30] ecryptfs: Provide a splice-read stub
Date:   Sat, 20 May 2023 01:00:36 +0100
Message-Id: <20230520000049.2226926-18-dhowells@redhat.com>
In-Reply-To: <20230520000049.2226926-1-dhowells@redhat.com>
References: <20230520000049.2226926-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Provide a splice_read stub for ecryptfs to update the access time on the
lower file after the operation.  Splicing from a direct I/O fd will update
the access time when ->read_iter() is called.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Tyler Hicks <code@tyhicks.com>
cc: ecryptfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/ecryptfs/file.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 268b74499c28..284395587be0 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -44,6 +44,31 @@ static ssize_t ecryptfs_read_update_atime(struct kiocb *iocb,
 	return rc;
 }
 
+/*
+ * ecryptfs_splice_read_update_atime
+ *
+ * generic_file_splice_read updates the atime of upper layer inode.  But, it
+ * doesn't give us a chance to update the atime of the lower layer inode.  This
+ * function is a wrapper to generic_file_read.  It updates the atime of the
+ * lower level inode if generic_file_read returns without any errors. This is
+ * to be used only for file reads.  The function to be used for directory reads
+ * is ecryptfs_read.
+ */
+static ssize_t ecryptfs_splice_read_update_atime(struct file *in, loff_t *ppos,
+						 struct pipe_inode_info *pipe,
+						 size_t len, unsigned int flags)
+{
+	ssize_t rc;
+	const struct path *path;
+
+	rc = generic_file_splice_read(in, ppos, pipe, len, flags);
+	if (rc >= 0) {
+		path = ecryptfs_dentry_to_lower_path(in->f_path.dentry);
+		touch_atime(path);
+	}
+	return rc;
+}
+
 struct ecryptfs_getdents_callback {
 	struct dir_context ctx;
 	struct dir_context *caller;
@@ -414,5 +439,5 @@ const struct file_operations ecryptfs_main_fops = {
 	.release = ecryptfs_release,
 	.fsync = ecryptfs_fsync,
 	.fasync = ecryptfs_fasync,
-	.splice_read = generic_file_splice_read,
+	.splice_read = ecryptfs_splice_read_update_atime,
 };

