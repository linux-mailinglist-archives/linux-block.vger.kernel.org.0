Return-Path: <linux-block+bounces-10483-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64D194FE5C
	for <lists+linux-block@lfdr.de>; Tue, 13 Aug 2024 09:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80684284836
	for <lists+linux-block@lfdr.de>; Tue, 13 Aug 2024 07:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A124317C;
	Tue, 13 Aug 2024 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHKoGOx0"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7934C81
	for <linux-block@vger.kernel.org>; Tue, 13 Aug 2024 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723532810; cv=none; b=dJfx9ywZ86leiOnYwQDUxMa3QA81AfwOsouf2Bg1FQPe8MvJdN/34ZknvaQTcqmqOgcmN+TJNpVOoAFbv3jv9NPPAcr4A88jrXMx2HR1KlBulHSkp/cntmtAgdIdLu1Kb2YUliW5MKJda7ry9WjOng5bLFsZXaI2pnp/Lp0/SPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723532810; c=relaxed/simple;
	bh=PeXP4knedHoEKd7rD4ZrwlJk/0EMpRXoty42pyQ40oI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWPstrpdiM3jfhLofFZWZlk7e1am4PmUhHo6LJGIFyz30oGE+5QU4yD48CDYRcGqVAqP1o7lj0vfnd8whaHYhWXGi1z7dfPwnAIOo2OeF1jbxH3J19pXN3UNpXfaqrcxrpnRi6mXWVXyW6gTlEH0FJPns5OVq0EKESung3CHJXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHKoGOx0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723532807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLMXoEnXQB4j6uGPV4owlqBBJTVhrRaJGaY0tIh4Xwc=;
	b=BHKoGOx08d9TLA6wZuNzv9ttS9oWEOq4pLLXUWuT+NTN0jJK2/hpXauIR6yhtIMsyb5R4W
	QWdylr8v3GHaDuDZ0w+1HiqMviWi2gI3eYT2mnqPm71M1oz3WEYPG8WB4hVsA2cQA49iXb
	frMa1SJacLCB7m//U0/QMWzGYTfhPwE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-hOIKGyWNMHSpxrnP6oUgSA-1; Tue, 13 Aug 2024 03:06:46 -0400
X-MC-Unique: hOIKGyWNMHSpxrnP6oUgSA-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-6fd42bf4316so4013080a12.2
        for <linux-block@vger.kernel.org>; Tue, 13 Aug 2024 00:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723532805; x=1724137605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLMXoEnXQB4j6uGPV4owlqBBJTVhrRaJGaY0tIh4Xwc=;
        b=h3UIYPiO4iZ+0e2o1cUyC7Ko5j4XkdiZzdo1wuId7p+f2KJoRc1aYR4z1Ph6PyWNYp
         TsH8eu64JvCg1vX+tj7VMR5iHImEtIKb0824q9dRDkPrxaHCq7M7sp0CowbBby+is/QG
         D1W47UnYtCryOn4PZahxk+yL6XK68iUekb8k5CWodtqLHwaidlxpOPj90zwS3szPYSPb
         AuzogUeEYEPjJRV2a7QPJU9Duihe1NOjzgr3EP87/2l2F7e+cilg0eplLmSxEYjJVHfX
         TVHWSGYyYL99d355bRQv4yEm1UP4oU/AyuZ9gSkV4tAApxQvpaimxNIyvoJIQf3BdRR5
         GQMg==
X-Forwarded-Encrypted: i=1; AJvYcCXT0U0n2wjFC0oSi9A+6l6Wx4IEQjX30UO3ppi94yZveNOWrVOMPf12EAh49fj6OLbis8LfG9i0UotSuKcCITcN7fqX3JYND6/Qp/8=
X-Gm-Message-State: AOJu0YyzVBDEgz19Qi19dY+ELWm1NC1zBzZ2VzZ6y+UUh3WvioAyGDZD
	HzammXAscqM7hXGfw1T/ruc1beQgIoH5b12yvYrn6vJPPRc/MkLKKHuRnEYh3EhgTU6Z1cEoRHy
	ZxdWtSsjBuLDf23v9vKiPU5boRM2Y4KdkTNy4E1rVROeqHeg0GdmYgMy+DjE8PCjpEMnvg1qVqD
	BMEDtlT6X5bynAFE48iC0Dknru0apPGXuCOAk=
X-Received: by 2002:a05:6a21:6b0c:b0:1c6:fc2f:40fa with SMTP id adf61e73a8af0-1c8d75c7c32mr3359011637.46.1723532805246;
        Tue, 13 Aug 2024 00:06:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4Sin0HKC9rjncXAyssbzbIMN1oJ/7IXsRidBfNy79BEr7HzyhaxZkC41l5rDTmBxwrSBe3UGPw42vPbsazvE=
X-Received: by 2002:a05:6a21:6b0c:b0:1c6:fc2f:40fa with SMTP id
 adf61e73a8af0-1c8d75c7c32mr3358990637.46.1723532804789; Tue, 13 Aug 2024
 00:06:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5yal5unzvisrvfhhvsqrsqgu4tfbjp2fsrnbuyxioaxjgbojsi@o2arvhebzes3>
 <ab363932-ab3d-49b1-853d-7313f02cce9e@linux.ibm.com> <ljqlgkvhkojsmehqddmeo4dng6l3yaav6le2uslsumfxivluwu@m7lkx3j4mkkw>
 <79a7ec0d-c22d-44cf-a832-13da05a1fcbd@linux.ibm.com>
In-Reply-To: <79a7ec0d-c22d-44cf-a832-13da05a1fcbd@linux.ibm.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 13 Aug 2024 15:06:32 +0800
Message-ID: <CAHj4cs-5DPDFuBzm3aymeAi6UWHhgXSYsgaCACKbjXp=i0SyTA@mail.gmail.com>
Subject: Re: blktests failures with v6.11-rc1 kernel
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "nbd@other.debian.org" <nbd@other.debian.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 12:49=E2=80=AFAM Nilay Shroff <nilay@linux.ibm.com> =
wrote:
>
>
>
> On 8/2/24 18:04, Shinichiro Kawasaki wrote:
> > CC+: Yi Zhang,
> >
> > On Aug 02, 2024 / 17:46, Nilay Shroff wrote:
> >>
> >>
> >> On 8/2/24 14:39, Shinichiro Kawasaki wrote:
> >>>
> >>> #3: nvme/052 (CKI failure)
> >>>
> >>>    The CKI project reported that nvme/052 fails occasionally [4].
> >>>    This needs further debug effort.
> >>>
> >>>   nvme/052 (tr=3Dloop) (Test file-ns creation/deletion under one subs=
ystem) [failed]
> >>>       runtime    ...  22.209s
> >>>       --- tests/nvme/052.out        2024-07-30 18:38:29.041716566 -04=
00
> >>>       +++ /mnt/tests/gitlab.com/redhat/centos-stream/tests/kernel/ker=
nel-tests/-/archive/production/kernel-tests-production.zip/storage/blktests=
/nvme/nvme-loop/blktests/results/nodev_tr_loop/nvme/052.out.bad     2024-07=
-30 18:45:35.438067452 -0400
> >>>       @@ -1,2 +1,4 @@
> >>>        Running nvme/052
> >>>       +cat: /sys/block/nvme1n2/uuid: No such file or directory
> >>>       +cat: /sys/block/nvme1n2/uuid: No such file or directory
> >>>        Test complete
> >>>
> >>>    [4] https://datawarehouse.cki-project.org/kcidb/tests/13669275
> >>
> >> I just checked the console logs of the nvme/052 and from the logs it's
> >> apparent that all namespaces were created successfully and so it's str=
ange
> >> to see that the test couldn't access "/sys/block/nvme1n2/uuid".
> >
> > I agree that it's strange. I think the "No such file or directory" erro=
r
> > happened in _find_nvme_ns(), and it checks existence of the uuid file b=
efore
> > the cat command. I have no idea why the error happens.
> >
> Yes exactly, and these two operations (checking the existence of uuid
> and cat command) are not atomic. So the only plausible theory I have at t=
his
> time is "if namespace is deleted after checking the existence of uuid but
> before cat command is executed" then this issue may potentially manifests=
.
> Furthermore, as you mentioned, this issue is seen on the test machine
> occasionally, so I asked if there's a possibility of simultaneous blktest
> or some other tests running on this system.

There are no simultaneous tests during the CKI tests running.
I reproduced the failure on that server and always can be reproduced
within 5 times:
# sh a.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D0
nvme/052 (tr=3Dloop) (Test file-ns creation/deletion under one subsystem) [=
passed]
    runtime  21.496s  ...  21.398s
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D1
nvme/052 (tr=3Dloop) (Test file-ns creation/deletion under one subsystem) [=
failed]
    runtime  21.398s  ...  21.974s
    --- tests/nvme/052.out 2024-08-10 00:30:06.989814226 -0400
    +++ /root/blktests/results/nodev_tr_loop/nvme/052.out.bad
2024-08-13 02:53:51.635047928 -0400
    @@ -1,2 +1,5 @@
     Running nvme/052
    +cat: /sys/block/nvme1n2/uuid: No such file or directory
    +cat: /sys/block/nvme1n2/uuid: No such file or directory
    +cat: /sys/block/nvme1n2/uuid: No such file or directory
     Test complete
# uname -r
6.11.0-rc3
[root@hpe-rl300gen11-04 blktests]# lsblk
NAME                                MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
zram0                               252:0    0     8G  0 disk [SWAP]
nvme0n1                             259:0    0 447.1G  0 disk
=E2=94=9C=E2=94=80nvme0n1p1                         259:1    0   600M  0 pa=
rt /boot/efi
=E2=94=9C=E2=94=80nvme0n1p2                         259:2    0     1G  0 pa=
rt /boot
=E2=94=94=E2=94=80nvme0n1p3                         259:3    0 445.5G  0 pa=
rt
  =E2=94=94=E2=94=80fedora_hpe--rl300gen11--04-root 253:0    0 445.5G  0 lv=
m  /


>
> Thanks,
> --Nilay
>


--=20
Best Regards,
  Yi Zhang


