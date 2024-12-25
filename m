Return-Path: <linux-block+bounces-15746-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4119FC4B8
	for <lists+linux-block@lfdr.de>; Wed, 25 Dec 2024 11:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34E26163D19
	for <lists+linux-block@lfdr.de>; Wed, 25 Dec 2024 10:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB311B21AB;
	Wed, 25 Dec 2024 10:07:25 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944B51925AE
	for <linux-block@vger.kernel.org>; Wed, 25 Dec 2024 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735121245; cv=none; b=LxeR2nGfgxGdbeAXK9QJN1Fg7/7MrMnKnRzuNsmwY1jwlU3dICKYaoEI1q9VM/rZVdjtK6TnnBMgJfUZd8TkE0sojXzNeYp2v8D9pbtg1oGg/0RWORUx3DBjAVgUrVGshfIwGfn4P3dLFTMIcNYV8H7dsgA72+on3EdGm7/M7K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735121245; c=relaxed/simple;
	bh=ld+H+GOZ+148+d8km0HdqbFu1AKry0FUdGlwL8yXPjg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VTOkzj2Xxqr2a3IEONN8MZSTCqacgdFHUmXTQ3jNsoFDN/LBhrHDJxOUphYgcjkgETtttVm7/57p6LF5dy7jpKQvonRwOMRE2Nwn19OKJXDOSkLe5X0Rm4y539g9Vr4LgaD0cbQV6+cjOh1DDCw1zdDBNU63yFkmAu9wZ7gSwcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a819a4e83dso60519165ab.1
        for <linux-block@vger.kernel.org>; Wed, 25 Dec 2024 02:07:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735121239; x=1735726039;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WNivbUa6+4Ughys9abAGbWAgtVIkfDguQE7jRYMVtB4=;
        b=hmOjD88FOXkdnR38ovEbfc2n4+IQ5LijFNE0nBpP6jWrPluh1L22/6p8AZ6j2sWeLv
         w05DwtW5PTJwSvtXkMKRjwwJC89VkDzVq4vHEgBaPARdJEytPK/KA1cS3T2ZVhQOCrBa
         jzk+q+gz+lQkAU29GQbLEtDuJAQLDx/LIjg0IONH0mqzGr6GUswp7Ef+LMzPoTIcaFTh
         pJrs9FAbYZCYZeOHFMNlILhJ8tqWy3NR+qOp58u0vdbJAdWeTvgOkGMalOq6EYKIDwA3
         PHowY3Ad3EgPOoYGtVpNlbExjDIeIVKFuAKqyYRxd20E0YGKTGRXJRSRRhcEghTHtvls
         qJdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6YRkpJr5jmNArCYVz2u3skAsSYlUDRQSdHnXBSpyRcjOYUGIEId3neI8c7Nf65TVmTKMWANQeV9LJGA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+G2ifEg/1tqZG2YJ4eV3W/nIgpw5tui67BAaOEqjt+PVf16MB
	L9TXvc7B3gSZFb+T/KquYTV7ACVkWOTIHDmcYMrZqjwCem8EBjz20/7qHs6tG0qKGQK8qNdwjEt
	k/Sz50DEvlw5eM0VAPBsdGDcyNCruNrVPY/X9p1U0fPnvMuOUDLIp5xw=
X-Google-Smtp-Source: AGHT+IFMtVOZJVNwUJ7/iLAMok5mGb7P+w3OjPP2mflGxI1ocxud/M+iwc4qeTi9EiG+/Fxs83zn5K4Ws8T85Qo3DF7Ad4rhQlL3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a63:b0:3a8:1195:f1f9 with SMTP id
 e9e14a558f8ab-3c2d2564124mr185082775ab.6.1735121239760; Wed, 25 Dec 2024
 02:07:19 -0800 (PST)
Date: Wed, 25 Dec 2024 02:07:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676bd957.050a0220.2f3838.02e2.GAE@google.com>
Subject: [syzbot] Monthly nbd report (Dec 2024)
From: syzbot <syzbot+lista56c9771895bcef0bc37@syzkaller.appspotmail.com>
To: josef@toxicpanda.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nbd maintainers/developers,

This is a 31-day syzbot report for the nbd subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nbd

During the period, 1 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 6 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 133     Yes   INFO: task hung in nbd_queue_rq
                  https://syzkaller.appspot.com/bug?extid=30c16035531e3248dcbc
<2> 129     Yes   INFO: task hung in nbd_ioctl (3)
                  https://syzkaller.appspot.com/bug?extid=fe03c50d25c0188f7487
<3> 25      No    possible deadlock in __nbd_set_size
                  https://syzkaller.appspot.com/bug?extid=143deed0891e0c211d8f
<4> 12      No    possible deadlock in __synchronize_srcu (2)
                  https://syzkaller.appspot.com/bug?extid=c89fbbd2838560d51069
<5> 5       No    possible deadlock in nbd_set_size
                  https://syzkaller.appspot.com/bug?extid=966c3b607cb094ce7299

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

