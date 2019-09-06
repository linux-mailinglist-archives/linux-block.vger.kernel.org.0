Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4C6AB06B
	for <lists+linux-block@lfdr.de>; Fri,  6 Sep 2019 03:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388604AbfIFBxP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 5 Sep 2019 21:53:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34717 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732755AbfIFBxP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Sep 2019 21:53:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so2539626pgc.1
        for <linux-block@vger.kernel.org>; Thu, 05 Sep 2019 18:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fuC7aNrIlu0FLWb5uxW6Ky6irB9KcFY2ncrOP9ADl4s=;
        b=fLnDmBU4gq7Er1C5Apm/3birxvKxf+Uu6oi9W55fvSI5ONTupwrw2Pvzpqw1MUoLcG
         vtwUFAKMivKiy64FfLznT8Bi2ksY6pmyaUhXclUrC8uo9yj97NIdAxnelRfWJi9iB44+
         jnZjNnsvcmuiv1YcCU1mxw/q3YjiSLTpZNUa9pVIb+WfyXVtQAQ7ioduuSvRW4cFCK30
         H6OfHXeG3cCEs6CBR9kEIu/pV/zXIGO2c3IDKtg/4bDSHHw3G6OSgqpVTM3WZavgSNY8
         dt7V/RIOIYbQq6KEOv+ME0I2AqeMQJAD7x04O0CW+r78jpvUpUpNyKhHxy5TiVMPlhun
         WZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fuC7aNrIlu0FLWb5uxW6Ky6irB9KcFY2ncrOP9ADl4s=;
        b=NGkQgoh07wErwCUd0dKt4/PwV45g8U6op6a6h/SZ1cJZ7S8f8Wsp9FZvCvEQ05g7vm
         ngGrpwWShk0q9duaRSbmsn21C4LXxAJLIRL4kQhQ6ZBWfttc6/mMA142k+2UhZ74RI0j
         lUJ9bM3XeaRovRZkTlNfsCiZ2KscQ+haVLywLbCofGLYzZSU/BRW64TA2mdvisJpfHE3
         QD9oNElqtyYcQjIv/gn15RW61YhQRfxee3Az4doYLkUkiG4n1+w+NjyVOxs9o9sKGWz0
         eUYmbHtCn5TX1pOYFrDcazaDxpxvOR6N1Nk+nm3j1qafpZH2EWTPG6qdQ3w3pxO1MVFY
         qQ/A==
X-Gm-Message-State: APjAAAV2nresmcIJScge7u7rOOLcTgmyMSCdkcEGcH/XVruiwtwFzlFr
        g+3h6mrxJZjx2+Oo7zMw+A8W2A==
X-Google-Smtp-Source: APXvYqwR+QVXHh47vAMcFozkBntiZ58ZyB4KlT1RLDiLFzWrkFjIH/t9MkG95W7t0nL/6o+PPAih2g==
X-Received: by 2002:a17:90a:c70c:: with SMTP id o12mr5672683pjt.50.1567734794503;
        Thu, 05 Sep 2019 18:53:14 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id m24sm5662690pfa.37.2019.09.05.18.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 18:53:13 -0700 (PDT)
Subject: Re: [PATCH v5 0/7] Elevator cleanups and improvements
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>
References: <20190905095135.26026-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b0913603-5a3f-472d-1013-9b12835e77fe@kernel.dk>
Date:   Thu, 5 Sep 2019 19:53:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905095135.26026-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/5/19 3:51 AM, Damien Le Moal wrote:
> This patch series implements some cleanup of the elevator initialization
> code and introduces elevator features identification and device matching
> to enhance checks for elevator/device compatibility and fitness.
> 
> The first 2 patches of the series are simple cleanups which simplify
> elevator initialization for newly allocated device queues.
> 
> Patch 3 introduce elevator features, allowing a clean and extensible
> definition of devices and features that an elevator supports and match
> these against features required by a block device. With this, the sysfs
> elevator list for a device always shows only elevators matching the
> features that a particular device requires, with the exception of the
> none elevator which has no features but is always available for use
> with any device.
> 
> The first feature defined is for zoned block device sequential write
> constraint support through zone write locking which prevents the use of
> any elevator that does not support this feature with zoned devices.
> 
> The last 4 patches of this series rework the default elevator selection
> and initialization to allow for the elevator/device features matching
> to work, doing so addressing cases not currently well supported, namely,
> multi-queue zoned block devices.

Applied for 5.4, thanks.

-- 
Jens Axboe

