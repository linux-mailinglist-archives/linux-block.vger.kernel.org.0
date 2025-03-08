Return-Path: <linux-block+bounces-18083-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFAFA5780E
	for <lists+linux-block@lfdr.de>; Sat,  8 Mar 2025 04:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB06216E9C9
	for <lists+linux-block@lfdr.de>; Sat,  8 Mar 2025 03:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8875E51C5A;
	Sat,  8 Mar 2025 03:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6ETkMBV"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581602CAB;
	Sat,  8 Mar 2025 03:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405786; cv=none; b=PsSMGmtfgjzEt5IiB5zIhZqaNjIaYN1qln1y2rHLSND7PeAQmNu2CsxykGB0Y3u4gpqkNLxzjtTBvTnaBZj763vWmq+Nm8B6n7rYC6e58TZLj4MD2jJ761Xx5gmRSR8/KF4Tnk9iuIewoBaIrtUuAAOR94ZlCJksb9Z/UMaPq84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405786; c=relaxed/simple;
	bh=2/DxdqCSAxsariLOtaoQkAGj3uF1Ebn1pZo/9k2V3PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwCwKlRhxNgpcrQW6+IDNMea2BJ3ERpCHVubRo9t9Y81Ka9JtdX+BByP7yrtmVSMCkSKqbb4FnvjWqg4EGYMDt/wgPG+VFWc5kqc/Ka6uGRjvIeE3geKub9k4kJh9J0Si/1NgZKKSURJQuPuZuqiAiR0vmpJChPVjGqaSQW7PPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6ETkMBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE90EC4CEE0;
	Sat,  8 Mar 2025 03:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741405785;
	bh=2/DxdqCSAxsariLOtaoQkAGj3uF1Ebn1pZo/9k2V3PI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n6ETkMBV3STfh2avZe1G42xUmy80Mhp4D8jdUYdrpc4gyxcAsA5im5FXjn+0ha33o
	 y9SzamCzzFcTL0a9niw5eq+3lhKSznGkToWkPrFHVb4saIpsbqufTKG3gvfbT01jYz
	 WxFksvGTJ7q/WhDFHBrNxOidWIo/exK67Ig497rxdFVZzbkIHDfESXzOLcl/RK7JAi
	 paMaw1ja8Nh04BzLL4e7hta0KsgT5KyoktSZ2aNX+wwMWbEIicuvD7nZJLRdoxIdwB
	 8MyVmJ8pWOYizVzhPA+/AlqGaXcVxQdY9dKnse5EHOfBUq8X7dHuG8irSzkY+wPJJ8
	 OWbb/N6TeYLMQ==
Date: Fri, 7 Mar 2025 19:49:45 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Heinz Mauelshagen <heinzm@redhat.com>, zkabelac@redhat.com,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
Message-ID: <20250308034945.GG2803740@frogsfrogsfrogs>
References: <7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com>
 <Z8W1q6OYKIgnfauA@infradead.org>
 <b3caee06-c798-420e-f39f-f500b3ea68ca@redhat.com>
 <Z8XlvU0o3C5hAAaM@infradead.org>
 <8adb8df2-0c75-592d-bc3e-5609bb8de8d8@redhat.com>
 <Z8Zh5T9ZtPOQlDzX@dread.disaster.area>
 <1fde6ab6-bfba-3dc4-d7fb-67074036deb0@redhat.com>
 <Z8eURG4AMbhornMf@dread.disaster.area>
 <81b037c8-8fea-2d4c-0baf-d9aa18835063@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81b037c8-8fea-2d4c-0baf-d9aa18835063@redhat.com>

On Fri, Mar 07, 2025 at 04:21:58PM +0100, Mikulas Patocka wrote:
> > I didn't say you were. I said the concept that dm-loop is based on
> > is fundamentally flawed and that your benchmark setup does not
> > reflect real world usage of loop devices.
> 
> > Where are the bug reports about the loop device being slow and the
> > analysis that indicates that it is unfixable?
> 
> So, I did benchmarks on an enterprise nvme drive (SAMSUNG 
> MZPLJ1T6HBJR-00007). I stacked ext4/loop/ext4, xfs/loop/xfs (using losetup 
> --direct-io=on), ext4/dm-loop/ext4 and xfs/dm-loop/xfs. And loop is slow.

Are you running the loop device in directio mode?  The default is to use
buffered io, which wastes pagecache /and/ sometimes trips dirty limits
throttling.  The loopdev tests in fstests get noticeably faster if I
force directio mode.

--D

> synchronous I/O:
> fio --direct=1 --bs=4k --runtime=10 --time_based --numjobs=12 --ioengine=psync --iodepth=1 --group_reporting=1 --filename=/mnt/test2/l -name=job --rw=rw
> raw block device:
>    READ: bw=399MiB/s (418MB/s), 399MiB/s-399MiB/s (418MB/s-418MB/s), io=3985MiB (4179MB), run=10001-10001msec
>   WRITE: bw=399MiB/s (418MB/s), 399MiB/s-399MiB/s (418MB/s-418MB/s), io=3990MiB (4184MB), run=10001-10001msec
> ext4/loop/ext4:
>    READ: bw=223MiB/s (234MB/s), 223MiB/s-223MiB/s (234MB/s-234MB/s), io=2232MiB (2341MB), run=10002-10002msec
>   WRITE: bw=223MiB/s (234MB/s), 223MiB/s-223MiB/s (234MB/s-234MB/s), io=2231MiB (2339MB), run=10002-10002msec
> xfs/loop/xfs:
>    READ: bw=220MiB/s (230MB/s), 220MiB/s-220MiB/s (230MB/s-230MB/s), io=2196MiB (2303MB), run=10001-10001msec
>   WRITE: bw=219MiB/s (230MB/s), 219MiB/s-219MiB/s (230MB/s-230MB/s), io=2193MiB (2300MB), run=10001-10001msec
> ext4/dm-loop/ext4:
>    READ: bw=338MiB/s (355MB/s), 338MiB/s-338MiB/s (355MB/s-355MB/s), io=3383MiB (3547MB), run=10002-10002msec
>   WRITE: bw=338MiB/s (355MB/s), 338MiB/s-338MiB/s (355MB/s-355MB/s), io=3385MiB (3549MB), run=10002-10002msec
> xfs/dm-loop/xfs:
>    READ: bw=375MiB/s (393MB/s), 375MiB/s-375MiB/s (393MB/s-393MB/s), io=3752MiB (3934MB), run=10002-10002msec
>   WRITE: bw=376MiB/s (394MB/s), 376MiB/s-376MiB/s (394MB/s-394MB/s), io=3756MiB (3938MB), run=10002-10002msec
> 
> asynchronous I/O:
> fio --direct=1 --bs=4k --runtime=10 --time_based --numjobs=12 --ioengine=libaio --iodepth=16 --group_reporting=1 --filename=/mnt/test2/l -name=job --rw=rw
> raw block device:
>    READ: bw=1246MiB/s (1306MB/s), 1246MiB/s-1246MiB/s (1306MB/s-1306MB/s), io=12.2GiB (13.1GB), run=10001-10001msec
>   WRITE: bw=1247MiB/s (1308MB/s), 1247MiB/s-1247MiB/s (1308MB/s-1308MB/s), io=12.2GiB (13.1GB), run=10001-10001msec
> ext4/loop/ext4:
>    READ: bw=274MiB/s (288MB/s), 274MiB/s-274MiB/s (288MB/s-288MB/s), io=2743MiB (2877MB), run=10001-10001msec
>   WRITE: bw=275MiB/s (288MB/s), 275MiB/s-275MiB/s (288MB/s-288MB/s), io=2747MiB (2880MB), run=10001-10001msec
> xfs/loop/xfs:
>    READ: bw=276MiB/s (289MB/s), 276MiB/s-276MiB/s (289MB/s-289MB/s), io=2761MiB (2896MB), run=10002-10002msec
>   WRITE: bw=276MiB/s (290MB/s), 276MiB/s-276MiB/s (290MB/s-290MB/s), io=2765MiB (2899MB), run=10002-10002msec
> ext4/dm-loop/ext4:
>    READ: bw=1189MiB/s (1247MB/s), 1189MiB/s-1189MiB/s (1247MB/s-1247MB/s), io=11.6GiB (12.5GB), run=10002-10002msec
>   WRITE: bw=1190MiB/s (1248MB/s), 1190MiB/s-1190MiB/s (1248MB/s-1248MB/s), io=11.6GiB (12.5GB), run=10002-10002msec
> xfs/dm-loop/xfs:
>    READ: bw=1209MiB/s (1268MB/s), 1209MiB/s-1209MiB/s (1268MB/s-1268MB/s), io=11.8GiB (12.7GB), run=10001-10001msec
>   WRITE: bw=1210MiB/s (1269MB/s), 1210MiB/s-1210MiB/s (1269MB/s-1269MB/s), io=11.8GiB (12.7GB), run=10001-10001msec
> 
> Mikulas
> 
> 

