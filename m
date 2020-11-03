Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825C92A3AD7
	for <lists+linux-block@lfdr.de>; Tue,  3 Nov 2020 04:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgKCDIV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 2 Nov 2020 22:08:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33012 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725913AbgKCDIV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Nov 2020 22:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604372900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=MJYyF6XJcRo4Z+XhoYpQ8eIJ/B8rjWdWWqBVGeI+dmE=;
        b=Ee45ChZRgJEjJboz+ZGdy8fXNXZwHOl01E2bbyh36dm8QCa9LTBhb5jdLbOfY0CdU3VTup
        gREE3tdXDyzu8KjXaf61oBHt8jHloYqfukxkGWMe2PxBu8intyp9XizimP2VY6POWZx9gg
        EB2KZ03mDXPmCkP1P0jKPHDnyJFYMtc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-rDuX3wu-PrOgKPMY8ynODw-1; Mon, 02 Nov 2020 22:08:18 -0500
X-MC-Unique: rDuX3wu-PrOgKPMY8ynODw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2F16809DCD;
        Tue,  3 Nov 2020 03:08:16 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (vm37-120.gsslab.pek2.redhat.com [10.72.37.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1828575127;
        Tue,  3 Nov 2020 03:08:10 +0000 (UTC)
From:   xiubli@redhat.com
To:     josef@toxicpanda.com, axboe@kernel.dk, ming.lei@redhat.com
Cc:     nbd@other.debian.org, linux-block@vger.kernel.org,
        jdillama@redhat.com, mgolub@suse.de, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH v2 0/2] nbd: fix use-after-freed and double lock bugs
Date:   Mon,  2 Nov 2020 22:07:56 -0500
Message-Id: <20201103030758.317781-1-xiubli@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

Changed in V2:
- fixed possible double lock issue in recv_work().
- adding comments instead to explain why there won't have double lock
issue.

Xiubo Li (2):
  nbd: fix use-after-freed crash for nbd->recv_workq
  nbd: add comments about double lock for config_lock confusion

 drivers/block/nbd.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

-- 
2.18.4

