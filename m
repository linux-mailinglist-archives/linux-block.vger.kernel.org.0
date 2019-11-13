Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D10DFA462
	for <lists+linux-block@lfdr.de>; Wed, 13 Nov 2019 03:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfKMCQq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 12 Nov 2019 21:16:46 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41502 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730171AbfKMCQo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Nov 2019 21:16:44 -0500
Received: by mail-pg1-f193.google.com with SMTP id h4so311111pgv.8
        for <linux-block@vger.kernel.org>; Tue, 12 Nov 2019 18:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=c7pgGUOErKCone57ckbGDS/eeyPemc6EIW0Fbaye1l4=;
        b=J1GKzxf5D4PNxbYKxDELs3k7YlYHe/IgHvU8Etzan0v3SuwtZ62rEm1vWFQAXFTWqg
         q5GbIvG6C/Bi2hnba2PXWn2pywiaPhAqj19zLVeHVpUB/w+bJn62gzb9mmaePzydVmxv
         XAYZZFMdQ6jMS+xxsqXiz430ptjXzzatWh97FtCiIUx8TWg2NGykQo3WcHtCfcJrMFcr
         eqAqztK9aojc6IvhkKDL8UM7ckfiwhqjgW7yUs9sNKNCQts2WY/qf/Y56U6wCuW8N3t0
         HTWIy5X+Nktu52sYBB0Vz/LfvTjVsXzxChLk+jf8NXDEItN26y685XWjFOthOBTTeLzq
         6W0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c7pgGUOErKCone57ckbGDS/eeyPemc6EIW0Fbaye1l4=;
        b=YjhqY8XoAocYnvLH+KZVZRokhgc/DohPGzRmeKrGussi6WY6UonXxECG+Ngpy3QF8g
         Qy+xAK7MqiG0WsS+xSVWl6IE5T0e02xrhPs+GN33HsIPWh9ek3XuPMddOv0p/6li/5k1
         G5RTpyUOwjmWH6stwe0J6Giifz/LoCV+iHt53JZ5HMC5v0DEMtIrGRx253DdZ2XRHYii
         uS50U/qijNsK9Kp0GlDbMnoBiA2E6uAgl9kCDblpC2dRz/+ukW/5+JYBuz+R3GJ3RKmU
         xJ/4kS8kv2agIYMaGEHPDAnqjKNFlweBZnt4nyHsEzU+UX0zNL3vB2okfXETmZ1FbWwo
         4ZRA==
X-Gm-Message-State: APjAAAX2WMdcLATfh4fHA59zKQtwyrsRgc7qZe1X9PqJQdE2JGEl6XY4
        RjBwK+nsMjH3p9w/N7NsKadHeg==
X-Google-Smtp-Source: APXvYqycpY+BSOLB53HT4o8SEWzgzYFea+fu4bX8JbhALJ60LxNdAWEQSjGNGVeVl5dehnnO9BWleQ==
X-Received: by 2002:a17:90a:a114:: with SMTP id s20mr1410230pjp.44.1573611402828;
        Tue, 12 Nov 2019 18:16:42 -0800 (PST)
Received: from [192.168.1.182] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id e17sm303534pfh.121.2019.11.12.18.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 18:16:41 -0800 (PST)
Subject: Re: [PATCH v2 0/9] Zoned block device enhancements and zone report
 rework
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
References: <20191111023930.638129-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a0c1c1bf-d6e5-8be1-ed99-6bfed3483d1d@kernel.dk>
Date:   Tue, 12 Nov 2019 19:16:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191111023930.638129-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/10/19 6:39 PM, Damien Le Moal wrote:
> This series of patches introduces changes to zoned block device handling
> code with the intent to simplify the code while optimizing run-time
> operation, particularly in the area of zone reporting.
> 
> The first patch lifts the device zone check code out of the sd driver
> and reimplements these zone checks generically as part of
> blk_revalidate_disk_zones(). This avoids zoned block device drivers to
> have to implement these checks. The second patch simplifies this
> function code for the !zoned case.
> 
> The third patch is a small cleanup of zone report processing in
> preparation for the fourth patch which removes support for partitions
> on zoned block devices. As mentioned in that patch commit message, none
> of the known partitioning tools support zoned devices and there are no
> known use case in the field of SMR disks being used with partitions.
> Dropping partition supports allows to significantly simplify the code
> for zone report as zone sector values remapping becomes unnecessary.
> 
> Patch 5 to 6 are small cleanups and fixes of the null_blk driver zoned
> mode.
> 
> The prep patch 7 optimizes zone report buffer allocation for the SCSI
> sd driver. Finally, patch 8 introduces a new interface for report zones
> handling using a callback function executed per zone reported by the
> device. This allows avoiding the need to allocate large arrays of
> blk_zone structures for the execution of zone reports. This can
> significantly reduce memory usage and pressure on the memory management
> system while significantly simplify the code all over.
> 
> Overall, this series not only reduces significantly the code size, it
> also improves run-time memory usage for zone report execution.
> 
> This series applies cleanly on the for-next block tree on top of the
> zone management operation series. It may however create a conflict with
> Christoph's reqork of disk size revalidation. Please consider this
> series for inclusion in the 5.5 kernel.

We're taking branching to new levels... I created for-5.5/zoned for this,
which is for-5.5/block + for-5.5/drivers + for-5.5/drivers-post combined.
The latter is a branch with the SCSI dependencies from Martin pulled in.

-- 
Jens Axboe

