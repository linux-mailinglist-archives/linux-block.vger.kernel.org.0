Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4311CA265
	for <lists+linux-block@lfdr.de>; Fri,  8 May 2020 06:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgEHEor (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 8 May 2020 00:44:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38308 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725825AbgEHEoq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 May 2020 00:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588913085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eqE+VZT6iP5BBQICf6hdfbtPcveHLASDX8yMLp9dHYE=;
        b=e8choH6Ll+vBelim8b3f+M8tdczTup0TQFuVoStXSH0B9yfAk7hZxwlTb1aDAtnWpY4ATZ
        NfZD2q4WV63+bbTUZ20e457p4OOdMpzCGC+RGncfFk5d1UWmq1TG+34TaDtcNQJhIOVWig
        9psMM6PUIPMCWPRrCqXueAdgGU2GcH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-meqgznt8OkeUCDmfNPERMA-1; Fri, 08 May 2020 00:44:42 -0400
X-MC-Unique: meqgznt8OkeUCDmfNPERMA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2EA380058A;
        Fri,  8 May 2020 04:44:40 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 69BD064456;
        Fri,  8 May 2020 04:44:36 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: [PATCH V2 3/4] block: re-organize fields of 'struct hd_part'
Date:   Fri,  8 May 2020 12:44:06 +0800
Message-Id: <20200508044407.1371907-4-ming.lei@redhat.com>
In-Reply-To: <20200508044407.1371907-1-ming.lei@redhat.com>
References: <20200508044407.1371907-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Put all fields accessed in IO path together at the beginning
of the struct, so that all can be fetched in single cacheline.

Cc: Yufen Yu <yuyufen@huawei.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hou Tao <houtao1@huawei.com>
Reviewed-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/genhd.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index b4744035ae58..a9384449465a 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -71,6 +71,14 @@ struct hd_struct {
 #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
 	seqcount_t nr_sects_seq;
 #endif
+	unsigned long stamp;
+#ifdef	CONFIG_SMP
+	struct disk_stats __percpu *dkstats;
+#else
+	struct disk_stats dkstats;
+#endif
+	struct percpu_ref ref;
+
 	sector_t alignment_offset;
 	unsigned int discard_alignment;
 	struct device __dev;
@@ -80,13 +88,6 @@ struct hd_struct {
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	int make_it_fail;
 #endif
-	unsigned long stamp;
-#ifdef	CONFIG_SMP
-	struct disk_stats __percpu *dkstats;
-#else
-	struct disk_stats dkstats;
-#endif
-	struct percpu_ref ref;
 	struct rcu_work rcu_work;
 };
 
-- 
2.25.2

