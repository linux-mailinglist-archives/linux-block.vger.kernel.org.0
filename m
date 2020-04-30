Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3642F1BFF90
	for <lists+linux-block@lfdr.de>; Thu, 30 Apr 2020 17:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgD3PED (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 30 Apr 2020 11:04:03 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20784 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgD3PED (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 11:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588259043; x=1619795043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OjMSKiBrvds+SLYkA3MrkyrBH9G9Ewa8M9wwMfkEBlU=;
  b=d0NlCypwFHIhKUO2BbOtZTcm2ySvwwMrEGuunnFYUYAOanKTAqz4nyUm
   xSlE2LWtb8sRkjjOpQA2rQS4RBwbPmhFUz2EVb/+KW0fhpBTVFE7ibh7i
   fmjjIpfv4zP1d3M0UqjGXM7sC/05itOYEAfeG50XpKeggBUjJdp6kbte9
   aYrvVFC3+SmvHT/XLvAluy7Km6g+hJna8wOWb6PYIyg2+9ZXqh8YuKZAT
   wr39ZsDRCt+7LvnhTrvJNKXBISXG6xRqzdTTNq6cR7KY0BkujKv1wPiFG
   eYB64GNuoIK+LzU/6oEKCLk/yE/Hl3XVUfu6ecz9et4WJQMQ45jHJ+5yP
   Q==;
IronPort-SDR: NGmwtcHPUrwqXkQvT/CLJj/AZ0UBC364s59eg9YIspsl/cODPGwPlRIqmXvkY9Rng7HbUwRGNT
 uULCDIvGuUSk7f2y9OKVcbJXYjP1gRzjlS0808Np0TxV0TLV+aFuJaIg4/unVM+t3Slzg2H/HJ
 kytXi2px47kViBMZeH5gtxSUGxRlFI66zlRsgaRo4G/REXRTwoIPEHioCpK2J+FWVhd+tb6rKQ
 YAiAWwsfqILzRlJsjFQEyGB78ksNHmqbApqrJZyV24ntp7FAeGPQw+mIDxxfoOCH7whZ2tLf+5
 IgM=
X-IronPort-AV: E=Sophos;i="5.73,336,1583164800"; 
   d="scan'208";a="140916561"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2020 23:04:02 +0800
IronPort-SDR: RJwdccjVF+KMI8UiggoC65raDiVufEO+RXdLEH5EE1suzYqqxKSPdOmUsnGM9PLK8JdvzB640u
 3XtLY5ZnFt9u+Jng9E7lMwIS0kmAq7g4o=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 07:54:05 -0700
IronPort-SDR: EAxAPlSByo4XljlhcJ/bS8CFMnquwY2DGOh9jE5/NVpCTQgHerPHfcRRd2gIaMp2JDJ1dqd1Uy
 lQT5wsq+K9yQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2020 08:04:02 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 1/3] block: remove blk_queue_root_blkg
Date:   Fri,  1 May 2020 00:03:54 +0900
Message-Id: <20200430150356.35691-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200430150356.35691-1-johannes.thumshirn@wdc.com>
References: <20200430150356.35691-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_queue_root_blkg() has no callers, remove it.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk-cgroup.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 4deb8bb7b6af..a606767cdcc7 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -364,17 +364,6 @@ static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
 	return __blkg_lookup(blkcg, q, false);
 }
 
-/**
- * blk_queue_root_blkg - return blkg for the (blkcg_root, @q) pair
- * @q: request_queue of interest
- *
- * Lookup blkg for @q at the root level. See also blkg_lookup().
- */
-static inline struct blkcg_gq *blk_queue_root_blkg(struct request_queue *q)
-{
-	return q->root_blkg;
-}
-
 /**
  * blkg_to_pdata - get policy private data
  * @blkg: blkg of interest
@@ -709,8 +698,6 @@ static inline bool blk_cgroup_congested(void) { return false; }
 static inline void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay) { }
 
 static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg, void *key) { return NULL; }
-static inline struct blkcg_gq *blk_queue_root_blkg(struct request_queue *q)
-{ return NULL; }
 static inline int blkcg_init_queue(struct request_queue *q) { return 0; }
 static inline void blkcg_exit_queue(struct request_queue *q) { }
 static inline int blkcg_policy_register(struct blkcg_policy *pol) { return 0; }
-- 
2.24.1

