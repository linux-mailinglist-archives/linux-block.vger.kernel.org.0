Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9AF29FB86
	for <lists+linux-block@lfdr.de>; Fri, 30 Oct 2020 03:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgJ3CnS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 29 Oct 2020 22:43:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28977 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbgJ3CnR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 22:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604025796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HdTqH5mYV4Nz0Vn26Z9mWS/VC2TGEAEI5hg/xR1dv7Q=;
        b=i/aYbM7496KTHtz5CRfBCJNMKjb9yFi+7AEFqRNibmZcbBwgNC6FRdEQLFolwoUwZz+/Dj
        YuP3AHPwuXqXi2doAO1XZiYJJy0FF7WOPnXE52WTp2Ew9QL+3JOKuokRfHGgRbQlWGBeG1
        NJTJoKC8SKuCOPzmO9wApJBC1QSf1jg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-uijZXzwyO1yxUFOY_hO6_A-1; Thu, 29 Oct 2020 22:43:14 -0400
X-MC-Unique: uijZXzwyO1yxUFOY_hO6_A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E6032FD0D;
        Fri, 30 Oct 2020 02:43:13 +0000 (UTC)
Received: from localhost (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FC755B4A9;
        Fri, 30 Oct 2020 02:43:00 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Chao Leng <lengchao@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] blk-mq: mark flush request as IDLE in flush_end_io()
Date:   Fri, 30 Oct 2020 10:42:53 +0800
Message-Id: <20201030024253.2025932-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Mark flush request as IDLE in its .end_io() for aligning to normal request since
flush request stays in in-flight tags in case of !elevator, so we need to change
its state into IDLE. Otherwise, we will hang in blk_mq_tagset_wait_completed_request()
during error recovery because flush request's state is kept as COMPLETE.

Cc: Chao Leng <lengchao@huawei.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-flush.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 53abb5c73d99..e32958f0b687 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -225,6 +225,7 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 	/* release the tag's ownership to the req cloned from */
 	spin_lock_irqsave(&fq->mq_flush_lock, flags);
 
+	WRITE_ONCE(flush_rq->state, MQ_RQ_IDLE);
 	if (!refcount_dec_and_test(&flush_rq->ref)) {
 		fq->rq_status = error;
 		spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
-- 
2.25.2

