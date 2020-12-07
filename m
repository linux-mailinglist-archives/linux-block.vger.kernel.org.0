Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDEA2D125F
	for <lists+linux-block@lfdr.de>; Mon,  7 Dec 2020 14:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgLGNnn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 7 Dec 2020 08:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgLGNnn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Dec 2020 08:43:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828BFC0613D0
        for <linux-block@vger.kernel.org>; Mon,  7 Dec 2020 05:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=immi4h3mOidVbra1ELQRuDt7C7+rTSMfg5mAbbh8HxQ=; b=L0YzKt9cEgvfqAqlV2B1pzyfH0
        8OwYWkgQyWEkVnEIJmRgFZfV18ZWhItzBqVvQkDVrdyCba3wc0wCt5VmFHDvp7w8ez81j6cidJcz5
        9/KxrFL4S2BGWcKOS89lhPVFepXzE9w8zuqDehCEPuUT64YhGkon9FAFs6toaHNDCsYqPD7rmRYdO
        OS688HZZ48F/kLE/nYUT67jI6GmGLKGXqIc/2DsKmmGlY3BKdv1dzv9zB1esVINGjyKgsHEtO7Cj+
        dYv5+lNLuEf6HWnaUbAm6Q70svVXLb9HFAlFeSqtdtOzossJFuyN6SFDDTX8uw2hothJUDYzeDu2G
        yQsoUeWQ==;
Received: from 089144200046.atnat0009.highway.a1.net ([89.144.200.46] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmGn6-0008PJ-46; Mon, 07 Dec 2020 13:43:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] blktrace: fix up a kerneldoc comment
Date:   Mon,  7 Dec 2020 14:40:48 +0100
Message-Id: <20201207134048.2253938-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fixes: a54895fa057c ("block: remove the request_queue to argument request based tracepoints")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/trace/blktrace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 774f965d9aca3c..4f825c66e5c0e0 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1024,7 +1024,6 @@ static void blk_add_trace_bio_remap(void *ignore, struct bio *bio, dev_t dev,
 /**
  * blk_add_trace_rq_remap - Add a trace for a request-remap operation
  * @ignore:	trace callback data parameter (not used)
- * @q:		queue the io is for
  * @rq:		the source request
  * @dev:	target device
  * @from:	source sector
-- 
2.29.2

