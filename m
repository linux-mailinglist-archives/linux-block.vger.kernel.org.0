Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A05A178F0C
	for <lists+linux-block@lfdr.de>; Wed,  4 Mar 2020 11:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387801AbgCDK7J (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 4 Mar 2020 05:59:09 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:55391 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387805AbgCDK7I (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 05:59:08 -0500
X-Originating-IP: 176.88.145.204
Received: from localhost.localdomain (unknown [176.88.145.204])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 9B91560009;
        Wed,  4 Mar 2020 10:59:03 +0000 (UTC)
From:   Cengiz Can <cengiz@kernel.wtf>
To:     Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cengiz Can <cengiz@kernel.wtf>
Subject: [PATCH v2] blktrace: fix dereference after null check
Date:   Wed,  4 Mar 2020 13:58:19 +0300
Message-Id: <20200304105818.11781-1-cengiz@kernel.wtf>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There was a recent change in blktrace.c that added a RCU protection to
`q->blk_trace` in order to fix a use-after-free issue during access.

However the change missed an edge case that can lead to dereferencing of
`bt` pointer even when it's NULL:

Coverity static analyzer marked this as a FORWARD_NULL issue with CID
1460458.

```
/kernel/trace/blktrace.c: 1904 in sysfs_blk_trace_attr_store()
1898            ret = 0;
1899            if (bt == NULL)
1900                    ret = blk_trace_setup_queue(q, bdev);
1901
1902            if (ret == 0) {
1903                    if (attr == &dev_attr_act_mask)
>>>     CID 1460458:  Null pointer dereferences  (FORWARD_NULL)
>>>     Dereferencing null pointer "bt".
1904                            bt->act_mask = value;
1905                    else if (attr == &dev_attr_pid)
1906                            bt->pid = value;
1907                    else if (attr == &dev_attr_start_lba)
1908                            bt->start_lba = value;
1909                    else if (attr == &dev_attr_end_lba)
```

Added a reassignment with RCU annotation to fix the issue.

Fixes: c780e86dd48 ("blktrace: Protect q->blk_trace with RCU")

Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
---

    Patch Changelog
    * v2: Added RCU annotation to assignment

 kernel/trace/blktrace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 4560878f0bac..ca39dc3230cb 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1896,8 +1896,11 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 	}

 	ret = 0;
-	if (bt == NULL)
+	if (bt == NULL) {
 		ret = blk_trace_setup_queue(q, bdev);
+		bt = rcu_dereference_protected(q->blk_trace,
+				lockdep_is_held(&q->blk_trace_mutex));
+	}

 	if (ret == 0) {
 		if (attr == &dev_attr_act_mask)
--
2.25.1

