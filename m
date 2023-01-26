Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5B967CD73
	for <lists+linux-block@lfdr.de>; Thu, 26 Jan 2023 15:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjAZORx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Jan 2023 09:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjAZORg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2023 09:17:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0205E410A6
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 06:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674742608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9PNg3WPaFWzxoLjSof2qU8psox3R+qpqOMDOMyjiLi8=;
        b=YADvt9l/TC3vAJPKaNcfrWVumeZ93LNJfKTlOnUTikwOuhAHdUvMVxYLD+q6OCcbzWdIOV
        NkKQ85fSDazyWnifJB3LFwlkBYl+NH4zr4V4mQnFJC4xwjoEE235eebJ2a5JE3B+9iAJvT
        49pHoTa8CGLK4aiiEF3te8674m962i4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-TDWE-n9FPgCznZ4yl1rJMA-1; Thu, 26 Jan 2023 09:16:44 -0500
X-MC-Unique: TDWE-n9FPgCznZ4yl1rJMA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3DD3857F82;
        Thu, 26 Jan 2023 14:16:43 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C432D2026D4B;
        Thu, 26 Jan 2023 14:16:41 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v11 4/8] block: Fix bio_flagged() so that gcc can better optimise it
Date:   Thu, 26 Jan 2023 14:16:22 +0000
Message-Id: <20230126141626.2809643-5-dhowells@redhat.com>
In-Reply-To: <20230126141626.2809643-1-dhowells@redhat.com>
References: <20230126141626.2809643-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix bio_flagged() so that multiple instances of it, such as:

	if (bio_flagged(bio, BIO_PAGE_REFFED) ||
	    bio_flagged(bio, BIO_PAGE_PINNED))

can be combined by the gcc optimiser into a single test in assembly
(arguably, this is a compiler optimisation issue[1]).

The missed optimisation stems from bio_flagged() comparing the result of
the bitwise-AND to zero.  This results in an out-of-line bio_release_page()
being compiled to something like:

   <+0>:     mov    0x14(%rdi),%eax
   <+3>:     test   $0x1,%al
   <+5>:     jne    0xffffffff816dac53 <bio_release_pages+11>
   <+7>:     test   $0x2,%al
   <+9>:     je     0xffffffff816dac5c <bio_release_pages+20>
   <+11>:    movzbl %sil,%esi
   <+15>:    jmp    0xffffffff816daba1 <__bio_release_pages>
   <+20>:    jmp    0xffffffff81d0b800 <__x86_return_thunk>

However, the test is superfluous as the return type is bool.  Removing it
results in:

   <+0>:     testb  $0x3,0x14(%rdi)
   <+4>:     je     0xffffffff816e4af4 <bio_release_pages+15>
   <+6>:     movzbl %sil,%esi
   <+10>:    jmp    0xffffffff816dab7c <__bio_release_pages>
   <+15>:    jmp    0xffffffff81d0b7c0 <__x86_return_thunk>

instead.

Also, the MOVZBL instruction looks unnecessary[2] - I think it's just
're-booling' the mark_dirty parameter.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: linux-block@vger.kernel.org
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108370 [1]
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108371 [2]
Link: https://lore.kernel.org/r/167391056756.2311931.356007731815807265.stgit@warthog.procyon.org.uk/ # v6
---
 include/linux/bio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index c1da63f6c808..10366b8bdb13 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -227,7 +227,7 @@ static inline void bio_cnt_set(struct bio *bio, unsigned int count)
 
 static inline bool bio_flagged(struct bio *bio, unsigned int bit)
 {
-	return (bio->bi_flags & (1U << bit)) != 0;
+	return bio->bi_flags & (1U << bit);
 }
 
 static inline void bio_set_flag(struct bio *bio, unsigned int bit)

