Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9E9AF160
	for <lists+linux-block@lfdr.de>; Tue, 30 Apr 2019 09:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfD3Hey (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 30 Apr 2019 03:34:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35133 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfD3Hey (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 03:34:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id z26so11836016ljj.2;
        Tue, 30 Apr 2019 00:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9CHE1lmmOCD1ZhFRGNkGzvfqQEM23kbmhQLG9DNgUJs=;
        b=vB96vkVf6/kI96T1U6JnZMQT9LspImJhGteLAYv67EBNbLW4sXFN/lFmHIEZTQ6c7j
         dAGNJjV5mx3lYzN6aJon/X2c+loKo+e5L/V5J1ebzc8PvJtb8t5eJFHGvOuLNb1Ndp3C
         iEejhzoI/9EA0o+hYYaraImUB4g36CpB+6wJGmmB5jhGr+D8qhBopQu6AE+0wTqWYSeO
         RjLYnxFz+PjahW0mNwbqbk2fxf+T0Tnh2O+LvvgyVYRwQi/MCs20FDaeuXTqLBLU5QLa
         dyRGguYvFvm6keGuZTwnbmhUBlQihDZR/18Z9AL7Hkwo1NGihCJnGOZFGEKU7lg+RBr0
         jvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9CHE1lmmOCD1ZhFRGNkGzvfqQEM23kbmhQLG9DNgUJs=;
        b=tBnWVY91h340+Ew9YSwRoZwOdaWdOxhkrH4jtXa+rcGH54LneH1fgz+GCjzjTA5lk3
         0Df51iLFwO2exxyePB8SC56hmocOmJoxUH/6Mm7aw3pyUwjdr8KMPdVtl9Y8bTFmP2LC
         JG3yoNLeK++ESE8JCsN/d3rDXgUc1H5d4ZCKKVZ0K+0U6UnC0NJtsTF59or3CWtxTJmT
         C5gZxFFSifhKVckCQT8UA/XIkc2PP/C6cBTtD/uYsIFTfr6mwDxYhAOSc5xguWbIGbEO
         PijiMhf98EPrw9jWfcnYhHj6oXKChs4YSz0d1Lh6lFbwKy9fDreR6d3QnmT0jHi2V+e7
         uN0w==
X-Gm-Message-State: APjAAAWMBV0jC8Vs0GVsMNOTwEXb7DK+MYEjjzGP9OmbQwFj7xDcCyk0
        NiHIJENX2oiZsEuFnSHmKUvv1+YC
X-Google-Smtp-Source: APXvYqyI8WfpiQqMpqsNaPSItXHBYEo5oMwlAZgWbDuGOy5jfZJo16/81JMFBVnKMLAFb96IpEKTDg==
X-Received: by 2002:a2e:9a0f:: with SMTP id o15mr25054986lji.130.1556609691970;
        Tue, 30 Apr 2019 00:34:51 -0700 (PDT)
Received: from localhost.localdomain ([109.126.133.52])
        by smtp.gmail.com with ESMTPSA id v23sm2400572ljk.14.2019.04.30.00.34.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 00:34:51 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 0/7] Adjust hybrid polling sleep time
Date:   Tue, 30 Apr 2019 10:34:12 +0300
Message-Id: <cover.1556609582.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

Sleep time for adaptive hybrid polling is coarse and can be improved to
decrease CPU load. Use variation of the 3-sigma rule and runtime
tuning.

This approach gives up to 2x CPU load reduction keeping the same latency
distribution and throughput.

Pavel Begunkov (7):
  blk-iolatency: Fix zero mean in previous stats
  blk-stats: Introduce explicit stat staging buffers
  blk-mq: Fix disabled hybrid polling
  blk-stats: Add left mean deviation to blk_stats
  blk-mq: Precalculate hybrid polling time
  blk-mq: Track num of overslept by hybrid poll rqs
  blk-mq: Adjust hybrid poll sleep time

 block/blk-core.c          |   7 +-
 block/blk-iolatency.c     |  60 ++++++++++----
 block/blk-mq-debugfs.c    |  14 ++--
 block/blk-mq.c            | 163 ++++++++++++++++++++++++++++----------
 block/blk-stat.c          |  67 +++++++++++++---
 block/blk-stat.h          |  15 +++-
 include/linux/blk_types.h |   9 +++
 include/linux/blkdev.h    |  17 +++-
 8 files changed, 271 insertions(+), 81 deletions(-)

-- 
2.21.0

