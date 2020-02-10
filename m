Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 123311571C1
	for <lists+linux-block@lfdr.de>; Mon, 10 Feb 2020 10:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgBJJeM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 10 Feb 2020 04:34:12 -0500
Received: from relay.sw.ru ([185.231.240.75]:59484 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727447AbgBJJeM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Feb 2020 04:34:12 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104] helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j15Rr-0000Jg-VM; Mon, 10 Feb 2020 12:33:48 +0300
Subject: [PATCH v6 3/6] block: Introduce
 blk_queue_get_max_write_zeroes_sectors()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     martin.petersen@oracle.com, bob.liu@oracle.com, axboe@kernel.dk
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        Chaitanya.Kulkarni@wdc.com, darrick.wong@oracle.com,
        ming.lei@redhat.com, osandov@fb.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        chaitanya.kulkarni@wdc.com, bvanassche@acm.org,
        dhowells@redhat.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Mon, 10 Feb 2020 12:33:47 +0300
Message-ID: <158132722779.239613.9781671964100227340.stgit@localhost.localdomain>
In-Reply-To: <158132703141.239613.3550455492676290009.stgit@localhost.localdomain>
References: <158132703141.239613.3550455492676290009.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This introduces a new primitive, which returns max sectors
for REQ_OP_WRITE_ZEROES operation.
@op_flags is unused now, and it will be enabled in next patch.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Reviewed-by: Bob Liu <bob.liu@oracle.com>
---
 block/blk-core.c       |    2 +-
 block/blk-merge.c      |    9 ++++++---
 include/linux/blkdev.h |    8 +++++++-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 28a6d46eb982..c7387b0d69e5 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -949,7 +949,7 @@ generic_make_request_checks(struct bio *bio)
 			goto not_supported;
 		break;
 	case REQ_OP_WRITE_ZEROES:
-		if (!q->limits.max_write_zeroes_sectors)
+		if (!blk_queue_get_max_write_zeroes_sectors(q, bio->bi_opf))
 			goto not_supported;
 		break;
 	default:
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 1534ed736363..467b292bc6e8 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -105,15 +105,18 @@ static struct bio *blk_bio_discard_split(struct request_queue *q,
 static struct bio *blk_bio_write_zeroes_split(struct request_queue *q,
 		struct bio *bio, struct bio_set *bs, unsigned *nsegs)
 {
+	unsigned int max_sectors;
+
+	max_sectors = blk_queue_get_max_write_zeroes_sectors(q, bio->bi_opf);
 	*nsegs = 0;
 
-	if (!q->limits.max_write_zeroes_sectors)
+	if (!max_sectors)
 		return NULL;
 
-	if (bio_sectors(bio) <= q->limits.max_write_zeroes_sectors)
+	if (bio_sectors(bio) <= max_sectors)
 		return NULL;
 
-	return bio_split(bio, q->limits.max_write_zeroes_sectors, GFP_NOIO, bs);
+	return bio_split(bio, max_sectors, GFP_NOIO, bs);
 }
 
 static struct bio *blk_bio_write_same_split(struct request_queue *q,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f4ec7ae214ab..55a714161684 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -987,6 +987,12 @@ static inline struct bio_vec req_bvec(struct request *rq)
 	return mp_bvec_iter_bvec(rq->bio->bi_io_vec, rq->bio->bi_iter);
 }
 
+static inline unsigned int blk_queue_get_max_write_zeroes_sectors(
+		struct request_queue *q, unsigned int op_flags)
+{
+	return q->limits.max_write_zeroes_sectors;
+}
+
 static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 						     unsigned int op_flags)
 {
@@ -1000,7 +1006,7 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 		return q->limits.max_write_same_sectors;
 
 	if (unlikely(op == REQ_OP_WRITE_ZEROES))
-		return q->limits.max_write_zeroes_sectors;
+		return blk_queue_get_max_write_zeroes_sectors(q, op_flags);
 
 	return q->limits.max_sectors;
 }


