Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D90573A44F
	for <lists+linux-block@lfdr.de>; Thu, 22 Jun 2023 17:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjFVPHS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 22 Jun 2023 11:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjFVPHO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jun 2023 11:07:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F015A1FF0
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 08:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=r9uc2WpZ1BdRzkhNCPFxF6WpdTrETRB8K52P6gzeXGE=; b=xsJGaoZmEAbUjTT98fYhSb6X9y
        FZKYG/ExODoJN7+LeKF3Xth4YdQ6BVie/QYEHd02Sk+5S3/ACkuQLWabPmby+usel4DZ5OQydk+yc
        dSsD2PohVoX6wn+VmXqsANvI2kd+Rw2tnq9fZguDu05SI/yEp2e77Q5LK6ZkoZgAI1VchZjjla2Ih
        VmXj/x8//nwUFZg+WmFsoamjEV0SUxjSM8B0dgwiXm4+exg4xsbvMeAy9cUGk9VKODC20KEBSLK6b
        3ubt6FMmSaIb+ta191c9lCpo93sBUX9CX+7S2KyCupNX2+62WbHmHTe0TJCy/VkT6DCJ2nTFaKkbC
        qbH6paJg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qCLtY-0015G1-0q;
        Thu, 22 Jun 2023 15:06:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] block: don't return -EINVAL for not found names in devt_from_devname
Date:   Thu, 22 Jun 2023 17:06:44 +0200
Message-Id: <20230622150644.600327-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When we didn't find a device and didn't guess it might be a partition,
it might still show up later, so don't disable rootwait for it by
returning -EINVAL.

Fixes: 079caa35f786 ("init: clear root_wait on all invalid root= strings")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/early-lookup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/early-lookup.c b/block/early-lookup.c
index a5be3c68ed079c..9e2d5a19de1b3b 100644
--- a/block/early-lookup.c
+++ b/block/early-lookup.c
@@ -174,7 +174,7 @@ static int __init devt_from_devname(const char *name, dev_t *devt)
 	while (p > s && isdigit(p[-1]))
 		p--;
 	if (p == s || !*p || *p == '0')
-		return -EINVAL;
+		return -ENODEV;
 
 	/* try disk name without <part number> */
 	part = simple_strtoul(p, NULL, 10);
@@ -185,7 +185,7 @@ static int __init devt_from_devname(const char *name, dev_t *devt)
 
 	/* try disk name without p<part number> */
 	if (p < s + 2 || !isdigit(p[-2]) || p[-1] != 'p')
-		return -EINVAL;
+		return -ENODEV;
 	p[-1] = '\0';
 	*devt = blk_lookup_devt(s, part);
 	if (*devt)
-- 
2.39.2

