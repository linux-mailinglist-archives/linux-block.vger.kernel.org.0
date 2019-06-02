Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3573232321
	for <lists+linux-block@lfdr.de>; Sun,  2 Jun 2019 13:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfFBLV3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 2 Jun 2019 07:21:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43597 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfFBLV2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Jun 2019 07:21:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so6598476pgv.10;
        Sun, 02 Jun 2019 04:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SWsv2Kj8e8VQJPMoaBE0n56CZDHc2v93YdRGa+NaSWg=;
        b=g57zPOz6tqBG3iAyMqRWgubMS3ZJ6Mjukgv6HGwbUeYtP5jZl4fbAmVCOCB20kqA9m
         xAF61M3/D+xB3b3Y7L00uNKk/sng7kiL4svmH2bkip8NulIuc0R527PgaimCqgMU6Zfo
         hdf5jInCexVgT1ln2/amJnqtZDGesXDLgGKHsmYErQxz7Cn6vxY8jYxO9+/E2je7I9Er
         Viuc21BIkFcvTyKw7rNsgF1iVLS7hdwlXfGSAqEQUpQMq1za5MBAD2bVpOw3FrCoBl8r
         YRolUSTKOEja8AgkEI5PU735OC0T4zW8uUe7DAqx5ClovfoFfMJ9GSrlAS3AhCy3vFRq
         d8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SWsv2Kj8e8VQJPMoaBE0n56CZDHc2v93YdRGa+NaSWg=;
        b=pWfR7dTNZuvWlnYJaaiVY99LhhpPRaWE4Oa7Fy4HNHg4ROul9ZZPGsbvArZbdI7I6l
         50xJEYNEbreVMrr3m35AUyw62GjgsPaqngBHmH32J+66CeoACDyu24a0mVytoyVO38OG
         MrpaQtjUbTJbsqDvh4evf1fn/1AzWY+bmWc1iwa/yzgcEKXmM+gKAPgUkzFrS2uNTO+X
         ff2434t2hLaoROVgBnYO9qpaZq9ASDc/IprsMEf+dpxhobLY1ylkv+SZLUmhy0XpgVU6
         kBDXFEyjGzVwnxKyFC07X3LUr0O58xnDCEH6aXXicS6a/3BFudyB9PASkxpublJpfGlC
         Zz8Q==
X-Gm-Message-State: APjAAAUv3+XgPnMl7rEGhvyShiZb1iNKFkLAFDeyksebRTfSU11cOqlg
        NzVYatHwVXHc6R015DtMjDind6Fzd4M=
X-Google-Smtp-Source: APXvYqwLtjM5bP8bTikgdx9VMuu6O5K9dZWqTrMAp75dRnbnELaIF0yQjFL3IYBDm2u14WQjKyLrQw==
X-Received: by 2002:a17:90a:778b:: with SMTP id v11mr22751443pjk.132.1559474487885;
        Sun, 02 Jun 2019 04:21:27 -0700 (PDT)
Received: from localhost.localdomain ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id h7sm16816872pfo.108.2019.06.02.04.21.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 04:21:27 -0700 (PDT)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Minwoo Im <minwoo.im@samsung.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: [PATCH] genirq/affinity: remove unused arg when building aff mask
Date:   Sun,  2 Jun 2019 20:21:17 +0900
Message-Id: <20190602112117.31839-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When building affinity masks, the struct irq_affinity *affd is not
needed because irq_create_affinity_masks() has already given a cursored
current vector after pre_vectors via "curvec".

This patch removes unused argument for irq_build_affinity_masks() and
__irq_build_affinity_masks().  No functions changes are included.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org
Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 kernel/irq/affinity.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index f18cd5aa33e8..4352b08ae48d 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -94,8 +94,7 @@ static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
 	return nodes;
 }
 
-static int __irq_build_affinity_masks(const struct irq_affinity *affd,
-				      unsigned int startvec,
+static int __irq_build_affinity_masks(unsigned int startvec,
 				      unsigned int numvecs,
 				      unsigned int firstvec,
 				      cpumask_var_t *node_to_cpumask,
@@ -171,8 +170,7 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
  *	1) spread present CPU on these vectors
  *	2) spread other possible CPUs on these vectors
  */
-static int irq_build_affinity_masks(const struct irq_affinity *affd,
-				    unsigned int startvec, unsigned int numvecs,
+static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
 				    unsigned int firstvec,
 				    struct irq_affinity_desc *masks)
 {
@@ -197,7 +195,7 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
 	build_node_to_cpumask(node_to_cpumask);
 
 	/* Spread on present CPUs starting from affd->pre_vectors */
-	nr_present = __irq_build_affinity_masks(affd, curvec, numvecs,
+	nr_present = __irq_build_affinity_masks(curvec, numvecs,
 						firstvec, node_to_cpumask,
 						cpu_present_mask, nmsk, masks);
 
@@ -212,7 +210,7 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
 	else
 		curvec = firstvec + nr_present;
 	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
-	nr_others = __irq_build_affinity_masks(affd, curvec, numvecs,
+	nr_others = __irq_build_affinity_masks(curvec, numvecs,
 					       firstvec, node_to_cpumask,
 					       npresmsk, nmsk, masks);
 	put_online_cpus();
@@ -295,7 +293,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 		unsigned int this_vecs = affd->set_size[i];
 		int ret;
 
-		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
+		ret = irq_build_affinity_masks(curvec, this_vecs,
 					       curvec, masks);
 		if (ret) {
 			kfree(masks);
-- 
2.21.0

