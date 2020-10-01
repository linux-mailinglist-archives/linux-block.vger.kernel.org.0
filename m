Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2B128032C
	for <lists+linux-block@lfdr.de>; Thu,  1 Oct 2020 17:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbgJAPtt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 1 Oct 2020 11:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30863 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732590AbgJAPtn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Oct 2020 11:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601567382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EbzAX+YvEvHOO3NGqM8YXZj1EdlAEAqHUR00Ej4MfhM=;
        b=U3EeE6A8ZSYUly3eYsp5I25hhHxK5PMUJqc9swCNaj+GL4U3kfjJMqgsoEUT0ozIoBJTcN
        2gf9QBN1G4fLvRx/FZ4CkShloO8+tDOyO1Z76//bZ2h22YlW3QaZY28Rpr4zUdJAaZS0Bx
        Sk/lun4JrLVEhA4hmf/1zfYNDUFkmKQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-xCk5aG_QNSaf-emfrz6JHA-1; Thu, 01 Oct 2020 11:49:38 -0400
X-MC-Unique: xCk5aG_QNSaf-emfrz6JHA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3C2C1009639;
        Thu,  1 Oct 2020 15:49:31 +0000 (UTC)
Received: from localhost (ovpn-12-47.pek2.redhat.com [10.72.12.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F3D684C20;
        Thu,  1 Oct 2020 15:49:30 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V7 2/2] block: move 'q_usage_counter' into front of 'request_queue'
Date:   Thu,  1 Oct 2020 23:48:42 +0800
Message-Id: <20201001154842.26896-3-ming.lei@redhat.com>
In-Reply-To: <20201001154842.26896-1-ming.lei@redhat.com>
References: <20201001154842.26896-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The field of 'q_usage_counter' is always fetched in fast path of every
block driver, and move it into front of 'request_queue', so it can be
fetched into 1st cacheline of 'request_queue' instance.

Tested-by: Veronika Kabatova <vkabatov@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blkdev.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d5a3e1a4c2f7..67935b3bef6c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -397,6 +397,8 @@ struct request_queue {
 	struct request		*last_merge;
 	struct elevator_queue	*elevator;
 
+	struct percpu_ref	q_usage_counter;
+
 	struct blk_queue_stats	*stats;
 	struct rq_qos		*rq_qos;
 
@@ -569,7 +571,6 @@ struct request_queue {
 	 * percpu_ref_kill() and percpu_ref_reinit().
 	 */
 	struct mutex		mq_freeze_lock;
-	struct percpu_ref	q_usage_counter;
 
 	struct blk_mq_tag_set	*tag_set;
 	struct list_head	tag_set_list;
-- 
2.25.2

