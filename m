Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1248733599
	for <lists+linux-block@lfdr.de>; Fri, 16 Jun 2023 18:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244026AbjFPQPT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 16 Jun 2023 12:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344365AbjFPQOn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 12:14:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223CF2D5D
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2023 09:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686932035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=icD5kbVEsLPzkQFWUHTmSK0TWNtewf4a1nLsJ/B7qIk=;
        b=jOElHfE26s5pNiIH77XasdFx5vznUAjxOpl24bNcYWbbZKr39diLvJ4KQI/zFtTy/2zLiV
        UCHjdFsFZ/LDkXMn0RMV/bxsjhEsVqRft7AQE/Q6opN3WTOFmLufsUY+sAZJPPY4KuD8E+
        nAjWajFfEjK1DKYCLQdApexes24uhN8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-k2tOiSBtOmiq9_ek1Ymj9w-1; Fri, 16 Jun 2023 12:13:54 -0400
X-MC-Unique: k2tOiSBtOmiq9_ek1Ymj9w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C23729AB3EE;
        Fri, 16 Jun 2023 16:13:53 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67C21140E952;
        Fri, 16 Jun 2023 16:13:50 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     netdev@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org
Subject: [PATCH net-next 14/17] drdb: Send an entire bio in a single sendmsg
Date:   Fri, 16 Jun 2023 17:12:57 +0100
Message-ID: <20230616161301.622169-15-dhowells@redhat.com>
In-Reply-To: <20230616161301.622169-1-dhowells@redhat.com>
References: <20230616161301.622169-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since _drdb_sendpage() is now using sendmsg to send the pages rather
sendpage, pass the entire bio in one go using a bvec iterator instead of
doing it piecemeal.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Philipp Reisner <philipp.reisner@linbit.com>
cc: Lars Ellenberg <lars.ellenberg@linbit.com>
cc: "Christoph Böhmwalder" <christoph.boehmwalder@linbit.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: drbd-dev@lists.linbit.com
cc: linux-block@vger.kernel.org
cc: netdev@vger.kernel.org
---
 drivers/block/drbd/drbd_main.c | 77 +++++++++++-----------------------
 1 file changed, 25 insertions(+), 52 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index c9d84183844c..f7ebdb5ab45e 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1520,28 +1520,15 @@ static void drbd_update_congested(struct drbd_connection *connection)
  * As a workaround, we disable sendpage on pages
  * with page_count == 0 or PageSlab.
  */
-static int _drbd_no_send_page(struct drbd_peer_device *peer_device, struct page *page,
-			      int offset, size_t size, unsigned msg_flags)
-{
-	struct socket *socket;
-	void *addr;
-	int err;
-
-	socket = peer_device->connection->data.socket;
-	addr = kmap(page) + offset;
-	err = drbd_send_all(peer_device->connection, socket, addr, size, msg_flags);
-	kunmap(page);
-	if (!err)
-		peer_device->device->send_cnt += size >> 9;
-	return err;
-}
-
-static int _drbd_send_page(struct drbd_peer_device *peer_device, struct page *page,
-		    int offset, size_t size, unsigned msg_flags)
+static int _drbd_send_pages(struct drbd_peer_device *peer_device,
+			    struct iov_iter *iter, unsigned msg_flags)
 {
 	struct socket *socket = peer_device->connection->data.socket;
-	struct bio_vec bvec;
-	struct msghdr msg = { .msg_flags = msg_flags, };
+	struct msghdr msg = {
+		.msg_flags	= msg_flags | MSG_NOSIGNAL,
+		.msg_iter	= *iter,
+	};
+	size_t size = iov_iter_count(iter);
 	int err = -EIO;
 
 	/* e.g. XFS meta- & log-data is in slab pages, which have a
@@ -1550,11 +1537,8 @@ static int _drbd_send_page(struct drbd_peer_device *peer_device, struct page *pa
 	 * put_page(); and would cause either a VM_BUG directly, or
 	 * __page_cache_release a page that would actually still be referenced
 	 * by someone, leading to some obscure delayed Oops somewhere else. */
-	if (!drbd_disable_sendpage && sendpage_ok(page))
-		msg.msg_flags |= MSG_NOSIGNAL | MSG_SPLICE_PAGES;
-
-	bvec_set_page(&bvec, page, offset, size);
-	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
+	if (drbd_disable_sendpage)
+		msg.msg_flags &= ~(MSG_NOSIGNAL | MSG_SPLICE_PAGES);
 
 	drbd_update_congested(peer_device->connection);
 	do {
@@ -1585,39 +1569,22 @@ static int _drbd_send_page(struct drbd_peer_device *peer_device, struct page *pa
 
 static int _drbd_send_bio(struct drbd_peer_device *peer_device, struct bio *bio)
 {
-	struct bio_vec bvec;
-	struct bvec_iter iter;
+	struct iov_iter iter;
 
-	/* hint all but last page with MSG_MORE */
-	bio_for_each_segment(bvec, bio, iter) {
-		int err;
+	iov_iter_bvec(&iter, ITER_SOURCE, bio->bi_io_vec, bio->bi_vcnt,
+		      bio->bi_iter.bi_size);
 
-		err = _drbd_no_send_page(peer_device, bvec.bv_page,
-					 bvec.bv_offset, bvec.bv_len,
-					 bio_iter_last(bvec, iter)
-					 ? 0 : MSG_MORE);
-		if (err)
-			return err;
-	}
-	return 0;
+	return _drbd_send_pages(peer_device, &iter, 0);
 }
 
 static int _drbd_send_zc_bio(struct drbd_peer_device *peer_device, struct bio *bio)
 {
-	struct bio_vec bvec;
-	struct bvec_iter iter;
+	struct iov_iter iter;
 
-	/* hint all but last page with MSG_MORE */
-	bio_for_each_segment(bvec, bio, iter) {
-		int err;
+	iov_iter_bvec(&iter, ITER_SOURCE, bio->bi_io_vec, bio->bi_vcnt,
+		      bio->bi_iter.bi_size);
 
-		err = _drbd_send_page(peer_device, bvec.bv_page,
-				      bvec.bv_offset, bvec.bv_len,
-				      bio_iter_last(bvec, iter) ? 0 : MSG_MORE);
-		if (err)
-			return err;
-	}
-	return 0;
+	return _drbd_send_pages(peer_device, &iter, MSG_SPLICE_PAGES);
 }
 
 static int _drbd_send_zc_ee(struct drbd_peer_device *peer_device,
@@ -1629,10 +1596,16 @@ static int _drbd_send_zc_ee(struct drbd_peer_device *peer_device,
 
 	/* hint all but last page with MSG_MORE */
 	page_chain_for_each(page) {
+		struct iov_iter iter;
+		struct bio_vec bvec;
 		unsigned l = min_t(unsigned, len, PAGE_SIZE);
 
-		err = _drbd_send_page(peer_device, page, 0, l,
-				      page_chain_next(page) ? MSG_MORE : 0);
+		bvec_set_page(&bvec, page, 0, l);
+		iov_iter_bvec(&iter, ITER_SOURCE, &bvec, 1, l);
+
+		err = _drbd_send_pages(peer_device, &iter,
+				       MSG_SPLICE_PAGES |
+				       (page_chain_next(page) ? MSG_MORE : 0));
 		if (err)
 			return err;
 		len -= l;

