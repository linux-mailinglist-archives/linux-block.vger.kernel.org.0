Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56CB70E7E6
	for <lists+linux-block@lfdr.de>; Tue, 23 May 2023 23:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238704AbjEWVry (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 May 2023 17:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238706AbjEWVrx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 17:47:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECDAE4B
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 14:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684878413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MN1Mj6eBpYY8Z8esJYe/eZzcU0IgBQTjilHWnZvZdps=;
        b=hp82CrPbD++aUrsf3id2J3Vtky9voinkLR4YTvMOCYTFI6MIR7CrLxYrb7AgzypHme7ADC
        vEPx8oxAjlwlYTVM66Lzw2jfk9gMiiO5Aqx08LPWTo1jWgo1kYv0FYZbTq045tw7wWWq64
        g7hGXFLlWdt4NBcP9Qavc0xV/r+GZX0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-mAXStK-HMDOyrtKWpgMUVg-1; Tue, 23 May 2023 17:46:52 -0400
X-MC-Unique: mAXStK-HMDOyrtKWpgMUVg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-75b2864e571so31992785a.1
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 14:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684878411; x=1687470411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MN1Mj6eBpYY8Z8esJYe/eZzcU0IgBQTjilHWnZvZdps=;
        b=Kt9hEwxDKZn+WxmhQdWA38/mxbr6SWeppArlVVTPo/UH0qOz70jrUVubGAkI1P+y1N
         w7+Bf3SlN9VeiQ4tXUYhraUOjSOEBh3XEbAeockBhhhQfp3x8n4MKh88w/A+M7Fnf6wd
         PyOXtUyGecjnvIp0Fr2I/3US1L3kEgs1cLMeUdD+xffPcjhkZqRTEGk5F70RAqZ0EeGK
         tEU46QCIn7PRmeX146yHLJmMLZ/YMqjcPezrUr2op3bgXx6rCiTVmI5JB2JMo7ZyyDax
         QZ1Yn7L8ijkPTJp8cJu92UqLMVjbWKI3CG5XhILn2AJ06MGRmJQ9tYgx1auGQBQkEdNL
         /Ocw==
X-Gm-Message-State: AC+VfDwcgKLgrMXhNTNrPKjpkVVZTDotQZ/soKmudRuTqAYwfc9O5Qku
        YQ1nmSQCovo775JCizANKINkEyNv0gOGf/jR1lVBrcFTn8eiroQjroeprh362njFZqHCClmyWOL
        M3auhrFEKYxFeuII0FpHIySU=
X-Received: by 2002:a05:620a:278a:b0:75b:23a1:831d with SMTP id g10-20020a05620a278a00b0075b23a1831dmr6411952qkp.24.1684878410926;
        Tue, 23 May 2023 14:46:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5KbSvGKdBpfi/kQfSDeN1A7HcuLSeQJpxNdwiYTcOknlGRHhEXUjdhShhuIhCIuX2sGE0R8g==
X-Received: by 2002:a05:620a:278a:b0:75b:23a1:831d with SMTP id g10-20020a05620a278a00b0075b23a1831dmr6411926qkp.24.1684878410315;
        Tue, 23 May 2023 14:46:50 -0700 (PDT)
Received: from bf36-1.. (173-166-2-198-newengland.hfc.comcastbusiness.net. [173.166.2.198])
        by smtp.gmail.com with ESMTPSA id f25-20020a05620a15b900b0075b196ae392sm1489722qkk.104.2023.05.23.14.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:46:49 -0700 (PDT)
From:   "J. corwin Coburn" <corwin@redhat.com>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org
Cc:     vdo-devel@redhat.com, "J. corwin Coburn" <corwin@redhat.com>
Subject: [PATCH v2 35/39] Add statistics tracking.
Date:   Tue, 23 May 2023 17:45:35 -0400
Message-Id: <20230523214539.226387-36-corwin@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523214539.226387-1-corwin@redhat.com>
References: <20230523214539.226387-1-corwin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: J. corwin Coburn <corwin@redhat.com>
---
 drivers/md/dm-vdo/message-stats.c | 1222 +++++++++++++++++++++++++++++
 drivers/md/dm-vdo/message-stats.h |   13 +
 drivers/md/dm-vdo/statistics.h    |  279 +++++++
 3 files changed, 1514 insertions(+)
 create mode 100644 drivers/md/dm-vdo/message-stats.c
 create mode 100644 drivers/md/dm-vdo/message-stats.h
 create mode 100644 drivers/md/dm-vdo/statistics.h

diff --git a/drivers/md/dm-vdo/message-stats.c b/drivers/md/dm-vdo/message-stats.c
new file mode 100644
index 00000000000..43a37623b90
--- /dev/null
+++ b/drivers/md/dm-vdo/message-stats.c
@@ -0,0 +1,1222 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright Red Hat
+ */
+
+#include "dedupe.h"
+#include "logger.h"
+#include "memory-alloc.h"
+#include "message-stats.h"
+#include "statistics.h"
+#include "thread-device.h"
+#include "vdo.h"
+
+static int write_u64(char *prefix,
+		     u64 value,
+		     char *suffix,
+		     char **buf,
+		     unsigned int *maxlen)
+{
+	int count = scnprintf(*buf, *maxlen, "%s%llu%s",
+			      prefix == NULL ? "" : prefix,
+			      value,
+			      suffix == NULL ? "" : suffix);
+	*buf += count;
+	*maxlen -= count;
+	if (count >= *maxlen)
+		return VDO_UNEXPECTED_EOF;
+	return VDO_SUCCESS;
+}
+
+static int write_u32(char *prefix,
+		     u32 value,
+		     char *suffix,
+		     char **buf,
+		     unsigned int *maxlen)
+{
+	int count = scnprintf(*buf, *maxlen, "%s%u%s",
+			      prefix == NULL ? "" : prefix,
+			      value,
+			      suffix == NULL ? "" : suffix);
+	*buf += count;
+	*maxlen -= count;
+	if (count >= *maxlen)
+		return VDO_UNEXPECTED_EOF;
+	return VDO_SUCCESS;
+}
+
+static int write_block_count_t(char *prefix,
+			       block_count_t value,
+			       char *suffix,
+			       char **buf,
+			       unsigned int *maxlen)
+{
+	int count = scnprintf(*buf, *maxlen, "%s%llu%s",
+			      prefix == NULL ? "" : prefix,
+			      value,
+			      suffix == NULL ? "" : suffix);
+	*buf += count;
+	*maxlen -= count;
+	if (count >= *maxlen)
+		return VDO_UNEXPECTED_EOF;
+	return VDO_SUCCESS;
+}
+
+static int write_string(char *prefix,
+			char *value,
+			char *suffix,
+			char **buf,
+			unsigned int *maxlen)
+{
+	int count = scnprintf(*buf, *maxlen, "%s%s%s",
+			      prefix == NULL ? "" : prefix,
+			      value,
+			      suffix == NULL ? "" : suffix);
+	*buf += count;
+	*maxlen -= count;
+	if (count >= *maxlen)
+		return VDO_UNEXPECTED_EOF;
+	return VDO_SUCCESS;
+}
+
+static int write_bool(char *prefix,
+		      bool value,
+		      char *suffix,
+		      char **buf,
+		      unsigned int *maxlen)
+{
+	int count = scnprintf(*buf, *maxlen, "%s%d%s",
+			      prefix == NULL ? "" : prefix,
+			      value,
+			      suffix == NULL ? "" : suffix);
+	*buf += count;
+	*maxlen -= count;
+	if (count >= *maxlen)
+		return VDO_UNEXPECTED_EOF;
+	return VDO_SUCCESS;
+}
+
+static int write_u8(char *prefix,
+		    u8 value,
+		    char *suffix,
+		    char **buf,
+		    unsigned int *maxlen)
+{
+	int count = scnprintf(*buf, *maxlen, "%s%u%s",
+			      prefix == NULL ? "" : prefix,
+			      value,
+			      suffix == NULL ? "" : suffix);
+	*buf += count;
+	*maxlen -= count;
+	if (count >= *maxlen)
+		return VDO_UNEXPECTED_EOF;
+	return VDO_SUCCESS;
+}
+
+static int write_block_allocator_statistics(char *prefix,
+					    struct block_allocator_statistics *stats,
+					    char *suffix,
+					    char **buf,
+					    unsigned int *maxlen)
+{
+	int result;
+
+	result = write_string(prefix, "{ ", NULL, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* The total number of slabs from which blocks may be allocated */
+	result = write_u64("slabCount : ",
+			   stats->slab_count,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* The total number of slabs from which blocks have ever been allocated */
+	result = write_u64("slabsOpened : ",
+			   stats->slabs_opened,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* The number of times since loading that a slab has been re-opened */
+	result = write_u64("slabsReopened : ",
+			   stats->slabs_reopened,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_string(NULL, "}", suffix, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	return VDO_SUCCESS;
+}
+
+static int write_commit_statistics(char *prefix,
+				   struct commit_statistics *stats,
+				   char *suffix,
+				   char **buf,
+				   unsigned int *maxlen)
+{
+	int result;
+
+	result = write_string(prefix, "{ ", NULL, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* The total number of items on which processing has started */
+	result = write_u64("started : ",
+			   stats->started,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* The total number of items for which a write operation has been issued */
+	result = write_u64("written : ",
+			   stats->written,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* The total number of items for which a write operation has completed */
+	result = write_u64("committed : ",
+			   stats->committed,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_string(NULL, "}", suffix, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	return VDO_SUCCESS;
+}
+
+static int write_recovery_journal_statistics(char *prefix,
+					     struct recovery_journal_statistics *stats,
+					     char *suffix,
+					     char **buf,
+					     unsigned int *maxlen)
+{
+	int result;
+
+	result = write_string(prefix, "{ ", NULL, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of times the on-disk journal was full */
+	result = write_u64("diskFull : ",
+			   stats->disk_full,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of times the recovery journal requested slab journal commits. */
+	result = write_u64("slabJournalCommitsRequested : ",
+			   stats->slab_journal_commits_requested,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Write/Commit totals for individual journal entries */
+	result = write_commit_statistics("entries : ",
+					 &stats->entries,
+					 ", ",
+					 buf,
+					 maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Write/Commit totals for journal blocks */
+	result = write_commit_statistics("blocks : ",
+					 &stats->blocks,
+					 ", ",
+					 buf,
+					 maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_string(NULL, "}", suffix, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	return VDO_SUCCESS;
+}
+
+static int write_packer_statistics(char *prefix,
+				   struct packer_statistics *stats,
+				   char *suffix,
+				   char **buf,
+				   unsigned int *maxlen)
+{
+	int result;
+
+	result = write_string(prefix, "{ ", NULL, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of compressed data items written since startup */
+	result = write_u64("compressedFragmentsWritten : ",
+			   stats->compressed_fragments_written,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of blocks containing compressed items written since startup */
+	result = write_u64("compressedBlocksWritten : ",
+			   stats->compressed_blocks_written,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of VIOs that are pending in the packer */
+	result = write_u64("compressedFragmentsInPacker : ",
+			   stats->compressed_fragments_in_packer,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_string(NULL, "}", suffix, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	return VDO_SUCCESS;
+}
+
+static int write_slab_journal_statistics(char *prefix,
+					 struct slab_journal_statistics *stats,
+					 char *suffix,
+					 char **buf,
+					 unsigned int *maxlen)
+{
+	int result;
+
+	result = write_string(prefix, "{ ", NULL, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of times the on-disk journal was full */
+	result = write_u64("diskFullCount : ",
+			   stats->disk_full_count,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of times an entry was added over the flush threshold */
+	result = write_u64("flushCount : ",
+			   stats->flush_count,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of times an entry was added over the block threshold */
+	result = write_u64("blockedCount : ",
+			   stats->blocked_count,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of times a tail block was written */
+	result = write_u64("blocksWritten : ",
+			   stats->blocks_written,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of times we had to wait for the tail to write */
+	result = write_u64("tailBusyCount : ",
+			   stats->tail_busy_count,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_string(NULL, "}", suffix, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	return VDO_SUCCESS;
+}
+
+static int write_slab_summary_statistics(char *prefix,
+					 struct slab_summary_statistics *stats,
+					 char *suffix,
+					 char **buf,
+					 unsigned int *maxlen)
+{
+	int result;
+
+	result = write_string(prefix, "{ ", NULL, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of blocks written */
+	result = write_u64("blocksWritten : ",
+			   stats->blocks_written,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_string(NULL, "}", suffix, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	return VDO_SUCCESS;
+}
+
+static int write_ref_counts_statistics(char *prefix,
+				       struct ref_counts_statistics *stats,
+				       char *suffix,
+				       char **buf,
+				       unsigned int *maxlen)
+{
+	int result;
+
+	result = write_string(prefix, "{ ", NULL, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of reference blocks written */
+	result = write_u64("blocksWritten : ",
+			   stats->blocks_written,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_string(NULL, "}", suffix, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	return VDO_SUCCESS;
+}
+
+static int write_block_map_statistics(char *prefix,
+				      struct block_map_statistics *stats,
+				      char *suffix,
+				      char **buf,
+				      unsigned int *maxlen)
+{
+	int result;
+
+	result = write_string(prefix, "{ ", NULL, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* number of dirty (resident) pages */
+	result = write_u32("dirtyPages : ",
+			   stats->dirty_pages,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* number of clean (resident) pages */
+	result = write_u32("cleanPages : ",
+			   stats->clean_pages,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* number of free pages */
+	result = write_u32("freePages : ",
+			   stats->free_pages,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* number of pages in failed state */
+	result = write_u32("failedPages : ",
+			   stats->failed_pages,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* number of pages incoming */
+	result = write_u32("incomingPages : ",
+			   stats->incoming_pages,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* number of pages outgoing */
+	result = write_u32("outgoingPages : ",
+			   stats->outgoing_pages,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* how many times free page not avail */
+	result = write_u32("cachePressure : ",
+			   stats->cache_pressure,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* number of get_vdo_page() calls for read */
+	result = write_u64("readCount : ",
+			   stats->read_count,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* number of get_vdo_page() calls for write */
+	result = write_u64("writeCount : ",
+			   stats->write_count,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* number of times pages failed to read */
+	result = write_u64("failedReads : ",
+			   stats->failed_reads,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* number of times pages failed to write */
+	result = write_u64("failedWrites : ",
+			   stats->failed_writes,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* number of gets that are reclaimed */
+	result = write_u64("reclaimed : ",
+			   stats->reclaimed,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* number of gets for outgoing pages */
+	result = write_u64("readOutgoing : ",
+			   stats->read_outgoing,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* number of gets that were already there */
+	result = write_u64("foundInCache : ",
+			   stats->found_in_cache,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* number of gets requiring discard */
+	result = write_u64("discardRequired : ",
+			   stats->discard_required,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* number of gets enqueued for their page */
+	result = write_u64("waitForPage : ",
+			   stats->wait_for_page,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* number of gets that have to fetch */
+	result = write_u64("fetchRequired : ",
+			   stats->fetch_required,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* number of page fetches */
+	result = write_u64("pagesLoaded : ",
+			   stats->pages_loaded,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* number of page saves */
+	result = write_u64("pagesSaved : ",
+			   stats->pages_saved,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* the number of flushes issued */
+	result = write_u64("flushCount : ",
+			   stats->flush_count,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_string(NULL, "}", suffix, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	return VDO_SUCCESS;
+}
+
+static int write_hash_lock_statistics(char *prefix,
+				      struct hash_lock_statistics *stats,
+				      char *suffix,
+				      char **buf,
+				      unsigned int *maxlen)
+{
+	int result;
+
+	result = write_string(prefix, "{ ", NULL, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of times the UDS advice proved correct */
+	result = write_u64("dedupeAdviceValid : ",
+			   stats->dedupe_advice_valid,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of times the UDS advice proved incorrect */
+	result = write_u64("dedupeAdviceStale : ",
+			   stats->dedupe_advice_stale,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of writes with the same data as another in-flight write */
+	result = write_u64("concurrentDataMatches : ",
+			   stats->concurrent_data_matches,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of writes whose hash collided with an in-flight write */
+	result = write_u64("concurrentHashCollisions : ",
+			   stats->concurrent_hash_collisions,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Current number of dedupe queries that are in flight */
+	result = write_u32("currDedupeQueries : ",
+			   stats->curr_dedupe_queries,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_string(NULL, "}", suffix, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	return VDO_SUCCESS;
+}
+
+static int write_error_statistics(char *prefix,
+				  struct error_statistics *stats,
+				  char *suffix,
+				  char **buf,
+				  unsigned int *maxlen)
+{
+	int result;
+
+	result = write_string(prefix, "{ ", NULL, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* number of times VDO got an invalid dedupe advice PBN from UDS */
+	result = write_u64("invalidAdvicePBNCount : ",
+			   stats->invalid_advice_pbn_count,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* number of times a VIO completed with a VDO_NO_SPACE error */
+	result = write_u64("noSpaceErrorCount : ",
+			   stats->no_space_error_count,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* number of times a VIO completed with a VDO_READ_ONLY error */
+	result = write_u64("readOnlyErrorCount : ",
+			   stats->read_only_error_count,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_string(NULL, "}", suffix, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	return VDO_SUCCESS;
+}
+
+static int write_bio_stats(char *prefix,
+			   struct bio_stats *stats,
+			   char *suffix,
+			   char **buf,
+			   unsigned int *maxlen)
+{
+	int result;
+
+	result = write_string(prefix, "{ ", NULL, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of REQ_OP_READ bios */
+	result = write_u64("read : ",
+			   stats->read,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of REQ_OP_WRITE bios with data */
+	result = write_u64("write : ",
+			   stats->write,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of bios tagged with REQ_PREFLUSH and containing no data */
+	result = write_u64("emptyFlush : ",
+			   stats->empty_flush,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of REQ_OP_DISCARD bios */
+	result = write_u64("discard : ",
+			   stats->discard,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of bios tagged with REQ_PREFLUSH */
+	result = write_u64("flush : ",
+			   stats->flush,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of bios tagged with REQ_FUA */
+	result = write_u64("fua : ",
+			   stats->fua,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_string(NULL, "}", suffix, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	return VDO_SUCCESS;
+}
+
+static int write_memory_usage(char *prefix,
+			      struct memory_usage *stats,
+			      char *suffix,
+			      char **buf,
+			      unsigned int *maxlen)
+{
+	int result;
+
+	result = write_string(prefix, "{ ", NULL, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Tracked bytes currently allocated. */
+	result = write_u64("bytesUsed : ",
+			   stats->bytes_used,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Maximum tracked bytes allocated. */
+	result = write_u64("peakBytesUsed : ",
+			   stats->peak_bytes_used,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_string(NULL, "}", suffix, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	return VDO_SUCCESS;
+}
+
+static int write_index_statistics(char *prefix,
+				  struct index_statistics *stats,
+				  char *suffix,
+				  char **buf,
+				  unsigned int *maxlen)
+{
+	int result;
+
+	result = write_string(prefix, "{ ", NULL, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of records stored in the index */
+	result = write_u64("entriesIndexed : ",
+			   stats->entries_indexed,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of post calls that found an existing entry */
+	result = write_u64("postsFound : ",
+			   stats->posts_found,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of post calls that added a new entry */
+	result = write_u64("postsNotFound : ",
+			   stats->posts_not_found,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of query calls that found an existing entry */
+	result = write_u64("queriesFound : ",
+			   stats->queries_found,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of query calls that added a new entry */
+	result = write_u64("queriesNotFound : ",
+			   stats->queries_not_found,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of update calls that found an existing entry */
+	result = write_u64("updatesFound : ",
+			   stats->updates_found,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of update calls that added a new entry */
+	result = write_u64("updatesNotFound : ",
+			   stats->updates_not_found,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of entries discarded */
+	result = write_u64("entriesDiscarded : ",
+			   stats->entries_discarded,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_string(NULL, "}", suffix, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	return VDO_SUCCESS;
+}
+
+static int write_vdo_statistics(char *prefix,
+				struct vdo_statistics *stats,
+				char *suffix,
+				char **buf,
+				unsigned int *maxlen)
+{
+	int result;
+
+	result = write_string(prefix, "{ ", NULL, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_u32("version : ",
+			   stats->version,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_u32("releaseVersion : ",
+			   stats->release_version,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of blocks used for data */
+	result = write_u64("dataBlocksUsed : ",
+			   stats->data_blocks_used,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of blocks used for VDO metadata */
+	result = write_u64("overheadBlocksUsed : ",
+			   stats->overhead_blocks_used,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of logical blocks that are currently mapped to physical blocks */
+	result = write_u64("logicalBlocksUsed : ",
+			   stats->logical_blocks_used,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* number of physical blocks */
+	result = write_block_count_t("physicalBlocks : ",
+				     stats->physical_blocks,
+				     ", ",
+				     buf,
+				     maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* number of logical blocks */
+	result = write_block_count_t("logicalBlocks : ",
+				     stats->logical_blocks,
+				     ", ",
+				     buf,
+				     maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Size of the block map page cache, in bytes */
+	result = write_u64("blockMapCacheSize : ",
+			   stats->block_map_cache_size,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* The physical block size */
+	result = write_u64("blockSize : ",
+			   stats->block_size,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of times the VDO has successfully recovered */
+	result = write_u64("completeRecoveries : ",
+			   stats->complete_recoveries,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of times the VDO has recovered from read-only mode */
+	result = write_u64("readOnlyRecoveries : ",
+			   stats->read_only_recoveries,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* String describing the operating mode of the VDO */
+	result = write_string("mode : ",
+			      stats->mode,
+			      ", ",
+			      buf,
+			      maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Whether the VDO is in recovery mode */
+	result = write_bool("inRecoveryMode : ",
+			    stats->in_recovery_mode,
+			    ", ",
+			    buf,
+			    maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* What percentage of recovery mode work has been completed */
+	result = write_u8("recoveryPercentage : ",
+			  stats->recovery_percentage,
+			  ", ",
+			  buf,
+			  maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* The statistics for the compressed block packer */
+	result = write_packer_statistics("packer : ",
+					 &stats->packer,
+					 ", ",
+					 buf,
+					 maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Counters for events in the block allocator */
+	result = write_block_allocator_statistics("allocator : ",
+						  &stats->allocator,
+						  ", ",
+						  buf,
+						  maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Counters for events in the recovery journal */
+	result = write_recovery_journal_statistics("journal : ",
+						   &stats->journal,
+						   ", ",
+						   buf,
+						   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* The statistics for the slab journals */
+	result = write_slab_journal_statistics("slabJournal : ",
+					       &stats->slab_journal,
+					       ", ",
+					       buf,
+					       maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* The statistics for the slab summary */
+	result = write_slab_summary_statistics("slabSummary : ",
+					       &stats->slab_summary,
+					       ", ",
+					       buf,
+					       maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* The statistics for the reference counts */
+	result = write_ref_counts_statistics("refCounts : ",
+					     &stats->ref_counts,
+					     ", ",
+					     buf,
+					     maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* The statistics for the block map */
+	result = write_block_map_statistics("blockMap : ",
+					    &stats->block_map,
+					    ", ",
+					    buf,
+					    maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* The dedupe statistics from hash locks */
+	result = write_hash_lock_statistics("hashLock : ",
+					    &stats->hash_lock,
+					    ", ",
+					    buf,
+					    maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Counts of error conditions */
+	result = write_error_statistics("errors : ",
+					&stats->errors,
+					", ",
+					buf,
+					maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* The VDO instance */
+	result = write_u32("instance : ",
+			   stats->instance,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Current number of active VIOs */
+	result = write_u32("currentVIOsInProgress : ",
+			   stats->current_vios_in_progress,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Maximum number of active VIOs */
+	result = write_u32("maxVIOs : ",
+			   stats->max_vios,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of times the UDS index was too slow in responding */
+	result = write_u64("dedupeAdviceTimeouts : ",
+			   stats->dedupe_advice_timeouts,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Number of flush requests submitted to the storage device */
+	result = write_u64("flushOut : ",
+			   stats->flush_out,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Logical block size */
+	result = write_u64("logicalBlockSize : ",
+			   stats->logical_block_size,
+			   ", ",
+			   buf,
+			   maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Bios submitted into VDO from above */
+	result = write_bio_stats("biosIn : ",
+				 &stats->bios_in,
+				 ", ",
+				 buf,
+				 maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_bio_stats("biosInPartial : ",
+				 &stats->bios_in_partial,
+				 ", ",
+				 buf,
+				 maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Bios submitted onward for user data */
+	result = write_bio_stats("biosOut : ",
+				 &stats->bios_out,
+				 ", ",
+				 buf,
+				 maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Bios submitted onward for metadata */
+	result = write_bio_stats("biosMeta : ",
+				 &stats->bios_meta,
+				 ", ",
+				 buf,
+				 maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_bio_stats("biosJournal : ",
+				 &stats->bios_journal,
+				 ", ",
+				 buf,
+				 maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_bio_stats("biosPageCache : ",
+				 &stats->bios_page_cache,
+				 ", ",
+				 buf,
+				 maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_bio_stats("biosOutCompleted : ",
+				 &stats->bios_out_completed,
+				 ", ",
+				 buf,
+				 maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_bio_stats("biosMetaCompleted : ",
+				 &stats->bios_meta_completed,
+				 ", ",
+				 buf,
+				 maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_bio_stats("biosJournalCompleted : ",
+				 &stats->bios_journal_completed,
+				 ", ",
+				 buf,
+				 maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_bio_stats("biosPageCacheCompleted : ",
+				 &stats->bios_page_cache_completed,
+				 ", ",
+				 buf,
+				 maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_bio_stats("biosAcknowledged : ",
+				 &stats->bios_acknowledged,
+				 ", ",
+				 buf,
+				 maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_bio_stats("biosAcknowledgedPartial : ",
+				 &stats->bios_acknowledged_partial,
+				 ", ",
+				 buf,
+				 maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Current number of bios in progress */
+	result = write_bio_stats("biosInProgress : ",
+				 &stats->bios_in_progress,
+				 ", ",
+				 buf,
+				 maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* Memory usage stats. */
+	result = write_memory_usage("memoryUsage : ",
+				    &stats->memory_usage,
+				    ", ",
+				    buf,
+				    maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	/* The statistics for the UDS index */
+	result = write_index_statistics("index : ",
+					&stats->index,
+					", ",
+					buf,
+					maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	result = write_string(NULL, "}", suffix, buf, maxlen);
+	if (result != VDO_SUCCESS)
+		return result;
+	return VDO_SUCCESS;
+}
+
+int vdo_write_stats(struct vdo *vdo,
+		    char *buf,
+		    unsigned int maxlen)
+{
+	struct vdo_statistics *stats;
+	int result;
+
+	result = UDS_ALLOCATE(1, struct vdo_statistics, __func__, &stats);
+	if (result != VDO_SUCCESS)
+		return result;
+
+	vdo_fetch_statistics(vdo, stats);
+	result = write_vdo_statistics(NULL, stats, NULL, &buf, &maxlen);
+	UDS_FREE(stats);
+	return result;
+}
diff --git a/drivers/md/dm-vdo/message-stats.h b/drivers/md/dm-vdo/message-stats.h
new file mode 100644
index 00000000000..fdcc819ce11
--- /dev/null
+++ b/drivers/md/dm-vdo/message-stats.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright Red Hat
+ */
+
+#ifndef VDO_MESSAGE_STATS_H
+#define VDO_MESSAGE_STATS_H
+
+#include "types.h"
+
+int vdo_write_stats(struct vdo *vdo, char *buf, unsigned int maxlen);
+
+#endif /* VDO_MESSAGE_STATS_H */
diff --git a/drivers/md/dm-vdo/statistics.h b/drivers/md/dm-vdo/statistics.h
new file mode 100644
index 00000000000..28f69ea0c8b
--- /dev/null
+++ b/drivers/md/dm-vdo/statistics.h
@@ -0,0 +1,279 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright Red Hat
+ */
+
+#ifndef STATISTICS_H
+#define STATISTICS_H
+
+#include "types.h"
+
+enum {
+	STATISTICS_VERSION = 36,
+};
+
+struct block_allocator_statistics {
+	/** The total number of slabs from which blocks may be allocated */
+	u64 slab_count;
+	/** The total number of slabs from which blocks have ever been allocated */
+	u64 slabs_opened;
+	/** The number of times since loading that a slab has been re-opened */
+	u64 slabs_reopened;
+};
+
+/**
+ * Counters for tracking the number of items written (blocks, requests, etc.)
+ * that keep track of totals at steps in the write pipeline. Three counters
+ * allow the number of buffered, in-memory items and the number of in-flight,
+ * unacknowledged writes to be derived, while still tracking totals for
+ * reporting purposes
+ */
+struct commit_statistics {
+	/** The total number of items on which processing has started */
+	u64 started;
+	/** The total number of items for which a write operation has been issued */
+	u64 written;
+	/** The total number of items for which a write operation has completed */
+	u64 committed;
+};
+
+/** Counters for events in the recovery journal */
+struct recovery_journal_statistics {
+	/** Number of times the on-disk journal was full */
+	u64 disk_full;
+	/** Number of times the recovery journal requested slab journal commits. */
+	u64 slab_journal_commits_requested;
+	/** Write/Commit totals for individual journal entries */
+	struct commit_statistics entries;
+	/** Write/Commit totals for journal blocks */
+	struct commit_statistics blocks;
+};
+
+/** The statistics for the compressed block packer. */
+struct packer_statistics {
+	/** Number of compressed data items written since startup */
+	u64 compressed_fragments_written;
+	/** Number of blocks containing compressed items written since startup */
+	u64 compressed_blocks_written;
+	/** Number of VIOs that are pending in the packer */
+	u64 compressed_fragments_in_packer;
+};
+
+/** The statistics for the slab journals. */
+struct slab_journal_statistics {
+	/** Number of times the on-disk journal was full */
+	u64 disk_full_count;
+	/** Number of times an entry was added over the flush threshold */
+	u64 flush_count;
+	/** Number of times an entry was added over the block threshold */
+	u64 blocked_count;
+	/** Number of times a tail block was written */
+	u64 blocks_written;
+	/** Number of times we had to wait for the tail to write */
+	u64 tail_busy_count;
+};
+
+/** The statistics for the slab summary. */
+struct slab_summary_statistics {
+	/** Number of blocks written */
+	u64 blocks_written;
+};
+
+/** The statistics for the reference counts. */
+struct ref_counts_statistics {
+	/** Number of reference blocks written */
+	u64 blocks_written;
+};
+
+/** The statistics for the block map. */
+struct block_map_statistics {
+	/** number of dirty (resident) pages */
+	u32 dirty_pages;
+	/** number of clean (resident) pages */
+	u32 clean_pages;
+	/** number of free pages */
+	u32 free_pages;
+	/** number of pages in failed state */
+	u32 failed_pages;
+	/** number of pages incoming */
+	u32 incoming_pages;
+	/** number of pages outgoing */
+	u32 outgoing_pages;
+	/** how many times free page not avail */
+	u32 cache_pressure;
+	/** number of get_vdo_page() calls for read */
+	u64 read_count;
+	/** number of get_vdo_page() calls for write */
+	u64 write_count;
+	/** number of times pages failed to read */
+	u64 failed_reads;
+	/** number of times pages failed to write */
+	u64 failed_writes;
+	/** number of gets that are reclaimed */
+	u64 reclaimed;
+	/** number of gets for outgoing pages */
+	u64 read_outgoing;
+	/** number of gets that were already there */
+	u64 found_in_cache;
+	/** number of gets requiring discard */
+	u64 discard_required;
+	/** number of gets enqueued for their page */
+	u64 wait_for_page;
+	/** number of gets that have to fetch */
+	u64 fetch_required;
+	/** number of page fetches */
+	u64 pages_loaded;
+	/** number of page saves */
+	u64 pages_saved;
+	/** the number of flushes issued */
+	u64 flush_count;
+};
+
+/** The dedupe statistics from hash locks */
+struct hash_lock_statistics {
+	/** Number of times the UDS advice proved correct */
+	u64 dedupe_advice_valid;
+	/** Number of times the UDS advice proved incorrect */
+	u64 dedupe_advice_stale;
+	/** Number of writes with the same data as another in-flight write */
+	u64 concurrent_data_matches;
+	/** Number of writes whose hash collided with an in-flight write */
+	u64 concurrent_hash_collisions;
+	/** Current number of dedupe queries that are in flight */
+	u32 curr_dedupe_queries;
+};
+
+/** Counts of error conditions in VDO. */
+struct error_statistics {
+	/** number of times VDO got an invalid dedupe advice PBN from UDS */
+	u64 invalid_advice_pbn_count;
+	/** number of times a VIO completed with a VDO_NO_SPACE error */
+	u64 no_space_error_count;
+	/** number of times a VIO completed with a VDO_READ_ONLY error */
+	u64 read_only_error_count;
+};
+
+struct bio_stats {
+	/** Number of REQ_OP_READ bios */
+	u64 read;
+	/** Number of REQ_OP_WRITE bios with data */
+	u64 write;
+	/** Number of bios tagged with REQ_PREFLUSH and containing no data */
+	u64 empty_flush;
+	/** Number of REQ_OP_DISCARD bios */
+	u64 discard;
+	/** Number of bios tagged with REQ_PREFLUSH */
+	u64 flush;
+	/** Number of bios tagged with REQ_FUA */
+	u64 fua;
+};
+
+struct memory_usage {
+	/** Tracked bytes currently allocated. */
+	u64 bytes_used;
+	/** Maximum tracked bytes allocated. */
+	u64 peak_bytes_used;
+};
+
+/** UDS index statistics */
+struct index_statistics {
+	/** Number of records stored in the index */
+	u64 entries_indexed;
+	/** Number of post calls that found an existing entry */
+	u64 posts_found;
+	/** Number of post calls that added a new entry */
+	u64 posts_not_found;
+	/** Number of query calls that found an existing entry */
+	u64 queries_found;
+	/** Number of query calls that added a new entry */
+	u64 queries_not_found;
+	/** Number of update calls that found an existing entry */
+	u64 updates_found;
+	/** Number of update calls that added a new entry */
+	u64 updates_not_found;
+	/** Number of entries discarded */
+	u64 entries_discarded;
+};
+
+/** The statistics of the vdo service. */
+struct vdo_statistics {
+	u32 version;
+	u32 release_version;
+	/** Number of blocks used for data */
+	u64 data_blocks_used;
+	/** Number of blocks used for VDO metadata */
+	u64 overhead_blocks_used;
+	/** Number of logical blocks that are currently mapped to physical blocks */
+	u64 logical_blocks_used;
+	/** number of physical blocks */
+	block_count_t physical_blocks;
+	/** number of logical blocks */
+	block_count_t logical_blocks;
+	/** Size of the block map page cache, in bytes */
+	u64 block_map_cache_size;
+	/** The physical block size */
+	u64 block_size;
+	/** Number of times the VDO has successfully recovered */
+	u64 complete_recoveries;
+	/** Number of times the VDO has recovered from read-only mode */
+	u64 read_only_recoveries;
+	/** String describing the operating mode of the VDO */
+	char mode[15];
+	/** Whether the VDO is in recovery mode */
+	bool in_recovery_mode;
+	/** What percentage of recovery mode work has been completed */
+	u8 recovery_percentage;
+	/** The statistics for the compressed block packer */
+	struct packer_statistics packer;
+	/** Counters for events in the block allocator */
+	struct block_allocator_statistics allocator;
+	/** Counters for events in the recovery journal */
+	struct recovery_journal_statistics journal;
+	/** The statistics for the slab journals */
+	struct slab_journal_statistics slab_journal;
+	/** The statistics for the slab summary */
+	struct slab_summary_statistics slab_summary;
+	/** The statistics for the reference counts */
+	struct ref_counts_statistics ref_counts;
+	/** The statistics for the block map */
+	struct block_map_statistics block_map;
+	/** The dedupe statistics from hash locks */
+	struct hash_lock_statistics hash_lock;
+	/** Counts of error conditions */
+	struct error_statistics errors;
+	/** The VDO instance */
+	u32 instance;
+	/** Current number of active VIOs */
+	u32 current_vios_in_progress;
+	/** Maximum number of active VIOs */
+	u32 max_vios;
+	/** Number of times the UDS index was too slow in responding */
+	u64 dedupe_advice_timeouts;
+	/** Number of flush requests submitted to the storage device */
+	u64 flush_out;
+	/** Logical block size */
+	u64 logical_block_size;
+	/** Bios submitted into VDO from above */
+	struct bio_stats bios_in;
+	struct bio_stats bios_in_partial;
+	/** Bios submitted onward for user data */
+	struct bio_stats bios_out;
+	/** Bios submitted onward for metadata */
+	struct bio_stats bios_meta;
+	struct bio_stats bios_journal;
+	struct bio_stats bios_page_cache;
+	struct bio_stats bios_out_completed;
+	struct bio_stats bios_meta_completed;
+	struct bio_stats bios_journal_completed;
+	struct bio_stats bios_page_cache_completed;
+	struct bio_stats bios_acknowledged;
+	struct bio_stats bios_acknowledged_partial;
+	/** Current number of bios in progress */
+	struct bio_stats bios_in_progress;
+	/** Memory usage stats. */
+	struct memory_usage memory_usage;
+	/** The statistics for the UDS index */
+	struct index_statistics index;
+};
+
+#endif /* not STATISTICS_H */
-- 
2.40.1

