Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C365D3AB175
	for <lists+linux-block@lfdr.de>; Thu, 17 Jun 2021 12:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFQKi2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 17 Jun 2021 06:38:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28259 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229891AbhFQKi2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 06:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623926180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3ONmPrG8vHVlJq6XovLsbCTLRF9VPso1TVWYDfk7fxk=;
        b=V3FaEqa9cdtyZHGqqcp1fP5UIDp8rAES2wxmdsHj/l35pe6gCBHZm3llaXz/2cry4QAsWN
        6sboiRC6+H0gRNIqgIfpZ9GS+QL1Y+iREyFP1+rJ/VIyoOnnJW6AbJcbZ/9UNkpS7HDFad
        XKz9M3ocN0cnnFivmURpqyoo8Ufgz48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-4xY4JTq8PvGHQ9oKCh4uRA-1; Thu, 17 Jun 2021 06:36:19 -0400
X-MC-Unique: 4xY4JTq8PvGHQ9oKCh4uRA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B71308049CA;
        Thu, 17 Jun 2021 10:36:17 +0000 (UTC)
Received: from localhost (ovpn-12-77.pek2.redhat.com [10.72.12.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F8CC5C22A;
        Thu, 17 Jun 2021 10:35:57 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH V2 0/3] block/dm: support bio polling
Date:   Thu, 17 Jun 2021 18:35:46 +0800
Message-Id: <20210617103549.930311-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Guys,

Based on Christoph's bio based polling model[1], implement DM bio polling
with one very simple approach.

Patch 1 adds helper of blk_queue_poll().

Patch 2 adds .bio_poll() callback to block_device_operations, so bio
driver can implement its own logic for io polling.

Patch 3 implements bio polling for device mapper.

Any comments are welcome.

V2:
	- drop patch to add new fields into bio
	- support io polling for dm native bio splitting
	- add comment

Ming Lei (3):
  block: add helper of blk_queue_poll
  block: add ->poll_bio to block_device_operations
  dm: support bio polling

 block/blk-core.c         |  21 +++++---
 block/blk-sysfs.c        |   4 +-
 block/genhd.c            |   3 ++
 drivers/md/dm-table.c    |  24 +++++++++
 drivers/md/dm.c          | 111 +++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/core.c |   2 +-
 include/linux/blkdev.h   |   3 ++
 7 files changed, 155 insertions(+), 13 deletions(-)

-- 
2.31.1

