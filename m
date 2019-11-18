Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 677F910034C
	for <lists+linux-block@lfdr.de>; Mon, 18 Nov 2019 12:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfKRLBd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 18 Nov 2019 06:01:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49661 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfKRLBd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 06:01:33 -0500
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iWemg-0008SU-DZ; Mon, 18 Nov 2019 12:01:30 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] block: Don't disable interrupts in trigger_softirq()
Date:   Mon, 18 Nov 2019 12:01:22 +0100
Message-Id: <20191118110122.50070-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

trigger_softirq() is always invoked as a SMP-function call which is
always invoked with disables interrupts.

Don't disable interrupt in trigger_softirq() because interrupts are
already disabled.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 block/blk-softirq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/blk-softirq.c b/block/blk-softirq.c
index 457d9ba3eb204..6e7ec87d49faa 100644
--- a/block/blk-softirq.c
+++ b/block/blk-softirq.c
@@ -42,17 +42,13 @@ static __latent_entropy void blk_done_softirq(struct so=
ftirq_action *h)
 static void trigger_softirq(void *data)
 {
 	struct request *rq =3D data;
-	unsigned long flags;
 	struct list_head *list;
=20
-	local_irq_save(flags);
 	list =3D this_cpu_ptr(&blk_cpu_done);
 	list_add_tail(&rq->ipi_list, list);
=20
 	if (list->next =3D=3D &rq->ipi_list)
 		raise_softirq_irqoff(BLOCK_SOFTIRQ);
-
-	local_irq_restore(flags);
 }
=20
 /*
--=20
2.24.0

