Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB6FC5C09C
	for <lists+linux-block@lfdr.de>; Mon,  1 Jul 2019 17:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbfGAPri (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 1 Jul 2019 11:47:38 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:42850 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfGAPri (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 11:47:38 -0400
Received: by mail-pl1-f177.google.com with SMTP id ay6so7521285plb.9
        for <linux-block@vger.kernel.org>; Mon, 01 Jul 2019 08:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q9g8IPL3CjS2k9OEuzMIikXyxe/gIXHs1YUZywnexnA=;
        b=ldqCiuBqmoGBrdVHx3uCM23I3wILiLTCHZKLrdg9rnUBV39XDTTJQVFzd6riOP4wrP
         72x6YAclvHqEcWVgQjtOdOXD4KHwzEgBsVvXQEt0+yDj8PWXzgSEis2TtsE9n/LLPI46
         GCgG5cg0LrtixCpXI/8LktspMpNzTCDIrJd6Mo+QZmGKKbz0G63BhzFzwmeiOQdf5Ev1
         5P94DPYsUyAdnHaCduYgGif2bYmQAGsiVt25r0tK056bv76GQZ4q33FF1fCUT4hlKv9H
         UrfZEBB8f0sXjh2owYjNygM+FZfByMz4TPBDtThF1HoIr1SVrMGfDRa8Tngj52yN5+QS
         tkGw==
X-Gm-Message-State: APjAAAWkqrGYZfrN8zVjoImUX19gA/8i68pDeBX1sQdGzc5Vr/wc5+Ut
        Au45w6dV2b/jPv6Ff0eP+wM=
X-Google-Smtp-Source: APXvYqyW1N0sV57UmBx96jc5lx3dHUpUtRGg0+87MS1YtAW7pi/Cuw9v72F0Gkp04rKZdEhGLDxisA==
X-Received: by 2002:a17:902:1e9:: with SMTP id b96mr29865253plb.277.1561996057405;
        Mon, 01 Jul 2019 08:47:37 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id x7sm11469103pfa.125.2019.07.01.08.47.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 08:47:36 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH, RESEND 0/2] Simplify blk-mq implementation
Date:   Mon,  1 Jul 2019 08:47:28 -0700
Message-Id: <20190701154730.203795-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

While reviewing the blk_mq_make_request() code I noticed that it is possible
to simplify the implementation of that function. Please consider these patches
for kernel v5.3.

Thanks,

Bart.

Bart Van Assche (2):
  blk-mq: Remove blk_mq_put_ctx()
  blk-mq: Simplify blk_mq_make_request()

 block/blk-mq-sched.c  |  5 +----
 block/blk-mq-tag.c    |  8 --------
 block/blk-mq.c        | 26 +++++---------------------
 block/blk-mq.h        |  7 +------
 block/kyber-iosched.c |  1 -
 5 files changed, 7 insertions(+), 40 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

