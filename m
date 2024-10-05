Return-Path: <linux-block+bounces-12230-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E479913C2
	for <lists+linux-block@lfdr.de>; Sat,  5 Oct 2024 03:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83BDCB20A7B
	for <lists+linux-block@lfdr.de>; Sat,  5 Oct 2024 01:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDBDD2FA;
	Sat,  5 Oct 2024 01:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="caXVk7ho"
X-Original-To: linux-block@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B107BE4F
	for <linux-block@vger.kernel.org>; Sat,  5 Oct 2024 01:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728091632; cv=none; b=dYZhJeIR54sBIJvzUSOZYbz4/d11lsJxXy0m0YU6fPqrGS4T0AviI4kBlJVTR4HeZR4LZtLTlt7DvZrb28uTNHpiB2HO7rbtNhjK134huNb7SFUND0UglUc6laGPs3bY8Ru6VvyB2Q9ej+ws3rMdA4ncKR/AE3EktYc3ecUbC2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728091632; c=relaxed/simple;
	bh=RZs2r+0Guaoz3xT1NSlzUotwj68Jj3jWXP6nM6TGbTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dYbTNGaqSDGhAN+l4z6kBxEOcMEpiMxjspvJsiviUokfOlel8ecASa4geqZkoptXCHictikvLrlozqDjQKffl6pQ42EPYnV/PUiPfOVLh7wPFX5StK9hyq4lj0KVIHkE/17XiSOmlpsl++ghn8B9j/jsC2HkqidReGMKP0FBKOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=caXVk7ho; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b60fa0ab-591b-41e8-9fca-399b6a25b6d9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728091628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2VC8qI0q43BjF9ZEaHIPqDkde6qxIB0LzkBDmmyVc2c=;
	b=caXVk7holI5r3PJjd9jKsM7ObMBgv6mEhFphPcPLVJQYorAQFMHyw7eehDowCjNuIumOe+
	rHF3uTT9M3sNDnPOD2OYe6r9zVinJ3bJmZ5Ln78QAba/dy88vevt0JVKDYmDhsWr05UwrL
	VH/7reVf3BHTne6xZSDpvbCSq9Yc5ns=
Date: Sat, 5 Oct 2024 09:26:56 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: blktests failures with v6.12-rc1 kernel
To: Bart Van Assche <bvanassche@acm.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <xpe6bea7rakpyoyfvspvin2dsozjmjtjktpph7rep3h25tv7fb@ooz4cu5z6bq6>
 <e6e6f77b-f5c6-4b1e-8ab2-b492755857f0@acm.org>
 <dvpmtffxeydtpid3gigfmmc2jtp2dws6tx4bc27hqo4dp2adhv@x4oqoa2qzl2l>
 <5cff6598-21f3-4e85-9a06-f3a28380585b@linux.dev>
 <9fe72efb-46b8-4a72-b29c-c60a8c64f88c@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <9fe72efb-46b8-4a72-b29c-c60a8c64f88c@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/10/5 0:31, Bart Van Assche 写道:
> On 10/4/24 5:40 AM, Zhu Yanjun wrote:
>> So I add a jiffies (u64) value into the name.
>
> I don't think that embedding the value of the jiffies counter in the 
> kmem cache names is sufficient to make cache names unique. That sounds 
> like a fragile approach to me.

Sorry. I can not get you. Why jiffies counter is not sufficient to make 
cache names unique? And why is it a fragile approach?

Can you share your advice with us?

I read your latest commit. In your commit, the ida is used to make cache 
names unique. It is a good approach if it can fix this problem.

The approach of jiffies seems clumsy. But it seems to be able to fix 
this problem, too. I can not see any risks about this jiffies appraoch.

Zhu Yanjun

>
> Bart.

-- 
Best Regards,
Yanjun.Zhu


