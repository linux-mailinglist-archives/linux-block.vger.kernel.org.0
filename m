Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 256292E7C4
	for <lists+linux-block@lfdr.de>; Thu, 30 May 2019 00:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfE2WHi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 May 2019 18:07:38 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40017 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfE2WHh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 18:07:37 -0400
Received: by mail-qk1-f196.google.com with SMTP id c70so2531424qkg.7
        for <linux-block@vger.kernel.org>; Wed, 29 May 2019 15:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ADNiCc3uXydWqkLdhpeHyzs+JqBudE9giKLME48I/hk=;
        b=QeaKogr3q0Rw05MAUVTGuzyY7eR6yL2SULD/8+pOUeL7dY2AALRx9rf2h1JpZwZa8d
         xaG6+25B6WsQD9+E/a5UxvVx2uf5f9zkbFlmZaBqoK3s53n7RE7HMxndh0rQvjEag7JA
         N5+qJD9Ametk9uLrXbgkgPwLjZVQQGbEgO1a/F9MXgxS13cjFtxGK2vf68I2R+vCAMyr
         kkqkrrZ8g3FQXQxPPrLizAIgJ36jC4MvW3vLq8+/vhcQYspCsotTJ/o9JMmth9dQBbrO
         7ok0Xth92CLZxkwgzEbxqDsNBPL3XMM19FpJBWfkIPoZTSp42JtPrJkgcOI6A5YK5QLG
         eDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ADNiCc3uXydWqkLdhpeHyzs+JqBudE9giKLME48I/hk=;
        b=MOuxJQ1Jr4AED/A6E5NVCUVu3xCpAbS2Qtgp9BLr7zUtyXIeBhw0GBxADSzbcqPhJK
         mSdRYpLWIwQyiQIR+33CH3+qbirQNtHgfl9XnlnU9xWUfZW1lPKPeT5mRkxQDP09lFDE
         m+iH0VXGKRbnhH0U4hJp4UMlwgY7Z0L0mQ+fXv8lsh6+15Iwj2DdehUK3QItSy0uszTa
         jIpdVKG46L317esqzeyT+HMNa2cJzFfEOoid+SQN1cKg0dMO4/6VW72aOkHy16SijCYq
         qhsGMJz5Ki+gncTW2HTUpnUuT86GcohBwW6aKjJV+eEB1G75sQwc/gmroSsprXDdIJRd
         C3kA==
X-Gm-Message-State: APjAAAVYiDnheQdsCMj/+tvQxYRdQvjViKmzxADVLwa+3yA6ixTqtpev
        kFJ6axrcg6MMlpsEkzFgQ04xzq5K
X-Google-Smtp-Source: APXvYqzVRpDIrFcNZicNhXLkcj4fbOr1O9qvvgHk85qg5Be1UiBnkT8TRNAXunozgYPCuWmIz/s7Nw==
X-Received: by 2002:a05:620a:14ba:: with SMTP id x26mr146040qkj.328.1559167656483;
        Wed, 29 May 2019 15:07:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:60e4])
        by smtp.gmail.com with ESMTPSA id z200sm428792qka.7.2019.05.29.15.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 15:07:35 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, jbacik@toxicpanda.com, kernel-team@fb.com
Subject: [PATCH v2 0/5] blk-mq queue stats
Date:   Wed, 29 May 2019 18:07:25 -0400
Message-Id: <20190529220730.28014-1-Jes.Sorensen@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jes Sorensen <jsorensen@fb.com>

Hi,

This patchset adds per-device histogram statistics of read, write, and
discard request sizes, as well as number of requests for each
bucket. It uses the blk-stat infrastructure and only collects stats
for devices for which it has been explicitly enabled by writing 1 to
/sys/block/<dev>/queue/histstat

In addition it builds on top of two patches I recklessly stole from
Josef - thanks!

Thoughts or oppinions on this approach? I am not married to the
naming, so happy to change that if wanted.

v2 updated to apply against 5.2-rc2

Thanks,
Jes


Jes Sorensen (3):
  Use blk-stat infrastructure to collect per queue device stats
  Export block dev stats to sysfs
  Expand block stats to export number of of requests per bucket

Josef Bacik (2):
  blk-stat: rename batch to time
  block: keep track of per-device io sizes in stats

 block/blk-iolatency.c     |  2 +-
 block/blk-mq.c            | 56 ++++++++++++++++++++++++++++--
 block/blk-stat.c          | 16 +++++----
 block/blk-stat.h          |  3 +-
 block/blk-sysfs.c         | 71 +++++++++++++++++++++++++++++++++++++++
 block/blk-throttle.c      |  3 +-
 include/linux/blk_types.h |  3 +-
 include/linux/blkdev.h    | 12 +++++--
 8 files changed, 149 insertions(+), 17 deletions(-)

-- 
2.17.1

