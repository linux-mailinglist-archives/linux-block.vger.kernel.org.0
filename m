Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663C13FAABF
	for <lists+linux-block@lfdr.de>; Sun, 29 Aug 2021 12:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhH2KJZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 29 Aug 2021 06:09:25 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:46936 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbhH2KJY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Aug 2021 06:09:24 -0400
Received: by mail-lj1-f181.google.com with SMTP id w4so20084939ljh.13;
        Sun, 29 Aug 2021 03:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=lZ8a62LsBSbCVNMfLtZfAK/Yj9mseijBB0w1OSZc27M=;
        b=AYszIwPeSM4n8qYMiHhPNjnp8hHXRai+PPK7eGDOnGKCFdwqswve842cSSkBbWIltP
         7BmmUhLQfOD36EOQUy1DFAuhk1wRXv6LsbwXKbBE7v2mQBAOq3sp2+08s+10R49QgfeZ
         4caBvBuTI8H5Y7BkZF6sS7TxxSDqza7/uvDFYYZPgCTXmPKUuHRdeNUMSZV43ioduSRV
         Nq/Y5tvDzPCAel3D/mAIowOpXBj1h1w8YDn+kqo105mG8uepO8eAvTiQu5C1UsZG1go+
         u3e3BSnHtOesboa3wCx0hsUj6rzYI1B/2+36KoDCvTHAR9KHjRLmLn5y9AqMLkBoEFjn
         NzEQ==
X-Gm-Message-State: AOAM531iJiU+dTJFw7R0B3X0JUu+jl2KZGFtmNBGK9iQnH0GClKxL8sc
        +9Q2NVqN8bR1t9SFwbW/7ppTpT3oWtFHIQ==
X-Google-Smtp-Source: ABdhPJwLI9Xn31NPmvy9xta3XWhY8V3pnojHLkk6peP3unPMAnMxpWip1yqKkY3zcElhnC9wwi8hEQ==
X-Received: by 2002:a2e:86cc:: with SMTP id n12mr15725920ljj.384.1630231711533;
        Sun, 29 Aug 2021 03:08:31 -0700 (PDT)
Received: from [10.68.32.40] (broadband-109-173-81-86.ip.moscow.rt.ru. [109.173.81.86])
        by smtp.gmail.com with ESMTPSA id m24sm287602lfb.223.2021.08.29.03.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 03:08:30 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Linux-kernel <linux-kernel@vger.kernel.org>
From:   Denis Efremov <efremov@linux.com>
Subject: [GIT PULL] Floppy patch for 5.15
Message-ID: <388418f4-2b9a-6fed-836c-a004369dc7c0@linux.com>
Date:   Sun, 29 Aug 2021 13:08:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Sorry for the late PR this time. I'll resend it later if it's too late for
your for-5.15/drivers branch. Thanks.

The following changes since commit 461d971215dfb55bcd5f7d040b2b222592040f95:

  Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.15/drivers (2021-08-27 16:32:01 -0600)

are available in the Git repository at:

  https://github.com/evdenis/linux-floppy tags/floppy-for-5.15

for you to fetch changes up to c7e9d0020361f4308a70cdfd6d5335e273eb8717:

  Revert "floppy: reintroduce O_NDELAY fix" (2021-08-28 11:16:47 +0300)

Please, pull

----------------------------------------------------------------
Bring back O_NDELAY for floppy

Only one commit this time with revert of O_NDELAY removal for the floppy.
Users reported that the commit breaks userspace utils and known floppy
workflow patterns. We already reverted the same commit back in 2016
presumably for the same reason. Completely drop O_NDELAY for floppy seems
excessive to solve problems it introduces.

I started to write basic selftests for the floppy to prevent this kind of
userspace breaks in the future.

Signed-off-by: Denis Efremov <efremov@linux.com>

----------------------------------------------------------------
Denis Efremov (1):
      Revert "floppy: reintroduce O_NDELAY fix"

 drivers/block/floppy.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)
