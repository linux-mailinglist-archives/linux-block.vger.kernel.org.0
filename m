Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EDD6BB9D2
	for <lists+linux-block@lfdr.de>; Wed, 15 Mar 2023 17:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjCOQhM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Mar 2023 12:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjCOQhC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Mar 2023 12:37:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17F56B309
        for <linux-block@vger.kernel.org>; Wed, 15 Mar 2023 09:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678898168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=imlbxN8+e/h/7fdYpvOZBQo8e/sPfLa+LUB+/4kjN58=;
        b=I8lhhXuV6OzXKczJwuv/rsrOynpk8jbTSfyLimvcQx83gAQ7U/qwRf9T5KMLKdyIFjbUCW
        YmzDeCLiSwQZvdAOsIpViNhUfSXk9J2gMvOX7HoSzUCJVBviegG6ackZQPBTDsLmR8AXGs
        YNkyFdWH6hqBT7Z8R1sc5qSqN57s7Ig=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-Ki0JtdioOVChXpS3qKCPXQ-1; Wed, 15 Mar 2023 12:36:06 -0400
X-MC-Unique: Ki0JtdioOVChXpS3qKCPXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BDF888B7A0;
        Wed, 15 Mar 2023 16:36:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DE122166B26;
        Wed, 15 Mar 2023 16:35:59 +0000 (UTC)
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
        Daniel Golle <daniel@makrotopia.org>,
        Guenter Roeck <groeck7@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH v19 03/15] shmem: Implement splice-read
Date:   Wed, 15 Mar 2023 16:35:37 +0000
Message-Id: <20230315163549.295454-4-dhowells@redhat.com>
In-Reply-To: <20230315163549.295454-1-dhowells@redhat.com>
References: <20230315163549.295454-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The new filemap_splice_read() has an implicit expectation via
filemap_get_pages() that ->read_folio() exists if ->readahead() doesn't
fully populate the pagecache of the file it is reading from[1], potentially
leading to a jump to NULL if this doesn't exist.  shmem, however, (and by
extension, tmpfs, ramfs and rootfs), doesn't have ->read_folio(),

Work around this by equipping shmem with its own splice-read
implementation, based on filemap_splice_read(), but able to paste in
zero_page when there's a page missing.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Daniel Golle <daniel@makrotopia.org>
cc: Guenter Roeck <groeck7@gmail.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: John Hubbard <jhubbard@nvidia.com>
cc: David Hildenbrand <david@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Hugh Dickins <hughd@google.com>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
Link: https://lore.kernel.org/r/Y+pdHFFTk1TTEBsO@makrotopia.org/ [1]
---

Notes:
    ver #19)
     - Remove a missed get_page() on the zero page.
    
    ver #18)
     - Don't take/release a ref on the zero page.

 mm/shmem.c | 134 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 133 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 448f393d8ab2..a0c268dcf7b8 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2719,6 +2719,138 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return retval ? retval : error;
 }
 
+static bool zero_pipe_buf_get(struct pipe_inode_info *pipe,
+			      struct pipe_buffer *buf)
+{
+	return true;
+}
+
+static void zero_pipe_buf_release(struct pipe_inode_info *pipe,
+				  struct pipe_buffer *buf)
+{
+}
+
+static bool zero_pipe_buf_try_steal(struct pipe_inode_info *pipe,
+				    struct pipe_buffer *buf)
+{
+	return false;
+}
+
+static const struct pipe_buf_operations zero_pipe_buf_ops = {
+	.release	= zero_pipe_buf_release,
+	.try_steal	= zero_pipe_buf_try_steal,
+	.get		= zero_pipe_buf_get,
+};
+
+static size_t splice_zeropage_into_pipe(struct pipe_inode_info *pipe,
+					loff_t fpos, size_t size)
+{
+	size_t offset = fpos & ~PAGE_MASK;
+
+	size = min_t(size_t, size, PAGE_SIZE - offset);
+
+	if (!pipe_full(pipe->head, pipe->tail, pipe->max_usage)) {
+		struct pipe_buffer *buf = pipe_head_buf(pipe);
+
+		*buf = (struct pipe_buffer) {
+			.ops	= &zero_pipe_buf_ops,
+			.page	= ZERO_PAGE(0),
+			.offset	= offset,
+			.len	= size,
+		};
+		pipe->head++;
+	}
+
+	return size;
+}
+
+static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
+				      struct pipe_inode_info *pipe,
+				      size_t len, unsigned int flags)
+{
+	struct inode *inode = file_inode(in);
+	struct address_space *mapping = inode->i_mapping;
+	struct folio *folio = NULL;
+	size_t total_spliced = 0, used, npages, n, part;
+	loff_t isize;
+	int error = 0;
+
+	/* Work out how much data we can actually add into the pipe */
+	used = pipe_occupancy(pipe->head, pipe->tail);
+	npages = max_t(ssize_t, pipe->max_usage - used, 0);
+	len = min_t(size_t, len, npages * PAGE_SIZE);
+
+	do {
+		if (*ppos >= i_size_read(inode))
+			break;
+
+		error = shmem_get_folio(inode, *ppos / PAGE_SIZE, &folio, SGP_READ);
+		if (error) {
+			if (error == -EINVAL)
+				error = 0;
+			break;
+		}
+		if (folio) {
+			folio_unlock(folio);
+
+			if (folio_test_hwpoison(folio)) {
+				error = -EIO;
+				break;
+			}
+		}
+
+		/*
+		 * i_size must be checked after we know the pages are Uptodate.
+		 *
+		 * Checking i_size after the check allows us to calculate
+		 * the correct value for "nr", which means the zero-filled
+		 * part of the page is not copied back to userspace (unless
+		 * another truncate extends the file - this is desired though).
+		 */
+		isize = i_size_read(inode);
+		if (unlikely(*ppos >= isize))
+			break;
+		part = min_t(loff_t, isize - *ppos, len);
+
+		if (folio) {
+			/*
+			 * If users can be writing to this page using arbitrary
+			 * virtual addresses, take care about potential aliasing
+			 * before reading the page on the kernel side.
+			 */
+			if (mapping_writably_mapped(mapping))
+				flush_dcache_folio(folio);
+			folio_mark_accessed(folio);
+			/*
+			 * Ok, we have the page, and it's up-to-date, so we can
+			 * now splice it into the pipe.
+			 */
+			n = splice_folio_into_pipe(pipe, folio, *ppos, part);
+			folio_put(folio);
+			folio = NULL;
+		} else {
+			n = splice_zeropage_into_pipe(pipe, *ppos, len);
+		}
+
+		if (!n)
+			break;
+		len -= n;
+		total_spliced += n;
+		*ppos += n;
+		in->f_ra.prev_pos = *ppos;
+		if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
+			break;
+
+		cond_resched();
+	} while (len);
+
+	if (folio)
+		folio_put(folio);
+
+	file_accessed(in);
+	return total_spliced ? total_spliced : error;
+}
+
 static loff_t shmem_file_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct address_space *mapping = file->f_mapping;
@@ -3938,7 +4070,7 @@ static const struct file_operations shmem_file_operations = {
 	.read_iter	= shmem_file_read_iter,
 	.write_iter	= generic_file_write_iter,
 	.fsync		= noop_fsync,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= shmem_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= shmem_fallocate,
 #endif

