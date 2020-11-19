Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3232B9C27
	for <lists+linux-block@lfdr.de>; Thu, 19 Nov 2020 21:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgKSUhB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 19 Nov 2020 15:37:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23386 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbgKSUhB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 15:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605818219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b7VUd+QwyZXpFdbHFzGEaZsURd7vfiAhFlh73NIl6fw=;
        b=diHlJSbZQyvNV3mPYHmCT+HbdTov5EjxodoQZk2dNCugm1w53AHItNwPlOt1oVmwOtVeBI
        hUAZMJvXHuIXtfcY+9aurSj9vWqlW21/f1lTOynL3CE4pAR3K7MOWFPq74tc4FgEiklrtQ
        0BOWNQ1WBJZ6X2pVfUFLprF4UGSXSmE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-L96qzbEKO_6LuW-BcFhyQw-1; Thu, 19 Nov 2020 15:36:56 -0500
X-MC-Unique: L96qzbEKO_6LuW-BcFhyQw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E454880EF82;
        Thu, 19 Nov 2020 20:36:55 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9859060BE2;
        Thu, 19 Nov 2020 20:36:52 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 0AJKaqp9012293;
        Thu, 19 Nov 2020 15:36:52 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 0AJKapuD012289;
        Thu, 19 Nov 2020 15:36:51 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 19 Nov 2020 15:36:51 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     David Teigland <teigland@redhat.com>, Jens Axboe <axboe@kernel.dk>
cc:     heinzm@redhat.com, Zdenek Kabelac <zkabelac@redhat.com>,
        Marian Csontos <mcsontos@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH] blk-settings: make sure that max_sectors is aligned on
 "logical_block_size" boundary.
In-Reply-To: <alpine.LRH.2.02.2011191337180.588@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2011191517360.10231@file01.intranet.prod.int.rdu2.redhat.com>
References: <20201118203127.GA30066@redhat.com> <20201118203408.GB30066@redhat.com> <fc7c4efd-0bb3-f023-19c6-54359d279ca8@redhat.com> <alpine.LRH.2.02.2011190810001.32672@file01.intranet.prod.int.rdu2.redhat.com> <20201119172807.GC1879@redhat.com>
 <alpine.LRH.2.02.2011191337180.588@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We get these I/O errors when we run md-raid1 on the top of dm-integrity on 
the top of ramdisk:
device-mapper: integrity: Bio not aligned on 8 sectors: 0xff00, 0xff
device-mapper: integrity: Bio not aligned on 8 sectors: 0xff00, 0xff
device-mapper: integrity: Bio not aligned on 8 sectors: 0xffff, 0x1
device-mapper: integrity: Bio not aligned on 8 sectors: 0xffff, 0x1
device-mapper: integrity: Bio not aligned on 8 sectors: 0x8048, 0xff
device-mapper: integrity: Bio not aligned on 8 sectors: 0x8147, 0xff
device-mapper: integrity: Bio not aligned on 8 sectors: 0x8246, 0xff
device-mapper: integrity: Bio not aligned on 8 sectors: 0x8345, 0xbb

The ramdisk device has logical_block_size 512 and max_sectors 255. The 
dm-integrity device uses logical_block_size 4096 and it doesn't affect the 
"max_sectors" value - thus, it inherits 255 from the ramdisk. So, we have 
a device with max_sectors not aligned on logical_block_size.

The md-raid device sees that the underlying leg has max_sectors 255 and it
will split the bios on 255-sector boundary, making the bios unaligned on
logical_block_size.

In order to fix the bug, we round down max_sectors to logical_block_size.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 block/blk-settings.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: linux-2.6/block/blk-settings.c
===================================================================
--- linux-2.6.orig/block/blk-settings.c	2020-10-29 12:20:46.000000000 +0100
+++ linux-2.6/block/blk-settings.c	2020-11-19 21:20:18.000000000 +0100
@@ -591,6 +591,16 @@ int blk_stack_limits(struct queue_limits
 		ret = -1;
 	}
 
+	t->max_sectors = round_down(t->max_sectors, t->logical_block_size / 512);
+	if (t->max_sectors < PAGE_SIZE / 512)
+		t->max_sectors = PAGE_SIZE / 512;
+	t->max_hw_sectors = round_down(t->max_hw_sectors, t->logical_block_size / 512);
+	if (t->max_sectors < PAGE_SIZE / 512)
+		t->max_hw_sectors = PAGE_SIZE / 512;
+	t->max_dev_sectors = round_down(t->max_dev_sectors, t->logical_block_size / 512);
+	if (t->max_sectors < PAGE_SIZE / 512)
+		t->max_dev_sectors = PAGE_SIZE / 512;
+
 	/* Discard alignment and granularity */
 	if (b->discard_granularity) {
 		alignment = queue_limit_discard_alignment(b, start);

