Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21C93D4C34
	for <lists+linux-block@lfdr.de>; Sun, 25 Jul 2021 07:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhGYFRF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 25 Jul 2021 01:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhGYFRF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Jul 2021 01:17:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063EEC061757
        for <linux-block@vger.kernel.org>; Sat, 24 Jul 2021 22:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jyPdE+myMQ8pIHG1s1Jkqvq4jP4Nx1GcQs6eUzWo54k=; b=NwA/LbGdC3f1UsIWoEo9iRnTXb
        HPEGG67KOuMoNBJxfRPzEzOlK2V6WKU0HQhS85Adty6AsqR6hxrn/U4EYvWAShPm4tlipBWfKyh7b
        slot1WrfeYVW26q8yKagT5zGZy6Ajva4E1W7xFFpZyuic/sbutbMCX9hpGkEApX8DhziSJwDBDnce
        T8KL+bBQWgNP7VqroATnp1Vay8sKTVbT38KHeqMH1/DsMg3U2rUQmeJN/Cd0zSI6ThBDxs9QeNvfp
        S0NWGiW9ejR3HbqgiYsKz8rkl/H6sMWjDpRs52UXcpoRoREf454xnH/23DUJSd8rpK1KbGwN+Sccs
        f0FRjK2g==;
Received: from [2001:4bb8:184:87c5:a8b3:bdfd:fc9b:6250] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7X8L-00CpmJ-8z; Sun, 25 Jul 2021 05:57:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 6/8] dm: move setting md->type into dm_setup_md_queue
Date:   Sun, 25 Jul 2021 07:54:56 +0200
Message-Id: <20210725055458.29008-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210725055458.29008-1-hch@lst.de>
References: <20210725055458.29008-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move setting md->type from both callers into dm_setup_md_queue.
This ensures that md->type is only set to a valid value after the queue
has been fully setup, something we'll rely on future changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-ioctl.c | 4 ----
 drivers/md/dm.c       | 5 +++--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 2209cbcd84db..2575074a2204 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1436,9 +1436,6 @@ static int table_load(struct file *filp, struct dm_ioctl *param, size_t param_si
 	}
 
 	if (dm_get_md_type(md) == DM_TYPE_NONE) {
-		/* Initial table load: acquire type of table. */
-		dm_set_md_type(md, dm_table_get_type(t));
-
 		/* setup md->queue to reflect md's type (may block) */
 		r = dm_setup_md_queue(md, t);
 		if (r) {
@@ -2187,7 +2184,6 @@ int __init dm_early_create(struct dm_ioctl *dmi,
 	if (r)
 		goto err_destroy_table;
 
-	md->type = dm_table_get_type(t);
 	/* setup md->queue to reflect md's type (may block) */
 	r = dm_setup_md_queue(md, t);
 	if (r) {
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 7971ec8ce677..f003bd5b93ce 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2052,9 +2052,9 @@ EXPORT_SYMBOL_GPL(dm_get_queue_limits);
  */
 int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
 {
-	int r;
+	enum dm_queue_mode type = dm_table_get_type(t);
 	struct queue_limits limits;
-	enum dm_queue_mode type = dm_get_md_type(md);
+	int r;
 
 	switch (type) {
 	case DM_TYPE_REQUEST_BASED:
@@ -2081,6 +2081,7 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
 	r = dm_table_set_restrictions(t, md->queue, &limits);
 	if (r)
 		return r;
+	md->type = type;
 
 	blk_register_queue(md->disk);
 
-- 
2.30.2

