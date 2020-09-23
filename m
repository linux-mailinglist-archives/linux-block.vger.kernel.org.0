Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4309F274E76
	for <lists+linux-block@lfdr.de>; Wed, 23 Sep 2020 03:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgIWBea (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Sep 2020 21:34:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48722 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727007AbgIWBea (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 21:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600824868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z8wgUsFeISNKKF5CeHLbqW5ctrWt2AjWQGP3NgC4Xqc=;
        b=B7a8Hu9P7+wuTHyIWFUicZSqiMQA9JrEDLgwndMhwTV9fZE96AMKPvpBT9WTxEsb1bNhiu
        ioVlO2sQupabA3NW09awe1IqYpUbcRV7AqeFvx4w4SbgAtufMPnIWyk8gvjnnZNTREnVCO
        3lrtHKxQixb3Yoq6kz6Y22gOw4ZPFUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-JyFYGeh0MYurG4UHQ6HFiQ-1; Tue, 22 Sep 2020 21:34:26 -0400
X-MC-Unique: JyFYGeh0MYurG4UHQ6HFiQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6595186DD27;
        Wed, 23 Sep 2020 01:34:24 +0000 (UTC)
Received: from localhost (ovpn-12-168.pek2.redhat.com [10.72.12.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A986E60C04;
        Wed, 23 Sep 2020 01:34:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V3 for 5.11 05/12] sbitmap: export sbitmap_weight
Date:   Wed, 23 Sep 2020 09:33:32 +0800
Message-Id: <20200923013339.1621784-6-ming.lei@redhat.com>
In-Reply-To: <20200923013339.1621784-1-ming.lei@redhat.com>
References: <20200923013339.1621784-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SCSI's .device_busy will be converted to sbitmap, and sbitmap_weight
is needed, so export the helper.

Cc: Omar Sandoval <osandov@fb.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/sbitmap.h |  9 +++++++++
 lib/sbitmap.c           | 11 ++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 103b41c03311..34343ce3ef6c 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -346,6 +346,15 @@ static inline int sbitmap_test_bit(struct sbitmap *sb, unsigned int bitnr)
  */
 void sbitmap_show(struct sbitmap *sb, struct seq_file *m);
 
+
+/**
+ * sbitmap_weight() - Return how many real bits set in a &struct sbitmap.
+ * @sb: Bitmap to check.
+ *
+ * Return: How many real bits set
+ */
+unsigned int sbitmap_weight(const struct sbitmap *sb);
+
 /**
  * sbitmap_bitmap_show() - Write a hex dump of a &struct sbitmap to a &struct
  * seq_file.
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 16f59e99143e..ab217bf5d619 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -345,20 +345,21 @@ static unsigned int __sbitmap_weight(const struct sbitmap *sb, bool set)
 	return weight;
 }
 
-static unsigned int sbitmap_weight(const struct sbitmap *sb)
+static unsigned int sbitmap_cleared(const struct sbitmap *sb)
 {
-	return __sbitmap_weight(sb, true);
+	return __sbitmap_weight(sb, false);
 }
 
-static unsigned int sbitmap_cleared(const struct sbitmap *sb)
+unsigned int sbitmap_weight(const struct sbitmap *sb)
 {
-	return __sbitmap_weight(sb, false);
+	return __sbitmap_weight(sb, true) - sbitmap_cleared(sb);
 }
+EXPORT_SYMBOL_GPL(sbitmap_weight);
 
 void sbitmap_show(struct sbitmap *sb, struct seq_file *m)
 {
 	seq_printf(m, "depth=%u\n", sb->depth);
-	seq_printf(m, "busy=%u\n", sbitmap_weight(sb) - sbitmap_cleared(sb));
+	seq_printf(m, "busy=%u\n", sbitmap_weight(sb));
 	seq_printf(m, "cleared=%u\n", sbitmap_cleared(sb));
 	seq_printf(m, "bits_per_word=%u\n", 1U << sb->shift);
 	seq_printf(m, "map_nr=%u\n", sb->map_nr);
-- 
2.25.2

