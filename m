Return-Path: <linux-block+bounces-6177-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A06B8A2F2D
	for <lists+linux-block@lfdr.de>; Fri, 12 Apr 2024 15:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0161C20BAB
	for <lists+linux-block@lfdr.de>; Fri, 12 Apr 2024 13:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F393E823CB;
	Fri, 12 Apr 2024 13:18:22 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907548174F
	for <linux-block@vger.kernel.org>; Fri, 12 Apr 2024 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927902; cv=none; b=sZlIQHcKxp3iX2WdpwUUhvZPqqQD2DH7u0cWEFDmUsFRA8ECnEXwL/V7uAub/np2n/EbduVnsEwvzFTZMuUwutqMrLASKjR+KRYzxqeIyJhcCHxVBYZ0EQkRDaoDcvabbjGMlHy9c4jfQbhG0mMZHTozikZJx+VZEepOlScL4cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927902; c=relaxed/simple;
	bh=10LLZDrGOU9wrEZQUx7zq0sXQtH4PdfTYhAVtwrWfek=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sj75DcSRkQT2+6kh1dsSDMoAK4/n9KMje0bEdJUftNIbVLYh4drd158obcz2OkT6bqqeuboVTELXFcckm6jBuyU3RuBUjaBCiO6Av7JZoKoM2YwGWnXfy5Q72UKeZBDRAokIiv6lMZidmy6dv1TPTppyn7UR18+obXAWArtojts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36afb9ef331so9774765ab.1
        for <linux-block@vger.kernel.org>; Fri, 12 Apr 2024 06:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712927901; x=1713532701;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/Mqv+/ZO+3xx7M9EDTPVKDbLutpy3xdH8I/GFId62E=;
        b=I+k8QuHkPpvmWaEbvJnB18B9YZaqWQ7wq4e/E6VPoN5WeK4ZbV1B6plgw8g20RSMf1
         kHTNzLcO/qxsvYLPgT+v1Hq6zRPeuEc3i+Jxv7XS2pE0U17CsufLsEAtf0cu+F8NWasV
         YbLYwFFoXU0Zts5m+X290P9j1ymj00umNAhWIS5KxK5IdadDQQSESzvf8U9QpVuEMk/X
         c9dL1WghqjbdIOKVRHJvm/NzcvJG11wuXkqUBQwcBv+4UmlDQ6XJ9p4whnbsvJqfKPw6
         xLoSmENQtwYNxwxG4LLwVysWGOddrno9SSsdJ4KptT/oZLGb4UtWUazj/otN4Ms1dn1P
         6vzQ==
X-Gm-Message-State: AOJu0YxILtLaphLokSGAPd7kDnyI9/wPQv9DO+ZLLw+CNpPDJ4/DqsXb
	c3TGK2p2BBWAQPgJZRboIn4opF1TdVV1Wsmr6rpL8YXYPYFdTO0TCG1G7FWJW6Z6vt2U9d/NAj3
	UGaOxbMwc5j9usNmLzWgUUuFHeiXVHPtGOaB17QNtTfGSajd4zoymHcY=
X-Google-Smtp-Source: AGHT+IE8vttjY9NAE6uAnOWzX9Vm1MdDFAe8ZTTMKL/qQ8uy81c+9dwqlhcgD7YXNi0KHYUX52veWeJRJ7fmrUkWYJDoN7o3L58W
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca47:0:b0:36a:a6c4:2 with SMTP id q7-20020a92ca47000000b0036aa6c40002mr222389ilo.5.1712927900815;
 Fri, 12 Apr 2024 06:18:20 -0700 (PDT)
Date: Fri, 12 Apr 2024 06:18:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000de9270615e61b58@google.com>
Subject: [syzbot] Monthly block report (Apr 2024)
From: syzbot <syzbot+list813439a47d944440e6fb@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 1 new issues were detected and 0 were fixed.
In total, 21 issues are still open and 92 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1571    Yes   KMSAN: kernel-infoleak in filemap_read
                  https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<2> 220     Yes   INFO: task hung in blkdev_fallocate
                  https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<3> 198     Yes   INFO: task hung in bdev_release
                  https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<4> 25      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<5> 8       Yes   INFO: task hung in blkdev_flush_mapping
                  https://syzkaller.appspot.com/bug?extid=20e9a5e0dd424a875f55
<6> 7       Yes   WARNING in validate_chain
                  https://syzkaller.appspot.com/bug?extid=6647fcd6542faf3abd06

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

