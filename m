Return-Path: <linux-block+bounces-23566-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A589AF5996
	for <lists+linux-block@lfdr.de>; Wed,  2 Jul 2025 15:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EBF13A6388
	for <lists+linux-block@lfdr.de>; Wed,  2 Jul 2025 13:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC83286439;
	Wed,  2 Jul 2025 13:32:33 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B195A275AFF
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463153; cv=none; b=k4oV29abHi7bw+4/7c8fNLki96gLRyhLRP4fEkzA15wZlnoPe6UYEFwXN7Ujn6p53jrW2uiIrUrfAyJ96dxknEthyXuXyw4mZJSxy4mZTpielxq+JxW+DOdPhhpXbrY7tGGPKDSoM2Z1b4fq905M1i484w6qLKhcRNPvzoITyFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463153; c=relaxed/simple;
	bh=0UysnKiHVvlQW4D9CjU0APKZI+eBDzvzOKsOIq/LkuA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=J6SwUxb1wPgQVGcDL8n/aZs2WcDXyZTDf3FGvDWaOBM5PjoxxxVk80UF7u5JaiKIa340cV0kJqKawUoL3uqOCR5SVIY5smWe3tZQtcWbvvXMJWg/3AZ8S63uRbFpzawjJIC1I/vbIMnZCBYi++kPJ6NmI2PHPADObZQ6mVrElmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3df3b71b987so39198755ab.0
        for <linux-block@vger.kernel.org>; Wed, 02 Jul 2025 06:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751463151; x=1752067951;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BubBoaagMLzEv8l+ERjtuMPNq+Ob+FgzeUx4GVvJZL4=;
        b=WQxHFVdq/a1mVqfAMkWK8lp6Ao/Il7vov+auwZPl9mGbz/sNKZeYa8hNwcpvrBEBgk
         rtPbUNIftB2DUr3Ux5oZKCEourarQBMWjzxEDEK1qTTIqcSwCnZD+sSNOUtX5ETCP51p
         Cczu8LYXLHE0BJOZRwbVUmcWE4yUUDCJoV9UGSoWxbXu6l7tQMwmPu8HiOIfco/3A/Qx
         PvxB9pWNom3x/iJPve/gsL+5OeANq000vwAPop8u5xp/T1rLIyjRq3nVRkwFx6hE45jF
         M2+miPP/IlGLS5gOAYwCE5WDRoZog2NFRApJcXNzlEbdKqSp8VJm8qgZrvILJ9dPCqOQ
         Y4tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUupNEu0g/tTeaklBnJlwB0amlgvmvQ667ogjVBaY/Vl0DRDE8e8t8WtcJrrYDbWVimaSeBRMm7IIck/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yytrb1q++MFssds4I/8YF6t8VfSkzOHhZSPaHGSOA7H+NfIbnZ8
	keB41W/Gr4S/NUiid4rdvaWIp2BI0X3LSn9vOelp7gZ6+7YdTM7aZSej/mlGTtBjF/mMRQFnfny
	CSYEEVbmghZXRvC5e1UHyJ7wfd3Yo2K+PSQB7QEwCyJhc1PmQnR6ViYiFlUw=
X-Google-Smtp-Source: AGHT+IHrimW8AKa/QhbwsVFAuzkmWEJwu5jAAhd5cDMyuxLiN0due4eoa8Liqe22LG8AEgSEqp6N1ctGEi1FXIX6eNNGIE53a9al
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214f:b0:3dc:8b29:3092 with SMTP id
 e9e14a558f8ab-3e054935199mr29220845ab.5.1751463150832; Wed, 02 Jul 2025
 06:32:30 -0700 (PDT)
Date: Wed, 02 Jul 2025 06:32:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686534ee.a70a0220.3b7e22.245a.GAE@google.com>
Subject: [syzbot] Monthly nbd report (Jul 2025)
From: syzbot <syzbot+list09715b34c25b498d986f@syzkaller.appspotmail.com>
To: josef@toxicpanda.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nbd maintainers/developers,

This is a 31-day syzbot report for the nbd subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nbd

During the period, 1 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 7 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 288     Yes   INFO: task hung in nbd_queue_rq
                  https://syzkaller.appspot.com/bug?extid=30c16035531e3248dcbc
<2> 141     Yes   INFO: task hung in nbd_ioctl (3)
                  https://syzkaller.appspot.com/bug?extid=fe03c50d25c0188f7487
<3> 12      No    possible deadlock in nbd_open
                  https://syzkaller.appspot.com/bug?extid=ea702c2366971b7fc6e4
<4> 7       Yes   INFO: task can't die in nbd_ioctl
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

