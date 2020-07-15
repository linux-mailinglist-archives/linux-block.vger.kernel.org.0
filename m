Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7AF220972
	for <lists+linux-block@lfdr.de>; Wed, 15 Jul 2020 12:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbgGOKEF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Jul 2020 06:04:05 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:51934 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730958AbgGOKEF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jul 2020 06:04:05 -0400
Received: by mail-io1-f71.google.com with SMTP id l1so1064658ioh.18
        for <linux-block@vger.kernel.org>; Wed, 15 Jul 2020 03:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lZUjqSiBJwDYPm36WdPBclDG5mrQQmRv25qcSv9nR2k=;
        b=gdBSK5C2ZNLaBOGdxPC/BLkaefbIjgkOzFNXj2EYfxbEa65+LP1usIhVUyBEt2Q0al
         8Ud2p2yAVRDk9zKxYBmZSzNVmtA6rmTJ/jfAmzhW87Vg7jKbzJs1jFpeXCR+cFBIYWvd
         Izcf8d5vULtpRSD0Pm4VRNzaXndHpM/MQgBq6oQwcGcO1fm786GMHXbzFEl7Itd9zO8j
         GWXNG3kQv1k3f4YA7oBQguXGb9hOaHh5w8tdze7BMd12cSSKD6Bi2hkvlOBnj6I1fG59
         gtlQ+/BIvYDyZY44zshjFuSIzs2KFxKxEfCxmMmhx5FMeqmWc5Asv/MrRiMaMCwJgq4+
         qb3g==
X-Gm-Message-State: AOAM532X2ajFzFNlCS08722aM1T+C6FzSX9eP1ZWINOcMzYkC4TsRAio
        0FoQGzBwTdNItshGKG1QPW9tWpI7hTiLSHSbC5V6RLNm/Gsc
X-Google-Smtp-Source: ABdhPJyycIp0AkfnugimTuwXQFSQQrRqDsnXwJhn4PoiwmUZVLf3foo73PthW2MSKGMpHMirmBnKlHZU4uzD7gjkdcVFSe3C9xDx
MIME-Version: 1.0
X-Received: by 2002:a92:7309:: with SMTP id o9mr8619036ilc.5.1594807444150;
 Wed, 15 Jul 2020 03:04:04 -0700 (PDT)
Date:   Wed, 15 Jul 2020 03:04:04 -0700
In-Reply-To: <000000000000e6807f05aa4608b7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031a14405aa780bdb@google.com>
Subject: Re: WARNING in kthread_queue_work
From:   syzbot <syzbot+fa64e680a1ff32087778@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, qiang.zhang@windriver.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has bisected this issue to:

commit 4977caef05aa154f5e45a232fc4f0e1c74a0c739
Author: Zhang Qiang <qiang.zhang@windriver.com>
Date:   Tue Jul 7 02:29:47 2020 +0000

    kthread: work could not be queued when worker being destroyed

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12c58f57100000
start commit:   89032636 Add linux-next specific files for 20200708
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11c58f57100000
console output: https://syzkaller.appspot.com/x/log.txt?x=16c58f57100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64a250ebabc6c320
dashboard link: https://syzkaller.appspot.com/bug?extid=fa64e680a1ff32087778
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bf9f2f100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118380ed100000

Reported-by: syzbot+fa64e680a1ff32087778@syzkaller.appspotmail.com
Fixes: 4977caef05aa ("kthread: work could not be queued when worker being destroyed")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
