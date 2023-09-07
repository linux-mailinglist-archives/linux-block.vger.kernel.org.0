Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFAE7976EE
	for <lists+linux-block@lfdr.de>; Thu,  7 Sep 2023 18:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbjIGQSt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 7 Sep 2023 12:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbjIGQRk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Sep 2023 12:17:40 -0400
Received: from mail-yw1-x1145.google.com (mail-yw1-x1145.google.com [IPv6:2607:f8b0:4864:20::1145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4508A7A
        for <linux-block@vger.kernel.org>; Thu,  7 Sep 2023 08:55:52 -0700 (PDT)
Received: by mail-yw1-x1145.google.com with SMTP id 00721157ae682-58c8cbf0a0dso39973057b3.1
        for <linux-block@vger.kernel.org>; Thu, 07 Sep 2023 08:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694102012; x=1694706812;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3uorYgBy/vSzGATNXjGaFcQjl0zqUtF7P8rETQPdQ6s=;
        b=RLnEsUgrEto7+C0mePm0qrfRhjpzFRh/KmMVBp6WIl8gcKzBbXq3r3lwjAR/5jBG/a
         vk3sgnoGG8TSHlN0be9TehKZQOnUrGlB9Y+pzJ+2qJqRS9IbNBxQDnRxjyz5VUGmqaSr
         abdXNeyQLkoL4k3yrAy/RjIHwLGKwdGxyB0EtWMmOsxG17oB1Lmqe/Rklc+NzeTJsZna
         FLhQCca7/yi6RTKRhnR4PSwjSRRmpBdvNqFF5EPYYvvxmWShsjpqqu1iVNw8N4KwQYHI
         gBtT17MbIS+Iw22c9kkSKXTZ9Mja98KHXB6NyPKxCP7TI4dDbF0EQrazztLzv49bTHBi
         BMKw==
X-Gm-Message-State: AOJu0YxeYGkUZ+P5UFrinrW3GB9C5HXmrQA060iVqJMZ7ox5eFGISi6Q
        MWcl5vVE7pDl8G3n2d0U1HZu/2rml2CcXcZPvaCrC3Gttm29nz0=
X-Google-Smtp-Source: AGHT+IFv5RoDlYTTHNTZRVCYgdQ3cCvXQcVZJdqAENmmBoZNBWPCxhGShggp718Md5FgEKnzPNCIe8409SLooz2fwa7VgMNc/OBG
MIME-Version: 1.0
X-Received: by 2002:a17:903:32c2:b0:1c2:2485:ad7 with SMTP id
 i2-20020a17090332c200b001c224850ad7mr587578plr.4.1694078749617; Thu, 07 Sep
 2023 02:25:49 -0700 (PDT)
Date:   Thu, 07 Sep 2023 02:25:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017b6b90604c17266@google.com>
Subject: [syzbot] Monthly block report (Sep 2023)
From:   syzbot <syzbot+list4766b5991d014e82a610@syzkaller.appspotmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 5 new issues were detected and 0 were fixed.
In total, 31 issues are still open and 85 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1987    Yes   WARNING in copy_page_from_iter
                   https://syzkaller.appspot.com/bug?extid=63dec323ac56c28e644f
<2>  407     Yes   INFO: task hung in blkdev_put (4)
                   https://syzkaller.appspot.com/bug?extid=9a29d5e745bd7523c851
<3>  252     No    KMSAN: kernel-infoleak in copy_page_to_iter (4)
                   https://syzkaller.appspot.com/bug?extid=17a061f6132066e9fb95
<4>  95      Yes   INFO: task hung in blkdev_fallocate
                   https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<5>  36      Yes   KASAN: use-after-free Read in __dev_queue_xmit (5)
                   https://syzkaller.appspot.com/bug?extid=b7be9429f37d15205470
<6>  25      Yes   INFO: task hung in blkdev_get_by_dev (5)
                   https://syzkaller.appspot.com/bug?extid=6229476844294775319e
<7>  24      Yes   WARNING in blk_register_tracepoints
                   https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<8>  16      Yes   WARNING in wait_til_done (2)
                   https://syzkaller.appspot.com/bug?extid=9bc4da690ee5334f5d15
<9>  8       Yes   WARNING in floppy_interrupt (2)
                   https://syzkaller.appspot.com/bug?extid=aa45f3927a085bc1b242
<10> 5       Yes   WARNING in get_probe_ref
                   https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
