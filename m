Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB2C6129E9
	for <lists+linux-block@lfdr.de>; Sun, 30 Oct 2022 11:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiJ3KH3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 30 Oct 2022 06:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3KH2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 06:07:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B69B1A0
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 03:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CAA4+Ne/KPXltwAowMnfMcRltgeoA9+LllSMPzF4IBY=; b=Xa3V1FCcq8/meOZdZbs1tkgjbS
        jRFYglUSB79+xYtXoMwxqwswRz1zDBe0ZsbqULpsf2iILzqy5pmSr55ye2qUy1txOejt7YcU5NCGk
        qyp+p5wMy96r2KLYyQAB/1yaUGOOQVpHePdr7Y6nAAMlcKl1iMTLRC3aj89P7ig77DM/yTNGba8G5
        M0wBGPWSenXMHRy76FMsNaSLcaomjD7ekaA9KTDWVSRaFawIc/nc83h2MQn0aRRAtbzbyKmIsvgyT
        stJfRIoj9a6dS0oEpxDPs1vYtEZ7JN3GBgaR5BUj041S9BEMTCC1UJwx71J4iUo9EALd84kodJiFF
        9U2uSojg==;
Received: from [2001:4bb8:199:6818:1c2a:5f62:2eb:6092] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1op5Dz-00F8JE-Hg; Sun, 30 Oct 2022 10:07:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/7] block: drop the duplicate check in elv_register
Date:   Sun, 30 Oct 2022 11:07:08 +0100
Message-Id: <20221030100714.876891-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221030100714.876891-1-hch@lst.de>
References: <20221030100714.876891-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have less than a handful of elevators, and if someone adds a duplicate
one it simply will never be found but other be harmless.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/elevator.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index d26aa787e29f0..ef9af17293ffb 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -545,13 +545,7 @@ int elv_register(struct elevator_type *e)
 			return -ENOMEM;
 	}
 
-	/* register, don't allow duplicate names */
 	spin_lock(&elv_list_lock);
-	if (elevator_find(e->elevator_name, 0)) {
-		spin_unlock(&elv_list_lock);
-		kmem_cache_destroy(e->icq_cache);
-		return -EBUSY;
-	}
 	list_add_tail(&e->list, &elv_list);
 	spin_unlock(&elv_list_lock);
 
-- 
2.30.2

