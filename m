Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C905AC1A04
	for <lists+linux-block@lfdr.de>; Mon, 30 Sep 2019 03:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfI3Bw2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 29 Sep 2019 21:52:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64553 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729010AbfI3Bw2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Sep 2019 21:52:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C1AA81F07;
        Mon, 30 Sep 2019 01:52:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.70.39.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC0365D9C3;
        Mon, 30 Sep 2019 01:52:23 +0000 (UTC)
From:   xiubli@redhat.com
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     mchristi@redhat.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v4 0/2] blk-mq: Avoid memory reclaim when allocating
Date:   Mon, 30 Sep 2019 07:22:11 +0530
Message-Id: <20190930015213.8865-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 30 Sep 2019 01:52:28 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

Changed in V2:
- Addressed the comment from Ming Lei, thanks.

Changed in V3:
- Switch to memalloc_noio_save/restore from Christoph's comment, thanks.

Changed in V4:
- Switch back to v2 by remove the memalloc_ stuff
- With a small fix by making all the gfp flags to BLK_MQ_GFP_FLAGS in
blk_mq_alloc_rq_map where the NOIO is needed.

Xiubo Li (2):
  blk-mq: Avoid memory reclaim when allocating request map
  blk-mq: use BLK_MQ_GFP_FLAGS macro instead

 block/blk-mq-tag.c |  5 +++--
 block/blk-mq-tag.h |  5 ++++-
 block/blk-mq.c     | 20 +++++++++++---------
 3 files changed, 18 insertions(+), 12 deletions(-)

-- 
2.21.0

