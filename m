Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFA7539D57
	for <lists+linux-block@lfdr.de>; Wed,  1 Jun 2022 08:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245204AbiFAGng (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 1 Jun 2022 02:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245200AbiFAGne (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 02:43:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B06B8E1BF
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 23:43:33 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AE9FB68AFE; Wed,  1 Jun 2022 08:43:29 +0200 (CEST)
Date:   Wed, 1 Jun 2022 08:43:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org,
        syzbot+3e3f419f4a7816471838@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: disable the elevator int del_gendisk
Message-ID: <20220601064329.GB22915@lst.de>
References: <20220531160535.3444915-1-hch@lst.de> <Ypa4xrAHUslpQPhN@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ypa4xrAHUslpQPhN@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 01, 2022 at 08:54:30AM +0800, Ming Lei wrote:
> This way can't be safe, who can guarantee that all sync submission
> activities are gone after queue is frozen? We had lots of reports on
> blk_mq_sched_has_work() which triggers UAF.

Yes, we probably need a blk_mq_quiesce_queue call like in the incremental
patch below.  Do you have any good reproducer, though?

diff --git a/block/genhd.c b/block/genhd.c
index 9914d0f24fecd..155b64ff991f6 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -652,9 +652,13 @@ void del_gendisk(struct gendisk *disk)
 	blk_mq_cancel_work_sync(q);
 
 	if (q->elevator) {
+		blk_mq_quiesce_queue(q);
+
 		mutex_lock(&q->sysfs_lock);
 		elevator_exit(q);
 		mutex_unlock(&q->sysfs_lock);
+
+		blk_mq_unquiesce_queue(q);
 	}
 
 	rq_qos_exit(q);
