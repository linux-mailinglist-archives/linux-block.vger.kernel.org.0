Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFECC699F2F
	for <lists+linux-block@lfdr.de>; Thu, 16 Feb 2023 22:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjBPVtH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 Feb 2023 16:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBPVtG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 16:49:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5AA4C6F7
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 13:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676584092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iluk0YvlYbmqrBsJ+zi3CUpWIoo6vLBgAkY0zGemXLc=;
        b=FsO8W0yGrf6/pndd+YAS1gh7P8MDvWHeU0tayG5MwbhaoB8o6G6hDfAt7OXYN6C2ay38/Z
        dXj9R28FOC9ige9j183l/qCg7xzehUVb0RxiXemw3jWwaNFiSAxbGcKs/n4w7LXeMo/HMt
        4jF3w05iU78q/QaiBtrHy9ksCHzazFE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-Jom6SA2lN1mnPzx0-IYKGQ-1; Thu, 16 Feb 2023 16:48:11 -0500
X-MC-Unique: Jom6SA2lN1mnPzx0-IYKGQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 774593C0F686;
        Thu, 16 Feb 2023 21:48:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81E7D401014C;
        Thu, 16 Feb 2023 21:47:50 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 01/17] mm: Pass info, not iter, into filemap_get_pages()
Date:   Thu, 16 Feb 2023 21:47:29 +0000
Message-Id: <20230216214745.3985496-2-dhowells@redhat.com>
In-Reply-To: <20230216214745.3985496-1-dhowells@redhat.com>
References: <20230216214745.3985496-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

filemap_get_pages() and a number of functions that it calls take an
iterator to provide two things: the number of bytes to be got from the file
specified and whether partially uptodate pages are allowed.  Change these
functions so that this information is passed in directly.  This allows it
to be called without having an iterator to hand.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Matthew Wilcox <willy@infradead.org>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 mm/filemap.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index c4d4ace9cc70..876e77278d2a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2440,21 +2440,19 @@ static int filemap_read_folio(struct file *file, filler_t filler,
 }
 
 static bool filemap_range_uptodate(struct address_space *mapping,
-		loff_t pos, struct iov_iter *iter, struct folio *folio)
+		loff_t pos, size_t count, struct folio *folio,
+		bool need_uptodate)
 {
-	int count;
-
 	if (folio_test_uptodate(folio))
 		return true;
 	/* pipes can't handle partially uptodate pages */
-	if (iov_iter_is_pipe(iter))
+	if (need_uptodate)
 		return false;
 	if (!mapping->a_ops->is_partially_uptodate)
 		return false;
 	if (mapping->host->i_blkbits >= folio_shift(folio))
 		return false;
 
-	count = iter->count;
 	if (folio_pos(folio) > pos) {
 		count -= folio_pos(folio) - pos;
 		pos = 0;
@@ -2466,8 +2464,8 @@ static bool filemap_range_uptodate(struct address_space *mapping,
 }
 
 static int filemap_update_page(struct kiocb *iocb,
-		struct address_space *mapping, struct iov_iter *iter,
-		struct folio *folio)
+		struct address_space *mapping, size_t count,
+		struct folio *folio, bool need_uptodate)
 {
 	int error;
 
@@ -2501,7 +2499,8 @@ static int filemap_update_page(struct kiocb *iocb,
 		goto unlock;
 
 	error = 0;
-	if (filemap_range_uptodate(mapping, iocb->ki_pos, iter, folio))
+	if (filemap_range_uptodate(mapping, iocb->ki_pos, count, folio,
+				   need_uptodate))
 		goto unlock;
 
 	error = -EAGAIN;
@@ -2577,8 +2576,8 @@ static int filemap_readahead(struct kiocb *iocb, struct file *file,
 	return 0;
 }
 
-static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
-		struct folio_batch *fbatch)
+static int filemap_get_pages(struct kiocb *iocb, size_t count,
+		struct folio_batch *fbatch, bool need_uptodate)
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
@@ -2588,7 +2587,7 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	struct folio *folio;
 	int err = 0;
 
-	last_index = DIV_ROUND_UP(iocb->ki_pos + iter->count, PAGE_SIZE);
+	last_index = DIV_ROUND_UP(iocb->ki_pos + count, PAGE_SIZE);
 retry:
 	if (fatal_signal_pending(current))
 		return -EINTR;
@@ -2621,7 +2620,8 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 		if ((iocb->ki_flags & IOCB_WAITQ) &&
 		    folio_batch_count(fbatch) > 1)
 			iocb->ki_flags |= IOCB_NOWAIT;
-		err = filemap_update_page(iocb, mapping, iter, folio);
+		err = filemap_update_page(iocb, mapping, count, folio,
+					  need_uptodate);
 		if (err)
 			goto err;
 	}
@@ -2691,7 +2691,8 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		if (unlikely(iocb->ki_pos >= i_size_read(inode)))
 			break;
 
-		error = filemap_get_pages(iocb, iter, &fbatch);
+		error = filemap_get_pages(iocb, iter->count, &fbatch,
+					  iov_iter_is_pipe(iter));
 		if (error < 0)
 			break;
 

