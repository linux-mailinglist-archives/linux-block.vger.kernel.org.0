Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2EB6173CC
	for <lists+linux-block@lfdr.de>; Thu,  3 Nov 2022 02:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiKCBkk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Nov 2022 21:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKCBkj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 21:40:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFAC11458
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 18:40:38 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o7so269812pjj.1
        for <linux-block@vger.kernel.org>; Wed, 02 Nov 2022 18:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EvT5dgXSYKBpxcVTYD1qf8cSHTUWaJZF8xGQfaZD+ZU=;
        b=a/RROOv1Lf+Wm2fr9D3eQRp6ISUL4AOlQae9HPGthkEBzMVudH/Ngx9bXGynny5St8
         g0gYbfl3i3N9mbrpII9cqdelc6e1jWDzwrnmemcXg1eQTOPVbzFlUqRFvUfpWh4Ma511
         97Sta3HSo6BKDK7nmnjJrX5BWxK3RqZtOqATk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EvT5dgXSYKBpxcVTYD1qf8cSHTUWaJZF8xGQfaZD+ZU=;
        b=Zo+M+RbOeuHv/zyMp5jXNpniVOPsMwA/pjkbnF9+Fy90Uxi3w7kTJfuFZvHXDx5vps
         Kls/EHerbNNPYp4YSJBMjVqQHA9yDw2ugPxOg2bWuZ5bgGKWIlUwmiaNrLaie9t2+0RV
         9OwcugxfIrl9pj7wlhq+1ClUCgBa0WWXwrWafW5wIOE5T5ptUzKxhcNE2qKHWBv/7/5y
         Q991nmbJ+rc+JO/UejD10Gqzm6HEA5C21o8ORt7NsY+cxHYry0EpNxnXFg4HowWoy0a7
         3f88fkZUuD5PFERRYCbKqD4Ea37CgYdsbU/ZAbYUoaGi57Dnuq0HsacDIRS2yJ/VYnI+
         IkBg==
X-Gm-Message-State: ACrzQf17/jTZEfdZ4twWxuW1JatDxT8qFHYB3W3uo6d4SrOSrohmpLlU
        Wz7t0RQ34QT9uw6jZXSTt/dx0A==
X-Google-Smtp-Source: AMsMyM4ZFU8NcuZa/IfoFF63mPChzAEuhWPz1vj/wKLxX3Xb12k+P70KW+/SFtCOkYmRgW38mDWg/w==
X-Received: by 2002:a17:90a:2a02:b0:214:247a:c185 with SMTP id i2-20020a17090a2a0200b00214247ac185mr8234172pjd.226.1667439633589;
        Wed, 02 Nov 2022 18:40:33 -0700 (PDT)
Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2d4:203:1464:23cb:dead:55d3])
        by smtp.gmail.com with ESMTPSA id x8-20020a17090abc8800b0020ad86f4c54sm2091370pjr.16.2022.11.02.18.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 18:40:33 -0700 (PDT)
From:   Khazhismel Kumykov <khazhy@chromium.org>
X-Google-Original-From: Khazhismel Kumykov <khazhy@google.com>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>
Subject: [RFC PATCH] bfq: fix waker_bfqq inconsistency crash
Date:   Wed,  2 Nov 2022 18:39:37 -0700
Message-Id: <20221103013937.603626-1-khazhy@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This fixes crashes in bfq_add_bfqq_busy due to waker_bfqq being NULL,
but woken_list_node still being hashed. This would happen when
bfq_init_rq() expects a brand new allocated queue to be returned from
bfq_get_bfqq_handle_split() and unconditionally updates waker_bfqq
without resetting woken_list_node. Since we can always return oom_bfqq
when attempting to allocate, we cannot assume waker_bfqq starts as NULL.
We must either reset woken_list_node, or avoid setting woken_list at all
for oom_bfqq - opt to do the former.

Crashes would have a stacktrace like:
[160595.656560]  bfq_add_bfqq_busy+0x110/0x1ec
[160595.661142]  bfq_add_request+0x6bc/0x980
[160595.666602]  bfq_insert_request+0x8ec/0x1240
[160595.671762]  bfq_insert_requests+0x58/0x9c
[160595.676420]  blk_mq_sched_insert_request+0x11c/0x198
[160595.682107]  blk_mq_submit_bio+0x270/0x62c
[160595.686759]  __submit_bio_noacct_mq+0xec/0x178
[160595.691926]  submit_bio+0x120/0x184
[160595.695990]  ext4_mpage_readpages+0x77c/0x7c8
[160595.701026]  ext4_readpage+0x60/0xb0
[160595.705158]  filemap_read_page+0x54/0x114
[160595.711961]  filemap_fault+0x228/0x5f4
[160595.716272]  do_read_fault+0xe0/0x1f0
[160595.720487]  do_fault+0x40/0x1c8

Tested by injecting random failures into bfq_get_queue, crashes go away
completely.

Fixes: 8ef3fc3a043c ("block, bfq: make shared queues inherit wakers")
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
RFC mainly because it's not clear to me the best policy here - but the
patch is tested and fixes a real crash we started seeing in 5.15

This is following up my ramble over at
https://lore.kernel.org/lkml/CACGdZYLMnfcqwbAXDx+x9vUOMn2cz55oc+8WySBS3J2Xd_q7Lg@mail.gmail.com/

 block/bfq-iosched.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 7ea427817f7f..5d2861119d20 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6793,7 +6793,12 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 				 * reset. So insert new_bfqq into the
 				 * woken_list of the waker. See
 				 * bfq_check_waker for details.
+				 *
+				 * Also, if we got oom_bfqq, we must check if
+				 * it's already in a woken_list
 				 */
+				if (unlikely(!hlist_unhashed(&bfqq->woken_list_node)))
+					hlist_del_init(&bfqq->woken_list_node);
 				if (bfqq->waker_bfqq)
 					hlist_add_head(&bfqq->woken_list_node,
 						       &bfqq->waker_bfqq->woken_list);
-- 
2.38.1.273.g43a17bfeac-goog

