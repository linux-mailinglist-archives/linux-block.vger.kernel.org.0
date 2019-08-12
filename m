Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F21589FF2
	for <lists+linux-block@lfdr.de>; Mon, 12 Aug 2019 15:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfHLNnb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 12 Aug 2019 09:43:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbfHLNnb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Aug 2019 09:43:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A5EFD30FB8F7;
        Mon, 12 Aug 2019 13:43:30 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41F8E5D6D0;
        Mon, 12 Aug 2019 13:43:26 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Minwoo Im <minwoo.im.dev@gmail.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH V2 0/5] blk-mq: improvement on handling IO during CPU hotplug
Date:   Mon, 12 Aug 2019 21:43:07 +0800
Message-Id: <20190812134312.16732-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 12 Aug 2019 13:43:30 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Thomas mentioned:
    "
     That was the constraint of managed interrupts from the very beginning:
    
      The driver/subsystem has to quiesce the interrupt line and the associated
      queue _before_ it gets shutdown in CPU unplug and not fiddle with it
      until it's restarted by the core when the CPU is plugged in again.
    "

But no drivers or blk-mq do that before one hctx becomes dead(all
CPUs for one hctx are offline), and even it is worse, blk-mq stills tries
to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead().

This patchset tries to address the issue by two stages:

1) add one new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE

- mark the hctx as internal stopped, and drain all in-flight requests
if the hctx is going to be dead.

2) re-submit IO in the state of CPUHP_BLK_MQ_DEAD after the hctx becomes dead

- steal bios from the request, and resubmit them via generic_make_request(),
then these IO will be mapped to other live hctx for dispatch

Please comment & review, thanks!

V2:
	- patch4 & patch 5 in V1 have been merged to block tree, so remove
	  them
	- address comments from John Garry and Minwoo


Ming Lei (5):
  blk-mq: add new state of BLK_MQ_S_INTERNAL_STOPPED
  blk-mq: add blk-mq flag of BLK_MQ_F_NO_MANAGED_IRQ
  blk-mq: stop to handle IO before hctx's all CPUs become offline
  blk-mq: re-submit IO in case that hctx is dead
  blk-mq: handle requests dispatched from IO scheduler in case that hctx
    is dead

 block/blk-mq-debugfs.c     |   2 +
 block/blk-mq-tag.c         |   2 +-
 block/blk-mq-tag.h         |   2 +
 block/blk-mq.c             | 143 +++++++++++++++++++++++++++++++++----
 block/blk-mq.h             |   3 +-
 drivers/block/loop.c       |   2 +-
 drivers/md/dm-rq.c         |   2 +-
 include/linux/blk-mq.h     |   5 ++
 include/linux/cpuhotplug.h |   1 +
 9 files changed, 146 insertions(+), 16 deletions(-)

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Keith Busch <keith.busch@intel.com>
-- 
2.20.1

