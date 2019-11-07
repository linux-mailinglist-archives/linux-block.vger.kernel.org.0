Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A476BF22E4
	for <lists+linux-block@lfdr.de>; Thu,  7 Nov 2019 00:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfKFXxO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 6 Nov 2019 18:53:14 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:46131 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfKFXxO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Nov 2019 18:53:14 -0500
Received: by mail-pf1-f176.google.com with SMTP id 193so457213pfc.13
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2019 15:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Meh5vxfYr1NflhjDrTcwDcLSoTmidOfklYId46u5pAg=;
        b=F9fxDCwhIYQO1GtoJOTQ3X5zERTnjlrBTBrSLEYO6zaFwviBXaBUYq9Nq1yIPCwJo4
         rlV4g+cw/GxJeaeWS2ajz5ilOXX1OHnXLqkwAZy1EHbAKNq1I0DGVM+q2nb/TFScsjv4
         9PU1ks6TAfFPa4aQyPVGcs2MVlVhBaEnDxZsfedoBuTQAUyWptL0deMiRuLwEDh80KuV
         zljDY1fBKJFRceiru6YUb+VBVNgsVIxojGVbj1YDW8WuRKPf9vl+6lF+2PiKGiK81MvX
         sP242xtVEakhLRoPp5lMo3EhtMsXTIuUSmjtUegQiICvok4uPYvm8HzoZAn90InE/4pJ
         kwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Meh5vxfYr1NflhjDrTcwDcLSoTmidOfklYId46u5pAg=;
        b=D/jU5jEzzDmpNBm4u5tgDA1BnPmGoeKt85wEQUPT6ZqqEEy7czCSaPQzJCANJKKhEQ
         pW4REhJdoluruH+X1nNx9Rnx0vBkD3ViRWilLJW5m/7lfymQx8hpw+jJl66FtelJtcRZ
         sREJwArGIQKMiCj8m9tVUQDl/osxaTQN22vH6SYp/GnhVYmrtqfOBpv9SKRLhV+1Gajt
         YtUj28XRYatTx6oz+Hguo+rxu6JDTztKeyXuNFbWIAS79RgF1Xriu9OAjzfpZ8QFT8RQ
         MMzcAAfh06b56P91NxQFUFKafE2FRLlRiB6rz33Jkn6n2LwWnKHrAHicrxhIXLKCeh/m
         OcPw==
X-Gm-Message-State: APjAAAVBc+/PwBHY4pc4ntF+w7IRUyApXu/Ozm+wdEUk+SSitrPixydG
        xqI+BRfcrkd4r5HM3yjDTpGek3sNCsQ=
X-Google-Smtp-Source: APXvYqztc+RlFRn7uf18lRbsZj4QcNjxb+vGy503ualpfk/4fKWg57p2aygF3Tlj0riwh2haVcgc9w==
X-Received: by 2002:a63:5960:: with SMTP id j32mr630409pgm.281.1573084392104;
        Wed, 06 Nov 2019 15:53:12 -0800 (PST)
Received: from x1.localdomain ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id x125sm109137pfb.93.2019.11.06.15.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 15:53:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, asml.silence@gmail.com,
        jannh@google.com
Subject: [PATCHSET v2 0/3] io_uring CQ ring backpressure
Date:   Wed,  6 Nov 2019 16:53:04 -0700
Message-Id: <20191106235307.32196-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently we drop completion events, if the CQ ring is full. That's fine
for requests with bounded completion times, but it may make it harder to
use io_uring with networked IO where request completion times are
generally unbounded. Or with POLL, for example, which is also unbounded.

This patch adds IORING_SETUP_CQ_NODROP, which changes the behavior a bit
for CQ ring overflows. First of all, it doesn't overflow the ring, it
simply stores backlog of completions that we weren't able to put into
the CQ ring. To prevent the backlog from growing indefinitely, if the
backlog is non-empty, we apply back pressure on IO submissions. Any
attempt to submit new IO with a non-empty backlog will get an -EBUSY
return from the kernel.

I think that makes for a pretty sane API in terms of how the application
can handle it. With CQ_NODROP enabled, we'll never drop a completion
event, but we'll also not allow submissions with a completion backlog.

Changes since v1:

- Drop the cqe_drop structure and allocation, simply use the io_kiocb
  for the overflow backlog
- Rebase on top of Pavel's series which made this cleaner
- Add prep patch for the fill/add CQ handler changes

 fs/io_uring.c                 | 203 +++++++++++++++++++++++-----------
 include/uapi/linux/io_uring.h |   1 +
 2 files changed, 138 insertions(+), 66 deletions(-)

-- 
Jens Axboe


