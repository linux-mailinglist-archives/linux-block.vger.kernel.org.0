Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A10C2921D
	for <lists+linux-block@lfdr.de>; Fri, 24 May 2019 09:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389147AbfEXHz4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 24 May 2019 03:55:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389139AbfEXHz4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 May 2019 03:55:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D75E30820E6;
        Fri, 24 May 2019 07:55:56 +0000 (UTC)
Received: from localhost (ovpn-117-142.ams2.redhat.com [10.36.117.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4BE0017D94;
        Fri, 24 May 2019 07:55:54 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing 2/2] Add test binaries to .gitignore
Date:   Fri, 24 May 2019 08:55:43 +0100
Message-Id: <20190524075543.30338-3-stefanha@redhat.com>
In-Reply-To: <20190524075543.30338-1-stefanha@redhat.com>
References: <20190524075543.30338-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 24 May 2019 07:55:56 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The same idea as for liburing.a and friends.  Ignore the executables
built in test/.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 .gitignore | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/.gitignore b/.gitignore
index 22c0cbd..55309e1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -13,6 +13,23 @@
 /examples/io_uring-test
 /examples/link-cp
 
+/test/poll
+/test/poll-cancel
+/test/ring-leak
+/test/fsync
+/test/io_uring_setup
+/test/io_uring_register
+/test/io_uring_enter
+/test/nop
+/test/sq-full
+/test/cq-full
+/test/35fa71a030ca-test
+/test/917257daa0fe-test
+/test/b19062a56726-test
+/test/eeed8b54e0df-test
+/test/link
+/test/send_recvmsg
+
 config-host.h
 config-host.mak
 config.log
-- 
2.21.0

