Return-Path: <linux-block+bounces-26682-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E76CEB41F34
	for <lists+linux-block@lfdr.de>; Wed,  3 Sep 2025 14:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD6A6866FA
	for <lists+linux-block@lfdr.de>; Wed,  3 Sep 2025 12:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3CE2FFDC6;
	Wed,  3 Sep 2025 12:36:38 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D263D2FE05F
	for <linux-block@vger.kernel.org>; Wed,  3 Sep 2025 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902998; cv=none; b=F/6ALpK8+5OFlWJAko2qUaBB7AqcuMCePnvAES8VEe0Z06AIky/CdSSPkLd7KoU/UShiQRaqrK0Vhiyz+SCA83gt1o7iCbPxrPSu0wj3/qGGGpZHjHaAvqujlQwz6TVjxa3fW4PrEcUnDc0sMH0v8lrPlnifz+r7nEqTJcYlc1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902998; c=relaxed/simple;
	bh=OeZ2/DC7R0QGjvivR5IydEgfYsUxOmhBrplooZ0Wm9o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DULjs+cDqhcXqvfvOc0euqyn7vNPeK9eO5BXVpgwZ09zkxzQIE5rCDrHgmmfrMA2SpESzEHEq1Jun8pbH9JmkWULf3EMMMue7oPvsxN6XbCWgv+BoGTK9hFgGXClCkUGTYX2yH/rpr9RmCMcM42IuDAo41JTNlyZALwzPKrxgJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3eea931c037so150998925ab.0
        for <linux-block@vger.kernel.org>; Wed, 03 Sep 2025 05:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756902996; x=1757507796;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2LHOUvTxUHRDZHTuy2WgSxf7xJT4vtu2i2hgQBjuX7w=;
        b=mgaKQkN2yK5x9GomCq7vVvuAMwvGGucg0Dq7F3GAMFqNCt6zIEszhhUjlk9vmKYLzl
         su/nMlOOUHLiSSMAlALuZZigcrGZabYm1P+Cl3npXTvgOxOa3iOxOrgptHYteVHTxpdB
         79/0w3gNseSyVE3tN+s6t1j2NTDvMUkU32b4bdqxikVJxujl96qGXfSBUpidC+gtv2Q6
         BFkvH9C5kLya4EOo/p55qzo+YCAqF4jLPZnUQlVeJGjjZFhUrgLMNQq72SzuTEfsRJx6
         3uXRCklHuQUi7fwqrO6bRKr3ZHPcfdn2A1VzLsgRKuKWqNbwORfKKJJNirYR4hpX4SFU
         Fyxg==
X-Forwarded-Encrypted: i=1; AJvYcCUuTb75L0Xh4jAt5W5p4qaKD8z4FmQF/9l2v0Q+4ShJx+2fFN0goNkybj81LXE4CiuwAFGwxrXFLbzkEw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ZvQT4renP3kYigR6SqVt+fuA0D7EIAZnX+xIelUP6KNl/d3i
	XpxYk6Ewr9DkzUFozULhFafUFpQk19w5b24nm2KmfowPdPQh0IijRquFgNmVMfbBJvAF0LyGIA3
	iDNMTWTxLYxiX/rwxSrr4G8Xlf0wJ9tggqyklNBTE3Zep7AqIE7VpEPSHAUc=
X-Google-Smtp-Source: AGHT+IETUswS2yDFuaaHHg2PyJKvgAiFrqCIYR4tRHFKt9SSy6k3VMVIe6nukUo/0neTzFmx7S3M8oMr51X9urYuFi1S6OfiVxkd
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1488:b0:3f1:a5b9:4a32 with SMTP id
 e9e14a558f8ab-3f3ffda5bacmr225600425ab.1.1756902995790; Wed, 03 Sep 2025
 05:36:35 -0700 (PDT)
Date: Wed, 03 Sep 2025 05:36:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b83653.050a0220.3db4df.01ef.GAE@google.com>
Subject: [syzbot] Monthly nbd report (Sep 2025)
From: syzbot <syzbot+liste8f48e3526c73d4bcab4@syzkaller.appspotmail.com>
To: josef@toxicpanda.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nbd maintainers/developers,

This is a 31-day syzbot report for the nbd subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nbd

During the period, 0 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 8 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 861     Yes   possible deadlock in pcpu_alloc_noprof (2)
                  https://syzkaller.appspot.com/bug?extid=91771b3fb86ec2dd7227
<2> 304     Yes   INFO: task hung in nbd_queue_rq
                  https://syzkaller.appspot.com/bug?extid=30c16035531e3248dcbc
<3> 143     Yes   INFO: task hung in nbd_ioctl (3)
                  https://syzkaller.appspot.com/bug?extid=fe03c50d25c0188f7487
<4> 55      No    INFO: task hung in nbd_disconnect_and_put
                  https://syzkaller.appspot.com/bug?extid=aa56a8f25e07970eef7f
<5> 6       No    possible deadlock in nbd_queue_rq
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

