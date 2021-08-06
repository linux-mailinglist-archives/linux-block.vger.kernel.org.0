Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAC43E22C8
	for <lists+linux-block@lfdr.de>; Fri,  6 Aug 2021 07:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242984AbhHFFMC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 6 Aug 2021 01:12:02 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64546 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242906AbhHFFMB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Aug 2021 01:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628226705; x=1659762705;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=yF/LJ6VOE4VEWoTqOdUoMSQXN8kTNgY8NlgLx4xkskI=;
  b=fhN5l2VICSYtSuFIFbH+7tde8HL7p+0+3SqyzvOKoZFEeuN8Swfm9GFv
   C4v+nWgw0xrcefE9+qdwu7LXmG1q0F0bKoKxq1yYk2myteLWWlL3PGWrd
   VcEbmvDy0jEaJ5Q921uFGreuC0LWs7VrSdEKwQwY7KwZYRiAngN+ZCxXy
   4ZAIKfq1AH2uFBWpwzcObatoO5dARC8O+1MHJRV/nSVsIePYZ5r5UcSac
   Di77cdIyHJwu5ocgsCLM6fNKiYxsT6Y8p6ttqOHYTYtcqN+MAJEv0nbvz
   2i9LipclNqJvUky1lIfKGTydFLCjDjysIEr9jiQ+F6dLl54n/Vug7Z5Bi
   A==;
X-IronPort-AV: E=Sophos;i="5.84,299,1620662400"; 
   d="scan'208";a="176473066"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2021 13:11:45 +0800
IronPort-SDR: lEKf7rrC7NZd3bUToxO9R3COxApIkKo/A5Wte2eZ7om38zgHEENdf2HYdSodMgYbH6vey+C9m0
 USP/nVYwZo0tUeSy8r0FXYT3bCw8LXgtebDCWXNQR/Z4f15lHWC3jowFHyrvwCuu3M3OszjyFs
 D7gjJysEM+1lj/0JYkUmkppoWUjBf1wehbwf1nrOshT0HCRAM02S8sBHtdhONdAnJERFxd94SN
 +qHowpqpfEnDCd9IyOdqfDHt8Pmy+ngUPOErMOe5ER+VN8oBag+8Kgf0mq2ayprMYilI/ke28S
 VXjBsN06QFkj10THz7M08nmS
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 21:49:15 -0700
IronPort-SDR: w8bV4j/ECwEnGb61JKPkK60ne7QZHiyOx4aiWPBKHc+/Lwy3T7i8PD2dgRL7CYtK930rAjoRuF
 5/pTFPHrvdZmAN56NEOh78/jBMsLjG0HGiwX81GtWrDlym4wBDdBgDXqYWnrZYJ02yE1nlqdCl
 L6kz2o/M7pbjVMCB75iqE4K8LRq9bRWHe8OqCV/BlBjLsed/1e3E0RyfxRn6U++DEygyqBC9Vx
 qDRmYHe9UNHk7x7x/M7uaLHmKdQvFNo/C+k2qqLiHpR5FduaUBBDZ6MfQtL0MHQIafShBwgOUp
 HKI=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Aug 2021 22:11:45 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 2/4] block: fix ioprio interface
Date:   Fri,  6 Aug 2021 14:11:38 +0900
Message-Id: <20210806051140.301127-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210806051140.301127-1-damien.lemoal@wdc.com>
References: <20210806051140.301127-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

An iocb aio_reqprio field is 16-bits (u16) but often handled as an int
in the block layer. E.g. ioprio_check_cap() takes an int as argument.
With such implicit int casting function calls, the upper 16-bits of the
int argument may be left uninitialized by the compiler, resulting in
invalid values for the IOPRIO_PRIO_CLASS() macro (garbage upper bits)
and in an error return for functions such as ioprio_check_cap().

Fix this by masking the result of the shift by IOPRIO_CLASS_SHIFT bits
in the IOPRIO_PRIO_CLASS() macro. The new macro IOPRIO_CLASS_MASK
defines the 3-bits mask for the priority class.

While at it, cleanup the following:
* Apply the mask IOPRIO_PRIO_MASK to the data argument of the
  IOPRIO_PRIO_VALUE() macro to ignore upper bits of the data value.
* Remove unnecessary parenthesis around fixed values in the macro
  definitions in include/uapi/linux/ioprio.h.
* Update the outdated mention of CFQ in the comment describing priority
  classes and instead mention BFQ and mq-deadline.
* Change the argument name of the IOPRIO_PRIO_CLASS() and
  IOPRIO_PRIO_DATA() macros from "mask" to "ioprio" to reflect the fact
  that an IO priority value should be passed rather than a mask.
* Change the ioprio_valid() macro into an inline function, adding a
  check on the maximum value of the class of a priority value as
  defined by the IOPRIO_CLASS_MAX enum value. Move this function to
  the kernel side in include/linux/ioprio.h.
* Remove the unnecessary "else" after the return statements in
  task_nice_ioclass().

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 include/linux/ioprio.h      | 15 ++++++++++++---
 include/uapi/linux/ioprio.h | 19 +++++++++++--------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index ef9ad4fb245f..9b3a6d8172b4 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -8,6 +8,16 @@
 
 #include <uapi/linux/ioprio.h>
 
+/*
+ * Check that a priority value has a valid class.
+ */
+static inline bool ioprio_valid(unsigned short ioprio)
+{
+	unsigned short class = IOPRIO_PRIO_CLASS(ioprio);
+
+	return class > IOPRIO_CLASS_NONE && class < IOPRIO_CLASS_MAX;
+}
+
 /*
  * if process has set io priority explicitly, use that. if not, convert
  * the cpu scheduler nice value to an io priority
@@ -25,10 +35,9 @@ static inline int task_nice_ioclass(struct task_struct *task)
 {
 	if (task->policy == SCHED_IDLE)
 		return IOPRIO_CLASS_IDLE;
-	else if (task_is_realtime(task))
+	if (task_is_realtime(task))
 		return IOPRIO_CLASS_RT;
-	else
-		return IOPRIO_CLASS_BE;
+	return IOPRIO_CLASS_BE;
 }
 
 /*
diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index 77b17e08b0da..abc40965aa96 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -5,12 +5,15 @@
 /*
  * Gives us 8 prio classes with 13-bits of data for each class
  */
-#define IOPRIO_CLASS_SHIFT	(13)
+#define IOPRIO_CLASS_SHIFT	13
+#define IOPRIO_CLASS_MASK	0x07
 #define IOPRIO_PRIO_MASK	((1UL << IOPRIO_CLASS_SHIFT) - 1)
 
-#define IOPRIO_PRIO_CLASS(mask)	((mask) >> IOPRIO_CLASS_SHIFT)
-#define IOPRIO_PRIO_DATA(mask)	((mask) & IOPRIO_PRIO_MASK)
-#define IOPRIO_PRIO_VALUE(class, data)	(((class) << IOPRIO_CLASS_SHIFT) | data)
+#define IOPRIO_PRIO_CLASS(ioprio)	\
+	(((ioprio) >> IOPRIO_CLASS_SHIFT) & IOPRIO_CLASS_MASK)
+#define IOPRIO_PRIO_DATA(ioprio)	((ioprio) & IOPRIO_PRIO_MASK)
+#define IOPRIO_PRIO_VALUE(class, data)	\
+	(((class) << IOPRIO_CLASS_SHIFT) | ((data) & IOPRIO_PRIO_MASK))
 
 /*
  * These are the io priority groups as implemented by CFQ. RT is the realtime
@@ -23,14 +26,14 @@ enum {
 	IOPRIO_CLASS_RT,
 	IOPRIO_CLASS_BE,
 	IOPRIO_CLASS_IDLE,
-};
 
-#define ioprio_valid(mask)	(IOPRIO_PRIO_CLASS((mask)) != IOPRIO_CLASS_NONE)
+	IOPRIO_CLASS_MAX,
+};
 
 /*
  * 8 best effort priority levels are supported
  */
-#define IOPRIO_BE_NR	(8)
+#define IOPRIO_BE_NR	8
 
 enum {
 	IOPRIO_WHO_PROCESS = 1,
@@ -41,6 +44,6 @@ enum {
 /*
  * Fallback BE priority
  */
-#define IOPRIO_NORM	(4)
+#define IOPRIO_NORM	4
 
 #endif /* _UAPI_LINUX_IOPRIO_H */
-- 
2.31.1

