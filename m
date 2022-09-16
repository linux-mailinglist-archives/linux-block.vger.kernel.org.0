Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A0D5BA8E5
	for <lists+linux-block@lfdr.de>; Fri, 16 Sep 2022 11:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbiIPJBy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 16 Sep 2022 05:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiIPJB3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Sep 2022 05:01:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF514A8974
        for <linux-block@vger.kernel.org>; Fri, 16 Sep 2022 02:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663318848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SGeUALzkpHlGTdD+bIbM2o/mONwjyQDl4XUhUw6myAg=;
        b=VqqEjAa0EVI0J7ulZqGxzkGGOh+YCfkrcIJUQoCg7jshPtYbcqa+1IUI+coUPLn4ShEAXF
        76ghNu//J+F2UaTyvdV3lKYsEn5P1eFEyDaXKOm6QFFIRBR22vxT7rHNn57LrZDV04056l
        VobYTEFKqxPFTKwmK1K4M2ZqNzYKYOU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-bp_feYEXMpqGv9F01voWDg-1; Fri, 16 Sep 2022 05:00:46 -0400
X-MC-Unique: bp_feYEXMpqGv9F01voWDg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95EF1381079E;
        Fri, 16 Sep 2022 09:00:46 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E1E9140EBF3;
        Fri, 16 Sep 2022 09:00:46 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 28G90kwr000940;
        Fri, 16 Sep 2022 05:00:46 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 28G90kgJ000937;
        Fri, 16 Sep 2022 05:00:46 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 16 Sep 2022 05:00:46 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Jens Axboe <axboe@kernel.dk>, Zdenek Kabelac <zkabelac@redhat.com>
cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 4/4] brd: implement secure erase and write zeroes
In-Reply-To: <alpine.LRH.2.02.2209151604410.13231@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2209160500190.543@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2209151604410.13231@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch implements REQ_OP_SECURE_ERASE and REQ_OP_WRITE_ZEROES on brd.
Write zeroes will free the pages just like discard, but the difference is
that it writes zeroes to the preceding and following page if the range is
not aligned on page boundary. Secure erase is just like write zeroes,
except that it clears the page content before freeing the page.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/block/brd.c |   28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/block/brd.c
===================================================================
--- linux-2.6.orig/drivers/block/brd.c
+++ linux-2.6/drivers/block/brd.c
@@ -118,7 +118,7 @@ static void brd_free_page_rcu(struct rcu
 	__free_page(page);
 }
 
-static void brd_free_page(struct brd_device *brd, sector_t sector)
+static void brd_free_page(struct brd_device *brd, sector_t sector, bool secure)
 {
 	struct page *page;
 	pgoff_t idx;
@@ -127,8 +127,11 @@ static void brd_free_page(struct brd_dev
 	idx = sector >> PAGE_SECTORS_SHIFT;
 	page = radix_tree_delete(&brd->brd_pages, idx);
 	spin_unlock(&brd->brd_lock);
-	if (page)
+	if (page) {
+		if (secure)
+			clear_highpage(page);
 		call_rcu(&page->rcu_head, brd_free_page_rcu);
+	}
 }
 
 /*
@@ -308,16 +311,29 @@ static void brd_submit_bio(struct bio *b
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 
-	if (bio_op(bio) == REQ_OP_DISCARD) {
+	if (bio_op(bio) == REQ_OP_DISCARD ||
+	    bio_op(bio) == REQ_OP_SECURE_ERASE ||
+	    bio_op(bio) == REQ_OP_WRITE_ZEROES) {
+		bool zero_padding = bio_op(bio) == REQ_OP_SECURE_ERASE || bio_op(bio) == REQ_OP_WRITE_ZEROES;
 		sector_t len = bio_sectors(bio);
 		sector_t front_pad = -sector & (PAGE_SECTORS - 1);
+		sector_t end_pad;
+
+		if (zero_padding && unlikely(front_pad != 0))
+			copy_to_brd(brd, page_address(ZERO_PAGE(0)), sector, min(len, front_pad) << SECTOR_SHIFT);
+
 		sector += front_pad;
 		if (unlikely(len <= front_pad))
 			goto endio;
 		len -= front_pad;
-		len = round_down(len, PAGE_SECTORS);
+
+		end_pad = len & (PAGE_SECTORS - 1);
+		if (zero_padding && unlikely(end_pad != 0))
+			copy_to_brd(brd, page_address(ZERO_PAGE(0)), sector + len - end_pad, end_pad << SECTOR_SHIFT);
+		len -= end_pad;
+
 		while (len) {
-			brd_free_page(brd, sector);
+			brd_free_page(brd, sector, bio_op(bio) == REQ_OP_SECURE_ERASE);
 			sector += PAGE_SECTORS;
 			len -= PAGE_SECTORS;
 			cond_resched();
@@ -448,6 +464,8 @@ static int brd_alloc(int i)
 
 	disk->queue->limits.discard_granularity = PAGE_SIZE;
 	blk_queue_max_discard_sectors(disk->queue, UINT_MAX);
+	blk_queue_max_write_zeroes_sectors(disk->queue, UINT_MAX);
+	blk_queue_max_secure_erase_sectors(disk->queue, UINT_MAX);
 
 	/* Tell the block layer that this is not a rotational device */
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);

