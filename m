Return-Path: <linux-block+bounces-1452-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4634281DF52
	for <lists+linux-block@lfdr.de>; Mon, 25 Dec 2023 09:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A33F1C216D7
	for <lists+linux-block@lfdr.de>; Mon, 25 Dec 2023 08:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E574417;
	Mon, 25 Dec 2023 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="OUhegLFX"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79143D6A
	for <linux-block@vger.kernel.org>; Mon, 25 Dec 2023 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e6ee8e911so1586925e87.1
        for <linux-block@vger.kernel.org>; Mon, 25 Dec 2023 00:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1703494527; x=1704099327; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rroRLlBJT6GfRNu70mzcTibxuMmHZLKJG0t1hBrphsg=;
        b=OUhegLFXMk+PWlvlYf5T27YF2g99aKfDibnW+XySpTz8HSse6+Tda7DYKy/1KP20MD
         wifVv4PJnmmvze1No1r6RjVAg4hOnoO9hJqZHGz6sTdHcqJf9KLffkp8/cjP8Wo7ISmm
         4h+4o/C17JGxkKBXnxpNTonZK3pB2HWXSzcqsYuewKm36wdAAjsbGJ9F9mkuLJf17ZNo
         B4UjsHCOMgDippQA7kGPSVuo5QvVnZkbBe70e5eHChvFrJQ/f55WsHZK6gvum/+g9fpy
         XMRcH8z1ws3Vue0NOMAadmQ3K//tSpVdMUVFzP0rqkJSGkO6SHVhLD1mdp7CJ65r2jBV
         caKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703494527; x=1704099327;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rroRLlBJT6GfRNu70mzcTibxuMmHZLKJG0t1hBrphsg=;
        b=p6UKw0uTON+TbWpiEVrD6CLjjss82hMbcVCf3GiJigJS6BNXzaGcPIYUsI/sGxgaC4
         JcAO+HvLpypWqBwwd35WOYF1F6w7MmDMwiT1j+L1xvMZgcC6nivgdPqpgTwY/OIcxXGW
         NZrH/1nBJSllto2gTE5R+dEWwOKnYUqY95dFqc354LoEIhsDtkuwiYuwozc/uojkr7hd
         Hoo6X+2lUgcbGN+FBL9+fvrhHugsoiZPyvAstNvrWUUrCOodiOa3UngHKrtJr36gvSVl
         5j26qg0DVMIQzrVzgLhZl8b8H5yoc/TaqbA0625bTR1SfSlpqVhxnwksN+1U0sshMXKK
         uUug==
X-Gm-Message-State: AOJu0Yxl/SS7/Fjbt5wN5sF8Wt6k5rp1WEwXcQcCTildiGMFskJgm+rj
	204ltZxRUFtx9I64KMFDr8Ll2PY/OoLrMQ==
X-Google-Smtp-Source: AGHT+IFSJKqM83HqTWjurjjSswy3qfTP3qwNqDRKOQb7Q6Q9cIw6mHWOV8UA03+wzEzCtDXgsyhqAA==
X-Received: by 2002:a05:6512:2f7:b0:50e:76bd:fa23 with SMTP id m23-20020a05651202f700b0050e76bdfa23mr646575lfq.87.1703494527641;
        Mon, 25 Dec 2023 00:55:27 -0800 (PST)
Received: from smtpclient.apple ([2a00:1370:81a4:169c:d097:b658:f57b:dbcf])
        by smtp.gmail.com with ESMTPSA id v17-20020ac25611000000b0050e75afd92csm628185lfd.212.2023.12.25.00.55.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Dec 2023 00:55:26 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [LSF/MM/BPF TOPIC] Large block for I/O
From: Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <ZYWz8K98YUGf/VZp@casper.infradead.org>
Date: Mon, 25 Dec 2023 11:55:23 +0300
Cc: Keith Busch <kbusch@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>,
 Hannes Reinecke <hare@suse.de>,
 lsf-pc@lists.linuxfoundation.org,
 linux-mm@kvack.org,
 linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FE53ACBB-1787-4EA0-93D9-1147E43A5F57@dubeyko.com>
References: <7970ad75-ca6a-34b9-43ea-c6f67fe6eae6@iogearbox.net>
 <4343d07b-b1b2-d43b-c201-a48e89145e5c@iogearbox.net>
 <03ebbc5f-2ff5-4f3c-8c5b-544413c55257@suse.de>
 <5c356222-fe9e-41b0-b7fe-218fbcde4573@acm.org>
 <BB694C7D-0000-4E2F-B26C-F0E719119B0C@dubeyko.com>
 <ZYWm_tMtfrKaNf3t@kbusch-mbp> <ZYWz8K98YUGf/VZp@casper.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3696.120.41.1.4)



> On Dec 22, 2023, at 7:06 PM, Matthew Wilcox <willy@infradead.org> =
wrote:
>=20
> On Fri, Dec 22, 2023 at 08:10:54AM -0700, Keith Busch wrote:
>> If the host really wants to write in small granularities, then larger
>> block sizes just shifts the write amplification from the device to =
the
>> host, which seems worse than letting the device deal with it.
>=20
> Maybe?  I'm never sure about that.  See, if the drive is actually
> managing the flash in 16kB chunks internally, then the drive has to do =
a
> RMW which is increased latency over the host just doing a 16kB write,
> which can go straight to flash.  Assuming the host has the whole 16kB =
in
> memory (likely?)  Of course, if you're PCIe bandwidth limited, then a
> 4kB write looks more attractive, but generally I think drives tend to
> be IOPS limited not bandwidth limited today?
>=20

Fundamentally, if storage device supports 16K physical sector size, then
I am not sure that we can write by 4K I/O requests. It means that we =
should
read 16K LBA into page cache or application=E2=80=99s buffer before any =
write
operation. So, I see potential RMW inside of storage device only if =
device
is capable to manage 4K I/O requests even if physical sector is 16K.
But is it real life use-case?

I am not sure about attractiveness of 4K write operations. Usually, file =
system
provides the way to configure an internal logical block size and =
metadata
granularities. Finally, it is possible to align the internal metadata =
and user data
granularities on 16K size, for example. An if we are talking about =
metadata
structures (for example, inodes table, block mapping, etc), then it=E2=80=99=
s frequently
updated data. So, 16K will most probably contains several updated 4K =
pieces.
And, as a result, we have to flush all these updated metadata, anyway, =
despite
PCIe bandwidth limitation (even if we have some). Also, I assume that to =
send
16K I/O request could be more beneficial that several 4K I/O requests. =
Of course,
real life is more complicated.=20

Thanks,
Slava.


