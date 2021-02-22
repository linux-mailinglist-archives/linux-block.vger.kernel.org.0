Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9763A32209B
	for <lists+linux-block@lfdr.de>; Mon, 22 Feb 2021 21:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhBVUFx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 22 Feb 2021 15:05:53 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:45481 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhBVUFt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 15:05:49 -0500
Received: by mail-il1-f199.google.com with SMTP id h17so8670985ila.12
        for <linux-block@vger.kernel.org>; Mon, 22 Feb 2021 12:05:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pLRhfTwy0FUDr6U+czrEs8kT0CiU0z5KeTk0hw3Qk44=;
        b=q5W+8EdoBzcaMNFEqLosIZk73MTSfUlA9aBTDV5tJpRDt4fcIFpwszoODGe5ZTI0NN
         EP5G5vT3WzBg9JucQZh0O5Gl3f7iTHMI8pkhwVCj+P0wYtm8Oz8pptJQb14PxhKOCHd/
         2izZVRYlLW4XY3S7pirWB68t90aVSAHUtRJy8CY0FS69+DRGxYSiM973BZ657RmUbq4F
         x11j8hbRVu2zg2ePiqObOLqCUO0nGh2xddNJjhTtZuQWzS+RavQ7ynaPZH+s1GNwPSom
         WfXxSR4kY6aRu5ap3K9HzpkKiir8qhPIqjCazORfdbk3B3NbPiACcVfMqQj1xVuzli8X
         zj1A==
X-Gm-Message-State: AOAM532lbudMrqENWuX5wXAOhHd8Xaf6b32yupm/AD/Z9hN/XkQi9QQo
        TMlQ9mfG1Q47IA0YevFOnjKi+VvyzcokpKAG7dcu91tDU3iX
X-Google-Smtp-Source: ABdhPJwszLmEf05WJAk7l0wSG1p+UlAXJeVI4fkex5PIO3u7zUVcnSOF4SeEDaLWNi51O4a7o1C+CBhUI8f7on020bFHQ1vhJh9q
MIME-Version: 1.0
X-Received: by 2002:a5e:8615:: with SMTP id z21mr9597031ioj.132.1614024309299;
 Mon, 22 Feb 2021 12:05:09 -0800 (PST)
Date:   Mon, 22 Feb 2021 12:05:09 -0800
In-Reply-To: <49ac93fc-57b0-1f94-c43e-f9ab9a3913af@toxicpanda.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d5c1205bbf251b9@google.com>
Subject: Re: KASAN: use-after-free Read in nbd_genl_connect
From:   syzbot <syzbot+429d3f82d757c211bff3@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+429d3f82d757c211bff3@syzkaller.appspotmail.com

Tested on:

commit:         2b31ee47 nbd: handle device refs for DESTROY_ON_DISCONNECT..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/josef/btrfs-next.git nbd-kasan-fix
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ff2a923e3615ffe
dashboard link: https://syzkaller.appspot.com/bug?extid=429d3f82d757c211bff3
compiler:       

Note: testing is done by a robot and is best-effort only.
