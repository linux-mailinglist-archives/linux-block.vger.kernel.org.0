Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E886104A73
	for <lists+linux-block@lfdr.de>; Thu, 21 Nov 2019 06:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKUF4B (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 21 Nov 2019 00:56:01 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:34624 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfKUF4B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Nov 2019 00:56:01 -0500
Received: by mail-io1-f71.google.com with SMTP id a13so1459622iol.1
        for <linux-block@vger.kernel.org>; Wed, 20 Nov 2019 21:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=mfH1KiCJRKrkCk6Xo24N026hP3QeH2tnCMon9TkgaqE=;
        b=t/TcPuWY9xCF6SCZwTcoQetfiRAS8hFFVbeFXvW+Tu9D0BIB5erT5x6kwKO6fP5SQ5
         +AM2MMQ9DYKLawmu9MIGh5z+yaVWd4nAqYqLElHzDnbEDdjVtizGZaoJ7Q3EItmegwHX
         zxI5F59YXr1O3mxMcK3Ew55RryIlXcatHI1GP7yXqNbmZamh4CcaDVb2Ce8AVRkwb0MK
         Hm5X/tXzpnlneeXr8JeSTX44tkI89z24dRt4RmPHuHU4ToxD23SJeXkfkqxeOqbPaCmt
         bNUQll08v/l8EGmdbrtFGZX3FkcyePRW892J5YgKLyw/Fwcv25UOkmYVxFode0OQTr+R
         TRHA==
X-Gm-Message-State: APjAAAXqcy6cqfFK00Jj/pBx8OCCfzyKBVL7kc6BtAd6HpeuwcfZrK71
        QRjzhfjdhB+8x9S/59+ss7wVgF+2f7MXhFROp0oauBPAjPcz
X-Google-Smtp-Source: APXvYqwUKLMPCVsGilywR82DgOMl8S8nXlNM4DAw4/+MPXBC9kph9vWN1fhkX08eEJ5ztd1Hs8pxMXnFldFW3iiHqxZP+FOWzVdW
MIME-Version: 1.0
X-Received: by 2002:a6b:9245:: with SMTP id u66mr5976497iod.98.1574315760516;
 Wed, 20 Nov 2019 21:56:00 -0800 (PST)
Date:   Wed, 20 Nov 2019 21:56:00 -0800
In-Reply-To: <00000000000072cb6c0597635d04@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab834f0597d4f337@google.com>
Subject: Re: INFO: trying to register non-static key in io_cqring_ev_posted
From:   syzbot <syzbot+0d818c0d39399188f393@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, liuyun01@kylinos.cn,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this bug to:

commit 206aefde4f886fdeb3b6339aacab3a85fb74cb7e
Author: Jens Axboe <axboe@kernel.dk>
Date:   Fri Nov 8 01:27:42 2019 +0000

     io_uring: reduce/pack size of io_ring_ctx

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f98af2e00000
start commit:   5d1131b4 Add linux-next specific files for 20191119
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17f98af2e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13f98af2e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b60c562d89e5a8df
dashboard link: https://syzkaller.appspot.com/bug?extid=0d818c0d39399188f393
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169b29d2e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b3956ae00000

Reported-by: syzbot+0d818c0d39399188f393@syzkaller.appspotmail.com
Fixes: 206aefde4f88 ("io_uring: reduce/pack size of io_ring_ctx")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
