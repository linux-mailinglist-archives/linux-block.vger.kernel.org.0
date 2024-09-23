Return-Path: <linux-block+bounces-11672-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BF3979029
	for <lists+linux-block@lfdr.de>; Sat, 14 Sep 2024 12:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882D01C22F00
	for <lists+linux-block@lfdr.de>; Sat, 14 Sep 2024 10:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6720C1CF2B2;
	Sat, 14 Sep 2024 10:58:28 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE76F1CF286
	for <linux-block@vger.kernel.org>; Sat, 14 Sep 2024 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726311508; cv=none; b=Rqpz6LS6i9i7s059NnsMKBWK4jVwmzK6wDOY3f+Yot2mBj49hszsN0I7f0FO9WwGIPF79n/oKcnBodoY5NKErtGrxHddIcy/7DtlBRon7y4BppLOBvbGvs/wAVE/46fzS9kbc6iFhvxhxVFBET0vKhREQ/T1/vgm8e5n2hyV7bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726311508; c=relaxed/simple;
	bh=8cPaGWVNvaiVsXGhl9BZ46sbtKEhwpT6r7AafzNYscU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Tndm/Z1gvzezh+gfNjPRNoZy4zj2EkOZbkphcoDyWqQgUnNSzwlDPXN5RtUesHwKbpYrlzqWubcsQ601P0N4tl9aMUR3VZBLeImSob1vLbat7GwH+dKRsnUbCOKXo66meuEM4IgziZcQzTlXTqmR7pjkew4qlJa6J121oXckscM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82aad3fa5edso507404739f.2
        for <linux-block@vger.kernel.org>; Sat, 14 Sep 2024 03:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726311506; x=1726916306;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xSXhuj3zISCMZB3nnxahyL41R/wox4A+ugF2KROurmQ=;
        b=VGkIJS6qktWvC5UsH/boGc8R7UDeKFmC9nT0hZHIxVX2I85xSPJngLMHMhUaRx++Xe
         FbmdWt9qA9d4MmbYd1hryqoAadVmuLMOOQ9qh9CZGj0QxyaiV9zpASxqUEsj/Acw78q7
         869+6HiwLhrLEIg/HXdpmC6MA43Ny5Xv8kx8GNjG1LQegAQ5AyxAukCMvlyOC28PXndF
         m0ljyevfPkt7Le86H8iTY03ECDOCPWjZrYGu26GfDGvFOz6/qUOKl74p6Yn3O4QYpbd6
         2HlUMHF/nxiXxAlaGDcqwdZoz7VlpjXsTNsVn/+/RohtLSgrft7YK7OIglB8VXcfGsnB
         MA6g==
X-Forwarded-Encrypted: i=1; AJvYcCUOTtw7monUj2STs9bg4sXCXDLjrNQWX1ZkcLh58O1ce3Yn/5lIojB+RlGTWjh3PSvcCN8Co5IpSOu4kQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXyLCWmNs7ACfbMTXn8zXYXBeWej9+L7Kwj+uTrrB4/XfotssO
	+ti8fJHTabm7OtVs3YV0oBCmUpbCV56WiwcYtwfhgsPMtikMcIRUmt+T9GK2ezWULzUM9ercrLW
	Mn269YlVRhPG4y6bkVPy+7dAMY2541fH1gPCcWTINrf1HyOwU9z0O+u8=
X-Google-Smtp-Source: AGHT+IEbp4K5Yuh/JujyoRFTiZfkIFNS7LT8IRlV7c50hWWYcE5sW6Kz1S9OHTVBkx3CynhKyyD9L0xgwQU1PGG6lWtwo0a3T57g
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:48e:b0:3a0:52f9:9170 with SMTP id
 e9e14a558f8ab-3a0848e5d4emr79133095ab.1.1726311505762; Sat, 14 Sep 2024
 03:58:25 -0700 (PDT)
Date: Sat, 14 Sep 2024 03:58:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66e56c51.050a0220.3a9b1.002f.GAE@google.com>
Subject: [syzbot] Monthly nbd report (Sep 2024)
From: syzbot <syzbot+list5448e58c688bab5fb496@syzkaller.appspotmail.com>
To: josef@toxicpanda.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nbd maintainers/developers,

This is a 31-day syzbot report for the nbd subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nbd

During the period, 0 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 6 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 126     Yes   INFO: task hung in nbd_ioctl (3)
                  https://syzkaller.appspot.com/bug?extid=fe03c50d25c0188f7487
<2> 42      No    INFO: task hung in nbd_queue_rq
                  https://syzkaller.appspot.com/bug?extid=30c16035531e3248dcbc
<3> 7       Yes   INFO: task can't die in nbd_ioctl
                  https://syzkaller.appspot.com/bug?extid=69a90a5e8f6b59086b2a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

