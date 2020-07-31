Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB7D233CF6
	for <lists+linux-block@lfdr.de>; Fri, 31 Jul 2020 03:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbgGaBm5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 30 Jul 2020 21:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731136AbgGaBm4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 21:42:56 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01312C061574;
        Thu, 30 Jul 2020 18:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zKOEtRCl1pcVK+aCgXCr/e81d1JBKV0gWfr1cRx6yA0=; b=1DO2SdBCj9bdPQGst7HvcOLlWQ
        RpeiP2J5NL2nY9aGXtsJqTI2j00WRbOFQKTj88FfBdZuu1we9KbJAnAj40TvcgyVVStrbCgbXf6dZ
        lT5hJ2FVFhZ0MobYMSH29SHK8HRIoY1oCSNfJy0zFY/DuhG1TKE3/EDQLCq31SPsz4Ej1ZHGQvr78
        X7MGdVYoR6hzaqO9kx0hemJxkZ+xxWKBhUE6kAEwE84gusPqe0GKL2PPznGsKTq3g1bhqNUhlkv9x
        yVhmuVROF19t//BYM3TFxCmkHYclXTCiJL8cgkIIdVGljWObuHjhCZ2xw5/iEm++3fK9gQychSujS
        JSE8QFNA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1K4T-0006bc-Gm; Fri, 31 Jul 2020 01:42:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: [PATCH 7/7] block: blk-timeout: delete duplicated word
Date:   Thu, 30 Jul 2020 18:42:33 -0700
Message-Id: <20200731014233.6418-8-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200731014233.6418-1-rdunlap@infradead.org>
References: <20200731014233.6418-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Drop the repeated word "request".
Change to the correct kernel-doc notation for function name separtor.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 block/blk-timeout.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200730.orig/block/blk-timeout.c
+++ linux-next-20200730/block/blk-timeout.c
@@ -68,7 +68,7 @@ ssize_t part_timeout_store(struct device
 #endif /* CONFIG_FAIL_IO_TIMEOUT */
 
 /**
- * blk_abort_request -- Request request recovery for the specified command
+ * blk_abort_request - Request recovery for the specified command
  * @req:	pointer to the request of interest
  *
  * This function requests that the block layer start recovery for the
