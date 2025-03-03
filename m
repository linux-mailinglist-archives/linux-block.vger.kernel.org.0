Return-Path: <linux-block+bounces-17901-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F221A4C6FA
	for <lists+linux-block@lfdr.de>; Mon,  3 Mar 2025 17:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C141176A90
	for <lists+linux-block@lfdr.de>; Mon,  3 Mar 2025 16:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD8C236440;
	Mon,  3 Mar 2025 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjjAFc8t"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC25217F33
	for <linux-block@vger.kernel.org>; Mon,  3 Mar 2025 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018626; cv=none; b=o/ibyjXYZpkxZLNfFE3kB6qpnkMPFFJJ3mJLfHFUCRSKpsIaYgfYCABqjB2oW8PsrLnIUD/iDdOhCYnyP49EO79397WRE8nHphxiPC0C1Smkk+VT34a97niMwPga7Kz3d2xRxXxTIl04ybWalFZ2gcfJdIeEGkczfHJWHBGoBiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018626; c=relaxed/simple;
	bh=jWdhIKl2I2QQBncoOZnrZ+9cadtpxIAftRf8sy7CY9U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=U9cWwqSmp9HSIn9MKkKySNTIHMzMvlw+J3OCHNo72ZTm6X3WTVDs+FF88eD4o0dJ1m75ZPejcGk2dXZDEpY8gd+iGroxLsteNm1VFSN4xwyJ9lieYoibpEEE/5D8dRY8cxGxTd3FuzRR0VzXoeKl4b5i3UvunIEhw1O5rUYhYso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RjjAFc8t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741018623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FsCq8nwmcrrTQM8f2jqJBEwrL/4u5mEmJM0AXk1sZEQ=;
	b=RjjAFc8tuJT6Q9LHOTVnyzAAaEbzB/9EOs9qj3xG9c5kj54CJefhg6AbFp9bPX5tgVH9rF
	BXZzsjE+f7X73QZML6myG8/WB9LxMy6HcPSr+HxWRfmV0FNS3ceMdGoeF5J74mjelLZIap
	II04lyyuHEmbydUjC8AaFDCfQk0CzVE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-GFj7L9FaOyuf6ATjaUQz9A-1; Mon,
 03 Mar 2025 11:16:57 -0500
X-MC-Unique: GFj7L9FaOyuf6ATjaUQz9A-1
X-Mimecast-MFC-AGG-ID: GFj7L9FaOyuf6ATjaUQz9A_1741018615
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E77218EB2CF;
	Mon,  3 Mar 2025 16:16:54 +0000 (UTC)
Received: from [10.45.224.44] (unknown [10.45.224.44])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E1AF180035E;
	Mon,  3 Mar 2025 16:16:50 +0000 (UTC)
Date: Mon, 3 Mar 2025 17:16:48 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
cc: Jooyung Han <jooyung@google.com>, Alasdair Kergon <agk@redhat.com>, 
    Mike Snitzer <snitzer@kernel.org>, Heinz Mauelshagen <heinzm@redhat.com>, 
    zkabelac@redhat.com, dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] the dm-loop target
In-Reply-To: <Z8W1q6OYKIgnfauA@infradead.org>
Message-ID: <b3caee06-c798-420e-f39f-f500b3ea68ca@redhat.com>
References: <7d6ae2c9-df8e-50d0-7ad6-b787cb3cfab4@redhat.com> <Z8W1q6OYKIgnfauA@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111



On Mon, 3 Mar 2025, Christoph Hellwig wrote:

> On Mon, Mar 03, 2025 at 11:24:27AM +0100, Mikulas Patocka wrote:
> > This is the dm-loop target - a replacement for the regular loop driver 
> > with better performance. The dm-loop target builds a map of the file in 
> > the constructor and it just remaps bios according to this map.
> 
> Using ->bmap is broken and a no-go for new code.

What should I use instead of bmap? Is fiemap exported for use in the 
kernel?

ext4_bmap flushes the journal if journaled data are used. Is there some 
equivalent function that would provide the same guarantee w.r.t. journaled 
data?

> If you have any real
> performance issues with the loop driver document and report them so that
> they can be fixed instead of working around them by duplicating the code
> (and in this case making the new code completely broken).

Would Jens Axboe agree to merge the dm-loop logic into the existing loop 
driver?


Dm-loop is significantly faster than the regular loop:

# modprobe brd rd_size=1048576
# dd if=/dev/zero of=/dev/ram0 bs=1048576
# mkfs.ext4 /dev/ram0
# mount -t ext4 /dev/ram0 /mnt/test
# dd if=/dev/zero of=/mnt/test/test bs=1048576 count=512

dm-loop (on /mnt/test/test):
# dmsetup create loop --table '0 1048576 loop /mnt/test/test 0'
# fio --direct=1 --bs=4k --runtime=10 --time_based --numjobs=16 
--ioengine=psync --iodepth=1 --group_reporting=1 
--filename=/dev/mapper/loop --name=job --rw=rw

   READ: bw=2428MiB/s (2546MB/s), 2428MiB/s-2428MiB/s (2546MB/s-2546MB/s), io=23.7GiB (25.5GB), run=10001-10001msec
  WRITE: bw=2429MiB/s (2547MB/s), 2429MiB/s-2429MiB/s (2547MB/s-2547MB/s), io=23.7GiB (25.5GB), run=10001-10001msec

regular loop (on /mnt/test/test):
# losetup /dev/loop0 /mnt/test/test
# fio --direct=1 --bs=4k --runtime=10 --time_based --numjobs=16 
--ioengine=psync --iodepth=1 --group_reporting=1 --filename=/dev/loop0 
--name=job --rw=rw

   READ: bw=326MiB/s (342MB/s), 326MiB/s-326MiB/s (342MB/s-342MB/s), io=3259MiB (3417MB), run=10003-10003msec
  WRITE: bw=326MiB/s (342MB/s), 326MiB/s-326MiB/s (342MB/s-342MB/s), io=3260MiB (3418MB), run=10003-10003msec


dm-loop is even slightly faster than running fio directly on the regular 
file:

# fio --direct=1 --bs=4k --runtime=10 --time_based --numjobs=16 
--ioengine=psync --iodepth=1 --group_reporting=1 --filename=/mnt/test/test 
--name=job --rw=rw
   READ: bw=2005MiB/s (2103MB/s), 2005MiB/s-2005MiB/s (2103MB/s-2103MB/s), io=19.6GiB (21.0GB), run=10002-10002msec
  WRITE: bw=2007MiB/s (2104MB/s), 2007MiB/s-2007MiB/s (2104MB/s-2104MB/s), io=19.6GiB (21.0GB), run=10002-10002msec

Mikulas


