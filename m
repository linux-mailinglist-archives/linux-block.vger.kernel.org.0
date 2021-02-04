Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472C930F039
	for <lists+linux-block@lfdr.de>; Thu,  4 Feb 2021 11:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbhBDKNE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 4 Feb 2021 05:13:04 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:37715 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbhBDKM4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 05:12:56 -0500
Received: by mail-lj1-f170.google.com with SMTP id m22so2716261ljj.4;
        Thu, 04 Feb 2021 02:12:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:to:cc:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=miyRJuOeBOtEV39DJpRHkSNP1r8kzb8jg7PJ/3fyMug=;
        b=m0/AmqfsV0vE3w/bR5saGcx1LpZyCp31kc94fsPY9rYkWYU+87c/tGRYb6Kr2x6kf3
         fxGno+XK/rURVUwAV5iyIkIUHsmHXAHkcwPxzpZr0G1wOti4bQyYvq9jk4vxJu20XNjB
         zPSUuN000caVZvxF/JhZqxNFv4ymdprQYM+5ev66AbUyrL+nkS1ImmnvcKceCRhGNoMe
         i3RDkHnV6YY72qhkRRgX6X5Ix+k/W4f0WiEuWpLuFAziKAcp8yO3+coasByVav7qIFvY
         IRv9iLJz71opuPF3L7MKFwbD2OGcJu/QpzNQxkqx42DYNB1/ajlPVFs0PDnyBhSdgE+t
         oi5g==
X-Gm-Message-State: AOAM533bhXpSkFRn9Sm+RMqfKro75LU8qY/YVwsswsKPJmZKdb0RiOkB
        oSzlwaGJi+ChIcWvAL6axg53Jli5Mf0=
X-Google-Smtp-Source: ABdhPJwXmCVETvaxv5iW5esOR1QNiHMfQn3s/NKlGMoSPgONQgN65H5rjGU2EBFoGR4fIFBuUymIiw==
X-Received: by 2002:a2e:3307:: with SMTP id d7mr4423040ljc.155.1612433533888;
        Thu, 04 Feb 2021 02:12:13 -0800 (PST)
Received: from [10.68.32.65] (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.gmail.com with ESMTPSA id b24sm554880lfc.160.2021.02.04.02.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 02:12:13 -0800 (PST)
Reply-To: efremov@linux.com
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>, Kurt Garloff <kurt@garloff.de>
From:   Denis Efremov <efremov@linux.com>
Subject: [GIT PULL] Floppy patch for 5.12
Message-ID: <45f555f4-b694-ca8e-c088-f34dea9fc7c7@linux.com>
Date:   Thu, 4 Feb 2021 13:12:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 0d7389718c32ad6bb8bee7895c91e2418b6b26aa:

  Merge tag 'nvme-5.21-2020-02-02' of git://git.infradead.org/nvme into for-5.12/drivers (2021-02-02 07:11:47 -0700)

are available in the Git repository at:

  https://github.com/evdenis/linux-floppy tags/floppy-for-5.12

for you to fetch changes up to 8a0c014cd20516ade9654fc13b51345ec58e7be8:

  floppy: reintroduce O_NDELAY fix (2021-02-04 13:00:24 +0300)

----------------------------------------------------------------
Floppy patch for 5.12

- O_NDELAY/O_NONBLOCK fix for floppy from Jiri Kosina.
  libblkid is using O_NONBLOCK when probing devices.
  This leads to pollution of kernel log with error
  messages from floppy driver. Also the driver fails
  a mount prior to being opened without O_NONBLOCK
  at least once. The patch fixes the issues.

Signed-off-by: Denis Efremov <efremov@linux.com>

----------------------------------------------------------------
Jiri Kosina (1):
      floppy: reintroduce O_NDELAY fix

 drivers/block/floppy.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)
