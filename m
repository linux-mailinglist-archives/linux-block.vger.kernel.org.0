Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F8921D642
	for <lists+linux-block@lfdr.de>; Mon, 13 Jul 2020 14:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbgGMMpC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 13 Jul 2020 08:45:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:36604 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgGMMpC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jul 2020 08:45:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BBE12ABF4;
        Mon, 13 Jul 2020 12:45:02 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-bcache@vger.kernel.org, hch@lst.de
Cc:     Coly Li <colyli@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Jan Kara <jack@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Vlastimil Babka <vbabka@suse.com>, stable@vger.kernel.org
Subject: [PATCH v2] nvme-tcp: don't use sendpage for pages not taking reference counter
Date:   Mon, 13 Jul 2020 20:44:44 +0800
Message-Id: <20200713124444.19640-1-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently nvme_tcp_try_send_data() doesn't use kernel_sendpage() to
send slab pages. But for pages allocated by __get_free_pages() without
__GFP_COMP, which also have refcount as 0, they are still sent by
kernel_sendpage() to remote end, this is problematic.

When bcache uses a remote NVMe SSD via nvme-over-tcp as its cache
device, writing meta data e.g. cache_set->disk_buckets to remote SSD may
trigger a kernel panic due to the above problem. Bcause the meta data
pages for cache_set->disk_buckets are allocated by __get_free_pages()
without __GFP_COMP.

This problem should be fixed both in upper layer driver (bcache) and
nvme-over-tcp code. This patch fixes the nvme-over-tcp code by checking
whether the page refcount is 0, if yes then don't use kernel_sendpage()
and call sock_no_sendpage() to send the page into network stack.

The code comments in this patch is copied and modified from drbd where
the similar problem already gets solved by Philipp Reisner. This is the
best code comment including my own version.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Jan Kara <jack@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Vlastimil Babka <vbabka@suse.com>
Cc: stable@vger.kernel.org
---
Changelog:
v2: fix typo in patch subject.
v1: the initial version.
 drivers/nvme/host/tcp.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 79ef2b8e2b3c..faa71db7522a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -887,8 +887,17 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 		else
 			flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
 
-		/* can't zcopy slab pages */
-		if (unlikely(PageSlab(page))) {
+		/*
+		 * e.g. XFS meta- & log-data is in slab pages, or bcache meta
+		 * data pages, or other high order pages allocated by
+		 * __get_free_pages() without __GFP_COMP, which have a page_count
+		 * of 0 and/or have PageSlab() set. We cannot use send_page for
+		 * those, as that does get_page(); put_page(); and would cause
+		 * either a VM_BUG directly, or __page_cache_release a page that
+		 * would actually still be referenced by someone, leading to some
+		 * obscure delayed Oops somewhere else.
+		 */
+		if (unlikely(PageSlab(page) || page_count(page) < 1)) {
 			ret = sock_no_sendpage(queue->sock, page, offset, len,
 					flags);
 		} else {
-- 
2.26.2

