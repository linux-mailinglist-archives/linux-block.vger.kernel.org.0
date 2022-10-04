Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF08D5F4009
	for <lists+linux-block@lfdr.de>; Tue,  4 Oct 2022 11:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiJDJnT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 4 Oct 2022 05:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiJDJm4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2022 05:42:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D91E57561
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 02:40:20 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id lt21so2345271ejb.0
        for <linux-block@vger.kernel.org>; Tue, 04 Oct 2022 02:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zL7MggT/wjl1I9Pu+YgUlKOT6FxpafG/7SpHyPz1qkE=;
        b=IOmIjj+sSjod0YaUczD0fikDsCfwO+ZpQUDGKMgh+KrZlAvUkVRqFFMgq+pzCe9ob+
         ynW801Ljib/cZ5orDbnQobGHmySqJ7ukxApJ+b43GNXTqH0IINEzPquGMI8uE4wHQgWz
         wcj2drhAKBVNNfuAwnRhWNRNGQJwCQOk9z9VUqsME9YlSO5bUzc0myzBsJboDSOZuf9c
         0Kwe5pN9XiJYU//npzZpWLOSjfDebDMFPSCShKXVUW8u/X+QUE+Iyzx7r8V4iEjTsK9r
         QI8PJhZvCutrDenlxCvm+lA5O7MshoOm1g13/NJt1D67iVXix4kKhTcfQStWcYCul3ru
         cGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zL7MggT/wjl1I9Pu+YgUlKOT6FxpafG/7SpHyPz1qkE=;
        b=YlqODgGKPtFE2Liu+nfNBvu6U3pzqo7dD86F4OPv0UIY0pdofGk0yOA0s3vmNppxBn
         NZ9M9Ptd6ymcA7gNHg+4avT2HN4Z4cqcovF7G+6gC2lBvvkRpnEWyK/nh+fRuAaeLIRu
         j76do0RlGDHMOThSRaQgthWyxbOZoHNFbhUSKol6eLbfhDYqM2oTVJ6EKHLdX1jLgG3f
         sGyKkJUiHFBDapDBq5G8jiI3wf4LoMvXTRwmkaGMtifg3YVHdnX0YZjDFynVDHufzqgm
         Xv3ZXmqho1gG0yNZjmzIxJ7EjcvrpM0HckDYDZxA/hBhiDjJ/m5DF5lgre7sKEBsyhhS
         voAA==
X-Gm-Message-State: ACrzQf2/6qGWRa/nt30Sg41JzRi1/IRYnC9Woky6HglK0L50I7j4F/30
        bneivsd+41uY+phmotxOY3oXkA==
X-Google-Smtp-Source: AMsMyM6qqy62fdBI86idXIKK8xWM7kAggmSgkH0teEDdtql7lqn+dSC74SlhkIwsiKHzsqy3N+EAzg==
X-Received: by 2002:a17:907:9812:b0:781:bbff:1d20 with SMTP id ji18-20020a170907981200b00781bbff1d20mr18555380ejc.33.1664876419191;
        Tue, 04 Oct 2022 02:40:19 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-37-207-44.cust.vodafonedsl.it. [2.37.207.44])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906200900b00780f6071b5dsm6774853ejo.188.2022.10.04.02.40.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2022 02:40:18 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, andrea.righi@canonical.com, glen.valante@linaro.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V3 2/8] block, bfq: forbid stable merging of queues associated with different actuators
Date:   Tue,  4 Oct 2022 11:40:04 +0200
Message-Id: <20221004094010.80090-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221004094010.80090-1-paolo.valente@linaro.org>
References: <20221004094010.80090-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If queues associated with different actuators are merged, then control
is lost on each actuator. Therefore some actuator may be
underutilized, and throughput may decrease. This problem cannot occur
with basic queue merging, because the latter is triggered by spatial
locality, and sectors for different actuators are not close to each
other. Yet it may happen with stable merging. To address this issue,
this commit prevents stable merging from occurring among queues
associated with different actuators.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index c2485b599d87..2a75009c1c06 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5695,9 +5695,13 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
 	 * it has been set already, but too long ago, then move it
 	 * forward to bfqq. Finally, move also if bfqq belongs to a
 	 * different group than last_bfqq_created, or if bfqq has a
-	 * different ioprio or ioprio_class. If none of these
-	 * conditions holds true, then try an early stable merge or
-	 * schedule a delayed stable merge.
+	 * different ioprio, ioprio_class or actuator_idx. If none of
+	 * these conditions holds true, then try an early stable merge
+	 * or schedule a delayed stable merge. As for the condition on
+	 * actuator_idx, the reason is that, if queues associated with
+	 * different actuators are merged, then control is lost on
+	 * each actuator. Therefore some actuator may be
+	 * underutilized, and throughput may decrease.
 	 *
 	 * A delayed merge is scheduled (instead of performing an
 	 * early merge), in case bfqq might soon prove to be more
@@ -5715,7 +5719,8 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
 			bfqq->creation_time) ||
 		bfqq->entity.parent != last_bfqq_created->entity.parent ||
 		bfqq->ioprio != last_bfqq_created->ioprio ||
-		bfqq->ioprio_class != last_bfqq_created->ioprio_class)
+		bfqq->ioprio_class != last_bfqq_created->ioprio_class ||
+		bfqq->actuator_idx != last_bfqq_created->actuator_idx)
 		*source_bfqq = bfqq;
 	else if (time_after_eq(last_bfqq_created->creation_time +
 				 bfqd->bfq_burst_interval,
-- 
2.20.1

