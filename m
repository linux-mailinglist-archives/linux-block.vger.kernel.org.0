Return-Path: <linux-block+bounces-1826-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C3D82D8C3
	for <lists+linux-block@lfdr.de>; Mon, 15 Jan 2024 13:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CDB32822F8
	for <lists+linux-block@lfdr.de>; Mon, 15 Jan 2024 12:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2752C6A0;
	Mon, 15 Jan 2024 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1RAle4o"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659AA2C68C
	for <linux-block@vger.kernel.org>; Mon, 15 Jan 2024 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705320842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=eY9sAlKGBP15WtJLvXPjMLCZS+l6QaLo35obeFomqdM=;
	b=C1RAle4olfOIAafJ4egeRo7iP5iBrPXMuQzRwwXRigbtaU2WWRUPNzN9l7E62qV99j9dji
	y/sC9JWb94OAi5UNyADBUknNHjbc86B+FJ49MWLhINCAXxowDXwrFL+QFcuPwr+yYOmkGV
	PGbgwNgbQ2/ALCOCHnKTlMfDl0yJmnc=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-znpBBSVqO_OERu2XCahEYw-1; Mon, 15 Jan 2024 07:14:00 -0500
X-MC-Unique: znpBBSVqO_OERu2XCahEYw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3bd5882b0bcso6256305b6e.2
        for <linux-block@vger.kernel.org>; Mon, 15 Jan 2024 04:14:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705320840; x=1705925640;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eY9sAlKGBP15WtJLvXPjMLCZS+l6QaLo35obeFomqdM=;
        b=OEMpV65kKgHoVaoO6YhsowEjTCZsGR6yfsaki0BRelpi1z2Cywixnvlh6cdUZXPj3U
         kNWzUvgRUK9w7MkeeM2wg4G+c2a1+lMkDAdnfBLBygpjL0rCb/R+9ro548a2GaEW3nDk
         bWlycictDvFnkDm3lKkBksfyy3wAteV0OIXl/dbs4umJK5Q12Z58FGKrWRJA7sp0wxbC
         V5D3VDfHaV3IaPZa60rT2pfVb28WIjxQEoF0+az1lgAdUaUCRE5VAXDKmQLr0CSDfrMz
         LMDxFUCrJniuwBm89htKEyCDxk5u7hckiIHlQoqiPNcgaFxIMXvKQEKcEcn+ODxpf+Y7
         xRCA==
X-Gm-Message-State: AOJu0Yz/3NTd1JuGXYfZ496ak7Sjk0tQOjDWcXQtSvRA8fMmXQ+Vztc5
	JDtMekwjID6uIK3PUSX2hkkwUg17ONKkjKKf8Ube3DRokbMRTJYutf/qxSInQKluw2YP03Yy9+4
	cioRqOkutxJ83Wdn7OcysaOrtvh8vDcIbOFfv3eOzZhW60sqw0LifPXBdJDrr
X-Received: by 2002:a05:6808:9b0:b0:3bd:4d3c:ff9c with SMTP id e16-20020a05680809b000b003bd4d3cff9cmr5899450oig.116.1705320840039;
        Mon, 15 Jan 2024 04:14:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFs8K3V2NJY0rd5ZWGCFYGPYrPQli0EaBE1JelHItthmZJmxbliNhX6GHA5fGuW2IbtQrk0kv2Lm3iC2eeg9p0=
X-Received: by 2002:a05:6808:9b0:b0:3bd:4d3c:ff9c with SMTP id
 e16-20020a05680809b000b003bd4d3cff9cmr5899442oig.116.1705320839720; Mon, 15
 Jan 2024 04:13:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Allison Karlitskaya <allison.karlitskaya@redhat.com>
Date: Mon, 15 Jan 2024 13:13:49 +0100
Message-ID: <CAOYeF9VsmqKMcQjo1k6YkGNujwN-nzfxY17N3F-CMikE1tYp+w@mail.gmail.com>
Subject: PROBLEM: BLKPG_DEL_PARTITION with GENHD_FL_NO_PART used to return
 ENXIO, now returns EINVAL
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

hi,

[1.] One line summary of the problem:
BLKPG_DEL_PARTITION on an empty loopback device used to return ENXIO
but now returns EINVAL, breaking partprobe

[2.] Full description of the problem/report:
We recently caught this problem in our CI for Cockpit:
https://github.com/cockpit-project/bots/pull/5793

The summary is that if you do something like this:

$ dd if=/dev/zero of=/tmp/foo bs=1M count=50
$ partprobe $(losetup --find --show /tmp/foo)

Then this will fail with the following error message:

Error: Partition(s) 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49,
50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64 on
/dev/loop2 have been written, but we have been unable to inform the
kernel of the change, probably because it/they are in use.  As a
result, the old partition(s) will remain in use.  You should reboot
now before making further changes.

... when it used to be successful.  That's down to this syscall
(called by partprobe) changing its behaviour between kernel versions:

-ioctl(3, BLKPG, {op=BLKPG_DEL_PARTITION, flags=0, datalen=152,
data={start=0, length=0, pno=1, devname="", volname=""}}) = -1 ENXIO
(No such device or address)
+ioctl(3, BLKPG, {op=BLKPG_DEL_PARTITION, flags=0, datalen=152,
data={start=0, length=0, pno=1, devname="", volname=""}}) = -1 EINVAL
(Invalid argument)

This is observed on Ubuntu jammy with partprobe from parted
3.4-2build1.  I've confirmed that the original parted-3.4 download
from https://ftp.gnu.org/gnu/parted/ is also impacted in the same way.

[3.] Keywords:
block, partition, BLKPG_DEL_PARTITION, loop device, EINVAL, ENXIO

[4.] Kernel information:
Linux ubuntu 5.15.0-94-generic #104-Ubuntu SMP Tue Jan 9 15:25:40 UTC
2024 x86_64 x86_64 x86_64 GNU/Linux

This is the version currently in jammy-proposed.  The likely culprit
is this commit:

  https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/jammy/commit/?id=49a502554e8aa853a0357f287121d4cdf4442a58

which is also upstream as 1a721de8489fa559ff4471f73c58bb74ac5580d3.

There has been discussion on linux-kernel before about this:
https://marc.info/?l=linux-kernel&m=169753467305218&w=2

but now we have a pretty clear case of "breaks userspace in the wild".

[4.1.] Kernel version (from /proc/version):

Linux version 5.15.0-94-generic (buildd@lcy02-amd64-096) (gcc (Ubuntu
11.4.0-1ubuntu1~22.04) 11.4.0, GNU ld (GNU Binutils for Ubuntu) 2.38)
#104-Ubuntu SMP Tue Jan 9 15:25:40 UTC 2024

[4.2.] Kernel .config file:

I pasted a copy here:

https://paste.centos.org/view/8d6506bc

but it won't be around for more than 24 hours.  It's just the config
file present in /boot on the affected install.

[5.] Most recent kernel version which did not have the bug:

We last tested 5.15.0-91-generic and found it to be working with the
previous behaviour (ie: returning ENXIO).

[7.] A small shell script or example program which triggers the
     problem (if possible)

as above:

$ dd if=/dev/zero of=/tmp/foo bs=1M count=50
$ partprobe $(losetup --find --show /tmp/foo)

[8.] Environment
[8.1.] Software (add the output of the ver_linux script here)
[8.2.] Processor information (from /proc/cpuinfo):
[8.3.] Module information (from /proc/modules):
[8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
[8.5.] PCI information ('lspci -vvv' as root)
[8.6.] SCSI information (from /proc/scsi/scsi)
[8.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
[X.] Other notes, patches, fixes, workarounds:


I don't expect there would be anything relevant here, but feel free to
ask.  It's a qemu x86_64 VM image running on my Intel laptop.  If you
want to test this, check out

   https://github.com/cockpit-project/bots/tree/image-refresh-ubuntu-2204-20240114-225118

and run

  ./vm-run -q ubuntu-2204

at which point you should be presented with instructions about how to
ssh to the machine.

Thanks for the attention!

Allison Karlitskaya


