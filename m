Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA36158A627
	for <lists+linux-block@lfdr.de>; Fri,  5 Aug 2022 08:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiHEGwm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 5 Aug 2022 02:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiHEGwl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Aug 2022 02:52:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C336413DD5
        for <linux-block@vger.kernel.org>; Thu,  4 Aug 2022 23:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659682359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JrlhN6OnXlaGeR+OnC3zS/Ao0sQFhuM9furIjnmbtgo=;
        b=PiVQVnUFj4i3zNLxtvhyjCsdnzwvgiwsmUMevFrWECeVi1c1e4FeVoIjlRD2TNnl9XDyq4
        lOFwYvl50yAI2lViOS39/tE8Slyh050Ei9dYh9dRaYJWE4Nd2fERMZPZ71ESiTyB+qrGm1
        EL77agjw6mVIMgufQ8h2cruheP2BbF4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-m1wLdpAWMXaqMh3CFX_vFQ-1; Fri, 05 Aug 2022 02:52:35 -0400
X-MC-Unique: m1wLdpAWMXaqMh3CFX_vFQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 953A9101A586;
        Fri,  5 Aug 2022 06:52:34 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79AB5492C3B;
        Fri,  5 Aug 2022 06:52:32 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     sunke32@huawei.com, shinichiro.kawasaki@wdc.com
Subject: [PATCH] src/mount_clear_sock.c: fix compiling error
Date:   Fri,  5 Aug 2022 14:52:25 +0800
Message-Id: <20220805065225.663947-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

<linux/mount.h> and <sys/mount.h> are known pairs of headers that conflict
See https://sourceware.org/glibc/wiki/Synchronizing_Headers
$ make
make -C src all
make[1]: Entering directory '/root/blktests/src'
cc  -O2 -Wall -Wshadow  -DHAVE_LINUX_BLKZONED_H -o mount_clear_sock mount_clear_sock.c
In file included from /usr/include/linux/fs.h:19,
                 from mount_clear_sock.c:15:
/usr/include/linux/mount.h:95:6: error: redeclaration of ‘enum fsconfig_command’
   95 | enum fsconfig_command {
      |      ^~~~~~~~~~~~~~~~
In file included from mount_clear_sock.c:11:
/usr/include/sys/mount.h:189:6: note: originally defined here
  189 | enum fsconfig_command
      |      ^~~~~~~~~~~~~~~~
/usr/include/linux/mount.h:96:9: error: redeclaration of enumerator ‘FSCONFIG_SET_FLAG’
   96 |         FSCONFIG_SET_FLAG       = 0,    /* Set parameter, supplying no value */
      |         ^~~~~~~~~~~~~~~~~
/usr/include/sys/mount.h:191:3: note: previous definition of ‘FSCONFIG_SET_FLAG’ with type ‘enum fsconfig_command’
  191 |   FSCONFIG_SET_FLAG       = 0,    /* Set parameter, supplying no value */
      |   ^~~~~~~~~~~~~~~~~
/usr/include/linux/mount.h:97:9: error: redeclaration of enumerator ‘FSCONFIG_SET_STRING’
   97 |         FSCONFIG_SET_STRING     = 1,    /* Set parameter, supplying a string value */
      |         ^~~~~~~~~~~~~~~~~~~
/usr/include/sys/mount.h:193:3: note: previous definition of ‘FSCONFIG_SET_STRING’ with type ‘enum fsconfig_command’
  193 |   FSCONFIG_SET_STRING     = 1,    /* Set parameter, supplying a string value */
      |   ^~~~~~~~~~~~~~~~~~~
/usr/include/linux/mount.h:98:9: error: redeclaration of enumerator ‘FSCONFIG_SET_BINARY’
   98 |         FSCONFIG_SET_BINARY     = 2,    /* Set parameter, supplying a binary blob value */
      |         ^~~~~~~~~~~~~~~~~~~
/usr/include/sys/mount.h:195:3: note: previous definition of ‘FSCONFIG_SET_BINARY’ with type ‘enum fsconfig_command’
  195 |   FSCONFIG_SET_BINARY     = 2,    /* Set parameter, supplying a binary blob value */
      |   ^~~~~~~~~~~~~~~~~~~
/usr/include/linux/mount.h:99:9: error: redeclaration of enumerator ‘FSCONFIG_SET_PATH’
   99 |         FSCONFIG_SET_PATH       = 3,    /* Set parameter, supplying an object by path */
      |         ^~~~~~~~~~~~~~~~~
/usr/include/sys/mount.h:197:3: note: previous definition of ‘FSCONFIG_SET_PATH’ with type ‘enum fsconfig_command’
  197 |   FSCONFIG_SET_PATH       = 3,    /* Set parameter, supplying an object by path */
      |   ^~~~~~~~~~~~~~~~~
/usr/include/linux/mount.h:100:9: error: redeclaration of enumerator ‘FSCONFIG_SET_PATH_EMPTY’
  100 |         FSCONFIG_SET_PATH_EMPTY = 4,    /* Set parameter, supplying an object by (empty) path */
      |         ^~~~~~~~~~~~~~~~~~~~~~~
/usr/include/sys/mount.h:199:3: note: previous definition of ‘FSCONFIG_SET_PATH_EMPTY’ with type ‘enum fsconfig_command’
  199 |   FSCONFIG_SET_PATH_EMPTY = 4,    /* Set parameter, supplying an object by (empty) path */
      |   ^~~~~~~~~~~~~~~~~~~~~~~
/usr/include/linux/mount.h:101:9: error: redeclaration of enumerator ‘FSCONFIG_SET_FD’
  101 |         FSCONFIG_SET_FD         = 5,    /* Set parameter, supplying an object by fd */
      |         ^~~~~~~~~~~~~~~
/usr/include/sys/mount.h:201:3: note: previous definition of ‘FSCONFIG_SET_FD’ with type ‘enum fsconfig_command’
  201 |   FSCONFIG_SET_FD         = 5,    /* Set parameter, supplying an object by fd */
      |   ^~~~~~~~~~~~~~~
/usr/include/linux/mount.h:102:9: error: redeclaration of enumerator ‘FSCONFIG_CMD_CREATE’
  102 |         FSCONFIG_CMD_CREATE     = 6,    /* Invoke superblock creation */
      |         ^~~~~~~~~~~~~~~~~~~
/usr/include/sys/mount.h:203:3: note: previous definition of ‘FSCONFIG_CMD_CREATE’ with type ‘enum fsconfig_command’
  203 |   FSCONFIG_CMD_CREATE     = 6,    /* Invoke superblock creation */
      |   ^~~~~~~~~~~~~~~~~~~
/usr/include/linux/mount.h:103:9: error: redeclaration of enumerator ‘FSCONFIG_CMD_RECONFIGURE’
  103 |         FSCONFIG_CMD_RECONFIGURE = 7,   /* Invoke superblock reconfiguration */
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
/usr/include/sys/mount.h:205:3: note: previous definition of ‘FSCONFIG_CMD_RECONFIGURE’ with type ‘enum fsconfig_command’
  205 |   FSCONFIG_CMD_RECONFIGURE = 7,   /* Invoke superblock reconfiguration */
      |   ^~~~~~~~~~~~~~~~~~~~~~~~
/usr/include/linux/mount.h:129:8: error: redefinition of ‘struct mount_attr’
  129 | struct mount_attr {
      |        ^~~~~~~~~~
/usr/include/sys/mount.h:161:8: note: originally defined here
  161 | struct mount_attr
      |        ^~~~~~~~~~

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 src/mount_clear_sock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/mount_clear_sock.c b/src/mount_clear_sock.c
index 984395e..5d9c900 100644
--- a/src/mount_clear_sock.c
+++ b/src/mount_clear_sock.c
@@ -12,7 +12,6 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
-#include <linux/fs.h>
 #include <linux/nbd.h>
 
 int main(int argc, char **argv)
-- 
2.34.1

