Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CFE6B0F44
	for <lists+linux-block@lfdr.de>; Wed,  8 Mar 2023 17:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjCHQyF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 8 Mar 2023 11:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjCHQyA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Mar 2023 11:54:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB165D276
        for <linux-block@vger.kernel.org>; Wed,  8 Mar 2023 08:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678294395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=74aMisHJvcrsbS5g8R7662ZNEA+1A6hMiypJVvVd5yo=;
        b=A19B4Ey6DrGvG1Ba6N287qxFG+OW30I6UoYxhi1jRGDOBeE0jLxJc+v9J11XGoCZ/epWzL
        IYNVdrouN5rCNEDkNSALw6V7pWqt5/0Il8mU3H+RH+PVZ47xXR5u3203dbdu+HUstj8ErU
        gThOZGshCThokiD3geE53q7t5Kj56WM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-CMD8rN7nNP6tp5tN6HG62A-1; Wed, 08 Mar 2023 11:53:11 -0500
X-MC-Unique: CMD8rN7nNP6tp5tN6HG62A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFF60100F909;
        Wed,  8 Mar 2023 16:53:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE39D492C3E;
        Wed,  8 Mar 2023 16:53:07 +0000 (UTC)
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Subject: [PATCH v17 04/14] overlayfs: Implement splice-read
Date:   Wed,  8 Mar 2023 16:52:41 +0000
Message-Id: <20230308165251.2078898-5-dhowells@redhat.com>
In-Reply-To: <20230308165251.2078898-1-dhowells@redhat.com>
References: <20230308165251.2078898-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Implement splice-read for overlayfs by passing the request down a layer
rather than going through generic_file_splice_read() which is going to be
changed to assume that ->read_folio() is present on buffered files.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: John Hubbard <jhubbard@nvidia.com>
cc: David Hildenbrand <david@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: linux-unionfs@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---

Notes:
    ver #17)
     - Use vfs_splice_read() helper rather than open-coding checks.
    
    ver #15)
     - Remove redundant FMODE_CAN_ODIRECT check on real file.
     - Do rw_verify_area() on the real file, not the overlay file.
     - Fix a file leak.

 fs/overlayfs/file.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 7c04f033aadd..86197882ff35 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -419,6 +419,27 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	return ret;
 }
 
+static ssize_t ovl_splice_read(struct file *in, loff_t *ppos,
+			       struct pipe_inode_info *pipe, size_t len,
+			       unsigned int flags)
+{
+	const struct cred *old_cred;
+	struct fd real;
+	ssize_t ret;
+
+	ret = ovl_real_fdget(in, &real);
+	if (ret)
+		return ret;
+
+	old_cred = ovl_override_creds(file_inode(in)->i_sb);
+	ret = vfs_splice_read(real.file, ppos, pipe, len, flags);
+	revert_creds(old_cred);
+	ovl_file_accessed(in);
+
+	fdput(real);
+	return ret;
+}
+
 /*
  * Calling iter_file_splice_write() directly from overlay's f_op may deadlock
  * due to lock order inversion between pipe->mutex in iter_file_splice_write()
@@ -695,7 +716,7 @@ const struct file_operations ovl_file_operations = {
 	.fallocate	= ovl_fallocate,
 	.fadvise	= ovl_fadvise,
 	.flush		= ovl_flush,
-	.splice_read    = generic_file_splice_read,
+	.splice_read    = ovl_splice_read,
 	.splice_write   = ovl_splice_write,
 
 	.copy_file_range	= ovl_copy_file_range,

