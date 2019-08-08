Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9C8486347
	for <lists+linux-block@lfdr.de>; Thu,  8 Aug 2019 15:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733046AbfHHNiQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 8 Aug 2019 09:38:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45321 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733075AbfHHNiQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Aug 2019 09:38:16 -0400
Received: by mail-pg1-f196.google.com with SMTP id o13so44073519pgp.12
        for <linux-block@vger.kernel.org>; Thu, 08 Aug 2019 06:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FC8WMRYCc08/2iY3rGHR1xp6uCgxjUjBA3bfpUjoiT4=;
        b=T6vR6iJXDPF9uwOrsPc5YE90CqDuG/xN2Wlzt24YUN4hX/3xX6gsVFKIYQ7buLpMmO
         1s4KKsrRJsFNpI8wWDClfPRqg8UriYmOudk1Bxh995ZUYlyLpGsCKHtB/h/GMR+2a525
         biReX75H6CQHkxy1c4uOIxfemfoWJltcR0ByJB/tFLsi3VGrpnRYFrNgtYPN86MikbRM
         Y51fcvCBeKiiND8ib/aib3FpAWgPwXSQhxfs19b9t1AcT2xSloXRZ1+vFIPRlWofGJvo
         WuCymUU7HLzDrtuJKGyCzeLRGrcg+tT/QW5En+Qn4GGuA5uaMtE9ITj3M8r9/9vTkbtE
         YT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FC8WMRYCc08/2iY3rGHR1xp6uCgxjUjBA3bfpUjoiT4=;
        b=ncgq2IgFLmxXz8/szN67Kvk7MXc3JL7rc4iWHqdEgxxTpApXyPvp8JKBFf08FZiAau
         itcXgaj463gftidlB7AnAx/OyvXoKvU/WgtG5v+rqlnyonyEYaosxlw2ls9p/cHuG+4b
         cgszIxUSfqxQgdiO9bA0fxCD5ayMkogyCcgXWvJa12cnmn9Q8+y5XU6afg1F8U8qUj+/
         BJwAP5gYPov4Jp5rxl2EMISjUAoi0MInpq/X0s3+z5W5uX8dSGZ/444Gye98QwsNupUV
         JPhynebZttJSF/DIi+Uo7ODIuTZ/Nq3G6YmZJYwdqsOhE0OwxFNukfOjWsSyBE7N6fi5
         EuXg==
X-Gm-Message-State: APjAAAWSA59fh4Nia1ioSPg2b7iOAQ3UUUNvhmpLn7r7kspyog/ZgrJo
        8oUNWolVaZbKmmrreW5LjqLNwQ==
X-Google-Smtp-Source: APXvYqwR9PJ3zPvk3ivmgS/oVWYZl4l1bRCg1qh2JwUu2XrqcUwF/W35Fvtu98MQ1xRPkOy2pB4BvA==
X-Received: by 2002:a17:90a:8d0c:: with SMTP id c12mr4008126pjo.140.1565271495115;
        Thu, 08 Aug 2019 06:38:15 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:186c:3a47:dc97:3ed1? ([2605:e000:100e:83a1:186c:3a47:dc97:3ed1])
        by smtp.gmail.com with ESMTPSA id x22sm101589775pff.5.2019.08.08.06.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 06:38:13 -0700 (PDT)
Subject: Re: regression: blktests block/001 failed with commit "loop: Fix
 mount(2) failure due to race with LOOP_SET_FD"
To:     Yi Zhang <yi.zhang@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Cc:     jack@suse.cz, kai.heng.feng@canonical.com
References: <1303057871.5074831.1565247040675.JavaMail.zimbra@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1eec3a2a-3409-7220-6a8b-ff5aeedd2093@kernel.dk>
Date:   Thu, 8 Aug 2019 06:38:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1303057871.5074831.1565247040675.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/7/19 11:50 PM, Yi Zhang wrote:
> Hello
> 
>  From kernel 5.3.0-rc3, blktests block/001 triggered a WARNING on aarch64, and I've bisected the bad commit [2]:
> 
> [1]
> [  163.963753] sr 7:0:0:0: Attached scsi CD-ROM sr1
> [  163.963924] sr 7:0:0:0: Attached scsi generic sg3 type 5
> [  163.974924] scsi 9:0:0:0: CD-ROM            Linux    scsi_debug       0188 PQ: 0 ANSI: 7
> [  163.983165] sr 9:0:0:0: Power-on or device reset occurred
> [  164.008597] sr 9:0:0:0: [sr1] scsi-1 drive
> [  164.012896] debugfs: Directory 'sr1' with parent 'block' already present!
> [  164.014426] scsi 6:0:0:0: CD-ROM            Linux    scsi_debug       0188 PQ: 0 ANSI: 7
> [  164.019711] sr 9:0:0:0: Attached scsi CD-ROM sr1
> [  164.019807] scsi 8:0:0:0: CD-ROM            Linux    scsi_debug       0188 PQ: 0 ANSI: 7
> [  164.019981] sr 8:0:0:0: Power-on or device reset occurred
> [  164.027941] sr 6:0:0:0: Power-on or device reset occurred
> [  164.035951] sr 9:0:0:0: Attached scsi generic sg3 type 5
> [  164.040027] sr 8:0:0:0: [sr2] scsi-1 drive
> [  164.040992] sr 8:0:0:0: Attached scsi CD-ROM sr2
> [  164.056098] sr 8:0:0:0: Attached scsi generic sg4 type 5
> [  164.061274] sr 6:0:0:0: [sr3] scsi-1 drive
> [  164.064852] scsi 7:0:0:0: CD-ROM            Linux    scsi_debug       0188 PQ: 0 ANSI: 7
> [  164.066576] sr 6:0:0:0: Attached scsi CD-ROM sr3
> [  164.073700] sr 6:0:0:0: Attached scsi generic sg3 type 5
> [  164.073744] sr 7:0:0:0: Power-on or device reset occurred
> [  164.075275] WARNING: CPU: 21 PID: 3490 at fs/block_dev.c:1899 __blkdev_put+0x238/0x260
> [  164.075276] Modules linked in: scsi_debug sunrpc vfat fat crct10dif_ce ghash_ce sha2_ce sha256_arm64 ipmi_ssif sg sha1_ce ipmi_devintf sbsa_gwdt ipmi_msghandler xgene_hwmon ip_tables xfs libcrc32c sr_mod cdrom ast drm_vram_helper ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm igb i2c_designware_platform gpio_dwapb ahci_platform i2c_algo_bit i2c_designware_core libahci_platform i2c_xgene_slimpro gpio_generic uas rndis_host usb_storage cdc_ether usbnet mii dm_mirror dm_region_hash dm_log dm_mod [last unloaded: scsi_debug]
> [  164.075305] CPU: 21 PID: 3490 Comm: systemd-udevd Not tainted 5.3.0-rc3 #11
> [  164.075306] Hardware name: AppliedMicro(R) OSPREY EV-883832-X3-0001/OSPREY, BIOS 4.9.6 01/04/2019
> [  164.075308] pstate: 60000005 (nZCv daif -PAN -UAO)
> [  164.075310] pc : __blkdev_put+0x238/0x260
> [  164.075312] lr : __blkdev_put+0x50/0x260
> [  164.075313] sp : ffff00001a1cfc80
> [  164.075314] x29: ffff00001a1cfc80 x28: ffff809eebb7e5c0
> [  164.075315] x27: 0000000000000000 x26: 00000000080a005d
> [  164.075317] x25: ffff809f2332d000 x24: ffff809f070557d8
> [  164.075318] x23: ffff809ee44c1ce0 x22: 00000000080a005d
> [  164.075320] x21: ffff0000112d3708 x20: 0000000000000000
> [  164.075321] x19: ffff809f070557c0 x18: 0000000000000000
> [  164.075322] x17: 0000000000000000 x16: 0000000000000000
> [  164.075324] x15: 0000000000000000 x14: 0000000000000000
> [  164.075325] x13: 0000000000000000 x12: 0000000000000000
> [  164.075326] x11: 0000000000000000 x10: 0000000040000028
> [  164.075328] x9 : 000000000000fec0 x8 : 0000000000210d00
> [  164.075329] x7 : ffff809ee3aa8e98 x6 : ffff0000112d3708
> [  164.075331] x5 : 0000000000000060 x4 : ffff7fe027b8eaa0
> [  164.075332] x3 : ffff809f25abae18 x2 : ffff809eebb7e5c0
> [  164.075333] x1 : 0000000000000000 x0 : 0000000000000002
> [  164.075335] Call trace:
> [  164.075337]  __blkdev_put+0x238/0x260
> [  164.075339]  blkdev_put+0xe4/0x118
> [  164.075341]  blkdev_close+0x2c/0x40
> [  164.075343]  __fput+0xa0/0x200
> [  164.075345]  ____fput+0x20/0x30
> [  164.075347]  task_work_run+0xc0/0xf0
> [  164.075349]  do_notify_resume+0x308/0x350
> [  164.075351]  work_pending+0x8/0x10
> [  164.075352] ---[ end trace a99909be528034c4 ]---
> 
> [2]
> commit 89e524c04fa966330e2e80ab2bc50b9944c5847a
> Author: Jan Kara <jack@suse.cz>
> Date:   Tue Jul 30 13:10:14 2019 +0200
> 
>      loop: Fix mount(2) failure due to race with LOOP_SET_FD
>      
>      Commit 33ec3e53e7b1 ("loop: Don't change loop device under exclusive
>      opener") made LOOP_SET_FD ioctl acquire exclusive block device reference
>      while it updates loop device binding. However this can make perfectly
>      valid mount(2) fail with EBUSY due to racing LOOP_SET_FD holding
>      temporarily the exclusive bdev reference in cases like this:
>      
>      for i in {a..z}{a..z}; do
>              dd if=/dev/zero of=$i.image bs=1k count=0 seek=1024
>              mkfs.ext2 $i.image
>              mkdir mnt$i
>      done
>      
>      echo "Run"
>      for i in {a..z}{a..z}; do
>              mount -o loop -t ext2 $i.image mnt$i &
>      done
>      
>      Fix the problem by not getting full exclusive bdev reference in
>      LOOP_SET_FD but instead just mark the bdev as being claimed while we
>      update the binding information. This just blocks new exclusive openers
>      instead of failing them with EBUSY thus fixing the problem.
>      
>      Fixes: 33ec3e53e7b1 ("loop: Don't change loop device under exclusive opener")
>      Cc: stable@vger.kernel.org
>      Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>      Signed-off-by: Jan Kara <jack@suse.cz>
>      Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Feel free to request any kind of further information or assistance.

Can you try with this:

http://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=e91455bad5cff40a8c232f2204a5104127e3fec2

-- 
Jens Axboe

