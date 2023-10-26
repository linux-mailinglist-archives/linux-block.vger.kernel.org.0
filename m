Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D987D8AC0
	for <lists+linux-block@lfdr.de>; Thu, 26 Oct 2023 23:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbjJZVoZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Oct 2023 17:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbjJZVoP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Oct 2023 17:44:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15E9D55
        for <linux-block@vger.kernel.org>; Thu, 26 Oct 2023 14:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698356505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FLdkNZeDzBDZw0g7S19QfUjJntZEmFaL/AX3V9UwJCc=;
        b=bm9QMHhUF8ylqrKVJHMGgQaDBkzHLKZE6MPi9BGE0bZK0msDASAyRJ2Ns8J8GOA92wJQ6a
        hMLo9PZbNhXb+wg0i1wwGf+COHu42LoBXo5mom05ir8/i84xO7ctwBhHBXzSN8ZoK/b5U/
        sZ3wxrpBPXH5soOL2CgEkH1m5Sl+UT8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-Y1-fw5DLPLa5XLFmMF7Bxw-1; Thu,
 26 Oct 2023 17:41:42 -0400
X-MC-Unique: Y1-fw5DLPLa5XLFmMF7Bxw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF09638143BF;
        Thu, 26 Oct 2023 21:41:41 +0000 (UTC)
Received: from pbitcolo-build-10.permabit.com (pbitcolo-build-10.permabit.lab.eng.bos.redhat.com [10.19.117.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9AE9E40C6F79;
        Thu, 26 Oct 2023 21:41:41 +0000 (UTC)
Received: by pbitcolo-build-10.permabit.com (Postfix, from userid 1138)
        id 517613003D; Thu, 26 Oct 2023 17:41:41 -0400 (EDT)
From:   Matthew Sakai <msakai@redhat.com>
To:     dm-devel@lists.linux.dev, linux-block@vger.kernel.org
Cc:     Matthew Sakai <msakai@redhat.com>
Subject: [PATCH v4 26/39] dm vdo: add the slab summary
Date:   Thu, 26 Oct 2023 17:41:23 -0400
Message-Id: <20231026214136.1067410-27-msakai@redhat.com>
In-Reply-To: <20231026214136.1067410-1-msakai@redhat.com>
References: <20231026214136.1067410-1-msakai@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The slab depot maintains an additional small data structure, the "slab
summary," which is used to reduce the amount of work needed to come back
online after a crash. The slab summary maintains an entry for each slab
indicating whether or not the slab has ever been used, whether it is clean
(i.e. all of its reference count updates have been persisted to storage),
and approximately how full it is. During recovery, each physical zone will
attempt to recover at least one slab, stopping whenever it has recovered a
slab which has some free blocks. Once each zone has some space (or has
determined that none is available), the target can resume normal operation
in a degraded mode. Read and write requests can be serviced, perhaps with
degraded performance, while the remainder of the dirty slabs are recovered.

Co-developed-by: J. corwin Coburn <corwin@hurlbutnet.net>
Signed-off-by: J. corwin Coburn <corwin@hurlbutnet.net>
Co-developed-by: Michael Sclafani <vdo-devel@redhat.com>
Signed-off-by: Michael Sclafani <vdo-devel@redhat.com>
Co-developed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Matthew Sakai <msakai@redhat.com>
---
 drivers/md/dm-vdo/slab-depot.c | 326 +++++++++++++++++++++++++++++++++
 drivers/md/dm-vdo/slab-depot.h |  74 ++++++++
 2 files changed, 400 insertions(+)

diff --git a/drivers/md/dm-vdo/slab-depot.c b/drivers/md/dm-vdo/slab-depot.c
index 48adf297a394..e2270319513a 100644
--- a/drivers/md/dm-vdo/slab-depot.c
+++ b/drivers/md/dm-vdo/slab-depot.c
@@ -190,6 +190,201 @@ static void check_if_slab_drained(struct vdo_slab *slab)
 	vdo_finish_draining_with_result(&slab->state, (read_only ? VDO_READ_ONLY : VDO_SUCCESS));
 }
 
+/* FULLNESS HINT COMPUTATION */
+
+/**
+ * compute_fullness_hint() - Translate a slab's free block count into a 'fullness hint' that can be
+ *                           stored in a slab_summary_entry's 7 bits that are dedicated to its free
+ *                           count.
+ * @depot: The depot whose summary being updated.
+ * @free_blocks: The number of free blocks.
+ *
+ * Note: the number of free blocks must be strictly less than 2^23 blocks, even though
+ * theoretically slabs could contain precisely 2^23 blocks; there is an assumption that at least
+ * one block is used by metadata. This assumption is necessary; otherwise, the fullness hint might
+ * overflow. The fullness hint formula is roughly (fullness >> 16) & 0x7f, but (2^23 >> 16) & 0x7f
+ * is 0, which would make it impossible to distinguish completely full from completely empty.
+ *
+ * Return: A fullness hint, which can be stored in 7 bits.
+ */
+static u8 __must_check compute_fullness_hint(struct slab_depot *depot, block_count_t free_blocks)
+{
+	block_count_t hint;
+
+	ASSERT_LOG_ONLY((free_blocks < (1 << 23)), "free blocks must be less than 2^23");
+
+	if (free_blocks == 0)
+		return 0;
+
+	hint = free_blocks >> depot->hint_shift;
+	return ((hint == 0) ? 1 : hint);
+}
+
+/**
+ * check_summary_drain_complete() - Check whether an allocators summary has finished draining.
+ */
+static void check_summary_drain_complete(struct block_allocator *allocator)
+{
+	struct vdo *vdo = allocator->depot->vdo;
+
+	if (!vdo_is_state_draining(&allocator->summary_state) ||
+	    (allocator->summary_write_count > 0))
+		return;
+
+	vdo_finish_operation(&allocator->summary_state,
+			     (vdo_is_read_only(vdo) ? VDO_READ_ONLY : VDO_SUCCESS));
+}
+
+/**
+ * notify_summary_waiters() - Wake all the waiters in a given queue.
+ * @allocator: The block allocator summary which owns the queue.
+ * @queue: The queue to notify.
+ */
+static void notify_summary_waiters(struct block_allocator *allocator, struct wait_queue *queue)
+{
+	int result = (vdo_is_read_only(allocator->depot->vdo) ? VDO_READ_ONLY : VDO_SUCCESS);
+
+	vdo_notify_all_waiters(queue, NULL, &result);
+}
+
+static void launch_write(struct slab_summary_block *summary_block);
+
+/**
+ * finish_updating_slab_summary_block() - Finish processing a block which attempted to write,
+ *                                        whether or not the attempt succeeded.
+ * @block: The block.
+ */
+static void finish_updating_slab_summary_block(struct slab_summary_block *block)
+{
+	notify_summary_waiters(block->allocator, &block->current_update_waiters);
+	block->writing = false;
+	block->allocator->summary_write_count--;
+	if (vdo_has_waiters(&block->next_update_waiters))
+		launch_write(block);
+	else
+		check_summary_drain_complete(block->allocator);
+}
+
+/**
+ * finish_update() - This is the callback for a successful summary block write.
+ * @completion: The write vio.
+ */
+static void finish_update(struct vdo_completion *completion)
+{
+	struct slab_summary_block *block =
+		container_of(as_vio(completion), struct slab_summary_block, vio);
+
+	atomic64_inc(&block->allocator->depot->summary_statistics.blocks_written);
+	finish_updating_slab_summary_block(block);
+}
+
+/**
+ * handle_write_error() - Handle an error writing a slab summary block.
+ * @completion: The write VIO.
+ */
+static void handle_write_error(struct vdo_completion *completion)
+{
+	struct slab_summary_block *block =
+		container_of(as_vio(completion), struct slab_summary_block, vio);
+
+	vio_record_metadata_io_error(as_vio(completion));
+	vdo_enter_read_only_mode(completion->vdo, completion->result);
+	finish_updating_slab_summary_block(block);
+}
+
+static void write_slab_summary_endio(struct bio *bio)
+{
+	struct vio *vio = bio->bi_private;
+	struct slab_summary_block *block = container_of(vio, struct slab_summary_block, vio);
+
+	continue_vio_after_io(vio, finish_update, block->allocator->thread_id);
+}
+
+/**
+ * launch_write() - Write a slab summary block unless it is currently out for writing.
+ * @block: The block that needs to be committed.
+ */
+static void launch_write(struct slab_summary_block *block)
+{
+	struct block_allocator *allocator = block->allocator;
+	struct slab_depot *depot = allocator->depot;
+	physical_block_number_t pbn;
+
+	if (block->writing)
+		return;
+
+	allocator->summary_write_count++;
+	vdo_transfer_all_waiters(&block->next_update_waiters, &block->current_update_waiters);
+	block->writing = true;
+
+	if (vdo_is_read_only(depot->vdo)) {
+		finish_updating_slab_summary_block(block);
+		return;
+	}
+
+	memcpy(block->outgoing_entries, block->entries, VDO_BLOCK_SIZE);
+
+	/*
+	 * Flush before writing to ensure that the slab journal tail blocks and reference updates
+	 * covered by this summary update are stable (VDO-2332).
+	 */
+	pbn = (depot->summary_origin +
+	       (VDO_SLAB_SUMMARY_BLOCKS_PER_ZONE * allocator->zone_number) +
+	       block->index);
+	submit_metadata_vio(&block->vio,
+			    pbn,
+			    write_slab_summary_endio,
+			    handle_write_error,
+			    REQ_OP_WRITE | REQ_PREFLUSH);
+}
+
+/**
+ * update_slab_summary_entry() - Update the entry for a slab.
+ * @slab: The slab whose entry is to be updated
+ * @waiter: The waiter that is updating the summary.
+ * @tail_block_offset: The offset of the slab journal's tail block.
+ * @load_ref_counts: Whether the reference counts must be loaded from disk on the vdo load.
+ * @is_clean: Whether the slab is clean.
+ * @free_blocks: The number of free blocks.
+ */
+static void
+update_slab_summary_entry(struct vdo_slab *slab,
+			  struct waiter *waiter,
+			  tail_block_offset_t tail_block_offset,
+			  bool load_ref_counts,
+			  bool is_clean,
+			  block_count_t free_blocks)
+{
+	u8 index = slab->slab_number / VDO_SLAB_SUMMARY_ENTRIES_PER_BLOCK;
+	struct block_allocator *allocator = slab->allocator;
+	struct slab_summary_block *block = &allocator->summary_blocks[index];
+	int result;
+	struct slab_summary_entry *entry;
+
+	if (vdo_is_read_only(block->vio.completion.vdo)) {
+		result = VDO_READ_ONLY;
+		waiter->callback(waiter, &result);
+		return;
+	}
+
+	if (vdo_is_state_draining(&allocator->summary_state) ||
+	    vdo_is_state_quiescent(&allocator->summary_state)) {
+		result = VDO_INVALID_ADMIN_STATE;
+		waiter->callback(waiter, &result);
+		return;
+	}
+
+	entry = &allocator->summary_entries[slab->slab_number];
+	*entry = (struct slab_summary_entry) {
+		.tail_block_offset = tail_block_offset,
+		.load_ref_counts = (entry->load_ref_counts || load_ref_counts),
+		.is_dirty = !is_clean,
+		.fullness_hint = compute_fullness_hint(allocator->depot, free_blocks),
+	};
+	vdo_enqueue_waiter(&block->next_update_waiters, waiter);
+	launch_write(block);
+}
+
 /**
  * finish_reaping() - Actually advance the head of the journal now that any necessary flushes are
  *                    complete.
@@ -2458,3 +2653,134 @@ make_slab(physical_block_number_t slab_origin,
 	*slab_ptr = slab;
 	return VDO_SUCCESS;
 }
+
+/**
+ * finish_combining_zones() - Clean up after saving out the combined slab summary.
+ * @completion: The vio which was used to write the summary data.
+ */
+static void finish_combining_zones(struct vdo_completion *completion)
+{
+	int result = completion->result;
+	struct vdo_completion *parent = completion->parent;
+
+	free_vio(as_vio(UDS_FORGET(completion)));
+	vdo_fail_completion(parent, result);
+}
+
+static void handle_combining_error(struct vdo_completion *completion)
+{
+	vio_record_metadata_io_error(as_vio(completion));
+	finish_combining_zones(completion);
+}
+
+static void write_summary_endio(struct bio *bio)
+{
+	struct vio *vio = bio->bi_private;
+	struct vdo *vdo = vio->completion.vdo;
+
+	continue_vio_after_io(vio, finish_combining_zones, vdo->thread_config.admin_thread);
+}
+
+/**
+ * combine_summaries() - Treating the current entries buffer as the on-disk value of all zones,
+ *                       update every zone to the correct values for every slab.
+ * @depot: The depot whose summary entries should be combined.
+ */
+static void combine_summaries(struct slab_depot *depot)
+{
+	/*
+	 * Combine all the old summary data into the portion of the buffer corresponding to the
+	 * first zone.
+	 */
+	zone_count_t zone = 0;
+	struct slab_summary_entry *entries = depot->summary_entries;
+
+	if (depot->old_zone_count > 1) {
+		slab_count_t entry_number;
+
+		for (entry_number = 0; entry_number < MAX_VDO_SLABS; entry_number++) {
+			if (zone != 0)
+				memcpy(entries + entry_number,
+				       entries + (zone * MAX_VDO_SLABS) + entry_number,
+				       sizeof(struct slab_summary_entry));
+			zone++;
+			if (zone == depot->old_zone_count)
+				zone = 0;
+		}
+	}
+
+	/* Copy the combined data to each zones's region of the buffer. */
+	for (zone = 1; zone < MAX_VDO_PHYSICAL_ZONES; zone++)
+		memcpy(entries + (zone * MAX_VDO_SLABS),
+		       entries,
+		       MAX_VDO_SLABS * sizeof(struct slab_summary_entry));
+}
+
+/**
+ * finish_loading_summary() - Finish loading slab summary data.
+ * @completion: The vio which was used to read the summary data.
+ *
+ * Combines the slab summary data from all the previously written zones and copies the combined
+ * summary to each partition's data region. Then writes the combined summary back out to disk. This
+ * callback is registered in load_summary_endio().
+ */
+static void finish_loading_summary(struct vdo_completion *completion)
+{
+	struct slab_depot *depot = completion->vdo->depot;
+
+	/* Combine the summary from each zone so each zone is correct for all slabs. */
+	combine_summaries(depot);
+
+	/* Write the combined summary back out. */
+	submit_metadata_vio(as_vio(completion),
+			    depot->summary_origin,
+			    write_summary_endio,
+			    handle_combining_error,
+			    REQ_OP_WRITE);
+}
+
+static void load_summary_endio(struct bio *bio)
+{
+	struct vio *vio = bio->bi_private;
+	struct vdo *vdo = vio->completion.vdo;
+
+	continue_vio_after_io(vio, finish_loading_summary, vdo->thread_config.admin_thread);
+}
+
+/**
+ * load_slab_summary() - The preamble of a load operation.
+ *
+ * Implements vdo_action_preamble.
+ */
+static void load_slab_summary(void *context, struct vdo_completion *parent)
+{
+	int result;
+	struct vio *vio;
+	struct slab_depot *depot = context;
+	const struct admin_state_code *operation =
+		vdo_get_current_manager_operation(depot->action_manager);
+
+	result = create_multi_block_metadata_vio(depot->vdo,
+						 VIO_TYPE_SLAB_SUMMARY,
+						 VIO_PRIORITY_METADATA,
+						 parent,
+						 VDO_SLAB_SUMMARY_BLOCKS,
+						 (char *) depot->summary_entries,
+						 &vio);
+	if (result != VDO_SUCCESS) {
+		vdo_fail_completion(parent, result);
+		return;
+	}
+
+	if ((operation == VDO_ADMIN_STATE_FORMATTING) ||
+	    (operation == VDO_ADMIN_STATE_LOADING_FOR_REBUILD)) {
+		finish_loading_summary(&vio->completion);
+		return;
+	}
+
+	submit_metadata_vio(vio,
+			    depot->summary_origin,
+			    load_summary_endio,
+			    handle_combining_error,
+			    REQ_OP_READ);
+}
diff --git a/drivers/md/dm-vdo/slab-depot.h b/drivers/md/dm-vdo/slab-depot.h
index 12086d475d1a..5e06746c7e71 100644
--- a/drivers/md/dm-vdo/slab-depot.h
+++ b/drivers/md/dm-vdo/slab-depot.h
@@ -24,6 +24,23 @@
 #include "vio.h"
 #include "wait-queue.h"
 
+/*
+ * A slab_depot is responsible for managing all of the slabs and block allocators of a VDO. It has
+ * a single array of slabs in order to eliminate the need for additional math in order to compute
+ * which physical zone a PBN is in. It also has a block_allocator per zone.
+ *
+ * Load operations are required to be performed on a single thread. Normal operations are assumed
+ * to be performed in the appropriate zone. Allocations and reference count updates must be done
+ * from the thread of their physical zone. Requests to commit slab journal tail blocks from the
+ * recovery journal must be done on the journal zone thread. Save operations are required to be
+ * launched from the same thread as the original load operation.
+ */
+
+enum {
+	/* The number of vios in the vio pool is proportional to the throughput of the VDO. */
+	BLOCK_ALLOCATOR_VIO_POOL_SIZE = 128,
+};
+
 /*
  * Represents the possible status of a block.
  */
@@ -240,6 +257,63 @@ struct vdo_slab {
 	struct reference_block *reference_blocks;
 };
 
+/*
+ * The slab_summary provides hints during load and recovery about the state of the slabs in order
+ * to avoid the need to read the slab journals in their entirety before a VDO can come online.
+ *
+ * The information in the summary for each slab includes the rough number of free blocks (which is
+ * used to prioritize scrubbing), the cleanliness of a slab (so that clean slabs containing free
+ * space will be used on restart), and the location of the tail block of the slab's journal.
+ *
+ * The slab_summary has its own partition at the end of the volume which is sized to allow for a
+ * complete copy of the summary for each of up to 16 physical zones.
+ *
+ * During resize, the slab_summary moves its backing partition and is saved once moved; the
+ * slab_summary is not permitted to overwrite the previous recovery journal space.
+ *
+ * The slab_summary does not have its own version information, but relies on the VDO volume version
+ * number.
+ */
+
+/*
+ * A slab status is a very small structure for use in determining the ordering of slabs in the
+ * scrubbing process.
+ */
+struct slab_status {
+	slab_count_t slab_number;
+	bool is_clean;
+	u8 emptiness;
+};
+
+struct slab_summary_block {
+	/* The block_allocator to which this block belongs */
+	struct block_allocator *allocator;
+	/* The index of this block in its zone's summary */
+	block_count_t index;
+	/* Whether this block has a write outstanding */
+	bool writing;
+	/* Ring of updates waiting on the outstanding write */
+	struct wait_queue current_update_waiters;
+	/* Ring of updates waiting on the next write */
+	struct wait_queue next_update_waiters;
+	/* The active slab_summary_entry array for this block */
+	struct slab_summary_entry *entries;
+	/* The vio used to write this block */
+	struct vio vio;
+	/* The packed entries, one block long, backing the vio */
+	char *outgoing_entries;
+};
+
+/*
+ * The statistics for all the slab summary zones owned by this slab summary. These fields are all
+ * mutated only by their physical zone threads, but are read by other threads when gathering
+ * statistics for the entire depot.
+ */
+struct atomic_slab_summary_statistics {
+	/* Number of blocks written */
+	atomic64_t blocks_written;
+};
+
 bool __must_check
 vdo_attempt_replay_into_slab(struct vdo_slab *slab,
 			     physical_block_number_t pbn,
-- 
2.40.0

