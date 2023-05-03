Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23BB6F617F
	for <lists+linux-block@lfdr.de>; Thu,  4 May 2023 00:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjECWwQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 3 May 2023 18:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjECWwP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 18:52:15 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1969F44B6
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 15:52:14 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1aaf21bb427so31963225ad.1
        for <linux-block@vger.kernel.org>; Wed, 03 May 2023 15:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683154333; x=1685746333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vDcymp3JnX1nkbupbRK2c50ONFnxz7pe2P6XHkvRwtg=;
        b=gmpdEK6sfTkOAAAJYM+btD+7eXeYVecBW7hVlhrdlQFji1Wg1/nXR0txS+ncKcwird
         QEHBHtBGNbufBM7GkCCzfDO8LsqwfmAZUvHcAOQ0j8vMor8Vud20flgPQMfd3BDzEZRK
         z4h11NEzEABm0HPeQMbwRTU5en+DipYtqUHurZKz1TtYgWFLfV7PoyrRyVzOyxpDQadh
         kekRTpDuHOjjvUnPOLlwcz0pEN44WZr9qQ81OAQmNlIkFDAksts4Gd0/vnW6z7AuPd8/
         WcURUPnr+l0OLaPY1NtAdWLSYpQqqDWt6XIRLayTrkmdEP/Gf7nQaEM/ul+VwrNrVoMY
         i9Wg==
X-Gm-Message-State: AC+VfDzpW+2haDGHUS/x96EiYztnNZ3jNCpSo+/tmfaoTs0Qg7nUp5Ue
        cqml+72bR3l//9kGWJNEPlSrs4NpzAY=
X-Google-Smtp-Source: ACHHUZ4n65rwztRq7VKYunaO0TuSKJEPdb955WHdhYWc5xMW9r18X4VR/wd46QgIs7CwObrygUfiLA==
X-Received: by 2002:a17:902:e883:b0:1ab:a30:c89d with SMTP id w3-20020a170902e88300b001ab0a30c89dmr1967947plg.51.1683154333315;
        Wed, 03 May 2023 15:52:13 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:2c3b:81e:ce21:2437])
        by smtp.gmail.com with ESMTPSA id e3-20020a170902744300b001aad4be4503sm227085plt.2.2023.05.03.15.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 15:52:12 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v4 00/11] mq-deadline: Improve support for zoned block devices
Date:   Wed,  3 May 2023 15:51:57 -0700
Message-ID: <20230503225208.2439206-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patch series improves support for zoned block devices in the mq-deadline
scheduler by preserving the order of requeued writes (REQ_OP_WRITE*).

Please consider this patch series for the next merge window.

Thank you,

Bart.

Changes compared to v3:
- Addressed Christoph's review feedback.
- Dropped patch "block: Micro-optimize blk_req_needs_zone_write_lock()".
- Added three new patches:
  * block: Fix the type of the second bdev_op_is_zoned_write() argument
  * block: Introduce op_is_zoned_write()
  * block: mq-deadline: Reduce lock contention

Changes compared to v2:
- In the patch that micro-optimizes blk_req_needs_zone_write_lock(), inline
  bdev_op_is_zoned_write() instead of modifying it.
- In patch "block: Introduce blk_rq_is_seq_zoned_write()", converted "case
  REQ_OP_ZONE_APPEND" into a source code comment.
- Reworked deadline_skip_seq_writes() as suggested by Christoph.
- Dropped the patch that disabled head insertion for zoned writes.
- Dropped patch "mq-deadline: Fix a race condition related to zoned writes".
- Reworked handling of requeued requests: the 'next_rq' pointer has been
  removed and instead the position of the most recently dispatched request is
  tracked.
- Dropped the patches for tracking zone capacity and for restricting the number
  of active zones.

Changes compared to v1:
- Left out the patches related to request insertion and requeuing since
  Christoph is busy with reworking these patches.
- Added a patch for enforcing the active zone limit.

Bart Van Assche (11):
  block: Simplify blk_req_needs_zone_write_lock()
  block: Fix the type of the second bdev_op_is_zoned_write() argument
  block: Introduce op_is_zoned_write()
  block: Introduce blk_rq_is_seq_zoned_write()
  block: mq-deadline: Clean up deadline_check_fifo()
  block: mq-deadline: Simplify deadline_skip_seq_writes()
  block: mq-deadline: Improve deadline_skip_seq_writes()
  block: mq-deadline: Reduce lock contention
  block: mq-deadline: Track the dispatch position
  block: mq-deadline: Handle requeued requests correctly
  block: mq-deadline: Fix handling of at-head zoned writes

 block/blk-zoned.c      |  20 +++++---
 block/mq-deadline.c    | 114 +++++++++++++++++++++++++++++------------
 include/linux/blk-mq.h |   6 +++
 include/linux/blkdev.h |  13 +++--
 4 files changed, 107 insertions(+), 46 deletions(-)

