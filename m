Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F041300CB0
	for <lists+linux-block@lfdr.de>; Fri, 22 Jan 2021 20:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbhAVSiu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 22 Jan 2021 13:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729292AbhAVSVZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jan 2021 13:21:25 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82DDC061788
        for <linux-block@vger.kernel.org>; Fri, 22 Jan 2021 10:20:34 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id w1so8950341ejf.11
        for <linux-block@vger.kernel.org>; Fri, 22 Jan 2021 10:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TyZpvCAcdGDNITJgWT8Sc1+UY4l/c7LqgAZAP6EAeRw=;
        b=W78BCYZvwAurnCHFncajNd0Y2yjhfHU3Iuo52ZjKsf1rzDVTR2parwdRzQAfxa8Aw4
         hnD0BZl69tuT8XFHGbujc/xhtK4SIzXhZPfEOE7iFh7JlJhEwOapsTTgfG+XW2jPEFbH
         qE0n+p9q8GO/4nDCYlQ2FRwqb9LAoGdCVuvCB5NpBqhcZKk/87a+NUysu/Z3cbzshjwZ
         GtWLl5LaaEaj8O/BuNnu6RKJmH6iHXRIH19xBLKFDmmBYAvic1vxf/+/Kx1lTev+iedE
         +08bRynaMuOls5+6uRqtsVxNq5PfOpRAbLtkMrELvTvrM99MMLJIukiq83rRXv+o56Pu
         2rqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TyZpvCAcdGDNITJgWT8Sc1+UY4l/c7LqgAZAP6EAeRw=;
        b=U/e6wN5LO91RZ1D8zMuOi7y1e9pfPoKH817SAAZgbuLVe/zkI9ZeLNW3rWV/cVzkTz
         HWp6OAeZm+ttnDIU3FbAMffzxPzBIFiY/Lv9uK5zjB0S0xblSUB3J+14oIi4dfvS/hxG
         mr2jsmjEqWVj8Xgq5hADyGikFzxVO2YFhJRh6mgvmZjWIbKXJYdev47Z4KOes7xDULj+
         Kz8m0XYzEHPsoPQDiOrUf3LBp+VCLmzMybgEOoYky1ASd3VCmpCQVkQKJgSsv0InbJJ8
         54e9Xa5PUIBSxaYUlLHbaSQei48B6fqrxDebiOZrbKgL8Glmck4DiILUv0apxvaj7IUN
         nuGQ==
X-Gm-Message-State: AOAM532Dla44XH4Ay7z1zFYkOmRyMRvKFdSSM1pxqqDxHz8lvjUFr4wr
        vTIlAHqkuROcMGml9fXe5Vs7BQ==
X-Google-Smtp-Source: ABdhPJy1+uoJxdBo0AJqieGqdnu3+jYRlUFFo6YcRe6Y3SNhMsGVLPK5qP/0JYdJmGoVllqyn+2jhw==
X-Received: by 2002:a17:906:46d3:: with SMTP id k19mr87575ejs.546.1611339633409;
        Fri, 22 Jan 2021 10:20:33 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id h16sm6003359eds.21.2021.01.22.10.20.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 10:20:32 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX/IMPROVEMENT 0/6] block, bfq: first bath of fixes and improvements
Date:   Fri, 22 Jan 2021 19:19:42 +0100
Message-Id: <20210122181948.35660-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

about nine months ago, Jan (Kara, SUSE) reported a throughput
regression with BFQ. That was the beginning of a fruitful dev&testing
collaboration, which led to 18 new commits. Part are fixes, part are
actual performance improvements.

Jia Cheng Hu (1):
  block, bfq: set next_rq to waker_bfqq->next_rq in waker injection

Paolo Valente (5):
  block, bfq: use half slice_idle as a threshold to check short ttime
  block, bfq: increase time window for waker detection
  block, bfq: do not raise non-default weights
  block, bfq: avoid spurious switches to soft_rt of interactive queues
  block, bfq: do not expire a queue when it is the only busy one

 block/bfq-iosched.c | 100 +++++++++++++++++++++++++++++++-------------
 1 file changed, 70 insertions(+), 30 deletions(-)

--
2.20.1
