Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B1379EF88
	for <lists+linux-block@lfdr.de>; Wed, 13 Sep 2023 18:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjIMQ6N (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 Sep 2023 12:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjIMQ6A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Sep 2023 12:58:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6313C19BF
        for <linux-block@vger.kernel.org>; Wed, 13 Sep 2023 09:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694624225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z7dUGMUCdPzyoXpN55evy5eiv8axvEjBjfUl9Q9dpbg=;
        b=NEoFbsTHrdL547dcISh6kFAMjleoAAzA3B8duaJ7cJxpb+Qr7snKOO87ZsJFEn3Ge4n7po
        W5j8JQf4pV63JboMOvSkr0oNHNilx0KDA/I4WqAzjG4aIDpW6m3jBzj+cywbHBjAUWEtlB
        9JeAnVactJrh7Wl2eCFEwgvqdTlo3dY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-B53T9xcDN2imp2fxxNS_HQ-1; Wed, 13 Sep 2023 12:57:01 -0400
X-MC-Unique: B53T9xcDN2imp2fxxNS_HQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0E9C185A79C;
        Wed, 13 Sep 2023 16:57:00 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 07E2263F9C;
        Wed, 13 Sep 2023 16:56:58 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/13] iov_iter: Derive user-backedness from the iterator type
Date:   Wed, 13 Sep 2023 17:56:38 +0100
Message-ID: <20230913165648.2570623-4-dhowells@redhat.com>
In-Reply-To: <20230913165648.2570623-1-dhowells@redhat.com>
References: <20230913165648.2570623-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the iterator type to determine whether an iterator is user-backed or
not rather than using a special flag for it.  Now that ITER_UBUF and
ITER_IOVEC are 0 and 1, they can be checked with a single comparison.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Alexander Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Christian Brauner <christian@brauner.io>
cc: Matthew Wilcox <willy@infradead.org>
cc: Linus Torvalds <torvalds@linux-foundation.org>
cc: David Laight <David.Laight@ACULAB.COM>
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 include/linux/uio.h | 4 +---
 lib/iov_iter.c      | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index d1801c46e89e..e2a248dad80b 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -43,7 +43,6 @@ struct iov_iter {
 	bool copy_mc;
 	bool nofault;
 	bool data_source;
-	bool user_backed;
 	union {
 		size_t iov_offset;
 		int last_offset;
@@ -143,7 +142,7 @@ static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 
 static inline bool user_backed_iter(const struct iov_iter *i)
 {
-	return i->user_backed;
+	return iter_is_ubuf(i) || iter_is_iovec(i);
 }
 
 /*
@@ -383,7 +382,6 @@ static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
 	*i = (struct iov_iter) {
 		.iter_type = ITER_UBUF,
 		.copy_mc = false,
-		.user_backed = true,
 		.data_source = direction,
 		.ubuf = buf,
 		.count = count,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 27234a820eeb..227c9f536b94 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -290,7 +290,6 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction,
 		.iter_type = ITER_IOVEC,
 		.copy_mc = false,
 		.nofault = false,
-		.user_backed = true,
 		.data_source = direction,
 		.__iov = iov,
 		.nr_segs = nr_segs,

