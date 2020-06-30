Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A53820F6B3
	for <lists+linux-block@lfdr.de>; Tue, 30 Jun 2020 16:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgF3OGG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 30 Jun 2020 10:06:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50184 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727796AbgF3OGG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 10:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593525965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lnRRuli2c/6CcTb+I8aj/A1f/tKEw3CM/UGazu1DzkA=;
        b=c++jsfkkGZMwpuDdbBDiqVrh0Fy8EFEa8TCnI529vfbPtaTeLjK2slViqmxGwYwvX6Z5jr
        L77Lr+iyVxOHKN+XpMDnHo5LZlZBzqO7lQ2Fe4MAdN9LjfIVt/j4ramKyiE4Ccw5bTIJv8
        rviR24P67A8mTyz2xFeVrGIFxwKD+/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-IREeywvaPzSFDCmTBft3jQ-1; Tue, 30 Jun 2020 10:05:58 -0400
X-MC-Unique: IREeywvaPzSFDCmTBft3jQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A841775E87;
        Tue, 30 Jun 2020 14:04:06 +0000 (UTC)
Received: from localhost (ovpn-13-98.pek2.redhat.com [10.72.13.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E22BB2B472;
        Tue, 30 Jun 2020 14:04:02 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V3 0/3] blk-mq: driver tag related cleanup
Date:   Tue, 30 Jun 2020 22:03:54 +0800
Message-Id: <20200630140357.2251174-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

The 1st & 2nd patch moves get/put driver tag helpers into blk-mq.c, and
the 3rd patch centralise related handling into blk_mq_get_driver_tag,
so both flush & blk-mq code get simplified.

V3:
	- rebase on latest for-5.9/block, only 3/3 is changed.

V2:
	- add reviewed-by tag
	- don't put blk_mq_tag_busy() into blk_mq_get_driver_tag
	- use BLK_MQ_NO_TAG in blk-flush.c

Ming Lei (3):
  blk-mq: move blk_mq_get_driver_tag into blk-mq.c
  blk-mq: move blk_mq_put_driver_tag() into blk-mq.c
  blk-mq: centralise related handling into blk_mq_get_driver_tag

 block/blk-flush.c  | 17 +++++-------
 block/blk-mq-tag.c | 58 ----------------------------------------
 block/blk-mq-tag.h | 41 +++++++++++++++++-----------
 block/blk-mq.c     | 66 +++++++++++++++++++++++++++++++++++++++++-----
 block/blk-mq.h     | 20 --------------
 block/blk.h        |  5 ----
 6 files changed, 91 insertions(+), 116 deletions(-)

Cc: Christoph Hellwig <hch@infradead.org>
-- 
2.25.2

