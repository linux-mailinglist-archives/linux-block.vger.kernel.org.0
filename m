Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF6345B9F
	for <lists+linux-block@lfdr.de>; Fri, 14 Jun 2019 13:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfFNLoa (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 14 Jun 2019 07:44:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41555 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfFNLoa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 07:44:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so2182539wrm.8;
        Fri, 14 Jun 2019 04:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nfOL/QEZKCqwjy4s7vi3c4DFfSxvD/93w3BZ2MZj8Vk=;
        b=uX+dN39E3i0FIlS5Q321OQ/Ml+GopVkhaRtA0MOAhayeHrvd5so3euF27cf7H/Z5Ei
         GIqhyq/D9j1Nxkqn43pH1JIlHBQsWCfBcp7RBiLSX/3mKx6JWVaZZ9HHsD/rYwk6Ogar
         2bH5E/jYfTzaBsB7sEPA2q+Qgy45fLc0uQ4JSrZLBQMs45zYLbTGt79Hzh/KjBtvJIe4
         S5HzMUt9HyOKba9ccuFk2Xhc+hlcsIZfsvAyCvxWsXr3ADCe6WfetwaRr4QeOREkV6lA
         Pe3p+ISTmpo1cIvUho0yivmqAdaqJF8duYIu84mIjn3HUQSAJgYJ5e7ixUVkCsFZg62L
         qlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nfOL/QEZKCqwjy4s7vi3c4DFfSxvD/93w3BZ2MZj8Vk=;
        b=eGHkm6CvRfEVwQ3FhRgtST/xZar29f1vW2PhzbA+2dExgtkLToLnwEsiDUWhCAbSPc
         rIs2W/pzInHyPlXydVF45tPatU1ComCzuOV07+2qje88vLskCip1E7iJFAtQ4rwFMoeG
         9QaQYJcvigI/foT8d8EpHQ5sxIBS6jrJQAihOxbZOlTB7zPQc9WTbIVcYm4T3A/lEfS3
         oeKQVLRiGwK8WPrpHew2zGe/8KRM2FW11HweMe+n/MjLCxtE+cz832Gt0Fis/NLbU3zl
         x2dtf5ZdDHM+9Y4sq5djbDjrenXmjuAIMxrx4bB2ZzojcjoN71aN862UEfJSaOjIHjxJ
         C8iw==
X-Gm-Message-State: APjAAAUnH7Sf6XU2Vgl19xMRecE3fhzF3SgUaXQ9TVktgBn7SlLu/F6F
        LVbgzMDKgbNIbcMqQIPR9Qs=
X-Google-Smtp-Source: APXvYqzC0NHfeSRCuYRGy3eWWyCg/1pEvAHwAwn0YSXciR+vsSOL8YcgVHefJ+T3cMLSWpKuQXikbg==
X-Received: by 2002:a5d:6b12:: with SMTP id v18mr65017972wrw.306.1560512668442;
        Fri, 14 Jun 2019 04:44:28 -0700 (PDT)
Received: from localhost.localdomain ([185.107.117.129])
        by smtp.gmail.com with ESMTPSA id b14sm2955592wro.5.2019.06.14.04.44.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 04:44:27 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, josef@toxicpanda.com,
        dennis@kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 0/2] Fix misuse of blk_rq_stats in blk-iolatency
Date:   Fri, 14 Jun 2019 14:44:11 +0300
Message-Id: <cover.1560510935.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

There are implicit assumptions about struct blk_rq_stats, which make
it's very easy to misuse. The first patch fixes consequences, and the
second employs type-system to prevent recurrences.


Pavel Begunkov (2):
  blk-iolatency: Fix zero mean in previous stats
  blk-stats: Introduce explicit stat staging buffers

 block/blk-iolatency.c     | 60 ++++++++++++++++++++++++++++++---------
 block/blk-stat.c          | 48 +++++++++++++++++++++++--------
 block/blk-stat.h          |  9 ++++--
 include/linux/blk_types.h |  6 ++++
 4 files changed, 94 insertions(+), 29 deletions(-)

-- 
2.22.0

