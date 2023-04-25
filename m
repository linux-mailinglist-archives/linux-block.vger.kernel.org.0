Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BD76EE16A
	for <lists+linux-block@lfdr.de>; Tue, 25 Apr 2023 13:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjDYLzC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 25 Apr 2023 07:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbjDYLzA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Apr 2023 07:55:00 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDB212CAB;
        Tue, 25 Apr 2023 04:54:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q5L5W1nqgz4f42YX;
        Tue, 25 Apr 2023 19:54:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbF+v0dkGEZ+IA--.20559S4;
        Tue, 25 Apr 2023 19:54:40 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     logang@deltatee.com, axboe@kernel.dk, song@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next v7 0/5] md: protect md_thread with rcu
Date:   Tue, 25 Apr 2023 19:52:51 +0800
Message-Id: <20230425115256.3663932-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbF+v0dkGEZ+IA--.20559S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4rXrW3GF15GFWfGr48JFb_yoW8AFy8pr
        WagFZxZw4UCrsxZFsxZ342ka45G3WrGay7KryxA3yrZa45uFyUJr4UJFykuF9rWFyfJa9F
        qF15Jr1DCF10yaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        fUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Changes in v7:
 - add missing changes for md-cluster
 - rebase for the latest md-next branch

Changes in v6:
 - remove first patch from v5, and use rcu_asign_pointer() directly from
 caller.
 - always use rcu_read_lock/unlock to protect mddev_set_timeout().

Changes in v5:
 - use rcu_dereference_protected() instead of rcu_access_pointer() where
 rcu_read_lock/unlock is not required.
 - add patch 4,5 to handle that bitmap timeout is set multiple times.

Changes in v4:
 - remove patch 2 from v3
 - fix sparse errors and warnings from v3, in order to do that, all access
 to md_thread need to be modified, patch 2-4 is splited to avoid a huge
 patch.

Changes in v3:
 - remove patch 3 from v2
 - use rcu instead of a new lock

Changes in v2:
 - fix a compile error for md-cluster in patch 2
 - replace spin_lock/unlock with spin_lock/unlock_irq in patch 5
 - don't wake up inside the new lock in md wakeup_thread in patch 5

Yu Kuai (5):
  md: factor out a helper to wake up md_thread directly
  dm-raid: remove useless checking in raid_message()
  md/bitmap: always wake up md_thread in timeout_store
  md/bitmap: factor out a helper to set timeout
  md: protect md_thread with rcu

 block/blk-cgroup.c        |  3 ++
 drivers/md/dm-raid.c      |  4 +-
 drivers/md/md-bitmap.c    | 43 +++++++++++--------
 drivers/md/md-cluster.c   | 17 +++++---
 drivers/md/md-multipath.c |  4 +-
 drivers/md/md.c           | 88 +++++++++++++++++++++------------------
 drivers/md/md.h           |  8 ++--
 drivers/md/raid1.c        |  7 ++--
 drivers/md/raid1.h        |  2 +-
 drivers/md/raid10.c       | 20 +++++----
 drivers/md/raid10.h       |  2 +-
 drivers/md/raid5-cache.c  | 22 ++++++----
 drivers/md/raid5.c        | 15 +++----
 drivers/md/raid5.h        |  2 +-
 14 files changed, 135 insertions(+), 102 deletions(-)

-- 
2.39.2

