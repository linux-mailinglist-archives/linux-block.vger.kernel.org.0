Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8B946BEC6
	for <lists+linux-block@lfdr.de>; Wed, 17 Jul 2019 17:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfGQPEv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 17 Jul 2019 11:04:51 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:44887 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfGQPEv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jul 2019 11:04:51 -0400
Received: by mail-pg1-f181.google.com with SMTP id i18so11298840pgl.11
        for <linux-block@vger.kernel.org>; Wed, 17 Jul 2019 08:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:reply-to;
        bh=BIU9T/wjilAJw/XbeVyfQOiaksadDiH37WbO5iqIE7Y=;
        b=BDTV56a46Afa0WZ++8ckwsmYO7V/Vphpg7Kpe8lBgMSpvER/POgpV6lPuXgqCKBWHn
         8nEqnHUCPdK65uws/8WdQBlRT2g9uxD9Ip8yPEtoT344OuYstnkXhQMIehYzVqR+8ya/
         ZJei++K4m624v0fCeRusZtGsirZWX4O+StgOze1lE6CTcp5PRS/VfPDd2ljjNrC9VdZA
         WEBQFxqtUn9sxFj9LvO9p2fKsyYWwPweWA7xZpPXSGFmUnZXKKYmKqm2K7aU/haKSkAf
         cpIAb+/3yoX2F9QeFI5YlYg3gvsGUPYmE9VF6HZ+cjAOhJMJFR1jh/lJnAc/3/9NLuFT
         xdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BIU9T/wjilAJw/XbeVyfQOiaksadDiH37WbO5iqIE7Y=;
        b=A8CelB9EIKnbNCvJSGlAy/ycn79oSkMpzjtSkZJouJxFZBdmcPdn+2Q9LfWiTyAYn0
         faaItwxql50RrLN17V4uQJ0VQosb/S3amq1AHgrdOW2QoybYZVIZRqHHGjmSF5gAnqFL
         mXSu1OLWlD4XezTd+V7dLxejKOWJbVbcXftKyNxwJT4La7YOQK6ptznBoi8wammBJj2k
         4IMQuxb/oOJAS2tE3fhNOhGrkhwBr+9pqGHPyqa+7XacYp8Cg34fyQ919/X7moTdyVEw
         qzGD5APoqsoFNziTwUO2t3xIJLOSwK0Zaf1i7uy++PqfZASmxe2XdFOapvj6Sl/oZGHb
         Ge/Q==
X-Gm-Message-State: APjAAAVlQeKnbIkqU5E1Z2RjsG7dZbsXrpGdodbg2vmO+mTBpclqxxXB
        2nAYMQrCQoeA0ZMBUWWtLQVm/SUaeNQ=
X-Google-Smtp-Source: APXvYqwNKKZwWngPINFKUhTWUkyN+opuQBgtgJqNxKmXxaY8eqyUHAXI6DjG2jnVZB2JhMN0Om3d6A==
X-Received: by 2002:a17:90a:3247:: with SMTP id k65mr1320694pjb.49.1563375889688;
        Wed, 17 Jul 2019 08:04:49 -0700 (PDT)
Received: from x1.localdomain (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id o35sm14112299pgm.29.2019.07.17.08.04.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 08:04:48 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Filipp.Mikoian@acronis.com
Subject: 
Date:   Wed, 17 Jul 2019 09:04:43 -0600
Message-Id: <20190717150445.1131-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Reply-To: "[RFC PATCHSET 0/2]"@vger.kernel.org, Fix@vger.kernel.org,
          O_DIRECT@vger.kernel.org, blocking@vger.kernel.org,
          with@vger.kernel.org, IOCB_NOWAIT@vger.kernel.org
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Got a bug report on io_uring that submission time with O_DIRECT rose
dramatically once the queue depth got higher. Turns out that
__blkdev_direct_IO() does not honor IOCB_NOWAIT at all.

blk-mq returns -EAGAIN errors through the bio end_io callback, which
isn't super useful for cases where you want to pass this information
back inline. Patch #1 adds a new flag for this, REQ_NOWAIT_INLINE,
which makes submission return BLK_QC_T_EAGAIN if we would have blocked.
Patch #2 then uses this in __blkdev_direct_IO() to return -EAGAIN, if
we would have needed to block due to resource starvation.

With this in place, submissions that would have blocked are correctly
punted to async context by io_uring.

Patches can also be found in my io_uring-test branch, which also
include a test patch that adds a "io_uring submission blocked" debug
patch for sched.

-- 
Jens Axboe


