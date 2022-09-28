Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922A95ED3B8
	for <lists+linux-block@lfdr.de>; Wed, 28 Sep 2022 06:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiI1EAN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 28 Sep 2022 00:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiI1D77 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 23:59:59 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228CC1559C3
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 20:59:49 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id v130so14106511oie.2
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 20:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date;
        bh=cKg3c7GVCjfn7CupnMnZ/SCSyFG5IPfos7eN/2zVwG8=;
        b=sHFs1Cooi2y5xXA0BL/6+6Waz0HuHk9jIF06Fx4P4A7WWhuUj2ptbrYtbHwJVVY1cR
         /tORdisbPuPUtriRGPRjua2G3N4xnV37aFT/NiJJxIfdXGfqG5akb9S/dv8ujedArwvI
         JM0sp6LLNhtI/knTj97Y3ecT4q63XITO/Gx0CdTV27UtsxCLYMm/WmgEDj31LfMTRSpk
         R3wg0M6pZmvZxz+LDkifiG6on/W1b2wH6VC0Colf/cENGwsYXP6msXL4azPjLA3p8Z1G
         r1lXbcFgk8HrPDyrreXOE2zKNgENl+2v2ddp56Lyey5RaqIUlq2cC8ihHusuJg8lwYus
         ABjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=cKg3c7GVCjfn7CupnMnZ/SCSyFG5IPfos7eN/2zVwG8=;
        b=Zae3ZwTHQZmUzKpuoklDhsXN6epBY6D0vmI+VZ5TdOX3hmgO0fi1f/xmRIl+9Tfx+w
         y1GQcOG8sEnstX6ju0GVNP0LpP73U1zdjLXTG1hFa1vxOAlbwZ9/KOslidT/Ji/ysOlV
         xgfmCXPPoPQ0u7BPT7f4myVyR6XdWWc7xW1h4dr87w+7hIuwe3ZzHQkI05NLyFVmjK5l
         18FP/JSnrPSSOcbOt/AvmfX2waRXzxb1u9CwifdVjOUB4ggZpcQuFv1IkxY+xkdUs22p
         2K8BzyJmjjH7KPqN0smsmB3IVESS9jTcYfZDtAuhrvjbI/v78hSSIjKQWABGXsNMrDvK
         oU8A==
X-Gm-Message-State: ACrzQf1w+oKRX0LFcTniuigL1yS3Uq3/lsG28phNPdWCQeVsKxJ4gGeH
        +kkideMQwOKmetuhMk4ZFocZrA==
X-Google-Smtp-Source: AMsMyM6Oiw0ZdSUZmTEBtMh2zFrN+RYkMMdT/KyVolkNoP2lwZXhk7I8dpQCmCwu5He3YGRE67Z7dg==
X-Received: by 2002:a05:6808:3007:b0:351:3de7:82f4 with SMTP id ay7-20020a056808300700b003513de782f4mr3211800oib.103.1664337589114;
        Tue, 27 Sep 2022 20:59:49 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q16-20020a9d6550000000b00636fd78dd57sm1628961otl.41.2022.09.27.20.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 20:59:48 -0700 (PDT)
Date:   Tue, 27 Sep 2022 20:59:47 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Jens Axboe <axbod@kernel.dk>
cc:     Jan Kara <jack@suse.cz>, Keith Busch <kbusch@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Liu Song <liusong@linux.alibaba.com>,
        Hillf Danton <hdanton@sina.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH next v2] sbitmap: fix lockup while swapping
In-Reply-To: <2b931ee7-1bc9-e389-9d9f-71eb778dcf1@google.com>
Message-ID: <f975dddf-6ec-b3cb-3746-e91f61b22ea@google.com>
References: <YyjdiKC0YYUkI+AI@kbusch-mbp> <f2d130d2-f3af-d09d-6fd7-10da28d26ba9@google.com> <20220921164012.s7lvklp2qk6occcg@quack3> <20220923144303.fywkmgnkg6eken4x@quack3> <d83885c9-2635-ef45-2ccc-a7e06421e1cc@google.com> <Yy4D54kPpenBkjHz@kbusch-mbp.dhcp.thefacebook.com>
 <391b1763-7146-857-e3b6-dc2a8e797162@google.com> <929a3aba-72b0-5e-5b80-824a2b7f5dc7@google.com> <20220926114416.t7t65u66ze76aiz7@quack3> <4539e48-417-edae-d42-9ef84602af0@google.com> <20220927103123.cvjbdx6lqv7jxa2w@quack3>
 <2b931ee7-1bc9-e389-9d9f-71eb778dcf1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 4acb83417cad ("sbitmap: fix batched wait_cnt accounting")
is a big improvement: without it, I had to revert to before commit
040b83fcecfb ("sbitmap: fix possible io hung due to lost wakeup")
to avoid the high system time and freezes which that had introduced.

Now okay on the NVME laptop, but 4acb83417cad is a disaster for heavy
swapping (kernel builds in low memory) on another: soon locking up in
sbitmap_queue_wake_up() (into which __sbq_wake_up() is inlined), cycling
around with waitqueue_active() but wait_cnt 0 .  Here is a backtrace,
showing the common pattern of outer sbitmap_queue_wake_up() interrupted
before setting wait_cnt 0 back to wake_batch (in some cases other CPUs
are idle, in other cases they're spinning for a lock in dd_bio_merge()):

sbitmap_queue_wake_up < sbitmap_queue_clear < blk_mq_put_tag <
__blk_mq_free_request < blk_mq_free_request < __blk_mq_end_request <
scsi_end_request < scsi_io_completion < scsi_finish_command <
scsi_complete < blk_complete_reqs < blk_done_softirq < __do_softirq <
__irq_exit_rcu < irq_exit_rcu < common_interrupt < asm_common_interrupt <
_raw_spin_unlock_irqrestore < __wake_up_common_lock < __wake_up <
sbitmap_queue_wake_up < sbitmap_queue_clear < blk_mq_put_tag <
__blk_mq_free_request < blk_mq_free_request < dd_bio_merge <
blk_mq_sched_bio_merge < blk_mq_attempt_bio_merge < blk_mq_submit_bio <
__submit_bio < submit_bio_noacct_nocheck < submit_bio_noacct <
submit_bio < __swap_writepage < swap_writepage < pageout <
shrink_folio_list < evict_folios < lru_gen_shrink_lruvec <
shrink_lruvec < shrink_node < do_try_to_free_pages < try_to_free_pages <
__alloc_pages_slowpath < __alloc_pages < folio_alloc < vma_alloc_folio <
do_anonymous_page < __handle_mm_fault < handle_mm_fault <
do_user_addr_fault < exc_page_fault < asm_exc_page_fault

See how the process-context sbitmap_queue_wake_up() has been interrupted,
after bringing wait_cnt down to 0 (and in this example, after doing its
wakeups), before advancing wake_index and refilling wake_cnt: an
interrupt-context sbitmap_queue_wake_up() of the same sbq gets stuck.

I have almost no grasp of all the possible sbitmap races, and their
consequences: but __sbq_wake_up() can do nothing useful while wait_cnt 0,
so it is better if sbq_wake_ptr() skips on to the next ws in that case:
which fixes the lockup and shows no adverse consequence for me.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
v2: - v1 to __sbq_wake_up() broke out when this happens, but
      v2 to sbq_wake_ptr() does better by skipping on to the next.
    - added more comment and deleted dubious Fixes attribution.

 lib/sbitmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -587,7 +587,7 @@ static struct sbq_wait_state *sbq_wake_p
 	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
 		struct sbq_wait_state *ws = &sbq->ws[wake_index];
 
-		if (waitqueue_active(&ws->wait)) {
+		if (waitqueue_active(&ws->wait) && atomic_read(&ws->wait_cnt)) {
 			if (wake_index != atomic_read(&sbq->wake_index))
 				atomic_set(&sbq->wake_index, wake_index);
 			return ws;
