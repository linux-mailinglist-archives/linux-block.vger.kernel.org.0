Return-Path: <linux-block+bounces-15643-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51079F80A2
	for <lists+linux-block@lfdr.de>; Thu, 19 Dec 2024 17:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0FAD16E76A
	for <lists+linux-block@lfdr.de>; Thu, 19 Dec 2024 16:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E17F143736;
	Thu, 19 Dec 2024 16:50:05 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A387153598
	for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627005; cv=none; b=OGKqXauluFTY4ygYtd7Zgp82YAb+nJIZC+XgIKIfiVTUCSc7PMpAbWsNu30zpGC8yOmk1RVcNWH4LkBZXtPmOJD7Ck8oHvcgGFxI8L+94eD99ac9jp7QiDSSv+P8E4ld896HLJjP9vwGbYHwNkQU3rLx/oQYa3zeMA1jGiaLEyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627005; c=relaxed/simple;
	bh=gS+npKdZGQZAbsWwUEudkXa3CKGCK66fIhIEVF8JjKY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=c8HESJrAhYeGoo+Rr5nItxvpJFxGLjgD15GYz7qSe57lw7NVAfvs1xMU+yoTmkV7wSQvLOLV2a6+LMXS1Oo6OH0CeX6a5BJQvYt5v8UGK2hvAxQMnOBhxHuqYvE9Ly77j8hSUAFCHHQzq9H2ZlLuzWcHciF3/j4mXgpcFXt+OPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-844e9b92401so163837539f.1
        for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 08:50:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734627003; x=1735231803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4m5ECO5ZQYjU363K3tYMrrXZVX5Ak+kvSrvy0oU41eQ=;
        b=cc0/tC57CzelpXwLg5Qx+XmHApoLoQw8TBZQPz0+ggW2/lruLUboOQeG5iv4WwIoMp
         7n34NHph3dLTqMx1s1vnHRHWrKDFFJWWcTLC9aybYOu9P9IySIq7Nqjihe9nNSd9cO+G
         kYyi6EpRXxjhc7kJmuJdNRX467bR+Ef7rkYMFPcvLMpZm1RgirKJUrrWvQn5N84zNYpx
         dfh+SsJqxreOp2DVHO6TwZb6gl1295N68DzXegmLbeOWD7vKqbwcOZCJtB92bcV4eVNE
         7YS01nUdwRaM21MmG7ZHeyZHv9mDYPekjvhI21lMrquILiXNJV6xL4rSsAMlzsSrDzzA
         cLKA==
X-Forwarded-Encrypted: i=1; AJvYcCU8Wx4UFdP7kp1Jejk2G+NK1RgCHmAzy+LcaRQ4n5iZlukVntB2dJwJenJAf9J5Z7eGo0S5JuxuLJmTwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAhz9KNkZCCfyio1F4rUAclb11MzjwSqSslpOkyFzM6Ksb6Leb
	WVIloXf8dc4aAcx5qbxs+7dXyEHTK/Em2p8IM2NXL+QR3Iz50W1pNf1moZJQSjQWhugM5t0yB03
	ldF6UXprdY0qieg3en/keTFsMcth1Y/wRAdQJjnqPOv/ZWPRQ3p3jFoQ=
X-Google-Smtp-Source: AGHT+IGq9d8xZKFDmkARN3f/WM6Eh2iRfI+5dIlGJY6myaXwmpftKqfsBzOeYPZR0+Elp5/JMzLFhbx/Ilstz/LNysJK6bxIfXw5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:168c:b0:83a:9488:154c with SMTP id
 ca18e2360f4ac-847584f267fmr893413439f.3.1734627002755; Thu, 19 Dec 2024
 08:50:02 -0800 (PST)
Date: Thu, 19 Dec 2024 08:50:02 -0800
In-Reply-To: <6714a705.050a0220.1e4b4d.0035.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67644eba.050a0220.1e8afc.0001.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] general protection fault in put_pwq_unlocked (2)
From: syzbot <syzbot+aa930d41d2f32904c5da@syzkaller.appspotmail.com>
To: axboe@kernel.dk, cem@kernel.org, clm@fb.com, djwong@kernel.org, 
	dsterba@suse.com, josef@toxicpanda.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 62719cf33c3ad62986130a19496cd864a0ed06c3
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Dec 23 22:50:29 2023 +0000

    bcachefs: Fix nochanges/read_only interaction

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17a4f7e8580000
start commit:   eabcdba3ad40 Merge tag 'for-6.13-rc3-tag' of git://git.ker..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1464f7e8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1064f7e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1234f097ee657d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=aa930d41d2f32904c5da
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16dc4cf8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12faef44580000

Reported-by: syzbot+aa930d41d2f32904c5da@syzkaller.appspotmail.com
Fixes: 62719cf33c3a ("bcachefs: Fix nochanges/read_only interaction")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

