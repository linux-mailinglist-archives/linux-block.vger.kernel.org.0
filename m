Return-Path: <linux-block+bounces-4749-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA6A880B89
	for <lists+linux-block@lfdr.de>; Wed, 20 Mar 2024 07:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10EE284008
	for <lists+linux-block@lfdr.de>; Wed, 20 Mar 2024 06:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A38D14A96;
	Wed, 20 Mar 2024 06:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IyjnzWPr"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACC71802E
	for <linux-block@vger.kernel.org>; Wed, 20 Mar 2024 06:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710917890; cv=none; b=GsDnxOSNrRvHjcdBUeKDFw+SFKC92OtvNbk5UPlNu05ZzR4yZMTCB0FB7ZMgzhFRU08eEfLbXJf+FCwzzFf2Tw0Mj5lDRERbA5kx6EmiXQB5WcaIGOThF9MzbvZcsMZgD7EzPEF+oxPCtnaVjrWxgQlYJfVbBFXK3zL+jVgDwSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710917890; c=relaxed/simple;
	bh=DzbL2ta32r3fZb3poZ+ecdauASwMD6F+D73N/oO6EFM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fuHNKjrNDUGhgStYVSoRpZTvXj2Bo1F21kdVbjrby6M0romD+EApQCr9bdmrU8k3r7FhcOVDnMdu6/UTRGePDaTjEV8TJ8uUJL+s57qH2WGmIpXpyr3cCiEjAnmcx+EbAjUIkPaDF+R8xstLOILIy2S/GqQQ/b+KY4+StgjkEH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IyjnzWPr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710917887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ja+Ql3ZN56r0tluKaw1RJ1px6iHKRsoQ+ikPDhL9tZo=;
	b=IyjnzWPr+QPXpiJlePLB8FqRrk7QK49JrYz1tcwuBzqVf/fmjaznriYp9oyGg4beGf4Mnf
	iisbkzljmn/SRxH/LYI20DE2sJOGIpPA8s1lDFQoF+GxAeYDwgQDY1lEEISJ+JBvrwzTu1
	1rpoShTx2rKNaJRFwjZjYauVJssW49o=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-KypkKm49N_2i1Ji1c9z3JA-1; Wed, 20 Mar 2024 02:58:01 -0400
X-MC-Unique: KypkKm49N_2i1Ji1c9z3JA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-29a5bae5b3fso5358701a91.2
        for <linux-block@vger.kernel.org>; Tue, 19 Mar 2024 23:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710917878; x=1711522678;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ja+Ql3ZN56r0tluKaw1RJ1px6iHKRsoQ+ikPDhL9tZo=;
        b=H+LvRHa4PKXJnq6MBSOJSb01DydAsTyLdLIA7XiZ0tpheUaN3R/XhT4MrXrqdo/B+7
         k4/PMd76udwetPO57a3TU8twnLECfBX6dGCjpDeRCHP3ihj4qzx4Jo+cgfJmQzLOfk2D
         CjKYEsQxTBcr360ptR3JYcDLI3UwZI2O49mQJ4Y5B2jwT5U+RAqJd0ezSEQB/Y2sQtyQ
         aBGivbXRnjX0LDYvur3YC1dnjwizspjBTo4aGK+6AihUDijEQH/PMtKRfJkK1dVvyK4C
         23Y+eAEDD/mA7fAfP84P5jerRy07A7Z7HUinSrWGgci0gOu+iubQdR8CLh2mpUmi8Onn
         K7Mw==
X-Gm-Message-State: AOJu0YxFQ1Dik9nhiHuF+9zTGyOlAcMKuWTld4RYcAVSp8C59w3S8vJt
	RXBawZhKdFBnSXiApm7+80sDU2Uz2gb+Oh6u4LLs2cM+CsPuosX+jcipX6hp7k+sInmvd/syOBT
	ZaFdyeBlE24r8TnhH6q6NNaqg+2/CC8jrhROTTiUTGhIMz4pQSyvmPYy9p6Z8piWdsBBCQJfll/
	jTPiQUjZH4TYDDhA4u0HViDy55VGVvkpuP+yqgjjxln8hRF1UT85I=
X-Received: by 2002:a17:90a:7286:b0:29c:3bed:afb2 with SMTP id e6-20020a17090a728600b0029c3bedafb2mr1236810pjg.7.1710917878546;
        Tue, 19 Mar 2024 23:57:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMW4uBLzqIz9g1sDiZZ+f4Lg/YiSXun3KgvGkTt5S5aSg+sWMiCrioPZR8AdVw0BsfQj6Hz8nG9SXnhvzUfBo=
X-Received: by 2002:a17:90a:7286:b0:29c:3bed:afb2 with SMTP id
 e6-20020a17090a728600b0029c3bedafb2mr1236798pjg.7.1710917878231; Tue, 19 Mar
 2024 23:57:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 20 Mar 2024 14:57:46 +0800
Message-ID: <CAHj4cs8dB4bbwnnAXde9S8Tarr8k_O_mkt_cB09X_TsZYjcGcQ@mail.gmail.com>
Subject: [bug report]debugfs: Directory 'target13:0:0' with parent
 'scsi_debug' already present! observed during blktests block/001
To: linux-block <linux-block@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"

Hello

I found below error log from dmesg during blktests block/001 on the
latest linux-block/for-next, please help check it, thanks.

[ 4036.273873] debugfs: Directory 'target13:0:0' with parent
'scsi_debug' already present!
[ 4036.275452] scsi 13:0:0:0: Direct-Access     Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 4036.278450] sd 10:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
[ 4036.281055] scsi 13:0:0:0: Power-on or device reset occurred
--snip--
[ 4038.401691] debugfs: Directory 'target10:0:0' with parent
'scsi_debug' already present!
[ 4038.403439] scsi 10:0:0:0: Direct-Access     Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 4038.409814] sd 11:0:0:0: [sde] Synchronizing SCSI cache
[ 4038.417776] scsi 10:0:0:0: Power-on or device reset occurred
[ 4038.418858] sd 12:0:0:0: Attached scsi generic sg1 type 0
[ 4038.419320] scsi 13:0:0:0: Direct-Access     Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 4038.421092] scsi 11:0:0:0: Direct-Access     Linux    scsi_debug
   0191 PQ: 0 ANSI: 7
[ 4038.424960] scsi 13:0:0:0: Power-on or device reset occurred
[ 4038.425373] sd 12:0:0:0: [sdb] 16384 512-byte logical blocks: (8.39
MB/8.00 MiB)
[ 4038.427895] scsi 11:0:0:0: Power-on or device reset occurred
[ 4038.440374] sd 12:0:0:0: [sdb] Write Protect is off
[ 4038.440470] sd 12:0:0:0: [sdb] Mode Sense: 73 00 10 08
[ 4038.440693] sd 12:0:0:0: [sdb] Asking for cache data failed
[ 4038.446410] sd 12:0:0:0: [sdb] Assuming drive cache: write through
[ 4038.454555] sd 12:0:0:0: [sdb] Preferred minimum I/O size 512 bytes
[ 4038.454643] sd 12:0:0:0: [sdb] Optimal transfer size 524288 bytes
[ 4038.460898] sd 10:0:0:0: Attached scsi generic sg1 type 0
[ 4038.461989] sd 11:0:0:0: [sdc] 16384 512-byte logical blocks: (8.39
MB/8.00 MiB)
[ 4038.462478] sd 10:0:0:0: [sdd] 16384 512-byte logical blocks: (8.39
MB/8.00 MiB)
[ 4038.463355] sd 11:0:0:0: [sdc] Write Protect is off
[ 4038.463438] sd 11:0:0:0: [sdc] Mode Sense: 73 00 10 08
[ 4038.464098] sd 10:0:0:0: [sdd] Write Protect is off
[ 4038.464194] sd 10:0:0:0: [sdd] Mode Sense: 73 00 10 08
[ 4038.465634] sd 13:0:0:0: [sde] 16384 512-byte logical blocks: (8.39
MB/8.00 MiB)
[ 4038.465828] sd 13:0:0:0: Attached scsi generic sg2 type 0
[ 4038.466047] sd 11:0:0:0: [sdc] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[ 4038.466849] sd 10:0:0:0: [sdd] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[ 4038.467347] sd 13:0:0:0: [sde] Write Protect is off
[ 4038.467432] sd 13:0:0:0: [sde] Mode Sense: 73 00 10 08
[ 4038.470204] sd 13:0:0:0: [sde] Write cache: enabled, read cache:
enabled, supports DPO and FUA
[ 4038.470270] sd 11:0:0:0: [sdc] Preferred minimum I/O size 512 bytes
[ 4038.470353] sd 11:0:0:0: [sdc] Optimal transfer size 524288 bytes
[ 4038.471268] sd 10:0:0:0: [sdd] Preferred minimum I/O size 512 bytes
[ 4038.471365] sd 10:0:0:0: [sdd] Optimal transfer size 524288 bytes
[ 4038.476629] sd 13:0:0:0: [sde] Preferred minimum I/O size 512 bytes
[ 4038.476708] sd 13:0:0:0: [sde] Optimal transfer size 524288 bytes
[ 4038.478031] sd 11:0:0:0: Attached scsi generic sg3 type 0
[ 4038.522116] sd 12:0:0:0: [sdb] Attached SCSI disk
[ 4038.528571] sd 10:0:0:0: [sdd] Attached SCSI disk
[ 4038.529208] sd 11:0:0:0: [sdc] Attached SCSI disk

-- 
Best Regards,
  Yi Zhang


