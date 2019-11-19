Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D167102D3A
	for <lists+linux-block@lfdr.de>; Tue, 19 Nov 2019 21:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfKSUIT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 19 Nov 2019 15:08:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32946 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfKSUIT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Nov 2019 15:08:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id w9so25444391wrr.0
        for <linux-block@vger.kernel.org>; Tue, 19 Nov 2019 12:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IxmtC2PxznwtkQUtloC5GUNCZaekTKyDjCJXJ6FJsCI=;
        b=bAnsHaFp6X7fg9d+6oBlr5NobzVdjrjdEAqqAnnsxpcN5kV6bbXhtMJCMuZdFU76a3
         5P6b3Lk+S//YSX5zQk16OwoD/PJmPzDZI6mrKSnG7RnNNRa5OD0JxxDYnsygKFTrqbeM
         5DWN7SFzu9wbv7R2AgE/XJ6sp1XSBGS16ZVVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IxmtC2PxznwtkQUtloC5GUNCZaekTKyDjCJXJ6FJsCI=;
        b=GM4oRdJLnGMvIeaAOKMiF9RML1ukdiUHJnyYi1AItsDWJDPNVm9BzAP+A1ZiMYH/F1
         gX0zQLh/dzkdO8dgGUExVNGpxZARjDW9ydSsu/OIj9Si867sE5EBq9geY0q9MZhxY9as
         Cwwu4x3YuSgSDxtvInro/4bIsq36KtLDalG0TQA2sJ5EU9KJ8AT6dnc40ba1Qv9JuLOL
         gWSWEHjd+3tTbS5aDjIZOO4O8GYZSH6jonfTEB+afptrFNxyyn33RbozubuOoB0FoVoi
         T76qw55zx4MYivI0np7ZoWyFcN313K6tmmuO4TDo9S60qeeit9vTyWe+XyoiS9KLoj2g
         VUNg==
X-Gm-Message-State: APjAAAVKyMwS5VswTzTqUM2cTwodbteDk3AdO9ZvCZacFIZqNDTNdqEo
        41umFUr5hcEB6zVetMHrRZ0IWA==
X-Google-Smtp-Source: APXvYqyXm6JCVe5Lweu8nf2CFgbaUFgIcNwZVFqGiAdxNHdguctFJtdS3VpHs78yZ00NujS7OkKxTA==
X-Received: by 2002:a5d:538d:: with SMTP id d13mr42070050wrv.304.1574194096534;
        Tue, 19 Nov 2019 12:08:16 -0800 (PST)
Received: from dhcp-135-15-167-92.dhcp.broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id x7sm33079002wrg.63.2019.11.19.12.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 12:08:15 -0800 (PST)
From:   Sumanesh Samanta <sumanesh.samanta@broadcom.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        ming.lei@redhat.com, sathya.prakash@broadcom.com,
        chaitra.basappa@broadcom.com,
        suganath-prabu.subramani@broadcom.com, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        emilne@redhat.com, hch@lst.de, hare@suse.de, bart.vanassche@wdc.com
Cc:     root <sumanesh.samanta@broadcom.com>
Subject: [PATCH 0/1] : limit overhead of device_busy counter for SSDs
Date:   Tue, 19 Nov 2019 12:07:58 -0800
Message-Id: <1574194079-27363-1-git-send-email-sumanesh.samanta@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: root <sumanesh.samanta@broadcom.com>

Recently a patch was delivered to remove host_busy counter from SCSI mid layer. That was a major bottleneck, and helped improve SCSI stack performance.
With that patch, bottle neck moved to the scsi_device device_busy counter. The performance issue with this counter is seen more in cases where a single device can produce very high IOPs, for example h/w RAID devices where OS sees one device, but there are many drives behind it, thus being capable of very high IOPs. The effect is also visible when cores from multiple NUMA nodes send IO to the same device or same controller.
The device_busy counter is not needed by controllers which can manage as many IO as submitted to it. Rotating media still uses it for merging IO, but for non-rotating SSD drives it becomes a major bottleneck as described above.

A few weeks back, a patch was provided to address the device_busy counter also but unfortunately that had some issues:
1. There was a functional issue discovered:
https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/VFKDTG4XC4VHWX5KKDJJI7P36EIGK526/
2. There was some concern about existing drivers using the device_busy counter.

This patch is an attempt to address both the above issues.
For this patch to be effective, LLDs need to set a specific flag use_per_cpu_device_busy in the scsi_host_template. For other drivers ( who does not set the flag), this patch would be a no-op, and should not affect their performance or functionality at all.

Also, this patch does not fundamentally change any logic or functionality of the code. All it does is replace device_busy with a per CPU counter. In fast path, all cpu increment/decrement their own counter. In relatively slow path. they call scsi_device_busy function to get the total no of IO outstanding on a device. Only functional aspect it changes is that for non-rotating media, the number of IO to a device is not restricted. Controllers which can handle that, can set the use_per_cpu_device_busy flag in scsi_host_template to take advantage of this patch. Other controllers need not modify any code and would work as usual.
Since the patch does not modify any other functional aspects, it should not have any side effects even for drivers that do set the use_per_cpu_device_busy flag


root (1):
  scsi core: limit overhead of device_busy counter for SSDs

 drivers/scsi/scsi_lib.c    | 151 ++++++++++++++++++++++++++++++++++---
 drivers/scsi/scsi_scan.c   |  16 ++++
 drivers/scsi/scsi_sysfs.c  |   9 ++-
 drivers/scsi/sg.c          |   2 +-
 include/scsi/scsi_device.h |  15 ++++
 include/scsi/scsi_host.h   |  16 ++++
 6 files changed, 197 insertions(+), 12 deletions(-)

-- 
2.23.0

