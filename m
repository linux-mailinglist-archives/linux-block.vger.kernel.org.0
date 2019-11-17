Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED137FFB00
	for <lists+linux-block@lfdr.de>; Sun, 17 Nov 2019 18:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfKQRxc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 17 Nov 2019 12:53:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30141 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726067AbfKQRxc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Nov 2019 12:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574013211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=z3jThtnFHn+u2Zbntihdur7DaqZTHatfWOLXJf5lMaI=;
        b=Hjl755FV3YPhozJVPCoT9QSY2iqbyeZWzfi2wsCI46A4UYNMRvV+DhIZOu+JnO2k9nv+YE
        6v/3UGgrAEtHEdvEAuEatQXLkrlxNajKqpJskMwn+CoOxkBUlVbrvIPYh6v1c7JxdXkA5Y
        ZdvGkR20fDM27sCszdZzBZjv3g2FxEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-fKrGSsigMlm1CY9tzT5iOA-1; Sun, 17 Nov 2019 12:53:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 615281800D4F;
        Sun, 17 Nov 2019 17:53:27 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBE6D60900;
        Sun, 17 Nov 2019 17:53:26 +0000 (UTC)
Date:   Mon, 18 Nov 2019 02:01:15 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     bfoster@redhat.com, cgroups@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Qestion about block cgroup for disk partition
Message-ID: <20191117180114.GQ3802@dhcp-12-102.nay.redhat.com>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: fKrGSsigMlm1CY9tzT5iOA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Recently we found a weird failure by running xfstests generic/563 on xfs or
ext4, when the test device is a general disk partition. If you don't want t=
o
try xfstests, you can see below script[1].

If we test on a disk partition (e.g. /dev/sdb1 or /dev/nvme0n1p1), the cgro=
up's
io.stat always can't output the correct minor device number of the disk
partition. LVM or loop devices don't have this issue.

Is there any 'blk-cgroup' expert would like to help to answer this question=
?
Is this expected or it's a bug will be fixed later? It can be reproduced on
latest upstream kernel.

Thanks,
Zorro


[1]
# cat blkcgroup-test.sh=20
#/bin/bash

umount /dev/nvme0n1p1 2>/dev/null
mkfs.xfs -f /dev/nvme0n1p1 >/dev/null 2>&1
mount /dev/nvme0n1p1 /mnt/scratch
major=3D$((0x`stat -L -c "%t" /dev/nvme0n1p1`))
minor=3D$((0x`stat -L -c "%T" /dev/nvme0n1p1`))
echo "$major:$minor"
echo "+io" > /sys/fs/cgroup/cgroup.subtree_control
echo $$ > /sys/fs/cgroup/cgroup.procs
rmdir /sys/fs/cgroup/mytest-cg
xfs_io -fc "pwrite 0 8m" /mnt/scratch/file >/dev/null 2>&1
umount /dev/nvme0n1p1 && mount /dev/nvme0n1p1 /mnt/scratch
stat /mnt/scratch/file >/dev/null
mkdir /sys/fs/cgroup/mytest-cg
echo $$ > /sys/fs/cgroup/mytest-cg/cgroup.procs
xfs_io -c "pread 0 8m" -c "pwrite 0 8m" -c fsync /mnt/scratch/file >/dev/nu=
ll 2>&1
mkdir -p /sys/fs/cgroup
echo $$ > /sys/fs/cgroup/cgroup.procs
xfs_io -c fsync /mnt/scratch/file
cat /sys/fs/cgroup/mytest-cg/io.stat

[2]
259:1
259:0 rbytes=3D8388608 wbytes=3D8389632 rios=3D67 wios=3D12 dbytes=3D0 dios=
=3D0

