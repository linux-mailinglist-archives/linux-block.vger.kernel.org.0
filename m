Return-Path: <linux-block+bounces-22223-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DF4ACC4F6
	for <lists+linux-block@lfdr.de>; Tue,  3 Jun 2025 13:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6BF16D096
	for <lists+linux-block@lfdr.de>; Tue,  3 Jun 2025 11:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD8822A804;
	Tue,  3 Jun 2025 11:07:36 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DA722ACEE
	for <linux-block@vger.kernel.org>; Tue,  3 Jun 2025 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748948856; cv=none; b=Pi51jQniUtNrL4i1iCWVgxANgh3F+QdHFlm2zFlj5VasbEjXJEEWGb+dGZLFfXORUy4WV20cazv99MobUPu1+jCwczDuNia0+TUDof2i2swCHvun2zSg5pqWdZtYxIIGNKtenBueYCvnQHs/ov34sPLBZrTRVEylfpLzBnwGcGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748948856; c=relaxed/simple;
	bh=4hbfj5sk/5AB04z35bRJN6lFh7ptHm1xUFlOrm/nFNc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=g/lqoRNYGs45RD5ieUggDrqEAG/MWfGxpJ8QKNfn1S6tAtTkGFpJzAs+6RVqLbIyaqnRbg011IvWOeI5ce6HvCUEbDZRpsmdwy0IT6yi4BjRhS1ju6W8m45FoJAIIZFA40qyvqnYKh/0iI8nBX4q27N4in1b0UTEZ5NvbD0RsXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ddba1b53e8so4443465ab.1
        for <linux-block@vger.kernel.org>; Tue, 03 Jun 2025 04:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748948853; x=1749553653;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zLSrHWHbfNcA561XoJBDbzrjzmQLC4U5teo5ImQYiP0=;
        b=lUhvWEqoZRdP0NnU8yMLoHocRlA0aV76l3AS0gTWXoewtoEsjJN0VKPl3JCVBLZMEU
         SV3ZQENjUiDVEhqzHI7jORmgEd284+qGQ9v+NHw8r6CuLEIgzgPr3KfRW4IlTwkJ5n5o
         rvi8ay/xtjZ1pExs/jwYGyKb/AyoqRMd3FYYJ69Hsy1EVpsBaIz1SwMByIPiUtWyGkD7
         /EaoXrfyD2m0rWo2AGdwSExS3hFOJKBMDG8nvxwuQwE8h5Qdr0cbhyV8TJt+ljZqgTw+
         L7U+USelDM6pHWJ/S6bg8fdVvbFVM3rZ6eOxyaAFPqLwN+4HsdtWtXYDVuaDtRdlnVkw
         lGzw==
X-Forwarded-Encrypted: i=1; AJvYcCUYyFMdtiDQ+jcAmaP1P0yqghZjTV43o185uzsgrbStdH66r5fh2Y4LFQVQyvwv2ZhELb8rn3zLBjzcyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWu6GV0003UXNkRlOVRlTK3TOW9oSgrXjXzee3pbvckRs0TD95
	6I/VL1f2XYIagrjg10dgRmGgbr+oCbTz6Gy0N/yB2kCIKSm7aNuvm4/J4xDksA4TgFm7SVT65l8
	ZvTZpalkIOD8tSw3oVOO77Wh4HtKhxBIo2n2RL4ZLrjWRVM3pphZNbKnk1RI=
X-Google-Smtp-Source: AGHT+IHtUaHEYDxtHe0U3SnICJX2cwJl+0M+OnT9H8IlulFaatAkd4pYEAgGae5VDAkYnjSlTg9TR+OlXSISbm1Am68ps6Np5uBh
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e05:b0:3dc:7b3d:6a5a with SMTP id
 e9e14a558f8ab-3dd9cbeed37mr130630885ab.10.1748948853398; Tue, 03 Jun 2025
 04:07:33 -0700 (PDT)
Date: Tue, 03 Jun 2025 04:07:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683ed775.a00a0220.d8eae.0066.GAE@google.com>
Subject: [syzbot] Monthly nbd report (Jun 2025)
From: syzbot <syzbot+list5809bc83320af48e7eee@syzkaller.appspotmail.com>
To: josef@toxicpanda.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nbd maintainers/developers,

This is a 31-day syzbot report for the nbd subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nbd

During the period, 1 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 7 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 271     Yes   INFO: task hung in nbd_queue_rq
                  https://syzkaller.appspot.com/bug?extid=30c16035531e3248dcbc
<2> 140     Yes   INFO: task hung in nbd_ioctl (3)
                  https://syzkaller.appspot.com/bug?extid=fe03c50d25c0188f7487
<3> 3       Yes   KASAN: slab-use-after-free Write in recv_work (2)
                  https://syzkaller.appspot.com/bug?extid=48240bab47e705c53126

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

