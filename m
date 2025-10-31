Return-Path: <linux-block+bounces-29290-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 239D7C2439F
	for <lists+linux-block@lfdr.de>; Fri, 31 Oct 2025 10:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA8C5610BE
	for <lists+linux-block@lfdr.de>; Fri, 31 Oct 2025 09:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78EA31B116;
	Fri, 31 Oct 2025 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="M8XsMH2e"
X-Original-To: linux-block@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D232D9797
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903412; cv=none; b=Ivk9wt6AFNVZ2F9pIJnbfmL8f4DPDFyXr2dIW4uQI9xskFoZckcAv7h7o7lEm+PaXMV1iO/onNrGwNo2w2wvNeI9887PqKYcJYtFFLcUaic48Iqho5s67gQY2HDo0dl0AXwrO1YwlWFTNWU3Fb/iMCkLOpcnFAcdcNepK5LhtW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903412; c=relaxed/simple;
	bh=nvNw+eBzau7jHl2SH6kk0F5lMVke3j2tW8GaTFH1hCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uT21ospW25cvStKsWZifvzOLn505QK2g970JxAiXCR8ZXABvwFYSx6yP+mmHlYTdHRtv+7aHF4zA3VnkJxmvSUr6WHU7dyaneWgb79wbbnqTWo4d5H7k3qUs1eO+CzQE6DCc+wwFnljgp2+3Z3t+tfAQBRAVSTCOYcGmJwHPwLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=M8XsMH2e; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761903407; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tlq1q0qf7tR7hYmQijZRFkXeOywMt6Qxywm1qb4NC+A=;
	b=M8XsMH2eq3AQSAc2nBL5DwPskTGY5FwlARD3TU/44klO/iXn/Dhh+T0L/wyEYj1vzqHsr1wNiUv41ALfes9SAWJzHgue15pPF3RWZ2rWVkOQtT2qiv8x13fFPxHBz67TQg9g2yFMtiKOyxIIwoTo3GVWheKzNzuTxuHU/saGgNw=
Received: from 30.221.132.210(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WrOW9Dm_1761903405 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 31 Oct 2025 17:36:46 +0800
Message-ID: <ae38c5dc-da90-4fb3-bb72-61b66ab5a0d2@linux.alibaba.com>
Date: Fri, 31 Oct 2025 17:36:45 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: question about bd_inode hashing against device_add() // Re:
 [PATCH 03/11] block: call bdev_add later in device_add_disk
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
 Christian Brauner <brauner@kernel.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
 Joseph Qi <joseph.qi@linux.alibaba.com>, guanghuifeng@linux.alibaba.com,
 zongyong.wzy@alibaba-inc.com, zyfjeff@linux.alibaba.com
References: <20210818144542.19305-1-hch@lst.de>
 <20210818144542.19305-4-hch@lst.de>
 <43375218-2a80-4a7a-b8bb-465f6419b595@linux.alibaba.com>
 <20251031090925.GA9379@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20251031090925.GA9379@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christoph,

On 2025/10/31 17:09, Christoph Hellwig wrote:
> On Fri, Oct 31, 2025 at 03:46:02PM +0800, Gao Xiang wrote:
>>  From my understanding, before this commit, bdev_add() will
>> be called prior to device_add() so insert_inode_hash()
>> in bdev_add() will be called before users can see blkdev
>> in the devtmpfs.
>>
>> But after this change, blkdev can be seen before
>> insert_inode_hash(), which opens a race (although I'm not
>> sure if it's an expected behavior) blkdev_get_no_open() will
>> find nothing (e.g. mounting) even blkdev in devtmpfs is
>> there.
> 
> We're not supposed to see the uevent notification before the
> block device is ready.

Thanks for the quick response.

Right, sorry yes, disk_uevent(KOBJ_ADD) is in the end.

>  Do you see that earlier, or do you have
> code busy polling for a node?

Personally I think it will break many userspace programs
(although I also don't think it's a correct expectation.)

After recheck internally, the userspace program logic is:
   - stat /dev/vdX;
   - if exists, mount directly;
   - if non-exists, listen uevent disk_add instead.

Previously, for devtmpfs blkdev files, such stat/mount
assumption is always valid.

After this change, it's only valid for udev generated blkdev
files (because they're generated by uevent).  again I'm not
saying it's a good assumption, but I guess many developpers
who don't know this will write such user code, including our
internal users.

Thanks,
Gao Xiang

