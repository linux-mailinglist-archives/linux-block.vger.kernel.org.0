Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7A3EF69E1
	for <lists+linux-block@lfdr.de>; Sun, 10 Nov 2019 16:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfKJPqM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 10 Nov 2019 10:46:12 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44425 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfKJPqM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Nov 2019 10:46:12 -0500
Received: by mail-pg1-f195.google.com with SMTP id f19so7533889pgk.11
        for <linux-block@vger.kernel.org>; Sun, 10 Nov 2019 07:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2GQxyegm0e037btzeEVrHaTSoeZSraQmKEF2HPtcINM=;
        b=iT76+jqdNNWdjCQpvuTo3yccQOGR0HF+Vv8uFc80bOjg5+6/QCNi9N4XCDxrlmtZQZ
         jTDXAvm6Ni5EyKsKAO64wIdHFKHZfVHypp/Akr4g0KVcgTuC1g+F2b1RAQsbzb9j20LF
         iOybYFb60Cb2ex2uQ8h6ecwW9fS8Yumwkr8OArCiwjoT/GP6QXb7TYFGn9of+RMjRwmL
         Z7tIFtXCBDI4bs0FHdfquiMmEJdYS1kbWI9beyWOK93RQa9p5Ifj+b3wARLX2xhL/hXQ
         //Wv7q/9XFN8ofBdUy24esQtUFUCQq7sadQtnaxWYlIqrdP341tJ1WUFT/u2T8Fk8Uni
         QCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2GQxyegm0e037btzeEVrHaTSoeZSraQmKEF2HPtcINM=;
        b=llCRoDtJC9ETJV9+auDIqWpru1TdbHXoHHUWa9vNW9G74Mja4+A//5YVPcRRrrsbTJ
         nQaOwfyevoNNwqE013A4NKw1h7Gai7aoSZUIwZOi9z64fXxVMTp0H7yK+l38rTSncanE
         0fiBdCxzlzxqAFDKrvJ1Xtlc4+2J7gHqJ1IMqBhmTWiR8kxxBG85XsodmL2sBj+fzaNj
         GItekQP0M8KmohYfZmVFUnqtkWv/GF6bmt10HjFJNC89KOM9L42KBNn+Snal+Fi+hPG7
         EjibJkZmQ2ItREbFM4NYFUsAo/arv0dI0cXmRzfDO5TZsrOIx9iqCES8Khc2a9a0SI/q
         9xbw==
X-Gm-Message-State: APjAAAUSPzbizrWbyBFQpW24VIoUd/CgJSuDVssUKvkxO4FRulUbKZGv
        UF6jp3tjrWr4bol8cc6vgp+wsh6pwkY=
X-Google-Smtp-Source: APXvYqxavNec6jVy0ssikQL5rcqDsZqRzOK/WiO6T6ozJAH7dR1eaCKDtNe/a15zS8npgO7vYxaorA==
X-Received: by 2002:aa7:9295:: with SMTP id j21mr7289159pfa.50.1573400769979;
        Sun, 10 Nov 2019 07:46:09 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id j126sm13804259pfg.4.2019.11.10.07.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 07:46:08 -0800 (PST)
Subject: Re: KASAN: invalid-free in io_sqe_files_unregister
To:     syzbot <syzbot+3254bc44113ae1e331ee@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <000000000000e11df90596fc9955@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e3ed8352-23ca-246d-088c-878f9da82c76@kernel.dk>
Date:   Sun, 10 Nov 2019 08:46:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <000000000000e11df90596fc9955@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/10/19 4:49 AM, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 65e19f54d29cd8559ce60cfd0d751bef7afbdc5c
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Sat Oct 26 13:20:21 2019 +0000
> 
>       io_uring: support for larger fixed file sets
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154f483ce00000
> start commit:   5591cf00 Add linux-next specific files for 20191108
> git tree:       linux-next
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=174f483ce00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=134f483ce00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e1036c6ef52866f9
> dashboard link: https://syzkaller.appspot.com/bug?extid=3254bc44113ae1e331ee
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116bb33ae00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173f133ae00000
> 
> Reported-by: syzbot+3254bc44113ae1e331ee@syzkaller.appspotmail.com
> Fixes: 65e19f54d29c ("io_uring: support for larger fixed file sets")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Thanks, I queued up a fix:

https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.5/io_uring&id=fc2a85cb02efd7bdbd09ea5d2d9847937da7bff7

-- 
Jens Axboe

