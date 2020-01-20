Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9F71433EA
	for <lists+linux-block@lfdr.de>; Mon, 20 Jan 2020 23:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgATW0n (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 20 Jan 2020 17:26:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43464 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgATW0n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jan 2020 17:26:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id p27so412510pli.10;
        Mon, 20 Jan 2020 14:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qPHXmfgTKX2jhDKGAsUFE7QXN74mgD0rsNUEzaus+QA=;
        b=eyvVr/VdB9Sz4J21uRBIcJ/5PKkVVxf60DWhKnlCnPhPGDGEsZRAdZa/foPHOd/LDW
         DnHWi7p+dz4hNMKO8ENxFHk7Obmjz0VTKrzS/WIomKaU/faRTVbxIUI/V0PRc2BnWSk9
         AS85dphzxlt+/SpdU9yuJgdiO9TnlyqnY0aV5luHNYTJ+WqI1lLIdGjmn2l5P2pCXwou
         dcRqRo8EPn3rgRylp1P8JCL3BkfAGVuGPoEwOG5+6rdNhKr4h1qr80Ek2OQWzFrqg7y+
         XXFziPy2lUUg/4pQ/tScV4DwIgSkibaAPUNS7Lh1PNQXQPt1p3WENcsUJBGajqIAyw2w
         LRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qPHXmfgTKX2jhDKGAsUFE7QXN74mgD0rsNUEzaus+QA=;
        b=Ffs8xIM/BC/ujqpojqDiVby1qHU8AhOgUvojkRSko7dRBdZfROLlAa8/rHXpHXxTcB
         T2sFxaEvmPUnnrcfTmfTzxp2IOWf9fjduYpoaerizp9auI5US/oEFChauwfICxoS8T8O
         xCgRj/1sKxK0yY2jk/IDOyH4lX+dA8IGIv8f5qfrJZZiU9myrtxKNr0YVPKGLPInS31M
         JxLByDVloAcshnY6YJwZlcfFnSkxbTgVm91YWi59oO4PIB3zn2E+Pa3bjqM1aNEfbGab
         uCX3lBuwVrslpOl+AEHfpI31bMScaSHZqN8shQV0XLDNB/I9ArbkQILO4KdUnEJ/ATg6
         EtAQ==
X-Gm-Message-State: APjAAAV+eAW3be+n/ioZQQwjpW6lzkhb1Nqy0R5MBbBrdLZUaIH1kZ7z
        hf4v+IMU3stb1qM3A+8A5TzJpx5iwy0=
X-Google-Smtp-Source: APXvYqxX5GDDR8FP/ent9qARAT8WgUzuWm6S9rRLHQlTncdNJ1guWbbpNwN91TAN74LpsKQl+niJvg==
X-Received: by 2002:a17:902:7596:: with SMTP id j22mr2024446pll.335.1579559201782;
        Mon, 20 Jan 2020 14:26:41 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id o16sm38649873pgl.58.2020.01.20.14.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 14:26:41 -0800 (PST)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [Patch v2] block: introduce block_rq_error tracepoint
Date:   Mon, 20 Jan 2020 14:26:18 -0800
Message-Id: <20200120222618.1456-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, rasdaemon uses the existing tracepoint block_rq_complete
and filters out non-error cases in order to capture block disk errors.

But there are a few problems with this approach:

1. Even kernel trace filter could do the filtering work, there is
   still some overhead after we enable this tracepoint.

2. The filter is merely based on errno, which does not align with kernel
   logic to check the errors for print_req_error().

3. block_rq_complete only provides dev major and minor to identify
   the block device, it is not convenient to use in user-space.

So introduce a new tracepoint block_rq_error just for the error case
and provides the device name for convenience too. With this patch,
rasdaemon could switch to block_rq_error.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 block/blk-core.c             |  4 +++-
 include/trace/events/block.h | 43 ++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 089e890ab208..0c7ad70d06be 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1450,8 +1450,10 @@ bool blk_update_request(struct request *req, blk_status_t error,
 #endif
 
 	if (unlikely(error && !blk_rq_is_passthrough(req) &&
-		     !(req->rq_flags & RQF_QUIET)))
+		     !(req->rq_flags & RQF_QUIET))) {
+		trace_block_rq_error(req, blk_status_to_errno(error), nr_bytes);
 		print_req_error(req, error, __func__);
+	}
 
 	blk_account_io_completion(req, nr_bytes);
 
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 81b43f5bdf23..37e99be19536 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -145,6 +145,49 @@ TRACE_EVENT(block_rq_complete,
 		  __entry->nr_sector, __entry->error)
 );
 
+/**
+ * block_rq_error - block IO operation error reported by device driver
+ * @rq: block operations request
+ * @error: status code
+ * @nr_bytes: number of completed bytes
+ *
+ * The block_rq_error tracepoint event indicates that some portion
+ * of operation request has failed as reported by the device driver.
+ */
+TRACE_EVENT(block_rq_error,
+
+	TP_PROTO(struct request *rq, int error, unsigned int nr_bytes),
+
+	TP_ARGS(rq, error, nr_bytes),
+
+	TP_STRUCT__entry(
+		__field(  dev_t,	dev			)
+		__dynamic_array( char,  name,	DISK_NAME_LEN	)
+		__field(  sector_t,	sector			)
+		__field(  unsigned int,	nr_sector		)
+		__field(  int,		error			)
+		__array(  char,		rwbs,	RWBS_LEN	)
+		__dynamic_array( char,	cmd,	1		)
+	),
+
+	TP_fast_assign(
+		__entry->dev	   = rq->rq_disk ? disk_devt(rq->rq_disk) : 0;
+		__assign_str(name,   rq->rq_disk ? rq->rq_disk->disk_name : "?");
+		__entry->sector    = blk_rq_pos(rq);
+		__entry->nr_sector = nr_bytes >> 9;
+		__entry->error     = error;
+
+		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, nr_bytes);
+		__get_str(cmd)[0] = '\0';
+	),
+
+	TP_printk("%d,%d %s %s (%s) %llu + %u [%d]",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __get_str(name), __entry->rwbs, __get_str(cmd),
+		  (unsigned long long)__entry->sector,
+		  __entry->nr_sector, __entry->error)
+);
+
 DECLARE_EVENT_CLASS(block_rq,
 
 	TP_PROTO(struct request_queue *q, struct request *rq),
-- 
2.21.1

