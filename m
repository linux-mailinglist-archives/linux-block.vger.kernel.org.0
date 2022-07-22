Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C64A57DCB8
	for <lists+linux-block@lfdr.de>; Fri, 22 Jul 2022 10:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbiGVIqg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 22 Jul 2022 04:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbiGVIqU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 04:46:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87FD79FE1E
        for <linux-block@vger.kernel.org>; Fri, 22 Jul 2022 01:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658479564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LBPMxK58eeFaYZO+mDr7jxmrJ7sT7p546GJgjwMsEZ0=;
        b=auD8d1iZ9ingmXS9t96wVXkjsugwNz87SZRLGwSW7cY/1HbRuTss5BHF4QVnhLdvc81L4V
        Ys2dHVjTpP2flmWAnHDavGvBbqCRrsXYoJogG/5s/mV/pmMPmEIKBjidPt1hsneHcRBCLd
        DXB+NileI/TCBIZmz6nuKfwQRotQy7M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-dHg6ijydNHKwRV1nx98J6g-1; Fri, 22 Jul 2022 04:46:00 -0400
X-MC-Unique: dHg6ijydNHKwRV1nx98J6g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C7C13C10140;
        Fri, 22 Jul 2022 08:46:00 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29E1640CF8F0;
        Fri, 22 Jul 2022 08:45:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 0/2] ublk_drv: make sure that correct flags(features) returned to userspace
Date:   Fri, 22 Jul 2022 16:45:14 +0800
Message-Id: <20220722084516.624457-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Jens,

The 1st patch cleans ublk_add_dev a bit, meantime fix one potential
free un-allocated buffer issue.

The 2nd one makes sure that driver supported flags returned to
userspace, this way is important for maintaining compatibility.

V3:
- cleanup ublk_ctrl_add_dev by Christoph

V2:
- avoid double free device in case that char dev is failed to add


Christoph Hellwig (1):
  ublk_drv: fix error handling of ublk_add_dev

Ming Lei (1):
  ublk_drv: make sure that correct flags(features) returned to userspace

 drivers/block/ublk_drv.c      | 112 ++++++++++++++++++----------------
 include/uapi/linux/ublk_cmd.h |  11 +++-
 2 files changed, 66 insertions(+), 57 deletions(-)

-- 
2.31.1

