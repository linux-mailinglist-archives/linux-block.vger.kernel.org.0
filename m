Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C6B5BEC64
	for <lists+linux-block@lfdr.de>; Tue, 20 Sep 2022 19:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiITRyG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 20 Sep 2022 13:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiITRx4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 13:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB64F101FC
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 10:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663696435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oNM9autimC6RvLv11sl2gSLRIEAUQLnjCfK9GHsQmCY=;
        b=hIsMkLt8UPz4XCtK3u3MNg5QVgA24AGjV6I2QarZivt8B7V2z5zYqt7DALrjCHWcAF1qrM
        gHhb6rZAjJ5tvZaHK0C+hMunBngPzjH03fjqgox9q54iJTge1mEE3zFCbE0aDequJZWv0W
        3aDuCiyDZ3DfyGJoWV1LlK9KsTJmBYg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-ZVPtqo5iPcOgIsvrFogxLQ-1; Tue, 20 Sep 2022 13:53:50 -0400
X-MC-Unique: ZVPtqo5iPcOgIsvrFogxLQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A9FE101A52A;
        Tue, 20 Sep 2022 17:53:50 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DD7440C6EC2;
        Tue, 20 Sep 2022 17:53:50 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 28KHroOC026300;
        Tue, 20 Sep 2022 13:53:50 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 28KHrnsM026296;
        Tue, 20 Sep 2022 13:53:49 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 20 Sep 2022 13:53:49 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Jens Axboe <axboe@kernel.dk>, Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v2 1/4] brd: make brd_insert_page return bool
In-Reply-To: <alpine.LRH.2.02.2209201350470.26058@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2209201352580.26058@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2209201350470.26058@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

brd_insert_page returns a pointer to struct page, however the pointer is
never used (it is only compared against NULL), so to clean-up the code, we
make it return bool.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>

---
 drivers/block/brd.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

Index: linux-2.6/drivers/block/brd.c
===================================================================
--- linux-2.6.orig/drivers/block/brd.c
+++ linux-2.6/drivers/block/brd.c
@@ -78,11 +78,11 @@ static struct page *brd_lookup_page(stru
 }
 
 /*
- * Look up and return a brd's page for a given sector.
- * If one does not exist, allocate an empty page, and insert that. Then
- * return it.
+ * If the page exists, return true.
+ * If it does not exist, allocate an empty page, and insert that. Return true
+ * if the allocation was successful.
  */
-static struct page *brd_insert_page(struct brd_device *brd, sector_t sector)
+static bool brd_insert_page(struct brd_device *brd, sector_t sector)
 {
 	pgoff_t idx;
 	struct page *page;
@@ -90,7 +90,7 @@ static struct page *brd_insert_page(stru
 
 	page = brd_lookup_page(brd, sector);
 	if (page)
-		return page;
+		return true;
 
 	/*
 	 * Must use NOIO because we don't want to recurse back into the
@@ -99,11 +99,11 @@ static struct page *brd_insert_page(stru
 	gfp_flags = GFP_NOIO | __GFP_ZERO | __GFP_HIGHMEM;
 	page = alloc_page(gfp_flags);
 	if (!page)
-		return NULL;
+		return false;
 
 	if (radix_tree_preload(GFP_NOIO)) {
 		__free_page(page);
-		return NULL;
+		return false;
 	}
 
 	spin_lock(&brd->brd_lock);
@@ -121,7 +121,7 @@ static struct page *brd_insert_page(stru
 
 	radix_tree_preload_end();
 
-	return page;
+	return true;
 }
 
 /*

