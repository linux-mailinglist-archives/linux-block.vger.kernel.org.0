Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BE27853CC
	for <lists+linux-block@lfdr.de>; Wed, 23 Aug 2023 11:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbjHWJZB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 23 Aug 2023 05:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbjHWJMJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Aug 2023 05:12:09 -0400
Received: from out-38.mta0.migadu.com (out-38.mta0.migadu.com [91.218.175.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A410BE54
        for <linux-block@vger.kernel.org>; Wed, 23 Aug 2023 02:05:02 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692781500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wjRgHpRn/Mi1kte2oU8yzlTkPSWTeowZKAuYRZmUUt4=;
        b=NGZSwtJIqW9YiG7QkogGParOqmBK3DQXG/4Jm3I1UUNPJKMlj81KwMCNkjLnJzKVM3z7Xs
        7y4bpA4eD0bfh6g7E0lot80JxKq+YInku6Ht/+rNBgPo7rQKSlxQeinP8WWXn3pwrk+/q3
        Arn8Oxobq/IFo9BvYDevQEER5ZxRCpA=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, bvanassche@acm.org,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v2 0/6] blk-mq-tag: remove bt_for_each()
Date:   Wed, 23 Aug 2023 17:04:35 +0800
Message-ID: <20230823090441.3986631-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Changes in v2:
  - Split by one change per patch and add Fixes tag.
  - Improve commit messages, suggested by Bart Van Assche.

There are two almost identical mechanisms in blk-mq-tag to iterate over
requests of one tags: bt_for_each() and the newer bt_tags_for_each().

This series aim to add support of queue filter in bt_tags_for_each()
then remove bt_for_each(). Fix and update documentation as we're here.

Thanks for review!

Chengming Zhou (6):
  blk-mq-tag: support queue filter in bt_tags_iter()
  blk-mq-tag: introduce __blk_mq_tagset_busy_iter()
  blk-mq-tag: remove bt_for_each()
  blk-mq: delete superfluous check in iterate callback
  blk-mq-tag: fix functions documentation
  blk-mq-tag: fix blk_mq_queue_tag_busy_iter() documentation

 block/blk-mq-tag.c | 176 ++++++++++++---------------------------------
 block/blk-mq.c     |  12 ++--
 2 files changed, 49 insertions(+), 139 deletions(-)

-- 
2.41.0

