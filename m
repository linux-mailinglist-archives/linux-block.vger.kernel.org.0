Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8FC2A3D01
	for <lists+linux-block@lfdr.de>; Tue,  3 Nov 2020 07:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbgKCGwN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 3 Nov 2020 01:52:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56624 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725968AbgKCGwM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Nov 2020 01:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604386332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=TxH16j2Sw/5o2F1ItbgMRTL1aZhFHzPmNWeIsPnKHzA=;
        b=Raq7Ieh/piRtFSb/v1hZsU7xheKpS8TPJQ0wrCADww9IzvMmWJg0fq5BW84nOX0mZJYmYJ
        nZ3bGvI8NHKxpMBz/mee5I2yqx6x8kdpCdP7JkWiS+0+fgHhFymtWDcfvRzkj8hd2gkm4e
        haUQ7y+jl22nnGvgK4zFzpV22rUn2Wo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-0g2tCd2KM1-93-QC5PKCng-1; Tue, 03 Nov 2020 01:52:07 -0500
X-MC-Unique: 0g2tCd2KM1-93-QC5PKCng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A709D1084D62;
        Tue,  3 Nov 2020 06:52:06 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (vm37-120.gsslab.pek2.redhat.com [10.72.37.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DAE65D9DD;
        Tue,  3 Nov 2020 06:51:59 +0000 (UTC)
From:   xiubli@redhat.com
To:     josef@toxicpanda.com, axboe@kernel.dk, ming.lei@redhat.com
Cc:     nbd@other.debian.org, linux-block@vger.kernel.org,
        jdillama@redhat.com, mgolub@suse.de, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v3 0/2] nbd: fix use-after-freed and double lock bugs
Date:   Tue,  3 Nov 2020 01:51:54 -0500
Message-Id: <20201103065156.342756-1-xiubli@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

Changed in V3:
- remove the likely()

Changed in V2:
- fixed possible double lock issue in recv_work().

Xiubo Li (2):
  nbd: fix use-after-freed crash for nbd->recv_workq
  nbd: add comments about double lock for config_lock confusion

 drivers/block/nbd.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

-- 
2.18.4

