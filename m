Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDD862B316
	for <lists+linux-block@lfdr.de>; Wed, 16 Nov 2022 07:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiKPGJu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Nov 2022 01:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiKPGJt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 01:09:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D827B2B
        for <linux-block@vger.kernel.org>; Tue, 15 Nov 2022 22:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668578929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DknHnSyilClRaaFb2h7NHScQt4Y6GnWgY9PZoRqOvsc=;
        b=eOw2JWGqA+RCG2bwWhumGdSA9ib/jxv3qb7nHC+KmGNhyMOdk9+mYu1T7/WdAT6/Y2Fapp
        Q4bxsYxEa1wff71dvvEC0fw9dFnM6RhLtE7NGIMBz6Pw0Ak9dRBohsITevaCI2AHjAIJaY
        CdL/Mg1b4EL8GHfV1gZwknY+LA4z/wE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-gw6WKL9rMnOCUHAe-0Yplw-1; Wed, 16 Nov 2022 01:08:46 -0500
X-MC-Unique: gw6WKL9rMnOCUHAe-0Yplw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F0993802B80;
        Wed, 16 Nov 2022 06:08:46 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 760BE40C83AA;
        Wed, 16 Nov 2022 06:08:43 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/6] ublk_drv: add mechanism for supporting unprivileged ublk device
Date:   Wed, 16 Nov 2022 14:08:29 +0800
Message-Id: <20221116060835.159945-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

Stefan Hajnoczi suggested un-privileged ublk device[1] for container
use case.

So far only administrator can create/control ublk device which is too
strict and increase system administrator burden, and this patchset
implements un-privileged ublk device:

- any user can create ublk device, which can only be controlled &
  accessed by the owner of the device or administrator

For using such mechanism, system administrator needs to deploy two
simple udev rules[2] after running 'make install' in ublksrv.

Userspace(ublksrv):

	https://github.com/ming1/ubdsrv/tree/unprivileged-ublk
    
'ublk add -t $TYPE --un_privileged=1' is for creating one un-privileged
ublk device if the user is un-privileged.


[1] https://lore.kernel.org/linux-block/YoOr6jBfgVm8GvWg@stefanha-x1.localdomain/
[2] https://github.com/ming1/ubdsrv/blob/unprivileged-ublk/README.rst#un-privileged-mode

Ming Lei (6):
  ublk_drv: remove nr_aborted_queues from ublk_device
  ublk_drv: don't probe partitions if the ubq daemon isn't trusted
  ublk_drv: move ublk_get_device_from_id into ublk_ctrl_uring_cmd
  ublk_drv: add device parameter UBLK_PARAM_TYPE_DEVT
  ublk_drv: add module parameter of ublks_max for limiting max allowed
    ublk dev
  ublk_drv: add mechanism for supporting unprivileged ublk device

 Documentation/block/ublk.rst  |  18 +-
 drivers/block/ublk_drv.c      | 340 ++++++++++++++++++++++++----------
 include/uapi/linux/ublk_cmd.h |  49 ++++-
 3 files changed, 299 insertions(+), 108 deletions(-)

-- 
2.31.1

