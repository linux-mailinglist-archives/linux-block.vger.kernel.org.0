Return-Path: <linux-block+bounces-28114-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A76ABBED10
	for <lists+linux-block@lfdr.de>; Mon, 06 Oct 2025 19:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE0A3BF5ED
	for <lists+linux-block@lfdr.de>; Mon,  6 Oct 2025 17:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69134242D63;
	Mon,  6 Oct 2025 17:29:30 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD90223F42D
	for <linux-block@vger.kernel.org>; Mon,  6 Oct 2025 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771770; cv=none; b=e6RPgBogFnpfohtGS0h+Fakx8PGd9obKlIMiSYtT4nV/PLZMfBf/Vk90O/U0S3vwqVD82XVbAaM6MfjKIcikH5uOi6O6TBvJ5ER2273DkARivjffmGTRbObI1raTR+puZruMZkggQdWoyot4Cqmb1Y2HdpXhTA9StCquP/uzRnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771770; c=relaxed/simple;
	bh=UfYkNlIqJ0UOcXUYMjPVrcZj2rIGaSllfBYPjdPn8fU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LrMkaoV2tvYqkCmG74lWl5uIDpOjkeOi46WM/39/KhSMWDW9CuMu5qcU7knSFl9lwUOHCAgkO0qm+3TOxEDm/2WqWyVNgxOkdgT/JUvnlhSmw2luCGydrlt2NenCxzV4zpij8KAeotyNFd7O638qHdl98wdznuOvZvFs4IZ7WAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-911c5f72370so570116639f.0
        for <linux-block@vger.kernel.org>; Mon, 06 Oct 2025 10:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759771768; x=1760376568;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qYSGI+wm950aF63lFDgqtSx38FxRnb1uTcZG6/4yc3Y=;
        b=NTRp5XNzs0Kp1mYcU4fJ16kbmB4dqZd76v/LeFOMAQ8Oz7ZJTiR9cOF4ywKbLaexTu
         62CUdtH94EKAiSmHe/tlohKb7ehxDYSERk+9wan1jYSKn4otl8FaTROs6iE0eQZMeGKO
         gpVuk9/QNX2saa2vdkX/ja8qRlKjWur5+RgGyNSpsgAzu3EGfP+weJ8QJAfwu7cydp2N
         DKLrGJG1J1yn5ifav91P8//P7ilbJ7UDG2LmRqaxn7Iz+NOPske+qd/PXBdZrxzbQqYl
         sX1RWcGxsRfMXOU8MG7AO0j21zMeUtFYxKtPbdjcHFi/AU1I1bG4yWycM2ra63PW1+OC
         CJ2w==
X-Forwarded-Encrypted: i=1; AJvYcCWQ76ZPA0hSQndsxI0AtiNdpnEjP8pW9etp+wK8UaOlQpZCz2SKLqGVRedwcLdSDErrz1Hw8ti0EGOHWw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1WNPKqBsFmRRCs89Z3oeQkMRCZpiSDne2C8yvT7gbMMzIuMMI
	SUe0w4VesXbABNMVWp4GyPhoYSNqt3eP79C39lvgDsdXaHCBGCsTh73YCx2lk26EHJFMjvv64bB
	XqzawZuaOLvMCA2h5SvXvj6xVrgCYSY2ncn0zcYr/6v9jBE/8SEzj4w6IrUo=
X-Google-Smtp-Source: AGHT+IFU19mSImJx6lton1MLSZgMp/idojUMivv0dv20oP6EqORkEcAASG3o4o0SdtLiJarrNuwleMsqT6tgK4XpkuHhHS6TQiiM
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1889:b0:42e:4c23:5363 with SMTP id
 e9e14a558f8ab-42e7adb29a1mr189932465ab.29.1759771767957; Mon, 06 Oct 2025
 10:29:27 -0700 (PDT)
Date: Mon, 06 Oct 2025 10:29:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e3fc77.a70a0220.160221.0006.GAE@google.com>
Subject: [syzbot] Monthly nbd report (Oct 2025)
From: syzbot <syzbot+listddef0da3f5f843882aee@syzkaller.appspotmail.com>
To: josef@toxicpanda.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nbd maintainers/developers,

This is a 31-day syzbot report for the nbd subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nbd

During the period, 0 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 8 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2150    Yes   possible deadlock in pcpu_alloc_noprof (2)
                  https://syzkaller.appspot.com/bug?extid=91771b3fb86ec2dd7227
<2> 310     Yes   INFO: task hung in nbd_queue_rq
                  https://syzkaller.appspot.com/bug?extid=30c16035531e3248dcbc
<3> 146     Yes   INFO: task hung in nbd_ioctl (3)
                  https://syzkaller.appspot.com/bug?extid=fe03c50d25c0188f7487
<4> 88      No    INFO: task hung in nbd_disconnect_and_put
                  https://syzkaller.appspot.com/bug?extid=aa56a8f25e07970eef7f
<5> 62      Yes   possible deadlock in nbd_queue_rq
                  https://syzkaller.appspot.com/bug?extid=3dbc6142c85cc77eaf04

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

