Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3498F7BD6E3
	for <lists+linux-block@lfdr.de>; Mon,  9 Oct 2023 11:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345758AbjJIJZG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 9 Oct 2023 05:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346034AbjJIJYz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Oct 2023 05:24:55 -0400
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E286310D0
        for <linux-block@vger.kernel.org>; Mon,  9 Oct 2023 02:23:54 -0700 (PDT)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1dd053fb4f0so6754734fac.2
        for <linux-block@vger.kernel.org>; Mon, 09 Oct 2023 02:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696843432; x=1697448232;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+CyAJnxOWQ6GiGTDmLcfZR8Xv/l2XyLipls4WBkmObE=;
        b=fAmjBn27wT7KPUz6qdmgvm+6/T7bdmRioJVaGBGkegK7i94RRrrHybUomPl3YQcN2n
         WBZ0xmlx2sf1SJmL377TTYq6i7Kuw6chAiGJ8L6RJk5BTD/APecTdSAxQGy3v8Y7zJnv
         YvHx7Ult/GF9p6DlsTjh275ChNCXIRjkHd9EFu/pebmNnO2FoPyHapYBWN5ahxdFev4g
         1rAHLB+8VUXFUtE6CaLD0wWWQon15xb0KN0BYI7cdMoJmvCKsoJRKto9CXw9LRcg2M3Z
         wZ2OswD86pwlMHKvikXI7iwSQpP6Zub8m6jFNtQ06bZph4V+3mqXqaQ6ieaIyIeUKvn9
         MK6w==
X-Gm-Message-State: AOJu0YwYJ2vQ4s4SAxxqERM4i4CXzCs4ld8zAldrOsCdTO+x8j/I3t4R
        W0sV7x7fdMaF82lQ8Mji5EBz7vokgjnQFqvoI/Q1ehXVfNE3yKU=
X-Google-Smtp-Source: AGHT+IHuVHWpi0LD46vyGjLgmHjMkFy4wVINux+71e3FEiWqtqbUjWLC2xNMo0Ups3Q9WvAyyrhPMJMtwBaIpH47G5oNxzr6gfkS
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5a9a:b0:1e1:82c6:33f9 with SMTP id
 dt26-20020a0568705a9a00b001e182c633f9mr6675734oab.6.1696843432671; Mon, 09
 Oct 2023 02:23:52 -0700 (PDT)
Date:   Mon, 09 Oct 2023 02:23:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b40b406074526eb@google.com>
Subject: [syzbot] Monthly block report (Oct 2023)
From:   syzbot <syzbot+list688244bb9b6f6399051d@syzkaller.appspotmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 3 new issues were detected and 2 were fixed.
In total, 29 issues are still open and 87 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  868     Yes   WARNING in blk_rq_map_user_iov
                   https://syzkaller.appspot.com/bug?extid=a532b03fdfee2c137666
<2>  427     Yes   INFO: task hung in blkdev_put (4)
                   https://syzkaller.appspot.com/bug?extid=9a29d5e745bd7523c851
<3>  101     Yes   INFO: task hung in blkdev_fallocate
                   https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<4>  38      Yes   KASAN: use-after-free Read in __dev_queue_xmit (5)
                   https://syzkaller.appspot.com/bug?extid=b7be9429f37d15205470
<5>  34      Yes   INFO: task hung in nbd_add_socket (2)
                   https://syzkaller.appspot.com/bug?extid=cbb4b1ebc70d0c5a8c29
<6>  30      Yes   INFO: task hung in blkdev_get_by_dev (5)
                   https://syzkaller.appspot.com/bug?extid=6229476844294775319e
<7>  24      Yes   WARNING in blk_register_tracepoints
                   https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<8>  19      Yes   WARNING in wait_til_done (2)
                   https://syzkaller.appspot.com/bug?extid=9bc4da690ee5334f5d15
<9>  13      No    WARNING in process_fd_request
                   https://syzkaller.appspot.com/bug?extid=1d4201dfe9f2386fdc0b
<10> 12      Yes   general protection fault in start_motor (3)
                   https://syzkaller.appspot.com/bug?extid=1fad709a9a55674f0e0b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
