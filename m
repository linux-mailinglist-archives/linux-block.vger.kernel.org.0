Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C95C70E7E3
	for <lists+linux-block@lfdr.de>; Tue, 23 May 2023 23:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238711AbjEWVrr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 May 2023 17:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238703AbjEWVrp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 17:47:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1295F1AC
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 14:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684878409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jgWiwpMgKa9dst+rsvEfBvCqfrPnAPkhaFHccj6D2jc=;
        b=C5ANI5H9AFY/rHqkkQ92D9SNEnR+bDBgYCGfp6UeVWwOJaTqwAYH1+w4aNliHY0Ko5iHKy
        3FZWnqSnfh7YKzuHVSF/FAUUv6TQ7nx6E373tLozUCbVpZ2Jzv3sNtd4AwAQvN3d4SvoVk
        5O+H1F70i/6IN7hz79e3E/osu0ftTeU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-3qzWbHFbM7Gb1wwNkgtthA-1; Tue, 23 May 2023 17:46:48 -0400
X-MC-Unique: 3qzWbHFbM7Gb1wwNkgtthA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7582a35bbf8so61363685a.1
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 14:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684878407; x=1687470407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgWiwpMgKa9dst+rsvEfBvCqfrPnAPkhaFHccj6D2jc=;
        b=ZBZdwVYLD0EKzl7R532qK9N18IBUFVvLc1qlJIQTBgb8ut0nIfDT9j8XyETnLv8alX
         c41lkvMfDlhckhIhlwS2RCWd+OX0Tt60o5K4o+KBB9smoSRHxIIfaqzihV0Ri9Owjlys
         nTBleIAC0B8stps/lPOKd6jsd8BCTtpIswdG77ut9mNoi8vB1QZX6dPKogAsS3x7GL8N
         F6UKe8D3OzhTdRwDmeK3lE+grMnnOKR7UbSofcT4nxp9638xNE8ExfRkVS1J1VJQs/zF
         3yj17Iwqg1sjhsPATbB/ofw/RGdrD1eo5T1mNw2v9yDuE8nc5Dcwge1uQzqSCfwGpzV4
         o+hQ==
X-Gm-Message-State: AC+VfDyPnTG05ONc1brhbiAQrBVK335XvaIfLSOfGg4nGqEG5eE7zyef
        dWf/zBUWQEZS9KfDwqH+29Ab0yot1QaCC92x8bej2HZaILgI9hdjx2pX1n0O19kUordEQoIeGVn
        dZPydWHayZDXaU9Ca4JqWQXhcQYdAclM=
X-Received: by 2002:a37:887:0:b0:75b:23a1:362b with SMTP id 129-20020a370887000000b0075b23a1362bmr5512222qki.60.1684878406560;
        Tue, 23 May 2023 14:46:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6jTUMnUVgSTw5LZQqVpqoZXgCjDyXwaUcUJup/BAqCiNG+Afg3gm0wzDwj+epVy2DLnpPbAw==
X-Received: by 2002:a37:887:0:b0:75b:23a1:362b with SMTP id 129-20020a370887000000b0075b23a1362bmr5512193qki.60.1684878405860;
        Tue, 23 May 2023 14:46:45 -0700 (PDT)
Received: from bf36-1.. (173-166-2-198-newengland.hfc.comcastbusiness.net. [173.166.2.198])
        by smtp.gmail.com with ESMTPSA id f25-20020a05620a15b900b0075b196ae392sm1489722qkk.104.2023.05.23.14.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:46:45 -0700 (PDT)
From:   "J. corwin Coburn" <corwin@redhat.com>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org
Cc:     vdo-devel@redhat.com, "J. corwin Coburn" <corwin@redhat.com>
Subject: [PATCH v2 30/39] Implement the vdo block map page cache.
Date:   Tue, 23 May 2023 17:45:30 -0400
Message-Id: <20230523214539.226387-31-corwin@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523214539.226387-1-corwin@redhat.com>
References: <20230523214539.226387-1-corwin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The set of leaf pages of the block map tree is too large to fit in memory,
so each block map zone maintains a cache of leaf pages. This patch adds the
implementation of that cache.

Signed-off-by: J. corwin Coburn <corwin@redhat.com>
---
 drivers/md/dm-vdo/block-map.c | 1230 +++++++++++++++++++++++++++++++++
 drivers/md/dm-vdo/block-map.h |  160 +++++
 2 files changed, 1390 insertions(+)

diff --git a/drivers/md/dm-vdo/block-map.c b/drivers/md/dm-vdo/block-map.c
index d10cf45cad5..c786f71b868 100644
--- a/drivers/md/dm-vdo/block-map.c
+++ b/drivers/md/dm-vdo/block-map.c
@@ -106,6 +106,1236 @@ struct cursors {
 /* Used to indicate that the page holding the location of a tree root has been "loaded". */
 const physical_block_number_t VDO_INVALID_PBN = 0xFFFFFFFFFFFFFFFF;
 
+enum {
+	LOG_INTERVAL = 4000,
+	DISPLAY_INTERVAL = 100000,
+};
+
+/*
+ * For adjusting VDO page cache statistic fields which are only mutated on the logical zone thread.
+ * Prevents any compiler shenanigans from affecting other threads reading those stats.
+ */
+#define ADD_ONCE(value, delta) WRITE_ONCE(value, (value) + (delta))
+
+static inline bool is_dirty(const struct page_info *info)
+{
+	return info->state == PS_DIRTY;
+}
+
+static inline bool is_present(const struct page_info *info)
+{
+	return (info->state == PS_RESIDENT) || (info->state == PS_DIRTY);
+}
+
+static inline bool is_in_flight(const struct page_info *info)
+{
+	return (info->state == PS_INCOMING) || (info->state == PS_OUTGOING);
+}
+
+static inline bool is_incoming(const struct page_info *info)
+{
+	return info->state == PS_INCOMING;
+}
+
+static inline bool is_outgoing(const struct page_info *info)
+{
+	return info->state == PS_OUTGOING;
+}
+
+static inline bool is_valid(const struct page_info *info)
+{
+	return is_present(info) || is_outgoing(info);
+}
+
+static char *get_page_buffer(struct page_info *info)
+{
+	struct vdo_page_cache *cache = info->cache;
+
+	return &cache->pages[(info - cache->infos) * VDO_BLOCK_SIZE];
+}
+
+static inline struct vdo_page_completion *page_completion_from_waiter(struct waiter *waiter)
+{
+	struct vdo_page_completion *completion;
+
+	if (waiter == NULL)
+		return NULL;
+
+	completion = container_of(waiter, struct vdo_page_completion, waiter);
+	vdo_assert_completion_type(&completion->completion, VDO_PAGE_COMPLETION);
+	return completion;
+}
+
+/**
+ * initialize_info() - Initialize all page info structures and put them on the free list.
+ *
+ * Return: VDO_SUCCESS or an error.
+ */
+static int initialize_info(struct vdo_page_cache *cache)
+{
+	struct page_info *info;
+
+	INIT_LIST_HEAD(&cache->free_list);
+	for (info = cache->infos; info < cache->infos + cache->page_count; ++info) {
+		int result;
+
+		info->cache = cache;
+		info->state = PS_FREE;
+		info->pbn = NO_PAGE;
+
+		result = create_metadata_vio(cache->vdo,
+					     VIO_TYPE_BLOCK_MAP,
+					     VIO_PRIORITY_METADATA, info,
+					     get_page_buffer(info),
+					     &info->vio);
+		if (result != VDO_SUCCESS)
+			return result;
+
+		/* The thread ID should never change. */
+		info->vio->completion.callback_thread_id = cache->zone->thread_id;
+
+		INIT_LIST_HEAD(&info->state_entry);
+		list_add_tail(&info->state_entry, &cache->free_list);
+		INIT_LIST_HEAD(&info->lru_entry);
+	}
+
+	return VDO_SUCCESS;
+}
+
+/**
+ * allocate_cache_components() - Allocate components of the cache which require their own
+ *                               allocation.
+ * @maximum_age: The number of journal blocks before a dirtied page is considered old and must be
+ *               written out.
+ *
+ * The caller is responsible for all clean up on errors.
+ *
+ * Return: VDO_SUCCESS or an error code.
+ */
+static int __must_check allocate_cache_components(struct vdo_page_cache *cache)
+{
+	u64 size = cache->page_count * (u64) VDO_BLOCK_SIZE;
+	int result;
+
+	result = UDS_ALLOCATE(cache->page_count, struct page_info, "page infos", &cache->infos);
+	if (result != UDS_SUCCESS)
+		return result;
+
+	result = uds_allocate_memory(size, VDO_BLOCK_SIZE, "cache pages", &cache->pages);
+	if (result != UDS_SUCCESS)
+		return result;
+
+	result = vdo_make_int_map(cache->page_count, 0, &cache->page_map);
+	if (result != UDS_SUCCESS)
+		return result;
+
+	return initialize_info(cache);
+}
+
+/**
+ * assert_on_cache_thread() - Assert that a function has been called on the VDO page cache's
+ *                            thread.
+ */
+static inline void assert_on_cache_thread(struct vdo_page_cache *cache, const char *function_name)
+{
+	thread_id_t thread_id = vdo_get_callback_thread_id();
+
+	ASSERT_LOG_ONLY((thread_id == cache->zone->thread_id),
+			"%s() must only be called on cache thread %d, not thread %d",
+			function_name,
+			cache->zone->thread_id,
+			thread_id);
+}
+
+/** assert_io_allowed() - Assert that a page cache may issue I/O. */
+static inline void assert_io_allowed(struct vdo_page_cache *cache)
+{
+	ASSERT_LOG_ONLY(!vdo_is_state_quiescent(&cache->zone->state),
+			"VDO page cache may issue I/O");
+}
+
+/** report_cache_pressure() - Log and, if enabled, report cache pressure. */
+static void report_cache_pressure(struct vdo_page_cache *cache)
+{
+	ADD_ONCE(cache->stats.cache_pressure, 1);
+	if (cache->waiter_count > cache->page_count) {
+		if ((cache->pressure_report % LOG_INTERVAL) == 0)
+			uds_log_info("page cache pressure %u", cache->stats.cache_pressure);
+
+		if (++cache->pressure_report >= DISPLAY_INTERVAL)
+			cache->pressure_report = 0;
+	}
+}
+
+/**
+ * get_page_state_name() - Return the name of a page state.
+ *
+ * If the page state is invalid a static string is returned and the invalid state is logged.
+ *
+ * Return: A pointer to a static page state name.
+ */
+static const char * __must_check get_page_state_name(enum vdo_page_buffer_state state)
+{
+	int result;
+	static const char * const state_names[] = {
+		"UDS_FREE", "INCOMING", "FAILED", "RESIDENT", "DIRTY", "OUTGOING"
+	};
+
+	STATIC_ASSERT(ARRAY_SIZE(state_names) == PAGE_STATE_COUNT);
+
+	result = ASSERT(state < ARRAY_SIZE(state_names), "Unknown page_state value %d", state);
+	if (result != UDS_SUCCESS)
+		return "[UNKNOWN PAGE STATE]";
+
+	return state_names[state];
+}
+
+/**
+ * update_counter() - Update the counter associated with a given state.
+ * @info: The page info to count.
+ * @delta: The delta to apply to the counter.
+ */
+static void update_counter(struct page_info *info, s32 delta)
+{
+	struct block_map_statistics *stats = &info->cache->stats;
+
+	switch (info->state) {
+	case PS_FREE:
+		ADD_ONCE(stats->free_pages, delta);
+		return;
+
+	case PS_INCOMING:
+		ADD_ONCE(stats->incoming_pages, delta);
+		return;
+
+	case PS_OUTGOING:
+		ADD_ONCE(stats->outgoing_pages, delta);
+		return;
+
+	case PS_FAILED:
+		ADD_ONCE(stats->failed_pages, delta);
+		return;
+
+	case PS_RESIDENT:
+		ADD_ONCE(stats->clean_pages, delta);
+		return;
+
+	case PS_DIRTY:
+		ADD_ONCE(stats->dirty_pages, delta);
+		return;
+
+	default:
+		return;
+	}
+}
+
+/** update_lru() - Update the lru information for an active page. */
+static void update_lru(struct page_info *info)
+{
+	if (info->cache->lru_list.prev != &info->lru_entry)
+		list_move_tail(&info->lru_entry, &info->cache->lru_list);
+}
+
+/**
+ * set_info_state() - Set the state of a page_info and put it on the right list, adjusting
+ *                    counters.
+ */
+static void
+set_info_state(struct page_info *info, enum vdo_page_buffer_state new_state)
+{
+	if (new_state == info->state)
+		return;
+
+	update_counter(info, -1);
+	info->state = new_state;
+	update_counter(info, 1);
+
+	switch (info->state) {
+	case PS_FREE:
+	case PS_FAILED:
+		list_move_tail(&info->state_entry, &info->cache->free_list);
+		return;
+
+	case PS_OUTGOING:
+		list_move_tail(&info->state_entry, &info->cache->outgoing_list);
+		return;
+
+	case PS_DIRTY:
+		return;
+
+	default:
+		list_del_init(&info->state_entry);
+	}
+}
+
+/** set_info_pbn() - Set the pbn for an info, updating the map as needed. */
+static int __must_check set_info_pbn(struct page_info *info, physical_block_number_t pbn)
+{
+	struct vdo_page_cache *cache = info->cache;
+
+	/* Either the new or the old page number must be NO_PAGE. */
+	int result = ASSERT((pbn == NO_PAGE) || (info->pbn == NO_PAGE),
+			    "Must free a page before reusing it.");
+	if (result != VDO_SUCCESS)
+		return result;
+
+	if (info->pbn != NO_PAGE)
+		vdo_int_map_remove(cache->page_map, info->pbn);
+
+	info->pbn = pbn;
+
+	if (pbn != NO_PAGE) {
+		result = vdo_int_map_put(cache->page_map, pbn, info, true, NULL);
+		if (result != UDS_SUCCESS)
+			return result;
+	}
+	return VDO_SUCCESS;
+}
+
+/** reset_page_info() - Reset page info to represent an unallocated page. */
+static int reset_page_info(struct page_info *info)
+{
+	int result;
+
+	result = ASSERT(info->busy == 0, "VDO Page must not be busy");
+	if (result != UDS_SUCCESS)
+		return result;
+
+	result = ASSERT(!vdo_has_waiters(&info->waiting), "VDO Page must not have waiters");
+	if (result != UDS_SUCCESS)
+		return result;
+
+	result = set_info_pbn(info, NO_PAGE);
+	set_info_state(info, PS_FREE);
+	list_del_init(&info->lru_entry);
+	return result;
+}
+
+/**
+ * find_free_page() - Find a free page.
+ *
+ * Return: A pointer to the page info structure (if found), NULL otherwise.
+ */
+static struct page_info * __must_check find_free_page(struct vdo_page_cache *cache)
+{
+	struct page_info *info;
+
+	info = list_first_entry_or_null(&cache->free_list, struct page_info, state_entry);
+	if (info != NULL)
+		list_del_init(&info->state_entry);
+	return info;
+}
+
+/**
+ * find_page() - Find the page info (if any) associated with a given pbn.
+ * @pbn: The absolute physical block number of the page.
+ *
+ * Return: The page info for the page if available, or NULL if not.
+ */
+static struct page_info * __must_check
+find_page(struct vdo_page_cache *cache, physical_block_number_t pbn)
+{
+	if ((cache->last_found != NULL) && (cache->last_found->pbn == pbn))
+		return cache->last_found;
+	cache->last_found = vdo_int_map_get(cache->page_map, pbn);
+	return cache->last_found;
+}
+
+/**
+ * select_lru_page() - Determine which page is least recently used.
+ *
+ * Picks the least recently used from among the non-busy entries at the front of each of the lru
+ * ring. Since whenever we mark a page busy we also put it to the end of the ring it is unlikely
+ * that the entries at the front are busy unless the queue is very short, but not impossible.
+ *
+ * Return: A pointer to the info structure for a relevant page, or NULL if no such page can be
+ *         found. The page can be dirty or resident.
+ */
+static struct page_info * __must_check select_lru_page(struct vdo_page_cache *cache)
+{
+	struct page_info *info;
+
+	list_for_each_entry(info, &cache->lru_list, lru_entry)
+		if ((info->busy == 0) && !is_in_flight(info))
+			return info;
+
+	return NULL;
+}
+
+/* ASYNCHRONOUS INTERFACE BEYOND THIS POINT */
+
+/**
+ * complete_with_page() - Helper to complete the VDO Page Completion request successfully.
+ * @info: The page info representing the result page.
+ * @vdo_page_comp: The VDO page completion to complete.
+ */
+static void complete_with_page(struct page_info *info, struct vdo_page_completion *vdo_page_comp)
+{
+	bool available = vdo_page_comp->writable ? is_present(info) : is_valid(info);
+
+	if (!available) {
+		uds_log_error_strerror(VDO_BAD_PAGE,
+				       "Requested cache page %llu in state %s is not %s",
+				       (unsigned long long) info->pbn,
+				       get_page_state_name(info->state),
+				       vdo_page_comp->writable ? "present" :
+				       "valid");
+		vdo_fail_completion(&vdo_page_comp->completion, VDO_BAD_PAGE);
+		return;
+	}
+
+	vdo_page_comp->info = info;
+	vdo_page_comp->ready = true;
+	vdo_finish_completion(&vdo_page_comp->completion);
+}
+
+/**
+ * complete_waiter_with_error() - Complete a page completion with an error code.
+ * @waiter: The page completion, as a waiter.
+ * @result_ptr: A pointer to the error code.
+ *
+ * Implements waiter_callback.
+ */
+static void complete_waiter_with_error(struct waiter *waiter, void *result_ptr)
+{
+	int *result = result_ptr;
+
+	vdo_fail_completion(&page_completion_from_waiter(waiter)->completion, *result);
+}
+
+/**
+ * complete_waiter_with_page() - Complete a page completion with a page.
+ * @waiter: The page completion, as a waiter.
+ * @page_info: The page info to complete with.
+ *
+ * Implements waiter_callback.
+ */
+static void complete_waiter_with_page(struct waiter *waiter, void *page_info)
+{
+	complete_with_page((struct page_info *) page_info, page_completion_from_waiter(waiter));
+}
+
+/**
+ * distribute_page_over_queue() - Complete a queue of VDO page completions with a page result.
+ *
+ * Upon completion the queue will be empty.
+ *
+ * Return: The number of pages distributed.
+ */
+static unsigned int distribute_page_over_queue(struct page_info *info, struct wait_queue *queue)
+{
+	size_t pages;
+
+	update_lru(info);
+	pages = vdo_count_waiters(queue);
+
+	/*
+	 * Increment the busy count once for each pending completion so that this page does not
+	 * stop being busy until all completions have been processed (VDO-83).
+	 */
+	info->busy += pages;
+
+	vdo_notify_all_waiters(queue, complete_waiter_with_page, info);
+	return pages;
+}
+
+/**
+ * set_persistent_error() - Set a persistent error which all requests will receive in the future.
+ * @context: A string describing what triggered the error.
+ *
+ * Once triggered, all enqueued completions will get this error. Any future requests will result in
+ * this error as well.
+ */
+static void set_persistent_error(struct vdo_page_cache *cache, const char *context, int result)
+{
+	struct page_info *info;
+	/* If we're already read-only, there's no need to log. */
+	struct vdo *vdo = cache->zone->block_map->vdo;
+
+	if ((result != VDO_READ_ONLY) && !vdo_is_read_only(vdo)) {
+		uds_log_error_strerror(result, "VDO Page Cache persistent error: %s", context);
+		vdo_enter_read_only_mode(vdo, result);
+	}
+
+	assert_on_cache_thread(cache, __func__);
+
+	vdo_notify_all_waiters(&cache->free_waiters, complete_waiter_with_error, &result);
+	cache->waiter_count = 0;
+
+	for (info = cache->infos; info < cache->infos + cache->page_count; ++info)
+		vdo_notify_all_waiters(&info->waiting, complete_waiter_with_error, &result);
+}
+
+/**
+ * validate_completed_page() - Check that a page completion which is being freed to the cache
+ *                             referred to a valid page and is in a valid state.
+ * @writable: Whether a writable page is required.
+ *
+ * Return: VDO_SUCCESS if the page was valid, otherwise as error
+ */
+static int __must_check
+validate_completed_page(struct vdo_page_completion *completion, bool writable)
+{
+	int result;
+
+	result = ASSERT(completion->ready, "VDO Page completion not ready");
+	if (result != UDS_SUCCESS)
+		return result;
+
+	result = ASSERT(completion->info != NULL, "VDO Page Completion must be complete");
+	if (result != UDS_SUCCESS)
+		return result;
+
+	result = ASSERT(completion->info->pbn == completion->pbn,
+			"VDO Page Completion pbn must be consistent");
+	if (result != UDS_SUCCESS)
+		return result;
+
+	result = ASSERT(is_valid(completion->info), "VDO Page Completion page must be valid");
+	if (result != UDS_SUCCESS)
+		return result;
+
+	if (writable) {
+		result = ASSERT(completion->writable, "VDO Page Completion is writable");
+		if (result != UDS_SUCCESS)
+			return result;
+	}
+
+	return VDO_SUCCESS;
+}
+
+static void check_for_drain_complete(struct block_map_zone *zone)
+{
+	if (vdo_is_state_draining(&zone->state) &&
+	    (zone->active_lookups == 0) &&
+	    !vdo_has_waiters(&zone->flush_waiters) &&
+	    !is_vio_pool_busy(zone->vio_pool) &&
+	    (zone->page_cache.outstanding_reads == 0) &&
+	    (zone->page_cache.outstanding_writes == 0))
+		vdo_finish_draining_with_result(&zone->state,
+						(vdo_is_read_only(zone->block_map->vdo) ?
+						 VDO_READ_ONLY : VDO_SUCCESS));
+}
+
+static void enter_zone_read_only_mode(struct block_map_zone *zone, int result)
+{
+	vdo_enter_read_only_mode(zone->block_map->vdo, result);
+
+	/*
+	 * We are in read-only mode, so we won't ever write any page out. Just take all waiters off
+	 * the queue so the zone can drain.
+	 */
+	while (vdo_has_waiters(&zone->flush_waiters))
+		vdo_dequeue_next_waiter(&zone->flush_waiters);
+
+	check_for_drain_complete(zone);
+}
+
+static bool __must_check
+validate_completed_page_or_enter_read_only_mode(struct vdo_page_completion *completion,
+						bool writable)
+{
+	int result = validate_completed_page(completion, writable);
+
+	if (result == VDO_SUCCESS)
+		return true;
+
+	enter_zone_read_only_mode(completion->info->cache->zone, result);
+	return false;
+}
+
+/**
+ * handle_load_error() - Handle page load errors.
+ * @completion: The page read vio.
+ */
+static void handle_load_error(struct vdo_completion *completion)
+{
+	int result = completion->result;
+	struct page_info *info = completion->parent;
+	struct vdo_page_cache *cache = info->cache;
+
+	assert_on_cache_thread(cache, __func__);
+	vio_record_metadata_io_error(as_vio(completion));
+	vdo_enter_read_only_mode(cache->zone->block_map->vdo, result);
+	ADD_ONCE(cache->stats.failed_reads, 1);
+	set_info_state(info, PS_FAILED);
+	vdo_notify_all_waiters(&info->waiting, complete_waiter_with_error, &result);
+	reset_page_info(info);
+
+	/*
+	 * Don't decrement until right before calling check_for_drain_complete() to
+	 * ensure that the above work can't cause the page cache to be freed out from under us.
+	 */
+	cache->outstanding_reads--;
+	check_for_drain_complete(cache->zone);
+}
+
+/**
+ * page_is_loaded() - Callback used when a page has been loaded.
+ * @completion: The vio which has loaded the page. Its parent is the page_info.
+ */
+static void page_is_loaded(struct vdo_completion *completion)
+{
+	struct page_info *info = completion->parent;
+	struct vdo_page_cache *cache = info->cache;
+	nonce_t nonce = info->cache->zone->block_map->nonce;
+	struct block_map_page *page;
+	enum block_map_page_validity validity;
+
+	assert_on_cache_thread(cache, __func__);
+
+	page = (struct block_map_page *) get_page_buffer(info);
+	validity = vdo_validate_block_map_page(page, nonce, info->pbn);
+	if (validity == VDO_BLOCK_MAP_PAGE_BAD) {
+		int result = uds_log_error_strerror(VDO_BAD_PAGE,
+						    "Expected page %llu but got page %llu instead",
+						    (unsigned long long) info->pbn,
+						    (unsigned long long) vdo_get_block_map_page_pbn(page));
+
+		vdo_continue_completion(completion, result);
+		return;
+	}
+
+	if (validity == VDO_BLOCK_MAP_PAGE_INVALID)
+		vdo_format_block_map_page(page, nonce, info->pbn, false);
+
+	info->recovery_lock = 0;
+	set_info_state(info, PS_RESIDENT);
+	distribute_page_over_queue(info, &info->waiting);
+
+	/*
+	 * Don't decrement until right before calling check_for_drain_complete() to
+	 * ensure that the above work can't cause the page cache to be freed out from under us.
+	 */
+	cache->outstanding_reads--;
+	check_for_drain_complete(cache->zone);
+}
+
+/**
+ * handle_rebuild_read_error() - Handle a read error during a read-only rebuild.
+ * @completion: The page load completion.
+ */
+static void handle_rebuild_read_error(struct vdo_completion *completion)
+{
+	struct page_info *info = completion->parent;
+	struct vdo_page_cache *cache = info->cache;
+
+	assert_on_cache_thread(cache, __func__);
+
+	/*
+	 * We are doing a read-only rebuild, so treat this as a successful read of an uninitialized
+	 * page.
+	 */
+	vio_record_metadata_io_error(as_vio(completion));
+	ADD_ONCE(cache->stats.failed_reads, 1);
+	memset(get_page_buffer(info), 0, VDO_BLOCK_SIZE);
+	vdo_reset_completion(completion);
+	page_is_loaded(completion);
+}
+
+static void load_cache_page_endio(struct bio *bio)
+{
+	struct vio *vio = bio->bi_private;
+	struct page_info *info = vio->completion.parent;
+
+	continue_vio_after_io(vio, page_is_loaded, info->cache->zone->thread_id);
+}
+
+/**
+ * launch_page_load() - Begin the process of loading a page.
+ *
+ * Return: VDO_SUCCESS or an error code.
+ */
+static int __must_check launch_page_load(struct page_info *info, physical_block_number_t pbn)
+{
+	int result;
+	vdo_action *callback;
+	struct vdo_page_cache *cache = info->cache;
+
+	assert_io_allowed(cache);
+
+	result = set_info_pbn(info, pbn);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	result = ASSERT((info->busy == 0), "Page is not busy before loading.");
+	if (result != VDO_SUCCESS)
+		return result;
+
+	set_info_state(info, PS_INCOMING);
+	cache->outstanding_reads++;
+	ADD_ONCE(cache->stats.pages_loaded, 1);
+	callback = (cache->rebuilding ? handle_rebuild_read_error : handle_load_error);
+	submit_metadata_vio(info->vio,
+			    pbn,
+			    load_cache_page_endio,
+			    callback,
+			    REQ_OP_READ | REQ_PRIO);
+	return VDO_SUCCESS;
+}
+
+static void write_pages(struct vdo_completion *completion);
+
+/** handle_flush_error() - Handle errors flushing the layer. */
+static void handle_flush_error(struct vdo_completion *completion)
+{
+	struct page_info *info = completion->parent;
+
+	vio_record_metadata_io_error(as_vio(completion));
+	set_persistent_error(info->cache, "flush failed", completion->result);
+	write_pages(completion);
+}
+
+static void flush_endio(struct bio *bio)
+{
+	struct vio *vio = bio->bi_private;
+	struct page_info *info = vio->completion.parent;
+
+	continue_vio_after_io(vio, write_pages, info->cache->zone->thread_id);
+}
+
+/** save_pages() - Attempt to save the outgoing pages by first flushing the layer. */
+static void save_pages(struct vdo_page_cache *cache)
+{
+	struct page_info *info;
+	struct vio *vio;
+
+	if ((cache->pages_in_flush > 0) || (cache->pages_to_flush == 0))
+		return;
+
+	assert_io_allowed(cache);
+
+	info = list_first_entry(&cache->outgoing_list, struct page_info, state_entry);
+
+	cache->pages_in_flush = cache->pages_to_flush;
+	cache->pages_to_flush = 0;
+	ADD_ONCE(cache->stats.flush_count, 1);
+
+	vio = info->vio;
+
+	/*
+	 * We must make sure that the recovery journal entries that changed these pages were
+	 * successfully persisted, and thus must issue a flush before each batch of pages is
+	 * written to ensure this.
+	 */
+	submit_flush_vio(vio, flush_endio, handle_flush_error);
+}
+
+/**
+ * schedule_page_save() - Add a page to the outgoing list of pages waiting to be saved.
+ *
+ * Once in the list, a page may not be used until it has been written out.
+ */
+static void schedule_page_save(struct page_info *info)
+{
+	if (info->busy > 0) {
+		info->write_status = WRITE_STATUS_DEFERRED;
+		return;
+	}
+
+	info->cache->pages_to_flush++;
+	info->cache->outstanding_writes++;
+	set_info_state(info, PS_OUTGOING);
+}
+
+/**
+ * launch_page_save() - Add a page to outgoing pages waiting to be saved, and then start saving
+ * pages if another save is not in progress.
+ */
+static void launch_page_save(struct page_info *info)
+{
+	schedule_page_save(info);
+	save_pages(info->cache);
+}
+
+/**
+ * completion_needs_page() - Determine whether a given vdo_page_completion (as a waiter) is
+ *                           requesting a given page number.
+ * @context: A pointer to the pbn of the desired page.
+ *
+ * Implements waiter_match.
+ *
+ * Return: true if the page completion is for the desired page number.
+ */
+static bool completion_needs_page(struct waiter *waiter, void *context)
+{
+	physical_block_number_t *pbn = context;
+
+	return (page_completion_from_waiter(waiter)->pbn == *pbn);
+}
+
+/**
+ * allocate_free_page() - Allocate a free page to the first completion in the waiting queue, and
+ *                        any other completions that match it in page number.
+ */
+static void allocate_free_page(struct page_info *info)
+{
+	int result;
+	struct waiter *oldest_waiter;
+	physical_block_number_t pbn;
+	struct vdo_page_cache *cache = info->cache;
+
+	assert_on_cache_thread(cache, __func__);
+
+	if (!vdo_has_waiters(&cache->free_waiters)) {
+		if (cache->stats.cache_pressure > 0) {
+			uds_log_info("page cache pressure relieved");
+			WRITE_ONCE(cache->stats.cache_pressure, 0);
+		}
+		return;
+	}
+
+	result = reset_page_info(info);
+	if (result != VDO_SUCCESS) {
+		set_persistent_error(cache, "cannot reset page info", result);
+		return;
+	}
+
+	oldest_waiter = vdo_get_first_waiter(&cache->free_waiters);
+	pbn = page_completion_from_waiter(oldest_waiter)->pbn;
+
+	/*
+	 * Remove all entries which match the page number in question and push them onto the page
+	 * info's wait queue.
+	 */
+	vdo_dequeue_matching_waiters(&cache->free_waiters,
+				     completion_needs_page,
+				     &pbn,
+				     &info->waiting);
+	cache->waiter_count -= vdo_count_waiters(&info->waiting);
+
+	result = launch_page_load(info, pbn);
+	if (result != VDO_SUCCESS)
+		vdo_notify_all_waiters(&info->waiting, complete_waiter_with_error, &result);
+}
+
+/**
+ * discard_a_page() - Begin the process of discarding a page.
+ *
+ * If no page is discardable, increments a count of deferred frees so that the next release of a
+ * page which is no longer busy will kick off another discard cycle. This is an indication that the
+ * cache is not big enough.
+ *
+ * If the selected page is not dirty, immediately allocates the page to the oldest completion
+ * waiting for a free page.
+ */
+static void discard_a_page(struct vdo_page_cache *cache)
+{
+	struct page_info *info = select_lru_page(cache);
+
+	if (info == NULL) {
+		report_cache_pressure(cache);
+		return;
+	}
+
+	if (!is_dirty(info)) {
+		allocate_free_page(info);
+		return;
+	}
+
+	ASSERT_LOG_ONLY(!is_in_flight(info), "page selected for discard is not in flight");
+
+	++cache->discard_count;
+	info->write_status = WRITE_STATUS_DISCARD;
+	launch_page_save(info);
+}
+
+/**
+ * discard_page_for_completion() - Helper used to trigger a discard so that the completion can get
+ *                                 a different page.
+ */
+static void discard_page_for_completion(struct vdo_page_completion *vdo_page_comp)
+{
+	struct vdo_page_cache *cache = vdo_page_comp->cache;
+
+	++cache->waiter_count;
+	vdo_enqueue_waiter(&cache->free_waiters, &vdo_page_comp->waiter);
+	discard_a_page(cache);
+}
+
+/**
+ * discard_page_if_needed() - Helper used to trigger a discard if the cache needs another free
+ *                            page.
+ * @cache: The page cache.
+ */
+static void discard_page_if_needed(struct vdo_page_cache *cache)
+{
+	if (cache->waiter_count > cache->discard_count)
+		discard_a_page(cache);
+}
+
+/**
+ * write_has_finished() - Inform the cache that a write has finished (possibly with an error).
+ * @info: The info structure for the page whose write just completed.
+ *
+ * Return: true if the page write was a discard.
+ */
+static bool write_has_finished(struct page_info *info)
+{
+	bool was_discard = (info->write_status == WRITE_STATUS_DISCARD);
+
+	assert_on_cache_thread(info->cache, __func__);
+	info->cache->outstanding_writes--;
+
+	info->write_status = WRITE_STATUS_NORMAL;
+	return was_discard;
+}
+
+/**
+ * handle_page_write_error() - Handler for page write errors.
+ * @completion: The page write vio.
+ */
+static void handle_page_write_error(struct vdo_completion *completion)
+{
+	int result = completion->result;
+	struct page_info *info = completion->parent;
+	struct vdo_page_cache *cache = info->cache;
+
+	vio_record_metadata_io_error(as_vio(completion));
+
+	/* If we're already read-only, write failures are to be expected. */
+	if (result != VDO_READ_ONLY) {
+		static DEFINE_RATELIMIT_STATE(error_limiter,
+					      DEFAULT_RATELIMIT_INTERVAL,
+					      DEFAULT_RATELIMIT_BURST);
+
+		if (__ratelimit(&error_limiter))
+			uds_log_error("failed to write block map page %llu",
+				      (unsigned long long) info->pbn);
+	}
+
+	set_info_state(info, PS_DIRTY);
+	ADD_ONCE(cache->stats.failed_writes, 1);
+	set_persistent_error(cache, "cannot write page", result);
+
+	if (!write_has_finished(info))
+		discard_page_if_needed(cache);
+
+	check_for_drain_complete(cache->zone);
+}
+
+static void page_is_written_out(struct vdo_completion *completion);
+
+static void write_cache_page_endio(struct bio *bio)
+{
+	struct vio *vio = bio->bi_private;
+	struct page_info *info = vio->completion.parent;
+
+	continue_vio_after_io(vio, page_is_written_out, info->cache->zone->thread_id);
+}
+
+/**
+ * page_is_written_out() - Callback used when a page has been written out.
+ * @completion: The vio which wrote the page. Its parent is a page_info.
+ */
+static void page_is_written_out(struct vdo_completion *completion)
+{
+	bool was_discard, reclaimed;
+	u32 reclamations;
+	struct page_info *info = completion->parent;
+	struct vdo_page_cache *cache = info->cache;
+	struct block_map_page *page = (struct block_map_page *) get_page_buffer(info);
+
+	if (!page->header.initialized) {
+		page->header.initialized = true;
+		submit_metadata_vio(info->vio,
+				    info->pbn,
+				    write_cache_page_endio,
+				    handle_page_write_error,
+				    (REQ_OP_WRITE | REQ_PRIO | REQ_PREFLUSH));
+		return;
+	}
+
+	/* Handle journal updates and torn write protection. */
+	vdo_release_recovery_journal_block_reference(cache->zone->block_map->journal,
+						     info->recovery_lock,
+						     VDO_ZONE_TYPE_LOGICAL,
+						     cache->zone->zone_number);
+	info->recovery_lock = 0;
+	was_discard = write_has_finished(info);
+	reclaimed = (!was_discard || (info->busy > 0) || vdo_has_waiters(&info->waiting));
+
+	set_info_state(info, PS_RESIDENT);
+
+	reclamations = distribute_page_over_queue(info, &info->waiting);
+	ADD_ONCE(cache->stats.reclaimed, reclamations);
+
+	if (was_discard)
+		cache->discard_count--;
+
+	if (reclaimed)
+		discard_page_if_needed(cache);
+	else
+		allocate_free_page(info);
+
+	check_for_drain_complete(cache->zone);
+}
+
+/**
+ * write_pages() - Write the batch of pages which were covered by the layer flush which just
+ *                 completed.
+ * @flush_completion: The flush vio.
+ *
+ * This callback is registered in save_pages().
+ */
+static void write_pages(struct vdo_completion *flush_completion)
+{
+	struct vdo_page_cache *cache = ((struct page_info *) flush_completion->parent)->cache;
+
+	/*
+	 * We need to cache these two values on the stack since in the error case below, it is
+	 * possible for the last page info to cause the page cache to get freed. Hence once we
+	 * launch the last page, it may be unsafe to dereference the cache [VDO-4724].
+	 */
+	bool has_unflushed_pages = (cache->pages_to_flush > 0);
+	page_count_t pages_in_flush = cache->pages_in_flush;
+
+	cache->pages_in_flush = 0;
+	while (pages_in_flush-- > 0) {
+		struct page_info *info =
+			list_first_entry(&cache->outgoing_list, struct page_info, state_entry);
+
+		list_del_init(&info->state_entry);
+		if (vdo_is_read_only(info->cache->zone->block_map->vdo)) {
+			struct vdo_completion *completion = &info->vio->completion;
+
+			vdo_reset_completion(completion);
+			completion->callback = page_is_written_out;
+			completion->error_handler = handle_page_write_error;
+			vdo_fail_completion(completion, VDO_READ_ONLY);
+			continue;
+		}
+		ADD_ONCE(info->cache->stats.pages_saved, 1);
+		submit_metadata_vio(info->vio,
+				    info->pbn,
+				    write_cache_page_endio,
+				    handle_page_write_error,
+				    REQ_OP_WRITE | REQ_PRIO);
+	}
+
+	if (has_unflushed_pages)
+		/*
+		 * If there are unflushed pages, the cache can't have been freed, so this call is
+		 * safe.
+		 */
+		save_pages(cache);
+}
+
+/**
+ * vdo_release_page_completion() - Release a VDO Page Completion.
+ *
+ * The page referenced by this completion (if any) will no longer be held busy by this completion.
+ * If a page becomes discardable and there are completions awaiting free pages then a new round of
+ * page discarding is started.
+ */
+void vdo_release_page_completion(struct vdo_completion *completion)
+{
+	struct page_info *discard_info = NULL;
+	struct vdo_page_completion *page_completion = as_vdo_page_completion(completion);
+	struct vdo_page_cache *cache;
+
+	if (completion->result == VDO_SUCCESS) {
+		if (!validate_completed_page_or_enter_read_only_mode(page_completion, false))
+			return;
+
+		if (--page_completion->info->busy == 0)
+			discard_info = page_completion->info;
+	}
+
+	ASSERT_LOG_ONLY((page_completion->waiter.next_waiter == NULL),
+			"Page being released after leaving all queues");
+
+	page_completion->info = NULL;
+	cache = page_completion->cache;
+	assert_on_cache_thread(cache, __func__);
+
+	if (discard_info != NULL) {
+		if (discard_info->write_status == WRITE_STATUS_DEFERRED) {
+			discard_info->write_status = WRITE_STATUS_NORMAL;
+			launch_page_save(discard_info);
+		}
+		/*
+		 * if there are excess requests for pages (that have not already started discards)
+		 * we need to discard some page (which may be this one)
+		 */
+		discard_page_if_needed(cache);
+	}
+}
+
+/**
+ * load_page_for_completion() - Helper function to load a page as described by a VDO Page
+ *                              Completion.
+ */
+static void
+load_page_for_completion(struct page_info *info, struct vdo_page_completion *vdo_page_comp)
+{
+	int result;
+
+	vdo_enqueue_waiter(&info->waiting, &vdo_page_comp->waiter);
+	result = launch_page_load(info, vdo_page_comp->pbn);
+	if (result != VDO_SUCCESS)
+		vdo_notify_all_waiters(&info->waiting, complete_waiter_with_error, &result);
+}
+
+/**
+ * vdo_get_page() - Initialize a page completion and get a block map page.
+ * @page_completion: The vdo_page_completion to initialize.
+ * @zone: The block map zone of the desired page.
+ * @pbn: The absolute physical block of the desired page.
+ * @writable: Whether the page can be modified.
+ * @parent: The object to notify when the fetch is complete.
+ * @callback: The notification callback.
+ * @error_handler: The handler for fetch errors.
+ * @requeue: Whether we must requeue when notifying the parent.
+ *
+ * May cause another page to be discarded (potentially writing a dirty page) and the one nominated
+ * by the completion to be loaded from disk. When the callback is invoked, the page will be
+ * resident in the cache and marked busy. All callers must call vdo_release_page_completion()
+ * when they are done with the page to clear the busy mark.
+ */
+void vdo_get_page(struct vdo_page_completion *page_completion,
+		  struct block_map_zone *zone,
+		  physical_block_number_t pbn,
+		  bool writable,
+		  void *parent,
+		  vdo_action *callback,
+		  vdo_action *error_handler,
+		  bool requeue)
+{
+	struct vdo_page_cache *cache = &zone->page_cache;
+	struct vdo_completion *completion = &page_completion->completion;
+	struct page_info *info;
+
+	assert_on_cache_thread(cache, __func__);
+	ASSERT_LOG_ONLY((page_completion->waiter.next_waiter == NULL),
+			"New page completion was not already on a wait queue");
+
+	*page_completion = (struct vdo_page_completion) {
+		.pbn = pbn,
+		.writable = writable,
+		.cache = cache,
+	};
+
+	vdo_initialize_completion(completion, cache->vdo, VDO_PAGE_COMPLETION);
+	vdo_prepare_completion(completion,
+			       callback,
+			       error_handler,
+			       cache->zone->thread_id,
+			       parent);
+	completion->requeue = requeue;
+
+	if (page_completion->writable && vdo_is_read_only(cache->zone->block_map->vdo)) {
+		vdo_fail_completion(completion, VDO_READ_ONLY);
+		return;
+	}
+
+	if (page_completion->writable)
+		ADD_ONCE(cache->stats.write_count, 1);
+	else
+		ADD_ONCE(cache->stats.read_count, 1);
+
+	info = find_page(cache, page_completion->pbn);
+	if (info != NULL) {
+		/* The page is in the cache already. */
+		if ((info->write_status == WRITE_STATUS_DEFERRED) ||
+		    is_incoming(info) ||
+		    (is_outgoing(info) && page_completion->writable)) {
+			/* The page is unusable until it has finished I/O. */
+			ADD_ONCE(cache->stats.wait_for_page, 1);
+			vdo_enqueue_waiter(&info->waiting, &page_completion->waiter);
+			return;
+		}
+
+		if (is_valid(info)) {
+			/* The page is usable. */
+			ADD_ONCE(cache->stats.found_in_cache, 1);
+			if (!is_present(info))
+				ADD_ONCE(cache->stats.read_outgoing, 1);
+			update_lru(info);
+			++info->busy;
+			complete_with_page(info, page_completion);
+			return;
+		}
+		/* Something horrible has gone wrong. */
+		ASSERT_LOG_ONLY(false, "Info found in a usable state.");
+	}
+
+	/* The page must be fetched. */
+	info = find_free_page(cache);
+	if (info != NULL) {
+		ADD_ONCE(cache->stats.fetch_required, 1);
+		load_page_for_completion(info, page_completion);
+		return;
+	}
+
+	/* The page must wait for a page to be discarded. */
+	ADD_ONCE(cache->stats.discard_required, 1);
+	discard_page_for_completion(page_completion);
+}
+
+/**
+ * vdo_request_page_write() - Request that a VDO page be written out as soon as it is not busy.
+ * @completion: The vdo_page_completion containing the page.
+ */
+void vdo_request_page_write(struct vdo_completion *completion)
+{
+	struct page_info *info;
+	struct vdo_page_completion *vdo_page_comp = as_vdo_page_completion(completion);
+
+	if (!validate_completed_page_or_enter_read_only_mode(vdo_page_comp, true))
+		return;
+
+	info = vdo_page_comp->info;
+	set_info_state(info, PS_DIRTY);
+	launch_page_save(info);
+}
+
+/**
+ * vdo_get_cached_page() - Get the block map page from a page completion.
+ * @completion: A vdo page completion whose callback has been called.
+ * @page_ptr: A pointer to hold the page
+ *
+ * Return: VDO_SUCCESS or an error
+ */
+int vdo_get_cached_page(struct vdo_completion *completion, struct block_map_page **page_ptr)
+{
+	int result;
+	struct vdo_page_completion *vpc;
+
+	vpc = as_vdo_page_completion(completion);
+	result = validate_completed_page(vpc, true);
+	if (result == VDO_SUCCESS)
+		*page_ptr = (struct block_map_page *) get_page_buffer(vpc->info);
+
+	return result;
+}
+
+/**
+ * vdo_invalidate_page_cache() - Invalidate all entries in the VDO page cache.
+ *
+ * There must not be any dirty pages in the cache.
+ *
+ * Return: A success or error code.
+ */
+int vdo_invalidate_page_cache(struct vdo_page_cache *cache)
+{
+	struct page_info *info;
+
+	assert_on_cache_thread(cache, __func__);
+
+	/* Make sure we don't throw away any dirty pages. */
+	for (info = cache->infos; info < cache->infos + cache->page_count; info++) {
+		int result = ASSERT(!is_dirty(info), "cache must have no dirty pages");
+
+		if (result != VDO_SUCCESS)
+			return result;
+	}
+
+	/* Reset the page map by re-allocating it. */
+	vdo_free_int_map(UDS_FORGET(cache->page_map));
+	return vdo_make_int_map(cache->page_count, 0, &cache->page_map);
+}
+
 /**
  * get_tree_page_by_index() - Get the tree page for a given height and page index.
  *
diff --git a/drivers/md/dm-vdo/block-map.h b/drivers/md/dm-vdo/block-map.h
index 347e7ceac1f..b97d53467f2 100644
--- a/drivers/md/dm-vdo/block-map.h
+++ b/drivers/md/dm-vdo/block-map.h
@@ -31,6 +31,142 @@ extern const physical_block_number_t VDO_INVALID_PBN;
  */
 typedef u32 vdo_page_generation;
 
+static const physical_block_number_t NO_PAGE = 0xFFFFFFFFFFFFFFFF;
+
+/* The VDO Page Cache abstraction. */
+struct vdo_page_cache {
+	/* the VDO which owns this cache */
+	struct vdo *vdo;
+	/* number of pages in cache */
+	page_count_t page_count;
+	/* number of pages to write in the current batch */
+	page_count_t pages_in_batch;
+	/* Whether the VDO is doing a read-only rebuild */
+	bool rebuilding;
+
+	/* array of page information entries */
+	struct page_info *infos;
+	/* raw memory for pages */
+	char *pages;
+	/* cache last found page info */
+	struct page_info *last_found;
+	/* map of page number to info */
+	struct int_map *page_map;
+	/* main LRU list (all infos) */
+	struct list_head lru_list;
+	/* free page list (oldest first) */
+	struct list_head free_list;
+	/* outgoing page list */
+	struct list_head outgoing_list;
+	/* number of read I/O operations pending */
+	page_count_t outstanding_reads;
+	/* number of write I/O operations pending */
+	page_count_t outstanding_writes;
+	/* number of pages covered by the current flush */
+	page_count_t pages_in_flush;
+	/* number of pages waiting to be included in the next flush */
+	page_count_t pages_to_flush;
+	/* number of discards in progress */
+	unsigned int discard_count;
+	/* how many VPCs waiting for free page */
+	unsigned int waiter_count;
+	/* queue of waiters who want a free page */
+	struct wait_queue free_waiters;
+	/*
+	 * Statistics are only updated on the logical zone thread, but are accessed from other
+	 * threads.
+	 */
+	struct block_map_statistics stats;
+	/* counter for pressure reports */
+	u32 pressure_report;
+	/* the block map zone to which this cache belongs */
+	struct block_map_zone *zone;
+};
+
+/*
+ * The state of a page buffer. If the page buffer is free no particular page is bound to it,
+ * otherwise the page buffer is bound to particular page whose absolute pbn is in the pbn field. If
+ * the page is resident or dirty the page data is stable and may be accessed. Otherwise the page is
+ * in flight (incoming or outgoing) and its data should not be accessed.
+ *
+ * @note Update the static data in get_page_state_name() if you change this enumeration.
+ */
+enum vdo_page_buffer_state {
+	/* this page buffer is not being used */
+	PS_FREE,
+	/* this page is being read from store */
+	PS_INCOMING,
+	/* attempt to load this page failed */
+	PS_FAILED,
+	/* this page is valid and un-modified */
+	PS_RESIDENT,
+	/* this page is valid and modified */
+	PS_DIRTY,
+	/* this page is being written and should not be used */
+	PS_OUTGOING,
+	/* not a state */
+	PAGE_STATE_COUNT,
+} __packed;
+
+/*
+ * The write status of page
+ */
+enum vdo_page_write_status {
+	WRITE_STATUS_NORMAL,
+	WRITE_STATUS_DISCARD,
+	WRITE_STATUS_DEFERRED,
+} __packed;
+
+/* Per-page-slot information. */
+struct page_info {
+	/* Preallocated page struct vio */
+	struct vio *vio;
+	/* back-link for references */
+	struct vdo_page_cache *cache;
+	/* the pbn of the page */
+	physical_block_number_t pbn;
+	/* page is busy (temporarily locked) */
+	u16 busy;
+	/* the write status the page */
+	enum vdo_page_write_status write_status;
+	/* page state */
+	enum vdo_page_buffer_state state;
+	/* queue of completions awaiting this item */
+	struct wait_queue waiting;
+	/* state linked list entry */
+	struct list_head state_entry;
+	/* LRU entry */
+	struct list_head lru_entry;
+	/*
+	 * The earliest recovery journal block containing uncommitted updates to the block map page
+	 * associated with this page_info. A reference (lock) is held on that block to prevent it
+	 * from being reaped. When this value changes, the reference on the old value must be
+	 * released and a reference on the new value must be acquired.
+	 */
+	sequence_number_t recovery_lock;
+};
+
+/*
+ * A completion awaiting a specific page. Also a live reference into the page once completed, until
+ * freed.
+ */
+struct vdo_page_completion {
+	/* The generic completion */
+	struct vdo_completion completion;
+	/* The cache involved */
+	struct vdo_page_cache *cache;
+	/* The waiter for the pending list */
+	struct waiter waiter;
+	/* The absolute physical block number of the page on disk */
+	physical_block_number_t pbn;
+	/* Whether the page may be modified */
+	bool writable;
+	/* Whether the page is available */
+	bool ready;
+	/* The info structure for the page, only valid when ready */
+	struct page_info *info;
+};
+
 struct forest;
 
 struct tree_page {
@@ -141,6 +277,30 @@ struct block_map {
  */
 typedef int vdo_entry_callback(physical_block_number_t pbn, struct vdo_completion *completion);
 
+static inline struct vdo_page_completion *as_vdo_page_completion(struct vdo_completion *completion)
+{
+	vdo_assert_completion_type(completion, VDO_PAGE_COMPLETION);
+	return container_of(completion, struct vdo_page_completion, completion);
+}
+
+void vdo_release_page_completion(struct vdo_completion *completion);
+
+void vdo_get_page(struct vdo_page_completion *page_completion,
+		  struct block_map_zone *zone,
+		  physical_block_number_t pbn,
+		  bool writable,
+		  void *parent,
+		  vdo_action *callback,
+		  vdo_action *error_handler,
+		  bool requeue);
+
+void vdo_request_page_write(struct vdo_completion *completion);
+
+int __must_check vdo_get_cached_page(struct vdo_completion *completion,
+				     struct block_map_page **page_ptr);
+
+int __must_check vdo_invalidate_page_cache(struct vdo_page_cache *cache);
+
 static inline struct block_map_page * __must_check
 vdo_as_block_map_page(struct tree_page *tree_page)
 {
-- 
2.40.1

