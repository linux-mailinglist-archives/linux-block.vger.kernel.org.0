Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E162C8BF1
	for <lists+linux-block@lfdr.de>; Mon, 30 Nov 2020 19:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgK3SBu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 30 Nov 2020 13:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgK3SBt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 13:01:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882F8C0613D2;
        Mon, 30 Nov 2020 10:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=f5RjujYTKMxq2LKGVVTVa+ZNCdWnMtWx1Vlp5DyU9Mo=; b=lHxLlVdpjKRVIz/PwYV3hn5nPp
        jjSgsXvIt2HuEHrqNKUAnb5KEaUMDo8hebbMKVfgx4rF2diDyxMXlha07e8LiKl28Mfas8zdaZA3c
        0KD+32ubCMfEQT8JHuZ0IXfPTcCbCdi6rdoGnyvqpFAolWyFoqySScTcy/Z/mWBVuI4j2MfZkVGF6
        9MYE/hYHUltVAXF+/TTdmnj6Y5dBE3vwrrCoGD8CCff3X4ecpwhVndBkUs5mIVgmo9iZSfjMUoNNZ
        k5F6Y90cj/cid5As6XiIsu7QjO+hMy9p756BoTDuqgbmgj/RhQNWWOuMqyQl7YGUsa3qqurQ1wmWt
        aRAm9T+A==;
Received: from 089144198196.atnat0007.highway.a1.net ([89.144.198.196] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjnU2-0006Rv-GW; Mon, 30 Nov 2020 18:01:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-s390@vger.kernel.org
Subject: block tracepoint cleanups
Date:   Mon, 30 Nov 2020 18:58:49 +0100
Message-Id: <20201130175854.982460-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series cleans up the block layer tracepoints by removing unused
tracepoints or tracepoint arguments and consolidating the implementation
of various bio based tracepoints.

Diffstat:
 block/blk-core.c              |    4 
 block/blk-merge.c             |    8 -
 block/blk-mq-sched.c          |    2 
 block/blk-mq.c                |   10 -
 block/bounce.c                |    2 
 drivers/md/dm-rq.c            |    2 
 drivers/md/dm.c               |    5 
 drivers/md/md-linear.c        |    3 
 drivers/md/md.c               |    5 
 drivers/md/raid0.c            |    4 
 drivers/md/raid1.c            |    7 -
 drivers/md/raid10.c           |    6 -
 drivers/md/raid5.c            |   15 +-
 drivers/nvme/host/multipath.c |    3 
 drivers/s390/scsi/zfcp_fsf.c  |    3 
 include/linux/blktrace_api.h  |    5 
 include/trace/events/block.h  |  228 +++++++++---------------------------------
 kernel/trace/blktrace.c       |  126 ++++++-----------------
 18 files changed, 125 insertions(+), 313 deletions(-)
