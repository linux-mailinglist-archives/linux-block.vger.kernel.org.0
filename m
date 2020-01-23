Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E41146F08
	for <lists+linux-block@lfdr.de>; Thu, 23 Jan 2020 18:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbgAWRDC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 23 Jan 2020 12:03:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:51806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729396AbgAWRDC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jan 2020 12:03:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CFF4AAC50;
        Thu, 23 Jan 2020 17:02:59 +0000 (UTC)
From:   colyli@suse.de
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 12/17] bcache: avoid unnecessary btree nodes flushing in btree_flush_write()
Date:   Fri, 24 Jan 2020 01:01:37 +0800
Message-Id: <20200123170142.98974-13-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200123170142.98974-1-colyli@suse.de>
References: <20200123170142.98974-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Coly Li <colyli@suse.de>

the commit 91be66e1318f ("bcache: performance improvement for
btree_flush_write()") was an effort to flushing btree node with oldest
btree node faster in following methods,
- Only iterate dirty btree nodes in c->btree_cache, avoid scanning a lot
  of clean btree nodes.
- Take c->btree_cache as a LRU-like list, aggressively flushing all
  dirty nodes from tail of c->btree_cache util the btree node with
  oldest journal entry is flushed. This is to reduce the time of holding
  c->bucket_lock.

Guoju Fang and Shuang Li reported that they observe unexptected extra
write I/Os on cache device after applying the above patch. Guoju Fang
provideed more detailed diagnose information that the aggressive
btree nodes flushing may cause 10x more btree nodes to flush in his
workload. He points out when system memory is large enough to hold all
btree nodes in memory, c->btree_cache is not a LRU-like list any more.
Then the btree node with oldest journal entry is very probably not-
close to the tail of c->btree_cache list. In such situation much more
dirty btree nodes will be aggressively flushed before the target node
is flushed. When slow SATA SSD is used as cache device, such over-
aggressive flushing behavior will cause performance regression.

After spending a lot of time on debug and diagnose, I find the real
condition is more complicated, aggressive flushing dirty btree nodes
from tail of c->btree_cache list is not a good solution.
- When all btree nodes are cached in memory, c->btree_cache is not
  a LRU-like list, the btree nodes with oldest journal entry won't
  be close to the tail of the list.
- There can be hundreds dirty btree nodes reference the oldest journal
  entry, before flushing all the nodes the oldest journal entry cannot
  be reclaimed.
When the above two conditions mixed together, a simply flushing from
tail of c->btree_cache list is really NOT a good idea.

Fortunately there is still chance to make btree_flush_write() work
better. Here is how this patch avoids unnecessary btree nodes flushing,
- Only acquire c->journal.lock when getting oldest journal entry of
  fifo c->journal.pin. In rested locations check the journal entries
  locklessly, so their values can be changed on other cores
  in parallel.
- In loop list_for_each_entry_safe_reverse(), checking latest front
  point of fifo c->journal.pin. If it is different from the original
  point which we get with locking c->journal.lock, it means the oldest
  journal entry is reclaim on other cores. At this moment, all selected
  dirty nodes recorded in array btree_nodes[] are all flushed and clean
  on other CPU cores, it is unncessary to iterate c->btree_cache any
  longer. Just quit the list_for_each_entry_safe_reverse() loop and
  the following for-loop will skip all the selected clean nodes.
- Find a proper time to quit the list_for_each_entry_safe_reverse()
  loop. Check the refcount value of orignial fifo front point, if the
  value is larger than selected node number of btree_nodes[], it means
  more matching btree nodes should be scanned. Otherwise it means no
  more matching btee nodes in rest of c->btree_cache list, the loop
  can be quit. If the original oldest journal entry is reclaimed and
  fifo front point is updated, the refcount of original fifo front point
  will be 0, then the loop will be quit too.
- Not hold c->bucket_lock too long time. c->bucket_lock is also required
  for space allocation for cached data, hold it for too long time will
  block regular I/O requests. When iterating list c->btree_cache, even
  there are a lot of maching btree nodes, in order to not holding
  c->bucket_lock for too long time, only BTREE_FLUSH_NR nodes are
  selected and to flush in following for-loop.
With this patch, only btree nodes referencing oldest journal entry
are flushed to cache device, no aggressive flushing for  unnecessary
btree node any more. And in order to avoid blocking regluar I/O
requests, each time when btree_flush_write() called, at most only
BTREE_FLUSH_NR btree nodes are selected to flush, even there are more
maching btree nodes in list c->btree_cache.

At last, one more thing to explain: Why it is safe to read front point
of c->journal.pin without holding c->journal.lock inside the
list_for_each_entry_safe_reverse() loop ?

Here is my answer: When reading the front point of fifo c->journal.pin,
we don't need to know the exact value of front point, we just want to
check whether the value is different from the original front point
(which is accurate value because we get it while c->jouranl.lock is
held). For such purpose, it works as expected without holding
c->journal.lock. Even the front point is changed on other CPU core and
not updated to local core, and current iterating btree node has
identical journal entry local as original fetched fifo front point, it
is still safe. Because after holding mutex b->write_lock (with memory
barrier) this btree node can be found as clean and skipped, the loop
will quite latter when iterate on next node of list c->btree_cache.

Fixes: 91be66e1318f ("bcache: performance improvement for btree_flush_write()")
Reported-by: Guoju Fang <fangguoju@gmail.com>
Reported-by: Shuang Li <psymon@bonuscloud.io>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/journal.c | 80 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 5 deletions(-)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index be2a2a201603..33ddc5269e8d 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -417,10 +417,14 @@ int bch_journal_replay(struct cache_set *s, struct list_head *list)
 
 /* Journalling */
 
+#define nr_to_fifo_front(p, front_p, mask)	(((p) - (front_p)) & (mask))
+
 static void btree_flush_write(struct cache_set *c)
 {
 	struct btree *b, *t, *btree_nodes[BTREE_FLUSH_NR];
-	unsigned int i, n;
+	unsigned int i, nr, ref_nr;
+	atomic_t *fifo_front_p, *now_fifo_front_p;
+	size_t mask;
 
 	if (c->journal.btree_flushing)
 		return;
@@ -433,12 +437,50 @@ static void btree_flush_write(struct cache_set *c)
 	c->journal.btree_flushing = true;
 	spin_unlock(&c->journal.flush_write_lock);
 
+	/* get the oldest journal entry and check its refcount */
+	spin_lock(&c->journal.lock);
+	fifo_front_p = &fifo_front(&c->journal.pin);
+	ref_nr = atomic_read(fifo_front_p);
+	if (ref_nr <= 0) {
+		/*
+		 * do nothing if no btree node references
+		 * the oldest journal entry
+		 */
+		spin_unlock(&c->journal.lock);
+		goto out;
+	}
+	spin_unlock(&c->journal.lock);
+
+	mask = c->journal.pin.mask;
+	nr = 0;
 	atomic_long_inc(&c->flush_write);
 	memset(btree_nodes, 0, sizeof(btree_nodes));
-	n = 0;
 
 	mutex_lock(&c->bucket_lock);
 	list_for_each_entry_safe_reverse(b, t, &c->btree_cache, list) {
+		/*
+		 * It is safe to get now_fifo_front_p without holding
+		 * c->journal.lock here, because we don't need to know
+		 * the exactly accurate value, just check whether the
+		 * front pointer of c->journal.pin is changed.
+		 */
+		now_fifo_front_p = &fifo_front(&c->journal.pin);
+		/*
+		 * If the oldest journal entry is reclaimed and front
+		 * pointer of c->journal.pin changes, it is unnecessary
+		 * to scan c->btree_cache anymore, just quit the loop and
+		 * flush out what we have already.
+		 */
+		if (now_fifo_front_p != fifo_front_p)
+			break;
+		/*
+		 * quit this loop if all matching btree nodes are
+		 * scanned and record in btree_nodes[] already.
+		 */
+		ref_nr = atomic_read(fifo_front_p);
+		if (nr >= ref_nr)
+			break;
+
 		if (btree_node_journal_flush(b))
 			pr_err("BUG: flush_write bit should not be set here!");
 
@@ -454,17 +496,44 @@ static void btree_flush_write(struct cache_set *c)
 			continue;
 		}
 
+		/*
+		 * Only select the btree node which exactly references
+		 * the oldest journal entry.
+		 *
+		 * If the journal entry pointed by fifo_front_p is
+		 * reclaimed in parallel, don't worry:
+		 * - the list_for_each_xxx loop will quit when checking
+		 *   next now_fifo_front_p.
+		 * - If there are matched nodes recorded in btree_nodes[],
+		 *   they are clean now (this is why and how the oldest
+		 *   journal entry can be reclaimed). These selected nodes
+		 *   will be ignored and skipped in the folowing for-loop.
+		 */
+		if (nr_to_fifo_front(btree_current_write(b)->journal,
+				     fifo_front_p,
+				     mask) != 0) {
+			mutex_unlock(&b->write_lock);
+			continue;
+		}
+
 		set_btree_node_journal_flush(b);
 
 		mutex_unlock(&b->write_lock);
 
-		btree_nodes[n++] = b;
-		if (n == BTREE_FLUSH_NR)
+		btree_nodes[nr++] = b;
+		/*
+		 * To avoid holding c->bucket_lock too long time,
+		 * only scan for BTREE_FLUSH_NR matched btree nodes
+		 * at most. If there are more btree nodes reference
+		 * the oldest journal entry, try to flush them next
+		 * time when btree_flush_write() is called.
+		 */
+		if (nr == BTREE_FLUSH_NR)
 			break;
 	}
 	mutex_unlock(&c->bucket_lock);
 
-	for (i = 0; i < n; i++) {
+	for (i = 0; i < nr; i++) {
 		b = btree_nodes[i];
 		if (!b) {
 			pr_err("BUG: btree_nodes[%d] is NULL", i);
@@ -497,6 +566,7 @@ static void btree_flush_write(struct cache_set *c)
 		mutex_unlock(&b->write_lock);
 	}
 
+out:
 	spin_lock(&c->journal.flush_write_lock);
 	c->journal.btree_flushing = false;
 	spin_unlock(&c->journal.flush_write_lock);
-- 
2.16.4

