Return-Path: <linux-block+bounces-16565-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AB4A1D524
	for <lists+linux-block@lfdr.de>; Mon, 27 Jan 2025 12:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C4216623D
	for <lists+linux-block@lfdr.de>; Mon, 27 Jan 2025 11:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25380139D1B;
	Mon, 27 Jan 2025 11:15:31 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9463325A646
	for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737976531; cv=none; b=mrRiubFK5uteKE+u1/EQIIV45PWnfMLzgCEQ9Ot6wp48stFq33aLuyu5YZGxk7VfUsJVKRlr78ELrcIYsgUckb4J8uXaprnpW2+9B4iBuELc+CQivhYK9qMzjyHcB9QDHqZeptsgXjcaGl2uk8q5RC2k7d9d2VxLP918VddOVls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737976531; c=relaxed/simple;
	bh=7RojPXEfQInBkBOkmXTmegSBJ0i4YqcSkd3Q1IOYrzc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nXhjFxpTWQai7CHPaGAloYp+Zj9CwX7JWKPYPVRDsQw7i0Y+4voRGZO+2h+pMW1hzGzdMEDPYPj9HYTZnEOxrbpJFLUglNMof94p4D8rVjcoSKZlZK1FMxeeGZaUkzS0MIV7BMezT4zv4HqJr61pvKpBUzkW/ME6PwnVT90KjFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3cfb2d37dbdso28979385ab.2
        for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 03:15:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737976528; x=1738581328;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U9VsM9mGHoc3CZ9tfRxD8Mr7R1jbAb5PHM9M1B23YDU=;
        b=NotzXYDcCXVTgQ8Hinq/vuSYqgbhHFnNvhANbW9vo66c9EmU4NtcUsphif7EebDbRJ
         VXCrXVqCkkceZZfzdLIVxVRRCMf5MaKaCfHLrJq6f2JWjaiOUtxzMNQgGxLoYbaqKdXi
         6Ch3Yy2Cf94UdIclYf6JD829LLxiAovXHyfrLsGDdA4bmZMEL17ah4FqFVx6Z73raM7G
         MRjdYwJz/Roq+NdG9TXEWNjqhd7xfuN7ePaLqvW8qr2Z+yPUrVQdmoDJTQU7hpxTDbVX
         ZgECVTi3DV4iswvXt/q/5MPwZUP3tOv6uoypPyKYsqY8oAX3sTcuAqIXytg9+qmHsdun
         3JGw==
X-Forwarded-Encrypted: i=1; AJvYcCXqVkapjTWzSb+MzLTAD0ma+5C8S161AqBtFwN50HEby1bMNGRE367U5WzPDq3/XX+479P2QeJj6lA3HA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLjTLBLUKOLTNCPCdhBvUEHZQRfr/AyplDAXy9tp+PuJ8blpHv
	pUfg5hO3hSXPGxKLvmZ0EsygeDw7TSO5OEL2ycqq1zMvfCWYW9sEG1fp8gfZEMnnwHXnJp1cInN
	52RDIYXKLDNXB7Y9kCjC9qckZngXsXBy4QlOBoQbHScr0GRmdqG00tks=
X-Google-Smtp-Source: AGHT+IHUsaApuOgybLxJ3ecANG9BZ7j21jn2ar1FOYqG5KqwTRLwHv8VRUqsp9bVxWE/fRPgYHksE8KZ1E0lH6IWDlVTsOTqRtSj
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c5:b0:3ce:8ed9:ca81 with SMTP id
 e9e14a558f8ab-3cf743d912bmr330575525ab.5.1737976528664; Mon, 27 Jan 2025
 03:15:28 -0800 (PST)
Date: Mon, 27 Jan 2025 03:15:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67976ad0.050a0220.2eae65.0046.GAE@google.com>
Subject: [syzbot] Monthly nbd report (Jan 2025)
From: syzbot <syzbot+list06c5a9a8f8fd9d49242d@syzkaller.appspotmail.com>
To: josef@toxicpanda.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nbd maintainers/developers,

This is a 31-day syzbot report for the nbd subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nbd

During the period, 0 new issues were detected and 1 were fixed.
In total, 6 issues are still open and 7 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 200     Yes   INFO: task hung in nbd_queue_rq
                  https://syzkaller.appspot.com/bug?extid=30c16035531e3248dcbc
<2> 131     Yes   INFO: task hung in nbd_ioctl (3)
                  https://syzkaller.appspot.com/bug?extid=fe03c50d25c0188f7487
<3> 26      No    possible deadlock in __synchronize_srcu (2)
                  https://syzkaller.appspot.com/bug?extid=c89fbbd2838560d51069
<4> 8       No    possible deadlock in nbd_set_size
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

