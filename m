Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDC817EF9C
	for <lists+linux-block@lfdr.de>; Tue, 10 Mar 2020 05:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgCJE0g (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 10 Mar 2020 00:26:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42054 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgCJE0g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Mar 2020 00:26:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id h8so5725599pgs.9
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2020 21:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eeNWQoDeiYeeNaUURvR0kvKyoP6OSHq9F5/Cz7NmbPg=;
        b=SMnrEm7VRFb6uK0YAKzEZ5LQGd1rGHB40+jvNxatNq+wBzzL0FpOSzpXiqUZEz/sVY
         YeAwCsNONN/zcyobKFGcQZFmOReoXZd5vsBEy8ISm0Jbc1QP0XBYXFSP1xbVm+DQHDEm
         r2d/rZzxLZ2bwwTMlM9t5TKrhBvIcGxW9ZA9B1B0zcE5J/9eUJjHtiWNJy/1X0yTPNB1
         trK3rYjWz40vdWHNfb7Lov6dRq4VMGTaDg7cSxR4uWItcR+wkmkRI0KPG9hzFg/hb3e5
         9YCMf4egXhtYh5mjq+1pXS/CBYDKAlAAAmksguxwhhEEwpXoiHrP/cHGtPbN5s+P+x/2
         w7Ag==
X-Gm-Message-State: ANhLgQ1KwLuRyPJGRy0Ki9gM/3ru9qOPiwnPNWzktko7WH3nE14gFSkX
        KnJi6Mc75UCtwewJjfklBec=
X-Google-Smtp-Source: ADFU+vvf6fdYPM4H/7OTutdw86c9Xdv+lAui2GukHyQON5q64bYM0PGkv7DAZS6AFFh2AmT764M9Nw==
X-Received: by 2002:aa7:958e:: with SMTP id z14mr19973136pfj.235.1583814395222;
        Mon, 09 Mar 2020 21:26:35 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:c0e4:71da:7a83:2357])
        by smtp.gmail.com with ESMTPSA id l189sm5963240pga.64.2020.03.09.21.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 21:26:34 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH v4 3/8] blk-mq: Fix a recently introduced regression in blk_mq_realloc_hw_ctxs()
Date:   Mon,  9 Mar 2020 21:26:18 -0700
Message-Id: <20200310042623.20779-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310042623.20779-1-bvanassche@acm.org>
References: <20200310042623.20779-1-bvanassche@acm.org>
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
index f174b6ad94cb..41f7264e51c9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2828,7 +2828,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 			memcpy(new_hctxs, hctxs, q->nr_hw_queues *
 			       sizeof(*hctxs));
 		q->queue_hw_ctx = new_hctxs;
-		q->nr_hw_queues = set->nr_hw_queues;
 		kfree(hctxs);
 		hctxs = new_hctxs;
 	}
