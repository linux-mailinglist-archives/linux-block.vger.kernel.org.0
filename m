Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC88137BDE4
	for <lists+linux-block@lfdr.de>; Wed, 12 May 2021 15:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhELNRs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 12 May 2021 09:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhELNR2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 09:17:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C82FC061343;
        Wed, 12 May 2021 06:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=wBqLf3U53W8o1nSjp41VH4IIHMom8i3XTwt27A2+ZxI=; b=luDeQe8Y+R3ijBUVYyP6fzwChU
        mkDdGOsW2OxC2aC/pfFKlfp/JkWneyZ9mPUD8mbykseGhLR8PCUyld9kMKGmd2bPl5v9MoeLUB4V0
        RKdwfFACiTi80amVVv0AApIfloUNXitvpeFeqiuIDKC4dJLnt+zehPbv0IKxq4WLCDap39RT20VW3
        oWEcrofbCJGrHKtqsz2ObjHYwL37QeaunF/IYDo7wEoIEDX4MBVs0sphhIW72roFS/AekT7SH6H6Q
        p1A+5fon9f83Q+nEOqdUydeHMPhiXMnqtOCMHRVU6V+1ZbM1i/mDh6SuU/Fw7CNjW6LTFSenH5D58
        C0HOa1kQ==;
Received: from [2001:4bb8:198:fbc8:1036:7ab9:f97a:adbc] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgoii-00AO4I-3c; Wed, 12 May 2021 13:16:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH 09/15] block: rename REQ_HIPRI to REQ_POLLED
Date:   Wed, 12 May 2021 15:15:39 +0200
Message-Id: <20210512131545.495160-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512131545.495160-1-hch@lst.de>
References: <20210512131545.495160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Unlike the RWF_HIPRI userspace ABI which is intentionally kept vague,
the bio flag is specific to the polling implementation, so rename and
document it properly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c          |  2 +-
 block/blk-merge.c         |  2 +-
 block/blk-mq-debugfs.c    |  2 +-
 block/blk-mq.c            |  4 ++--
 block/blk-mq.h            |  4 ++--
 drivers/nvme/host/core.c  |  2 +-
 drivers/scsi/scsi_debug.c | 10 +++++-----
 include/linux/bio.h       |  2 +-
 include/linux/blk_types.h |  4 ++--
 mm/page_io.c              |  2 +-
 10 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 689aac2625d2..94a817532472 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -837,7 +837,7 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 	}
 
 	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
-		bio->bi_opf &= ~REQ_HIPRI;
+		bio->bi_opf &= ~REQ_POLLED;
 
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 4d97fb6dd226..5c9d2a4ece86 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -285,7 +285,7 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	 * iopoll in direct IO routine. Given performance gain of iopoll for
 	 * big IO can be trival, disable iopoll when split needed.
 	 */
-	bio->bi_opf &= ~REQ_HIPRI;
+	bio->bi_opf &= ~REQ_POLLED;
 
 	return bio_split(bio, sectors, GFP_NOIO, bs);
 }
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 2a75bc7401df..0b821b369ffd 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -286,7 +286,7 @@ static const char *const cmd_flag_name[] = {
 	CMD_FLAG_NAME(BACKGROUND),
 	CMD_FLAG_NAME(NOWAIT),
 	CMD_FLAG_NAME(NOUNMAP),
-	CMD_FLAG_NAME(HIPRI),
+	CMD_FLAG_NAME(POLLED),
 };
 #undef CMD_FLAG_NAME
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 164e39d34bf6..b0b35473f339 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -667,7 +667,7 @@ bool blk_mq_complete_request_remote(struct request *rq)
 	 * For a polled request, always complete locallly, it's pointless
 	 * to redirect the completion.
 	 */
-	if (rq->cmd_flags & REQ_HIPRI)
+	if (rq->cmd_flags & REQ_POLLED)
 		return false;
 
 	if (blk_mq_complete_need_ipi(rq)) {
@@ -2216,7 +2216,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 
 	rq_qos_throttle(q, bio);
 
-	hipri = bio->bi_opf & REQ_HIPRI;
+	hipri = bio->bi_opf & REQ_POLLED;
 
 	data.cmd_flags = bio->bi_opf;
 	rq = __blk_mq_alloc_request(&data);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9ce64bc4a6c8..2c1c73e19c89 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -108,9 +108,9 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 	enum hctx_type type = HCTX_TYPE_DEFAULT;
 
 	/*
-	 * The caller ensure that if REQ_HIPRI, poll must be enabled.
+	 * The caller ensure that if REQ_POLLED, poll must be enabled.
 	 */
-	if (flags & REQ_HIPRI)
+	if (flags & REQ_POLLED)
 		type = HCTX_TYPE_POLL;
 	else if ((flags & REQ_OP_MASK) == REQ_OP_READ)
 		type = HCTX_TYPE_READ;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8fa7e90020b0..c58dde3460e9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1027,7 +1027,7 @@ static void nvme_execute_rq_polled(struct request_queue *q,
 
 	WARN_ON_ONCE(!test_bit(QUEUE_FLAG_POLL, &q->queue_flags));
 
-	rq->cmd_flags |= REQ_HIPRI;
+	rq->cmd_flags |= REQ_POLLED;
 	rq->end_io_data = &wait;
 	blk_execute_rq_nowait(bd_disk, rq, at_head, nvme_end_sync_rq);
 
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index a5d1633b5bd8..81384d28ff90 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5367,7 +5367,7 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 {
 	bool new_sd_dp;
 	bool inject = false;
-	bool hipri = (cmnd->request->cmd_flags & REQ_HIPRI);
+	bool polled = (cmnd->request->cmd_flags & REQ_POLLED);
 	int k, num_in_q, qdepth;
 	unsigned long iflags;
 	u64 ns_from_boot = 0;
@@ -5454,7 +5454,7 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 	if (sdebug_host_max_queue)
 		sd_dp->hc_idx = get_tag(cmnd);
 
-	if (hipri)
+	if (polled)
 		ns_from_boot = ktime_get_boottime_ns();
 
 	/* one of the resp_*() response functions is called here */
@@ -5514,7 +5514,7 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 				kt -= d;
 			}
 		}
-		if (hipri) {
+		if (polled) {
 			sd_dp->cmpl_ts = ktime_add(ns_to_ktime(ns_from_boot), kt);
 			spin_lock_irqsave(&sqp->qc_lock, iflags);
 			if (!sd_dp->init_poll) {
@@ -5545,7 +5545,7 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 		if (unlikely((sdebug_opts & SDEBUG_OPT_CMD_ABORT) &&
 			     atomic_read(&sdeb_inject_pending)))
 			sd_dp->aborted = true;
-		if (hipri) {
+		if (polled) {
 			sd_dp->cmpl_ts = ns_to_ktime(ns_from_boot);
 			spin_lock_irqsave(&sqp->qc_lock, iflags);
 			if (!sd_dp->init_poll) {
@@ -7313,7 +7313,7 @@ static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
 			if (kt_from_boot < sd_dp->cmpl_ts)
 				continue;
 
-		} else		/* ignoring non REQ_HIPRI requests */
+		} else		/* ignoring non REQ_POLLED requests */
 			continue;
 		devip = (struct sdebug_dev_info *)scp->device->hostdata;
 		if (likely(devip))
diff --git a/include/linux/bio.h b/include/linux/bio.h
index a0b4cfdf62a4..439a70bc42e2 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -817,7 +817,7 @@ static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
  */
 static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 {
-	bio->bi_opf |= REQ_HIPRI;
+	bio->bi_opf |= REQ_POLLED;
 	if (!is_sync_kiocb(kiocb))
 		bio->bi_opf |= REQ_NOWAIT;
 }
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d0cf835d3b50..ac60432752e3 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -392,7 +392,7 @@ enum req_flag_bits {
 	/* command specific flags for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
 
-	__REQ_HIPRI,
+	__REQ_POLLED,		/* caller polls for completion using blk_poll */
 
 	/* for driver use */
 	__REQ_DRV,
@@ -417,7 +417,7 @@ enum req_flag_bits {
 #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
 
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
-#define REQ_HIPRI		(1ULL << __REQ_HIPRI)
+#define REQ_POLLED		(1ULL << __REQ_POLLED)
 
 #define REQ_DRV			(1ULL << __REQ_DRV)
 #define REQ_SWAP		(1ULL << __REQ_SWAP)
diff --git a/mm/page_io.c b/mm/page_io.c
index 5d5543fcefa4..ed2eded74f3a 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -416,7 +416,7 @@ int swap_readpage(struct page *page, bool synchronous)
 	 * attempt to access it in the page fault retry time check.
 	 */
 	if (synchronous) {
-		bio->bi_opf |= REQ_HIPRI;
+		bio->bi_opf |= REQ_POLLED;
 		get_task_struct(current);
 		bio->bi_private = current;
 	}
-- 
2.30.2

