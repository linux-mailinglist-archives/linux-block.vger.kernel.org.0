Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D539563D6C
	for <lists+linux-block@lfdr.de>; Tue,  9 Jul 2019 23:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfGIVld (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 9 Jul 2019 17:41:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34079 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGIVld (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Jul 2019 17:41:33 -0400
Received: by mail-qt1-f193.google.com with SMTP id k10so241095qtq.1;
        Tue, 09 Jul 2019 14:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QwndTe0YbWPxv611pI7V02B0mIgtu96cP7ewbywUwjg=;
        b=ZlaVdzKR62QMVBXExU9yecMvvjrWv8pcrvYYz0tUBQsKOLGNKSV5xNTkinxqgIqCgS
         HCVlwMsbqDmAOOUh8vx8/AMcBziTzA++EN/SxF22aFYfg9JJl/IikxqOUwcog7DAmDAR
         f3bOc18RFmELS57k6X6Y5nAaP3+lZsUSK3l2XCl5CIbFa3JKm8chgH/lxW35c0INZaii
         unu8dLxIq56kVcfKpFqwvQJUe1o/2gJNfpeZJneMA1cgX1r+0oglkb1NrIMHIMF/1cFv
         W1l7fs4qDJuewO0qsb3PpdlXhmFeKW7Nh6KaKJ4ghjLIiws6HHB9UBoZf25KvZLE1q61
         9ACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=QwndTe0YbWPxv611pI7V02B0mIgtu96cP7ewbywUwjg=;
        b=M/UUUnu4lrcb/B4xKwzQa+Eixbk/9+qFOWzAOi8i0gXP3w81VpP8KJfjL4AsdcwqP8
         Ofv/+Ouea/IZ7JxAfWlthk9W0d9ubXhMMSnqJor9nRhkgaAFmZfVkqJdxRbH0Rtq54Nk
         3kTfiFZ2b+QnrCIITwmpvPak/XSVv0IkTPd1pjEzG+iKKrtjiFDZCIcvpS6iJAr2UfEP
         7mbbNzyXJBwUVzMIGomI/hAhxKJ8csQli7R09VeEYEu16fgpkjDyIfom6Qq0Bkzm2q6U
         YcsABqSF7ZY4YuCM6HGl6OfsLPf5wjOdQSM1R9ddmEWoeCs6ee+M6Pl83W3uESXcRseI
         D6cw==
X-Gm-Message-State: APjAAAXd++SY4N9siO6zFxge5jz5boLB2izxIUs4Mjhc2Kt0FasqGWVo
        YlzpCTg6KQjkke5J8LUV37M=
X-Google-Smtp-Source: APXvYqxaoI19YT2qAqYhYrPj4SUcXRaqW0XeVWjsErjSs90LfkZJ+RwXWeVsjac2cGBC6uCKXbNK6g==
X-Received: by 2002:a0c:b521:: with SMTP id d33mr21593820qve.239.1562708492394;
        Tue, 09 Jul 2019 14:41:32 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:fa50])
        by smtp.gmail.com with ESMTPSA id x8sm138972qka.106.2019.07.09.14.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 14:41:31 -0700 (PDT)
Date:   Tue, 9 Jul 2019 14:41:29 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH] blk-cgroup: turn on psi memstall stuff
Message-ID: <20190709214129.GK657710@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Josef Bacik <jbacik@fb.com>

With the psi stuff in place we can use the memstall flag to indicate
pressure that happens from throttling.

Signed-off-by: Josef Bacik <jbacik@fb.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 1f7127b03490..6ed515b78cb3 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -29,6 +29,7 @@
 #include <linux/ctype.h>
 #include <linux/blk-cgroup.h>
 #include <linux/tracehook.h>
+#include <linux/psi.h>
 #include "blk.h"
 
 #define MAX_KEY_LEN 100
@@ -1644,6 +1645,7 @@ static void blkcg_scale_delay(struct blkcg_gq *blkg, u64 now)
  */
 static void blkcg_maybe_throttle_blkg(struct blkcg_gq *blkg, bool use_memdelay)
 {
+	unsigned long pflags;
 	u64 now = ktime_to_ns(ktime_get());
 	u64 exp;
 	u64 delay_nsec = 0;
@@ -1670,11 +1672,8 @@ static void blkcg_maybe_throttle_blkg(struct blkcg_gq *blkg, bool use_memdelay)
 	 */
 	delay_nsec = min_t(u64, delay_nsec, 250 * NSEC_PER_MSEC);
 
-	/*
-	 * TODO: the use_memdelay flag is going to be for the upcoming psi stuff
-	 * that hasn't landed upstream yet.  Once that stuff is in place we need
-	 * to do a psi_memstall_enter/leave if memdelay is set.
-	 */
+	if (use_memdelay)
+		psi_memstall_enter(&pflags);
 
 	exp = ktime_add_ns(now, delay_nsec);
 	tok = io_schedule_prepare();
@@ -1684,6 +1683,9 @@ static void blkcg_maybe_throttle_blkg(struct blkcg_gq *blkg, bool use_memdelay)
 			break;
 	} while (!fatal_signal_pending(current));
 	io_schedule_finish(tok);
+
+	if (use_memdelay)
+		psi_memstall_leave(&pflags);
 }
 
 /**
