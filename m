Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4C97165538
	for <lists+linux-block@lfdr.de>; Thu, 20 Feb 2020 03:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgBTCox (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 19 Feb 2020 21:44:53 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43094 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbgBTCox (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 21:44:53 -0500
Received: by mail-pg1-f194.google.com with SMTP id u12so1133368pgb.10
        for <linux-block@vger.kernel.org>; Wed, 19 Feb 2020 18:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VHzHniqW9FZF1qhMp65mKq0FyUT0hhSij2tHk+/E1cg=;
        b=Y66X6E6XEZI/0df9uutcNbZlHauE4KPTlF1h+L//uHonJC3TDwrsDMLUFJRz1r7VDC
         bL8qZD4hOFNg4aVgLFLefIzQR8cbN9n3QvlCMjuyEhSjteBnX46KoJ66J92F9rdYmQ6V
         sG5xPEJ6Iu73KxS4N0CUIE2f5ePqZNHRH4A1vIrNImoAWNsmQC+Iey9+fd7Gh4qg8Yy5
         /JfVP0VCanFZ9Fe7P/LAn+gSjrRgzd5Bhf433SdWsO6BU0e4Zlae8MCLvalo7PWpARpk
         eYNNDedMSIdk5ez0WsvQY9fkzVvCjWRL+e0zWU70XEkZbJd+WjMcXGKyLNtN8/W5DKYA
         fIDA==
X-Gm-Message-State: APjAAAWIUws8dDDooOhHG/JoQgxgnAwjuFB1PmX4l9ab6GC0LASoMpFz
        cRGiMu7AWAq8CQ8K8HuyPII=
X-Google-Smtp-Source: APXvYqw5R5nzsc/wBnbG50HtmHcuvppit5Ke+Pua1QL7LncsUjQz87Ak3mMUBfv2e6c84UsgG6QoQA==
X-Received: by 2002:a63:348b:: with SMTP id b133mr31194547pga.372.1582166691423;
        Wed, 19 Feb 2020 18:44:51 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:29a7:b1bb:5b40:3d61])
        by smtp.gmail.com with ESMTPSA id t23sm1005466pfq.6.2020.02.19.18.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 18:44:50 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2 3/8] blk-mq: Fix a recently introduced regression in blk_mq_realloc_hw_ctxs()
Date:   Wed, 19 Feb 2020 18:44:36 -0800
Message-Id: <20200220024441.11558-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220024441.11558-1-bvanassche@acm.org>
References: <20200220024441.11558-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

q->nr_hw_queues must only be updated once it is known that
blk_mq_realloc_hw_ctxs() has succeeded. Otherwise it can happen that
reallocation fails and that q->nr_hw_queues is larger than the number of
allocated hardware queues. This patch fixes the following crash if
increasing the number of hardware queues fails:

BUG: KASAN: null-ptr-deref in blk_mq_map_swqueue+0x775/0x810
Write of size 8 at addr 0000000000000118 by task check/977

CPU: 3 PID: 977 Comm: check Not tainted 5.6.0-rc1-dbg+ #8
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Call Trace:
 dump_stack+0xa5/0xe6
 __kasan_report.cold+0x65/0x99
 kasan_report+0x16/0x20
 check_memory_region+0x140/0x1b0
 memset+0x28/0x40
 blk_mq_map_swqueue+0x775/0x810
 blk_mq_update_nr_hw_queues+0x468/0x710
 nullb_device_submit_queues_store+0xf7/0x1a0 [null_blk]
 configfs_write_file+0x1c4/0x250 [configfs]
 __vfs_write+0x4c/0x90
 vfs_write+0x145/0x2c0
 ksys_write+0xd7/0x180
 __x64_sys_write+0x47/0x50
 do_syscall_64+0x6f/0x2f0
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jth@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>
Fixes: ac0d6b926e74 ("block: Reduce the amount of memory required per request queue")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7f996e427733..948523fbfa7f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2824,7 +2824,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 			memcpy(new_hctxs, hctxs, q->nr_hw_queues *
 			       sizeof(*hctxs));
 		q->queue_hw_ctx = new_hctxs;
-		q->nr_hw_queues = set->nr_hw_queues;
 		kfree(hctxs);
 		hctxs = new_hctxs;
 	}
