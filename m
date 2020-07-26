Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C0122DAC7
	for <lists+linux-block@lfdr.de>; Sun, 26 Jul 2020 02:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgGZAXF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 25 Jul 2020 20:23:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42495 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbgGZAXF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 25 Jul 2020 20:23:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id 1so7175961pfn.9
        for <linux-block@vger.kernel.org>; Sat, 25 Jul 2020 17:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zov0rmybKEV0FzMtRbguhfxoEydQHEwBnfQeWkxGBD4=;
        b=ruUauENArFDjX9lHkK2XEBxb+eZCSWutC+qODYjUzs7Y8jqzvt02gjzyy5lthO+CTZ
         mv8Tqf1Qzn68WixuirItEu9RKxz2YjKsYyYxP1SrjSSN9sf7WjkU1PG0kWYQikoMz4of
         Mi+bONu6w6+xdzcGUaK6IDwgOqArLbSV8pvSduWSPAI4gJtBKtZiZFXCmjQpHzBuQgH9
         GAup4d5cMWQ9Ku0W1rTQiHZi6HjdqGjFXpk2FYRj9VHZ8K0YHvmUBYGqIXXwvkXnTBU9
         VTAW1bmEVBYUQAaAcNBeE6LcV/od7Q++WkwRwb4bgTpVErVf3o5bN2PRZs4lEy4wWBmF
         9UwA==
X-Gm-Message-State: AOAM530ym6icyMH6FrNEl+OsSTboavGP2tWTl7cJ1Gky2EbQQ65guCKL
        MkmhZLGZ+BOzPBS3j3oJzoY2hoX+
X-Google-Smtp-Source: ABdhPJwcEDqhV+qtgHezjEOLgjMywYa8dBy4Jvq5qgrInC1mzqtKrpsIJjl6TpwgAP5K6EXMsIJeXg==
X-Received: by 2002:a63:4419:: with SMTP id r25mr13648955pga.198.1595722984965;
        Sat, 25 Jul 2020 17:23:04 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net ([2601:647:4802:9070:c428:8d39:30dd:38a5])
        by smtp.gmail.com with ESMTPSA id z62sm10185620pfb.47.2020.07.25.17.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 17:23:04 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>
Subject: [PATCH v3 0/2] improve quiesce time for large amount of namespaces
Date:   Sat, 25 Jul 2020 17:22:59 -0700
Message-Id: <20200726002301.145627-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This set attempts to improve the quiesce time when using a large set of
namespaces, which also improves I/O failover time in a multipath environment.

We improve for both non-blocking hctxs (e.g. pci, fc, rdma) and blocking
hctxs (e.g. tcp) by splitting queue auiesce to async call_(s)rcu and
async_wait to wait for it to complete.

Changes from v2:
- made blk_mq_quiesce_queue_async operate on both blocking and
  non-blocking hctxs.
- removed separation between blocking vs. non-blocking queues
- dropeed patch from Chao
- dropped nvme-rdma test patch

Changes from v1:
- trivial typo fixes

Sagi Grimberg (2):
  blk-mq: add async quiesce interface
  nvme: improve quiesce time for large amount of namespaces

 block/blk-mq.c           | 32 ++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c |  4 +++-
 include/linux/blk-mq.h   |  4 ++++
 3 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.25.1

