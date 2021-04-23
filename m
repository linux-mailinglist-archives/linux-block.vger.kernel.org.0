Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F53369B65
	for <lists+linux-block@lfdr.de>; Fri, 23 Apr 2021 22:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243975AbhDWUjk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 23 Apr 2021 16:39:40 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:38710 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243797AbhDWUji (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Apr 2021 16:39:38 -0400
Received: by mail-pg1-f178.google.com with SMTP id w10so35981944pgh.5
        for <linux-block@vger.kernel.org>; Fri, 23 Apr 2021 13:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=CBw2oUkcioQg/YhgjnYpEN+gBNhmtSzKfowoLKnIaxI=;
        b=s1j5OgyOOsabd4m/t4tH5SjS7tukHl1osyny09s66ROaQ7DzVKTf/xLr+K1KxY/sDm
         +g7IG43YaiQHywFURTLjhFRAbHeJCub3ZK2+tC3pUXnbtJXHHHGVQSZx4ixBMwuopdXV
         GPj/eQ/jIp2fB0vMnRUKIuWUGDEkXYyKxl4axUqJUBa2usWqIPJdZVORD+CAyexBirac
         VicSOxkxfJqINd7tKTsdznmsWF1Drqr9zsiQBYYriM3KPw8NDRheis7ZGl3/CoYhd4c/
         1O2j0T1vtyr37MfKzHAaIGbIq254SHbEHeGdr7d9iBRfAyOZ5RUoz7qD9n5uEQ5kLnro
         hafA==
X-Gm-Message-State: AOAM533uQmPy+/Yeqsfx4RAie34ct78OcozOfG8B4qAGH+r2X6H4byVd
        gRnjEdDAdEVRI+ENO2yLlShG9QDFe8o=
X-Google-Smtp-Source: ABdhPJzDO55tNAo1mX27srErRmmEvYzWxXZIsASPiTDWv4GKxMqFdvUl9KCeEsmK8EOF/cr6qFPGKA==
X-Received: by 2002:a63:aa48:: with SMTP id x8mr5524925pgo.246.1619210340068;
        Fri, 23 Apr 2021 13:39:00 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:a976:f332:ee26:584f? ([2601:647:4000:d7:a976:f332:ee26:584f])
        by smtp.gmail.com with ESMTPSA id j10sm5541781pfn.207.2021.04.23.13.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 13:38:58 -0700 (PDT)
To:     Changheun Lee <nanich.lee@samsung.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Subject: New kernel warning triggered by blktests
Message-ID: <45925919-ea46-1e38-2983-87b12c12003a@acm.org>
Date:   Fri, 23 Apr 2021 13:38:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Changheun,

If I run blktest srp/001 then a kernel warning appears that I haven't
seen before. I think this is a side-effect of the patch that limits the
bio size. Please take a look.

Thanks,

Bart.

WARNING: CPU: 1 PID: 15449 at block/bio.c:1034
__bio_iov_iter_get_pages+0x324/0x350
Call Trace:
 bio_iov_iter_get_pages+0x6c/0x360
 __blkdev_direct_IO_simple+0x291/0x580
 blkdev_direct_IO+0xb5/0xc0
 generic_file_direct_write+0x10d/0x290
 __generic_file_write_iter+0x120/0x290
 blkdev_write_iter+0x16e/0x280
 new_sync_write+0x268/0x380
 vfs_write+0x3e0/0x4f0
 ksys_write+0xd9/0x180
 __x64_sys_write+0x43/0x50
 do_syscall_64+0x32/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
