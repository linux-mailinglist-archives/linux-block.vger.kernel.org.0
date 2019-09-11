Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5F4FAFF17
	for <lists+linux-block@lfdr.de>; Wed, 11 Sep 2019 16:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfIKOrr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 11 Sep 2019 10:47:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56894 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfIKOrr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Sep 2019 10:47:47 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 467DE260785
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, axboe@kernel.dk, m@bjorling.me,
        kernel@collabora.com, krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 1/3] docs: block: null_blk: enhance document style
Date:   Wed, 11 Sep 2019 11:46:34 -0300
Message-Id: <20190911144636.226945-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use proper ReST syntax for chapters. Add more information to enhance
standardization in the file and to make the rendering more homogeneous.
Add a SPDX identifier. Mark single-queue mode as deprecated.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
I've asked the file creator (Matias Bjørling <m@bjorling.me>), and
he confirmed that I could use GPL-2.0 for this file.

 Documentation/block/null_blk.rst | 33 +++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/Documentation/block/null_blk.rst b/Documentation/block/null_blk.rst
index 31451d80783c..edbbab2f12f8 100644
--- a/Documentation/block/null_blk.rst
+++ b/Documentation/block/null_blk.rst
@@ -1,19 +1,16 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ========================
 Null block device driver
 ========================
 
-1. Overview
-===========
+Overview
+========
 
-The null block device (/dev/nullb*) is used for benchmarking the various
+The null block device (``/dev/nullb*``) is used for benchmarking the various
 block-layer implementations. It emulates a block device of X gigabytes in size.
-The following instances are possible:
-
-  Single-queue block-layer
-
-    - Request-based.
-    - Single submission queue per device.
-    - Implements IO scheduling algorithms (CFQ, Deadline, noop).
+It does not execute any read/write operation, just mark them as complete in
+the request queue. The following instances are possible:
 
   Multi-queue block-layer
 
@@ -27,15 +24,15 @@ The following instances are possible:
 
 All of them have a completion queue for each core in the system.
 
-2. Module parameters applicable for all instances
-=================================================
+Module parameters
+=================
 
 queue_mode=[0-2]: Default: 2-Multi-queue
   Selects which block-layer the module should instantiate with.
 
   =  ============
   0  Bio-based
-  1  Single-queue
+  1  Single-queue (deprecated)
   2  Multi-queue
   =  ============
 
@@ -67,7 +64,7 @@ irqmode=[0-2]: Default: 1-Soft-irq
 completion_nsec=[ns]: Default: 10,000ns
   Combined with irqmode=2 (timer). The time each completion event must wait.
 
-submit_queues=[1..nr_cpus]:
+submit_queues=[1..nr_cpus]: Default: 1
   The number of submission queues attached to the device driver. If unset, it
   defaults to 1. For multi-queue, it is ignored when use_per_node_hctx module
   parameter is 1.
@@ -75,9 +72,11 @@ submit_queues=[1..nr_cpus]:
 hw_queue_depth=[0..qdepth]: Default: 64
   The hardware queue depth of the device.
 
-III: Multi-queue specific parameters
+Multi-queue specific parameters
+-------------------------------
 
 use_per_node_hctx=[0/1]: Default: 0
+  Number of hardware context queues.
 
   =  =====================================================================
   0  The number of submit queues are set to the value of the submit_queues
@@ -87,6 +86,7 @@ use_per_node_hctx=[0/1]: Default: 0
   =  =====================================================================
 
 no_sched=[0/1]: Default: 0
+  Enable/disable the io scheduler.
 
   =  ======================================
   0  nullb* use default blk-mq io scheduler
@@ -94,6 +94,7 @@ no_sched=[0/1]: Default: 0
   =  ======================================
 
 blocking=[0/1]: Default: 0
+  Blocking behavior of the request queue.
 
   =  ===============================================================
   0  Register as a non-blocking blk-mq driver device.
@@ -103,6 +104,7 @@ blocking=[0/1]: Default: 0
   =  ===============================================================
 
 shared_tags=[0/1]: Default: 0
+  Sharing tags between devices.
 
   =  ================================================================
   0  Tag set is not shared.
@@ -111,6 +113,7 @@ shared_tags=[0/1]: Default: 0
   =  ================================================================
 
 zoned=[0/1]: Default: 0
+  Device is a random-access or a zoned block device.
 
   =  ======================================================================
   0  Block device is exposed as a random-access block device.
-- 
2.23.0

