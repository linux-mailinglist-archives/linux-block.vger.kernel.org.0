Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E00845A043
	for <lists+linux-block@lfdr.de>; Tue, 23 Nov 2021 11:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbhKWKfJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 Nov 2021 05:35:09 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57482 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbhKWKfH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 05:35:07 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AA7A31FD5D;
        Tue, 23 Nov 2021 10:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637663518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tp7/8R1LmG938qy5axq4MAM3rTPHcg6t4envA+5B7xo=;
        b=nWKMVABmByzQ3zIZXP3PskKizx2tX1Mqr+Pf2KBjmUG3iwAxsWcQjJHrpsH03tbnL0jAXY
        qKl03DPMDL4yP9vI3Z6jB62aUBjhHcHMoTassp3vwuL/5NfJb5w8GvmvemVrHlnYHvoGKF
        T0TSd8w1/WTOKnFL3z5ZTkitJK1jXtQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637663518;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tp7/8R1LmG938qy5axq4MAM3rTPHcg6t4envA+5B7xo=;
        b=5VWSmDXIotZmyjURxtK9epV88adVeYS06QX7iGIl2/1X5l+Au7HiUEFNvdnL1t+pa4pcdk
        Tq1fRW8eVnWrwkAQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id A290AA3B89;
        Tue, 23 Nov 2021 10:31:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 759C71E3B01; Tue, 23 Nov 2021 11:31:58 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 6/8] bfq: Provide helper to generate bfqq name
Date:   Tue, 23 Nov 2021 11:29:18 +0100
Message-Id: <20211123103158.17284-6-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211123101109.20879-1-jack@suse.cz>
References: <20211123101109.20879-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2907; h=from:subject; bh=lIW8uaLgOKwWPQwZ8mubQz8UhMz485reSQkalNeN/dQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhnMJ9yHX8wjbtONKgxP8uQ+RM1kSJK6/bTo5GIH08 iqxLYvSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYZzCfQAKCRCcnaoHP2RA2W68CA DomDxuKwQ1TF80s8mqC0OabqkJZ7FzI5l/oe2me/iNX79EWPItu3vY8jXTLyKO4Z8h998eTHKLgiJn WzJoM/g1rpRSTAhA/Ed5pATLQe5Epzg3tXtRVMM7KCt2w41qmRjXVY+YjvY2L7q1XjHv1Zd8R/gYOM 9A3evRzxyTWcl+Zr1ZVN2l8Gpgl8emQ5pGg8yWBvulSNTHU5mI+saFU2SQr77Q2ragYHMLm9brzuA3 QRlS3mqSHQEq9tDR/Ka7BYVXxvZCRO5tHwOe08u5cDmZWAC/F4WU57aHDlcDVc7M0w6OKRVduAUTm8 2Xm0oLINT2MhHfm2eeyucVhgt7UjSH
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of having helper formating bfqq pid, provide a helper to
generate full bfqq name as used in the traces. It saves some code
duplication and will save more in the coming tracepoints.

Acked-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.h | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index bb8180c52a31..07288b9da389 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -25,7 +25,7 @@
 #define BFQ_DEFAULT_GRP_IOPRIO	0
 #define BFQ_DEFAULT_GRP_CLASS	IOPRIO_CLASS_BE
 
-#define MAX_PID_STR_LENGTH 12
+#define MAX_BFQQ_NAME_LENGTH 16
 
 /*
  * Soft real-time applications are extremely more latency sensitive
@@ -1083,26 +1083,27 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq);
 /* --------------- end of interface of B-WF2Q+ ---------------- */
 
 /* Logging facilities. */
-static inline void bfq_pid_to_str(int pid, char *str, int len)
+static inline void bfq_bfqq_name(struct bfq_queue *bfqq, char *str, int len)
 {
-	if (pid != -1)
-		snprintf(str, len, "%d", pid);
+	char type = bfq_bfqq_sync(bfqq) ? 'S' : 'A';
+
+	if (bfqq->pid != -1)
+		snprintf(str, len, "bfq%d%c", bfqq->pid, type);
 	else
-		snprintf(str, len, "SHARED-");
+		snprintf(str, len, "bfqSHARED-%c", type);
 }
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
 
 #define bfq_log_bfqq(bfqd, bfqq, fmt, args...)	do {			\
-	char pid_str[MAX_PID_STR_LENGTH];	\
+	char pid_str[MAX_BFQQ_NAME_LENGTH];				\
 	if (likely(!blk_trace_note_message_enabled((bfqd)->queue)))	\
 		break;							\
-	bfq_pid_to_str((bfqq)->pid, pid_str, MAX_PID_STR_LENGTH);	\
+	bfq_bfqq_name((bfqq), pid_str, MAX_BFQQ_NAME_LENGTH);		\
 	blk_add_cgroup_trace_msg((bfqd)->queue,				\
 			bfqg_to_blkg(bfqq_group(bfqq))->blkcg,		\
-			"bfq%s%c " fmt, pid_str,			\
-			bfq_bfqq_sync((bfqq)) ? 'S' : 'A', ##args);	\
+			"%s " fmt, pid_str, ##args);			\
 } while (0)
 
 #define bfq_log_bfqg(bfqd, bfqg, fmt, args...)	do {			\
@@ -1113,13 +1114,11 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
 #else /* CONFIG_BFQ_GROUP_IOSCHED */
 
 #define bfq_log_bfqq(bfqd, bfqq, fmt, args...) do {	\
-	char pid_str[MAX_PID_STR_LENGTH];	\
+	char pid_str[MAX_BFQQ_NAME_LENGTH];				\
 	if (likely(!blk_trace_note_message_enabled((bfqd)->queue)))	\
 		break;							\
-	bfq_pid_to_str((bfqq)->pid, pid_str, MAX_PID_STR_LENGTH);	\
-	blk_add_trace_msg((bfqd)->queue, "bfq%s%c " fmt, pid_str,	\
-			bfq_bfqq_sync((bfqq)) ? 'S' : 'A',		\
-				##args);	\
+	bfq_bfqq_name((bfqq), pid_str, MAX_BFQQ_NAME_LENGTH);		\
+	blk_add_trace_msg((bfqd)->queue, "%s " fmt, pid_str, ##args);	\
 } while (0)
 #define bfq_log_bfqg(bfqd, bfqg, fmt, args...)		do {} while (0)
 
-- 
2.26.2

