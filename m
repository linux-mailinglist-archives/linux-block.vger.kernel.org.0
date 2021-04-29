Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABDE36E34A
	for <lists+linux-block@lfdr.de>; Thu, 29 Apr 2021 04:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhD2Cfm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 28 Apr 2021 22:35:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20674 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229718AbhD2Cfm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 22:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619663696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YsMow13UhOcKvFHYPwloP19yU+1zaEDGD3xs35xsQSo=;
        b=gAi40KW2jFvBjJoHfp+qfpBBu3ZoQKpEKEwISycuRN2+M6Lh+5EHymrSmDc6P5DDrlUxDM
        v0pebOZr2+FDBYyLHT3Au9VwRzwnv/Ngf1+1LrVVTNQ0u/loHFal5Vcf3beQG+NYSigFqI
        a77lhNKOTPjNDvVS73bg6uEuxMBeY64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-KA6l1JNUMbeTxje6CjkKFw-1; Wed, 28 Apr 2021 22:34:54 -0400
X-MC-Unique: KA6l1JNUMbeTxje6CjkKFw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51DFF501E3;
        Thu, 29 Apr 2021 02:34:53 +0000 (UTC)
Received: from localhost (ovpn-12-135.pek2.redhat.com [10.72.12.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 051866A251;
        Thu, 29 Apr 2021 02:34:48 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 0/4] blk-mq: fix request UAF related with iterating over tagset requests
Date:   Thu, 29 Apr 2021 10:34:54 +0800
Message-Id: <20210429023458.3044317-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patchset fixes the request UAF issue by one simple approach,
without clearing ->rqs[] in fast path.

1) grab request's ref before calling ->fn in blk_mq_tagset_busy_iter,
and release it after calling ->fn, so ->fn won't be called for one
request if its queue is frozen, done in 2st patch

2) clearing any stale request referred in ->rqs[] before freeing the
request pool, one per-tags spinlock is added for protecting
grabbing request ref vs. clearing ->rqs[tag], so UAF by refcount_inc_not_zero
in bt_tags_iter() is avoided, done in 3rd patch.


V4:
	- remove hctx->fq-flush_rq from tags->rqs[] before freeing hw queue,
	patch 4/4 is added, which is based on David's patch.

V3:
	- drop patches for completing requests started in iterator ->fn,
	  because blk-mq guarantees that valid request is passed to ->fn,
	  and it is driver's responsibility for avoiding double completion.
	  And drivers works well for not completing rq twice.
	- add one patch for avoiding double accounting of flush rq 

V2:
	- take Bart's suggestion to not add blk-mq helper for completing
	  requests when it is being iterated
	- don't grab rq->ref if the iterator is over static rqs because
	the use case do require to iterate over all requests no matter if
	the request is initialized or not



Ming Lei (4):
  block: avoid double io accounting for flush request
  blk-mq: grab rq->refcount before calling ->fn in
    blk_mq_tagset_busy_iter
  blk-mq: clear stale request in tags->rq[] before freeing one request
    pool
  blk-mq: clearing flush request reference in tags->rqs[]

 block/blk-flush.c  |  3 +-
 block/blk-mq-tag.c | 29 +++++++++++++----
 block/blk-mq-tag.h |  3 ++
 block/blk-mq.c     | 77 +++++++++++++++++++++++++++++++++++++++-------
 block/blk-mq.h     |  1 +
 5 files changed, 94 insertions(+), 19 deletions(-)

-- 
2.29.2

