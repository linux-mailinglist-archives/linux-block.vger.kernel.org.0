Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFC7699F71
	for <lists+linux-block@lfdr.de>; Thu, 16 Feb 2023 22:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjBPVvN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 Feb 2023 16:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjBPVuS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 16:50:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFAE53834
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 13:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676584139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=41+Q30ZI9D1dRm8dDNs28BfljdF5S2Rwn6LqsfU1dM4=;
        b=XBYWWY7/0fLfnmFdhob85FuE8MajW2jdBdxD27oUhyK+3HMw3O98HHKzp+CmVWGY+atxDV
        6HfR01mFSw4fJyUqxCsBOtc9dS5mW4p/eZipXxb/koUOsasmKEjrdPnIfnKYTzUPvTwG1V
        N1T2cGHhpWcUFQfDZTihX6oJTbuiCBk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-VO6ytfueMLuoZZiqci4i-A-1; Thu, 16 Feb 2023 16:48:55 -0500
X-MC-Unique: VO6ytfueMLuoZZiqci4i-A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 632A71C05EB1;
        Thu, 16 Feb 2023 21:48:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8077F2166B30;
        Thu, 16 Feb 2023 21:48:52 +0000 (UTC)
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
        Steve French <sfrench@samba.org>
Subject: [PATCH 17/17] cifs: DIO to/from KVEC-type iterators should now work
Date:   Thu, 16 Feb 2023 21:47:45 +0000
Message-Id: <20230216214745.3985496-18-dhowells@redhat.com>
In-Reply-To: <20230216214745.3985496-1-dhowells@redhat.com>
References: <20230216214745.3985496-1-dhowells@redhat.com>
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

DIO to/from KVEC-type iterators should now work as the iterator is passed
down to the socket in non-RDMA/non-crypto mode and in RDMA or crypto mode
care is taken to handle vmap/vmalloc correctly and not take page refs when
building a scatterlist.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Tom Talpey <tom@talpey.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
---
 fs/cifs/file.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 60949fc352ed..6969699632dc 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3549,16 +3549,6 @@ static ssize_t __cifs_writev(
 	struct cifs_aio_ctx *ctx;
 	int rc;
 
-	/*
-	 * iov_iter_get_pages_alloc doesn't work with ITER_KVEC.
-	 * In this case, fall back to non-direct write function.
-	 * this could be improved by getting pages directly in ITER_KVEC
-	 */
-	if (direct && iov_iter_is_kvec(from)) {
-		cifs_dbg(FYI, "use non-direct cifs_writev for kvec I/O\n");
-		direct = false;
-	}
-
 	rc = generic_write_checks(iocb, from);
 	if (rc <= 0)
 		return rc;
@@ -4092,16 +4082,6 @@ static ssize_t __cifs_readv(
 	loff_t offset = iocb->ki_pos;
 	struct cifs_aio_ctx *ctx;
 
-	/*
-	 * iov_iter_get_pages_alloc() doesn't work with ITER_KVEC,
-	 * fall back to data copy read path
-	 * this could be improved by getting pages directly in ITER_KVEC
-	 */
-	if (direct && iov_iter_is_kvec(to)) {
-		cifs_dbg(FYI, "use non-direct cifs_user_readv for kvec I/O\n");
-		direct = false;
-	}
-
 	len = iov_iter_count(to);
 	if (!len)
 		return 0;

