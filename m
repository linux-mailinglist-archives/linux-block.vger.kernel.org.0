Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27FD5B44B9
	for <lists+linux-block@lfdr.de>; Sat, 10 Sep 2022 08:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiIJGvV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 10 Sep 2022 02:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIJGvU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 10 Sep 2022 02:51:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C5C3121D;
        Fri,  9 Sep 2022 23:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TWMB057d75ixVxyjdIFV1XXGOo0lh1V+gLJp5z7ed9M=; b=NBIurit5r6+q8mICiFS5WC3bos
        uEapd4J0qYeXSXm7FM/nQTunbL1M8v4YBFR9liWo5ysvmgUYjxYsTtwK2M8sQCLKESTfdhMW3H/3l
        Jz7Q6BUAlaFmzwe8swKOZJT70jf5yW9XUqZoi1Yecm/TY3dhKnFbxNoLAsYNyqPvFRsmJiM/MEZiN
        npLdahDgF7NnGQTEutWPlQcdWL2ZeMoJ8yHrx6o8043Pvp0q9HwICGWwVeK1zI8LF6iZu6Xv0k04b
        vTmK+8o2q/D1f7TAGVbdim1bIj0B4DNljspC3aewMIQ4+UoC3TVM/JOldv1tphvsPX88P38NUZCGG
        TJI26X9A==;
Received: from [2001:4bb8:198:38af:e8dc:dbbd:a9d:5c54] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWuKa-006pZL-QP; Sat, 10 Sep 2022 06:51:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-mm@kvack.org
Subject: [PATCH 1/5] mm: add PSI accounting around ->read_folio and ->readahead calls
Date:   Sat, 10 Sep 2022 08:50:54 +0200
Message-Id: <20220910065058.3303831-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220910065058.3303831-1-hch@lst.de>
References: <20220910065058.3303831-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PSI tries to account for the cost of bringing back in pages discarded by
the MM LRU management.  Currently the prime place for that is hooked into
the bio submission path, which is a rather bad place:

 - it does not actually account I/O for non-block file systems, of which
   we have many
 - it adds overhead and a layering violation to the block layer

Add the accounting into the two places in the core MM code that read
pages into an address space by calling into ->read_folio and ->readahead
so that the entire file system operations are covered, to broaden
the coverage and allow removing the accounting in the block layer going
forward.

As psi_memstall_enter can deal with nested calls this will not lead to
double accounting even while the bio annotations are still present.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            |  7 +++++++
 mm/readahead.c          | 22 ++++++++++++++++++----
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0178b2040ea38..201dc7281640b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1173,6 +1173,8 @@ struct readahead_control {
 	pgoff_t _index;
 	unsigned int _nr_pages;
 	unsigned int _batch_count;
+	bool _workingset;
+	unsigned long _pflags;
 };
 
 #define DEFINE_READAHEAD(ractl, f, r, m, i)				\
diff --git a/mm/filemap.c b/mm/filemap.c
index 15800334147b3..c943d1b90cc26 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2382,6 +2382,8 @@ static void filemap_get_read_batch(struct address_space *mapping,
 static int filemap_read_folio(struct file *file, filler_t filler,
 		struct folio *folio)
 {
+	bool workingset = folio_test_workingset(folio);
+	unsigned long pflags;
 	int error;
 
 	/*
@@ -2390,8 +2392,13 @@ static int filemap_read_folio(struct file *file, filler_t filler,
 	 * fails.
 	 */
 	folio_clear_error(folio);
+
 	/* Start the actual read. The read will unlock the page. */
+	if (unlikely(workingset))
+		psi_memstall_enter(&pflags);
 	error = filler(file, folio);
+	if (unlikely(workingset))
+		psi_memstall_leave(&pflags);
 	if (error)
 		return error;
 
diff --git a/mm/readahead.c b/mm/readahead.c
index fdcd28cbd92de..43631c146d6dc 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -122,6 +122,7 @@
 #include <linux/task_io_accounting_ops.h>
 #include <linux/pagevec.h>
 #include <linux/pagemap.h>
+#include <linux/psi.h>
 #include <linux/syscalls.h>
 #include <linux/file.h>
 #include <linux/mm_inline.h>
@@ -152,6 +153,8 @@ static void read_pages(struct readahead_control *rac)
 	if (!readahead_count(rac))
 		return;
 
+	if (unlikely(rac->_workingset))
+		psi_memstall_enter(&rac->_pflags);
 	blk_start_plug(&plug);
 
 	if (aops->readahead) {
@@ -179,6 +182,9 @@ static void read_pages(struct readahead_control *rac)
 	}
 
 	blk_finish_plug(&plug);
+	if (unlikely(rac->_workingset))
+		psi_memstall_leave(&rac->_pflags);
+	rac->_workingset = false;
 
 	BUG_ON(readahead_count(rac));
 }
@@ -252,6 +258,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 		}
 		if (i == nr_to_read - lookahead_size)
 			folio_set_readahead(folio);
+		ractl->_workingset |= folio_test_workingset(folio);
 		ractl->_nr_pages++;
 	}
 
@@ -480,11 +487,14 @@ static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
 	if (index == mark)
 		folio_set_readahead(folio);
 	err = filemap_add_folio(ractl->mapping, folio, index, gfp);
-	if (err)
+	if (err) {
 		folio_put(folio);
-	else
-		ractl->_nr_pages += 1UL << order;
-	return err;
+		return err;
+	}
+
+	ractl->_nr_pages += 1UL << order;
+	ractl->_workingset = folio_test_workingset(folio);
+	return 0;
 }
 
 void page_cache_ra_order(struct readahead_control *ractl,
@@ -826,6 +836,10 @@ void readahead_expand(struct readahead_control *ractl,
 			put_page(page);
 			return;
 		}
+		if (unlikely(PageWorkingset(page)) && !ractl->_workingset) {
+			ractl->_workingset = true;
+			psi_memstall_enter(&ractl->_pflags);
+		}
 		ractl->_nr_pages++;
 		if (ra) {
 			ra->size++;
-- 
2.30.2

