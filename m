Return-Path: <linux-block+bounces-7325-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D9E8C48A3
	for <lists+linux-block@lfdr.de>; Mon, 13 May 2024 23:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B203A1C229F8
	for <lists+linux-block@lfdr.de>; Mon, 13 May 2024 21:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AE1823CB;
	Mon, 13 May 2024 21:12:25 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C601DA24
	for <linux-block@vger.kernel.org>; Mon, 13 May 2024 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715634745; cv=none; b=JdzrM8Sz5/4LFb93gvDcpkjO3A8egWNCSsM6zAf49UO3f6dWddsXyU7IESy3TXPMhcNxz1TH65B6TYpGoV27Q4pybukB3MLZwfFSjpGnpbQbuldenXWecZixZ60a0uvu5CSx2L5BkEPvSxUFFhOWcGYZTzuYk6bv9XW8toT9Ecc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715634745; c=relaxed/simple;
	bh=8EnRdsBjowrNdTSYXjh3wQuSkxjMck9SaCyVU3wiW2o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YIZpEw7DrmWS6aLGndGecZYcrYLW+/Knp9YhNYfCmpEN6sTQpWzyqDm9+bkRQ+V1NoqDztFe9zGxzrvmtl1ngBTqvgBIgMeOOgfE8SCDZL5B/yvfDUZ4iYzQ1PB+Ut+mTp4+Lk4CTxaxRoZ8i4vn0VzdWQ0FJeLElWLZcea3WLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7dabc125bddso585300639f.1
        for <linux-block@vger.kernel.org>; Mon, 13 May 2024 14:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715634743; x=1716239543;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O0cHBhxMMfEjJ9WT0QLR66DdBILB117/YjTROp4tBsQ=;
        b=tm4N6RepjZBlEctg6kwjylIrvtBZOp4xaw5MBnWZq/w4e+bQXqM1llea4n1ebf1VEa
         kC3xn1RQKE7AnP8ybk5QwJKg3Pny3jFseDzZ11oa2gRt7fyR4JWYNmgTvU/6zxOMk0j7
         FftATg1gd/QWJ9swGpTcDIlpUN5cx1bYY9zMiuBdIa2TTu9ObSi30vlfoevNt9TGWdRt
         gHY9BkDVip+TNFXY8owHIqvjd1s+F29oH8ei7vbg3EnVZdqp8gHVfPScFwyv/HPwTzWd
         kjwWVvN7dzsPuDCIX4bEL6bqUcLoK5jI4G/6rIwAVnuMYUhbwznhof4a7++5rwE7DfzC
         dLTQ==
X-Gm-Message-State: AOJu0YyDC+XjHjQ93X5SKIKfTbkRyCWMjg6HOOFiiDLp7/zcrD/ElIJM
	TvU8YDWGf/OGSf2X0u4K37Dhe/Sr59cP68Yauq6rvcTPOpJpI8Ejaz3esfqu5kcFLLuFGTBkXyH
	IAgXY+nV0JfG/Ho0DGlZjBNk2G7C0hHUU6SVxIRXUcBINcY9NNN4DDzg=
X-Google-Smtp-Source: AGHT+IGjoGKqX3GEU/1VaxWLx2c6lO30ElEalCWyHZ/iQadcTse7eh+3dp533KeKJyR1DbX/J/0UyreloVCdvGxBbcSH3t9w3Yy1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8305:b0:487:100b:9212 with SMTP id
 8926c6da1cb9f-48958af8591mr886940173.3.1715634743006; Mon, 13 May 2024
 14:12:23 -0700 (PDT)
Date: Mon, 13 May 2024 14:12:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006be76306185c57ba@google.com>
Subject: [syzbot] Monthly block report (May 2024)
From: syzbot <syzbot+list9b070cf19dd61929702c@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 3 new issues were detected and 0 were fixed.
In total, 23 issues are still open and 92 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1830    Yes   KMSAN: kernel-infoleak in filemap_read
                  https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<2> 385     Yes   INFO: task hung in blkdev_fallocate
                  https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<3> 204     Yes   INFO: task hung in bdev_release
                  https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<4> 36      Yes   INFO: task hung in nbd_add_socket (2)
                  https://syzkaller.appspot.com/bug?extid=cbb4b1ebc70d0c5a8c29
<5> 3       Yes   kernel BUG in set_blocksize
                  https://syzkaller.appspot.com/bug?extid=4bfc572b93963675a662
<6> 1       No    WARNING: locking bug in mempool_init_node
                  https://syzkaller.appspot.com/bug?extid=d24a87174027a66198b8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

