Return-Path: <linux-block+bounces-7021-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD8A8BCD44
	for <lists+linux-block@lfdr.de>; Mon,  6 May 2024 14:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5047E1F23786
	for <lists+linux-block@lfdr.de>; Mon,  6 May 2024 12:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C209143745;
	Mon,  6 May 2024 12:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="E29DjPF2"
X-Original-To: linux-block@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC471DFCE;
	Mon,  6 May 2024 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714996891; cv=none; b=l1eFo+KnmR3giEqKNuzwed5f1iQFF4XSkRIykKeC35CEuivibfPuwKZdyDVOYbqJFkY2zoC0c7gO/GHxyqeqxYOQXmG5PS7KQjf1ZrpDDu/OUU64IgeJEcQ82U2e/+f/3Uc98Mrwfhmx5teYBYCWLymXwRD7lDlii/isPh7cipw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714996891; c=relaxed/simple;
	bh=dtaebrFxgytb4AGXpY5GeugioiOAxQ3+iNt00wjMwWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgVRXOEo681IgIx0BKCNDhVlquBmaPGQrAPXGyh8sI/Oqk32MmAd1S6UQR1l4oOHAlN6jP7GTPbahGbQvnAR4RbbsEOxUoek/IA7dbkxCj6UOjH7ARD/u4Z7JwCFUThkSBVdmC+c2lQ9irNvj43oZrNuJ6D3vaboaSst+zLrWbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=E29DjPF2; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=AG+zQRf+8WPdqPqt9AeLRxxMJATcL0pMg0adtWHljsM=; b=E29DjPF2mJhvF/tH
	6kJn3XIiosuHAIbuYBvxFMTArJEjzCQxy0KBRuEnlAq0mSgPXYhMdIgFg3H6WEInJ6wY/eYc+xVki
	jhXNbo88INLpaMzzi0QnlHBhmTKNQaoSZYrgjuqYJeYKbrHWxYu4++LgJKIFH0eyLv8sLJBJNWs1E
	DVKNd1jT809fxN22xYO1Q1d9z/FWtymv1DwW80X73dD9AAaaeqyg9nz5kRAxl15YtqjcXrHqebXT/
	hBNaApX/aClEkSbh3Yv/18TFzx89NP7JEdlTiefquieVYPdfr0cJZ3yj+TtQRQW6ycwDzcvc2KB0y
	54kecO6WKmeH9W6FtA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1s3x24-004uVK-05;
	Mon, 06 May 2024 12:01:24 +0000
Date: Mon, 6 May 2024 12:01:24 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-raid <linux-raid@vger.kernel.org>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: Massive slowdown in kernels as of 6.x
Message-ID: <ZjjGlLaPcxgFIJv6@gallifrey>
References: <1ebabc15-51a8-59f3-c813-4e65e897a373@diagnostix.dwd.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1ebabc15-51a8-59f3-c813-4e65e897a373@diagnostix.dwd.de>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-17-amd64 (x86_64)
X-Uptime: 11:54:02 up 124 days, 14:43,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Holger Kiehl (Holger.Kiehl@dwd.de) wrote:
> Hello,
> 
> on a 4 socket file server distributing ~90 million files with
> ~130TiB of data daily, I see a massive slowdown of IO operation
> after some time (sometimes in less then a day). This slowdown
> only started as of Kernel 6.x and does not happen with 5.15.x.
> Have so far tried, 6.0.9, 6.1.27 and 6.6.30 kernel and they all
> have this same slowdown effect after some time. If the load is
> taken away from the server and it is nearly idle, it still has
> this slowdown effect and only recovers after some hours by itself.
> During this slowdown and idle time I had a look at an rsync
> process with strace that was uploading some small files to the
> server and could see the slowdown here was in the rename() system
> call, all other system calls (read(), write(), newfstatat(),
> openat(), fchmod(), etc) where not effected:
> 
>    rename(".27095571.iXVMMT", "27095571")  = 0 <18.305817>
>    rename(".272629ef.22gv2x", "272629ef")  = 0 <18.325222>

Having a test that takes many seconds at least means you could
attack it with some simple tools while it's doing it.

Some thoughts:
  a) Try using 'iostat' to see what the drives and raids
are doing during that time, and compare it to 'fast'.
  b) You could run a 'perf record -a' during the bad run
and see where the CPUs are spending their time (make sure
you get the perf data recorded off the troublesome fs)
  c) Given the names, I'm curious, is it a directory with
millions of files in one directory?
  d) I'm assuming that this is not happening during the
RAID check or trimming.

Dave

>    rename(".275fbacf.UBj6J5", "275fbacf")  = 0 <18.317571>
>    rename(".277ab7da.K5y144", "277ab7da")  = 0 <18.312568>
>    rename(".27873039.ZQ4Lum", "27873039")  = 0 <18.310120>
>    rename(".27ebf01f.t1FKeU", "27ebf01f")  = 0 <18.376816>
>    rename(".27f97e6a.kJqqfL", "27f97e6a")  = 0 <18.290618>
>    rename(".28078cd9.rV7JdN", "28078cd9")  = 0 <18.315415>
>    rename(".28105bb4.gljiDk", "28105bb4")  = 0 <18.325392>
>    rename(".282209b1.Cy3Wt2", "282209b1")  = 0 <30.188303>
>    rename(".28888272.aUCxRj", "28888272")  = 0 <18.263236>
>    rename(".288d8408.XjfGbH", "288d8408")  = 0 <18.312444>
>    rename(".2897f455.hm3FG6", "2897f455")  = 0 <18.281729>
>    rename(".28d7d7e8.pzMMF6", "28d7d7e8")  = 0 <18.281402>
>    rename(".28d9a820.KQuaM0", "28d9a820")  = 0 <32.620562>
>    rename(".294ae845.8Y6vYR", "294ae845")  = 0 <18.289532>
>    rename(".294fee3f.eccu2p", "294fee3f")  = 0 <18.260564>
>    rename(".29581b50.zPTjTh", "29581b50")  = 0 <18.314536>
>    rename(".2975d45f.l5FUYX", "2975d45f")  = 0 <18.293864>
>    rename(".29b3770a.tlNMvb", "29b3770a")  = 0 <0.000062>
>    rename(".29c5e6ee.EexCwZ", "29c5e6ee")  = 0 <18.268144>
>    rename(".29d23183.sLqxpd", "29d23183")  = 0 <18.344478>
>    rename(".29d4f65.oyjRWj", "29d4f65")    = 0 <18.553610>
>    rename(".29dcfab1.Y47Z1B", "29dcfab1")  = 0 <18.339336>
>    rename(".29f26c7c.KNZXEe", "29f26c7c")  = 0 <18.372242>
>    rename(".2a09907b.SXIgev", "2a09907b")  = 0 <18.317119>
>    rename(".2a0c499c.8DiCsM", "2a0c499c")  = 0 <18.380393>
>    rename(".2a64b7e8.FPnsB3", "2a64b7e8")  = 0 <18.372004>
>    rename(".2a6765c9.t7Z0hj", "2a6765c9")  = 0 <18.296044>
>    rename(".2a83d78f.UJVoMu", "2a83d78f")  = 0 <18.380678>
>    rename(".2a94e724.AorYof", "2a94e724")  = 0 <18.360716>
>    rename(".2a9ea651.EWpBHM", "2a9ea651")  = 0 <18.327733>
>    rename(".2a9f1679.xDYq9Q", "2a9f1679")  = 0 <18.312850>
>    rename(".2ab0a134.2GWgmr", "2ab0a134")  = 0 <18.326181>
>    rename(".2aebf110.pGkILq", "2aebf110")  = 0 <0.000188>
>    rename(".2af10031.7Sl5g6", "2af10031")  = 0 <18.342683>
>    rename(".2b095066.MCauJX", "2b095066")  = 0 <18.375003>
>    rename(".2b217bfd.HauJjr", "2b217bfd")  = 0 <18.427703>
>    rename(".2b336a06.w5NN0p", "2b336a06")  = 0 <18.378774>
>    rename(".2b40b422.i2v0E6", "2b40b422")  = 0 <14.727797>
>    rename(".2b568d13.9zmRRX", "2b568d13")  = 0 <0.000056>
>    rename(".2b5ccc66.AFd86P", "2b5ccc66")  = 0 <0.000063>
>    rename(".2b7d0a43.qWyxge", "2b7d0a43")  = 0 <0.000046>
>    rename(".2b7f968a.QAqOCb", "2b7f968a")  = 0 <0.000041>
>    rename(".2ba6dddf.ynNTvi", "2ba6dddf")  = 0 <0.000039>
>    rename(".2bce23ab.tliDkg", "2bce23ab")  = 0 <0.000040>
>    rename(".2c19e144.CvHPV5", "2c19e144")  = 0 <0.000060>
>    rename(".2c7c0651.8x1kQy", "2c7c0651")  = 0 <0.000057>
>    rename(".2ca1a6b7.QwujH4", "2ca1a6b7")  = 0 <0.000396>
>    rename(".2cc71683.7n9EYA", "2cc71683")  = 0 <0.000045>
>    rename(".2cebde90.ZiGcTa", "2cebde90")  = 0 <0.000042>
>    rename(".2d057cb4.5PGOIP", "2d057cb4")  = 0 <0.000042>
>    rename(".2d29b4a7.A8hfwg", "2d29b4a7")  = 0 <0.000043>
> 
> So during the slow phase it took mostly ~18 seconds and as the phase
> ends, the renames are very fast again.
> 
> Tried to change the priority of the process with renice and
> also enabled some different IO schedulers for the block device,
> but this had no effect.
> 
> Could not find anything in the logs or dmesg when this happens.
> 
> Any idea what could be the cause of this slowdown?
> 
> What else can I do to better locate in which part of the kernel
> the IO is stuck?
> 
> The system has 1.5TiB memory and the filesystem is ext4 on a MD
> raid10 with 10 nvme drives (Intel P4610):
> 
>    cat /proc/mdstat
>    Personalities : [raid10]
>    md0 : active raid10 nvme1n1[2] nvme4n1[4] nvme5n1[5] nvme3n1[3] nvme9n1[9] nvme8n1[8] nvme7n1[7] nvme6n1[6] nvme2n1[1] nvme0n1[0]
>          7813406720 blocks super 1.2 512K chunks 2 near-copies [10/10] [UUUUUUUUUU]
>          bitmap: 28/59 pages [112KB], 65536KB chunk
> 
> Mounted as follows:
> 
>    /dev/md0 on /u2 type ext4 (rw,nodev,noatime,commit=600,stripe=640)
> 
> The following cron entry is used to trim the device:
> 
>    25 */2 * * * root /usr/sbin/fstrim -v /u2 >> /tmp/u2.trim 2>&1
> 
> A check of the raid was also performed with no issues:
> 
>    [Sun May  5 13:52:01 2024] md: data-check of RAID array md0
>    [Sun May  5 14:54:25 2024] md: md0: data-check done.
>    cat /sys/block/md0/md/mismatch_cnt
>    0
> 
> CPU's are four Intel Xeon Platinum 8268 and server is a Dell Poweredge R940.
> 
> Additional information of the kernel config and other information I have
> uploaded to https://download.dwd.de/pub/afd/test/kernel_problem
> 
> Regards,
> Holger
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

