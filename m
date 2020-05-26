Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 725B61A179B
	for <lists+linux-block@lfdr.de>; Wed,  8 Apr 2020 00:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgDGWAs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 Apr 2020 18:00:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36729 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgDGWAr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Apr 2020 18:00:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id n10so1436786pff.3
        for <linux-block@vger.kernel.org>; Tue, 07 Apr 2020 15:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Va+2nc4i3Yd/W+iIcLatzp6wimnXHUJvgsPfQPVfjOk=;
        b=gy9VuPQkWxTJk5f0NPImzjXAgbmkdVnSGu/aCOlfUYUONmXPV34RUXTT3IJ7hCCZeZ
         qk0UN2+a0tnubLFizwXeReioGyiMApRKwoHrXd6DWPlY8tn3qMLBbhUo5cwYMalX/UWJ
         d0V3h9CexwCSBJhcf92nXnfL5uzWNpMz3ppyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Va+2nc4i3Yd/W+iIcLatzp6wimnXHUJvgsPfQPVfjOk=;
        b=UdiNhBU9+oPLlnIzNDwXSp9fFlCga9rvXa0C+o4DDrZxGWMQdR7sN9IhUID3aHktBW
         ghE/iNgefi+HncqpOcEHENSD+H8GOD+6Pi72XKpB2wxRXJEiX5gFcPCwM+p/3CgY5qnT
         MHV5ZHG2apArprnNPGNHWDx0evpXsrjLYYfIFqmuWOpQeH0k+dPosWNbE3QjOKu8pvzn
         f64oVvUSd1M0x5qfOeFXjMaEug6yd02OfNHjzEZ5TLNK7mn8CjVGOi5E6KqhchHXAN4g
         9mu4cZ7HdoxG1+6+kAiiBa0QQsRIfUY1hep8rnfkxUHMSiz8NXV5WSD0mfjo2kSdj5yG
         ts6g==
X-Gm-Message-State: AGi0PuazSA21G60Sr+E1PpsEQBB9B6c7zRNhahTx6lf3GLtlJ0tGWmrF
        +oahanZWdVc8+Kh/FtSsppbiYw==
X-Google-Smtp-Source: APiQypL2Qu8KYDrWW/tOAFF4GfWMTLWK8Gme7f6J6H+6CiWntfa0rfCy/dU1fPn7+ho9ZB99Vqc/kA==
X-Received: by 2002:a63:e350:: with SMTP id o16mr3931135pgj.250.1586296842988;
        Tue, 07 Apr 2020 15:00:42 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id g3sm880112pgd.64.2020.04.07.15.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 15:00:42 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        sqazi@google.com, Gwendal Grignou <gwendal@chromium.org>,
        groeck@chromium.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] Revert "scsi: core: run queue if SCSI device queue isn't ready and queue is idle"
Date:   Tue,  7 Apr 2020 15:00:05 -0700
Message-Id: <20200407145906.v3.4.I630e6ca4cdcf9ab13ea899274745f9e3174eb12b@changeid>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200407220005.119540-1-dianders@chromium.org>
References: <20200407220005.119540-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This reverts commit 7e70aa789d4a0c89dbfbd2c8a974a4df717475ec.

Now that we have the patches ("blk-mq: In blk_mq_dispatch_rq_list()
"no budget" is a reason to kick") and ("blk-mq: Rerun dispatching in
the case of budget contention") we should no longer need the fix in
the SCSI code.  Revert it, resolving conflicts with other patches that
have touched this code.

With this revert (and the two new patches) I can run the script that
was in commit 7e70aa789d4a ("scsi: core: run queue if SCSI device
queue isn't ready and queue is idle") in a loop with no failure.  If I
do this revert without the two new patches I can easily get a failure.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I don't know for sure that we can revert this patch, but in the very
least the original test case now passes.  If there is any question
about this, we can just drop this patch.

Changes in v3:
- ("Revert "scsi: core: run queue...") new for v3.

Changes in v2: None

 drivers/scsi/scsi_lib.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 47835c4b4ee0..ea18f618dc66 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1610,12 +1610,7 @@ static bool scsi_mq_get_budget(struct blk_mq_hw_ctx *hctx)
 	struct request_queue *q = hctx->queue;
 	struct scsi_device *sdev = q->queuedata;
 
-	if (scsi_dev_queue_ready(q, sdev))
-		return true;
-
-	if (atomic_read(&sdev->device_busy) == 0 && !scsi_device_blocked(sdev))
-		blk_mq_delay_run_hw_queue(hctx, SCSI_QUEUE_DELAY);
-	return false;
+	return scsi_dev_queue_ready(q, sdev);
 }
 
 static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
-- 
2.26.0.292.g33ef6b2f38-goog

