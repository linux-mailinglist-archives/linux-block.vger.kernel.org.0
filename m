Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F27749ED0
	for <lists+linux-block@lfdr.de>; Thu,  6 Jul 2023 16:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjGFOSD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 6 Jul 2023 10:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjGFORz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jul 2023 10:17:55 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76531BFD
        for <linux-block@vger.kernel.org>; Thu,  6 Jul 2023 07:17:49 -0700 (PDT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-53feeb13906so1171079a12.1
        for <linux-block@vger.kernel.org>; Thu, 06 Jul 2023 07:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688653069; x=1691245069;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EWHU7qQSpq7jEJZ7piv+O344Wp3pDTZ25crNyt0IquE=;
        b=YpqImG+aCq4gIXQ7U3S+tS4KJs9GGJgMn1bL0ajJYnHqN5LeEKaX5pIp2SkulW2iZj
         skjvZSYiLqut/hH1CCJhG4Nyew3Z9hdh53q9tQ4mJQ8N9fStTKKHxdPjshsMYGvAM533
         vug3injPWC8kNiNd1xjnDY3UwmrE4mmaa+H1a+yKeixftrZBdmfH6nqZvTr8Gx2LlCxH
         gqU5qqljkX1+JSOqBRzk5UncZ6qLUFn4xQ8OC0ZbmkVSmvkqpNKe2oACqL1SjIgKgcyc
         QJWed7t4qLLX/YTpfmOGf6ezPk+I4cVqYOIhCZUVtat0CL508TBfJG3Wal0rq+DHnA+j
         q91A==
X-Gm-Message-State: ABy/qLbm0LE18JWQ3OJfNgoHy0FO80LiWQekcmmvpJk9X50vbhDD33PR
        A7Q9sIX3v2VJpl7sND70C5qq684UC2xKddbyMBHJIFTmoguQz8k=
X-Google-Smtp-Source: APBJJlFnQOv8pcKufgaBpnQIaZTboCZmV5Y7/rYQg0qpVvW3Yd/t1EywnTS6PCcSG+zIswYld+6jwe3nSErbdENbkN9gDmuS96PN
MIME-Version: 1.0
X-Received: by 2002:a63:36c8:0:b0:55a:e875:36be with SMTP id
 d191-20020a6336c8000000b0055ae87536bemr1030831pga.8.1688653068977; Thu, 06
 Jul 2023 07:17:48 -0700 (PDT)
Date:   Thu, 06 Jul 2023 07:17:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053502e05ffd22edb@google.com>
Subject: [syzbot] Monthly block report (Jul 2023)
From:   syzbot <syzbot+list131e433296c0242f0025@syzkaller.appspotmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
In total, 30 issues are still open and 84 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  976     Yes   WARNING in copy_page_from_iter
                   https://syzkaller.appspot.com/bug?extid=63dec323ac56c28e644f
<2>  386     Yes   INFO: task hung in blkdev_put (4)
                   https://syzkaller.appspot.com/bug?extid=9a29d5e745bd7523c851
<3>  179     Yes   INFO: task hung in do_read_cache_folio
                   https://syzkaller.appspot.com/bug?extid=be946efe33b2d9664348
<4>  111     Yes   INFO: task hung in __filemap_get_folio
                   https://syzkaller.appspot.com/bug?extid=0e9dc403e57033a74b1d
<5>  87      Yes   INFO: task hung in blkdev_fallocate
                   https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<6>  33      Yes   INFO: task hung in nbd_add_socket (2)
                   https://syzkaller.appspot.com/bug?extid=cbb4b1ebc70d0c5a8c29
<7>  32      Yes   KASAN: use-after-free Read in __dev_queue_xmit (5)
                   https://syzkaller.appspot.com/bug?extid=b7be9429f37d15205470
<8>  32      No    KMSAN: kernel-infoleak in copy_page_to_iter (4)
                   https://syzkaller.appspot.com/bug?extid=17a061f6132066e9fb95
<9>  21      Yes   INFO: task hung in blkdev_get_by_dev (5)
                   https://syzkaller.appspot.com/bug?extid=6229476844294775319e
<10> 10      Yes   WARNING in wait_til_done (2)
                   https://syzkaller.appspot.com/bug?extid=9bc4da690ee5334f5d15

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
