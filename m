Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37012729E6
	for <lists+linux-block@lfdr.de>; Wed, 24 Jul 2019 10:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfGXIZI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 24 Jul 2019 04:25:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfGXIZI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jul 2019 04:25:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C57C30C34EC;
        Wed, 24 Jul 2019 08:25:08 +0000 (UTC)
Received: from localhost (ovpn-117-162.ams2.redhat.com [10.36.117.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D4E260497;
        Wed, 24 Jul 2019 08:25:04 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>,
        Jeff Moyer <jmoyer@redhat.com>, linux-block@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing 3/4] src/Makefile: honor the caller's includedir and libdir
Date:   Wed, 24 Jul 2019 09:24:49 +0100
Message-Id: <20190724082450.12135-4-stefanha@redhat.com>
In-Reply-To: <20190724082450.12135-1-stefanha@redhat.com>
References: <20190724082450.12135-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 24 Jul 2019 08:25:08 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The top-level makefile passes in includedir and libdir so we should
not override them.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 src/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/Makefile b/src/Makefile
index 954e05e..aa93199 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -1,6 +1,6 @@
 prefix ?= /usr
-includedir=$(prefix)/include
-libdir=$(prefix)/lib
+includedir ?= $(prefix)/include
+libdir ?= $(prefix)/lib
 
 CFLAGS ?= -g -fomit-frame-pointer -O2
 override CFLAGS += -Wall -I.
-- 
2.21.0

