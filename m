Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDB66F060F
	for <lists+linux-block@lfdr.de>; Thu, 27 Apr 2023 14:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243510AbjD0MpR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 27 Apr 2023 08:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243518AbjD0MpQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2023 08:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA13EE78
        for <linux-block@vger.kernel.org>; Thu, 27 Apr 2023 05:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682599462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Xl0dlyajuBqDzvKgZQwQchrTbLW3fzygddwaf5rqp0c=;
        b=RCu/SqBlLgI+sc4tBiTMlv9aUq4YBjwzIiPdd0IiJ4MwKlU7Yr0b3uPuuWHd6lQ4SQqmBD
        MUFM5j5Q5OCSqMEEwLBb/pmFNotM6vUQ91yUaJEZ6ZKbPDi8V74jn6iPrGjn8mrszno8Ae
        u38czjz3x/PHJv7rBuTREUkxBzSnzkI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-vEw3_KHCNWO-dYU8PHKZPg-1; Thu, 27 Apr 2023 08:44:20 -0400
X-MC-Unique: vEw3_KHCNWO-dYU8PHKZPg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E51538123A5;
        Thu, 27 Apr 2023 12:44:20 +0000 (UTC)
Received: from localhost (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7707BC15BA0;
        Thu, 27 Apr 2023 12:44:19 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Harris James R <james.r.harris@intel.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/7] ublk: cleanup and support user copy
Date:   Thu, 27 Apr 2023 20:44:07 +0800
Message-Id: <20230427124414.319945-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

The 1st 3 patch are cleanup.

The other patches support to move data copy between io request pages and
userspace buffer into ublk server(userspace). This way avoids one round trip
of uring command(UBLK_F_NEED_GET_DATA), and solve buffer release issue for
READ[1]. Meantime both sides becomes cleaner. Also it can be thought as
prep patch for supporting zero copy.

ublksrv loop usercopy code:

	https://github.com/ming1/ubdsrv/commits/usercopy

[1] https://lore.kernel.org/linux-block/116d8a56-0881-56d3-9bcc-78ff3e1dc4e5@linux.alibaba.com/T/#m23bd4b8634c0a054e6797063167b469949a247bb


V2:
	- rebase on latest linus tree


Ming Lei (7):
  ublk: kill queuing request by task_work_add
  ublk: cleanup io cmd code path by adding ublk_fill_io()
  ublk: cleanup ublk_copy_user_pages
  ublk: grab request reference when the request is handled by userspace
  ublk: support to copy any part of request pages
  ublk: add read()/write() support for ublk char device
  ublk: support user copy

 drivers/block/ublk_drv.c      | 458 +++++++++++++++++++++++++---------
 include/uapi/linux/ublk_cmd.h |  25 +-
 2 files changed, 361 insertions(+), 122 deletions(-)

-- 
2.40.0

