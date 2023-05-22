Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9F270C08A
	for <lists+linux-block@lfdr.de>; Mon, 22 May 2023 15:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbjEVN40 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 22 May 2023 09:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbjEVNzr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 09:55:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303BC19B2
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 06:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684763542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sPgb6iT0KyhUHD55wBvrfISNeJ76P+kmnyDDc2IZvro=;
        b=GlrWBAmoNYAESyBS3ymQV24WyKnB/GoNXn86Ai/y1dpCRjLtiNbX2EdiJB4xqkqpK8FEZm
        fQjPIOhz8rRE6kkYMsUGrOPEXlD++pIEq2b8uzsgo1lKJLJ5xaBVPdjCUPjvowH3oS15Gz
        oVRvI5UTMb/rOY8ACkVhxrNCq0k1yEo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-wzCHOXg9PImMcHZvn4QAHg-1; Mon, 22 May 2023 09:52:19 -0400
X-MC-Unique: wzCHOXg9PImMcHZvn4QAHg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB97D8032F5;
        Mon, 22 May 2023 13:52:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A30C40CFD45;
        Mon, 22 May 2023 13:52:14 +0000 (UTC)
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
        Steve French <smfrench@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>, linux-cifs@vger.kernel.org
Subject: [PATCH v22 29/31] splice: Remove generic_file_splice_read()
Date:   Mon, 22 May 2023 14:50:16 +0100
Message-Id: <20230522135018.2742245-30-dhowells@redhat.com>
In-Reply-To: <20230522135018.2742245-1-dhowells@redhat.com>
References: <20230522135018.2742245-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove generic_file_splice_read() as it has been replaced with calls to
filemap_splice_read() and copy_splice_read().

With this, ITER_PIPE is no longer used.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Steve French <smfrench@gmail.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---

Notes:
    ver #21)
     - Move zero-len check to vfs_splice_read().
     - Move s_maxbytes check to filemap_splice_read().
     - DIO (and DAX) are handled by vfs_splice_read().
    
    ver #20)
     - Use s_maxbytes from the backing store (in->f_mapping), not the front
       inode (especially for a blockdev).
    
    ver #18)
     - Split out the change to cifs to make it use generic_file_splice_read().
     - Split out the unexport of filemap_splice_read() (still needed by cifs).

 fs/splice.c        | 43 -------------------------------------------
 include/linux/fs.h |  2 --
 2 files changed, 45 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 8268248df3a9..9be4cb3b9879 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -386,49 +386,6 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 }
 EXPORT_SYMBOL(copy_splice_read);
 
-/**
- * generic_file_splice_read - splice data from file to a pipe
- * @in:		file to splice from
- * @ppos:	position in @in
- * @pipe:	pipe to splice to
- * @len:	number of bytes to splice
- * @flags:	splice modifier flags
- *
- * Description:
- *    Will read pages from given file and fill them into a pipe. Can be
- *    used as long as it has more or less sane ->read_iter().
- *
- */
-ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
-				 struct pipe_inode_info *pipe, size_t len,
-				 unsigned int flags)
-{
-	struct iov_iter to;
-	struct kiocb kiocb;
-	int ret;
-
-	iov_iter_pipe(&to, ITER_DEST, pipe, len);
-	init_sync_kiocb(&kiocb, in);
-	kiocb.ki_pos = *ppos;
-	ret = call_read_iter(in, &kiocb, &to);
-	if (ret > 0) {
-		*ppos = kiocb.ki_pos;
-		file_accessed(in);
-	} else if (ret < 0) {
-		/* free what was emitted */
-		pipe_discard_from(pipe, to.start_head);
-		/*
-		 * callers of ->splice_read() expect -EAGAIN on
-		 * "can't put anything in there", rather than -EFAULT.
-		 */
-		if (ret == -EFAULT)
-			ret = -EAGAIN;
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL(generic_file_splice_read);
-
 const struct pipe_buf_operations default_pipe_buf_ops = {
 	.release	= generic_pipe_buf_release,
 	.try_steal	= generic_pipe_buf_try_steal,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e3c22efa413e..08ba2ae1d3ce 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2755,8 +2755,6 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 			 struct pipe_inode_info *pipe,
 			 size_t len, unsigned int flags);
-extern ssize_t generic_file_splice_read(struct file *, loff_t *,
-		struct pipe_inode_info *, size_t, unsigned int);
 extern ssize_t iter_file_splice_write(struct pipe_inode_info *,
 		struct file *, loff_t *, size_t, unsigned int);
 extern ssize_t generic_splice_sendpage(struct pipe_inode_info *pipe,

