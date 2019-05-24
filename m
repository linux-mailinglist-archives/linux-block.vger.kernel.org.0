Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 266232921C
	for <lists+linux-block@lfdr.de>; Fri, 24 May 2019 09:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389142AbfEXHz4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 24 May 2019 03:55:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59976 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389139AbfEXHz4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 May 2019 03:55:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E251E81F25;
        Fri, 24 May 2019 07:55:52 +0000 (UTC)
Received: from localhost (ovpn-117-142.ams2.redhat.com [10.36.117.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5BB3D179F8;
        Fri, 24 May 2019 07:55:50 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing 1/2] Add example binaries to .gitignore
Date:   Fri, 24 May 2019 08:55:42 +0100
Message-Id: <20190524075543.30338-2-stefanha@redhat.com>
In-Reply-To: <20190524075543.30338-1-stefanha@redhat.com>
References: <20190524075543.30338-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 24 May 2019 07:55:55 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The same idea as for liburing.a and friends.  Ignore the executables
built in examples/.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 .gitignore | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitignore b/.gitignore
index e292825..22c0cbd 100644
--- a/.gitignore
+++ b/.gitignore
@@ -9,6 +9,10 @@
 /src/liburing.a
 /src/liburing.so*
 
+/examples/io_uring-cp
+/examples/io_uring-test
+/examples/link-cp
+
 config-host.h
 config-host.mak
 config.log
-- 
2.21.0

