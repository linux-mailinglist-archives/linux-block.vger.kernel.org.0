Return-Path: <linux-block+bounces-4817-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C56CB88638C
	for <lists+linux-block@lfdr.de>; Thu, 21 Mar 2024 23:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB9A1F21D1F
	for <lists+linux-block@lfdr.de>; Thu, 21 Mar 2024 22:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEAF53B8;
	Thu, 21 Mar 2024 22:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="FuKmzHxw"
X-Original-To: linux-block@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EDB5231
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 22:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711061833; cv=none; b=dPziCs4w9aYErgZcZRC3Qho+MD+OYgtWaPnRMFznX2UO4x6ag7IJchYDKgUxXqRemJIjOX7AFGoK+HeooD8VkRRQLo/5eXRqVoKvLJg/fr9N8R862T3K3+/J2CP9Tihrs7BO40E35It7eZe8f81G4zCNNKrhprT3emi1QfAtPos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711061833; c=relaxed/simple;
	bh=iM2qeI+ui3Vbrt27py8b64OKLBb2MmCyRQfCRIKf4iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WXTnd7JctfrA3IhRP1123UUz0fJiDZFNpYAB3L2b5TKgneHkj0LBsExzqSsD0o+2xamAnIM3kJNSzJi+GXfdHHfyz/ivDpSZtg9kyBkiBXwAmkGmpgvjpObM30EOdq5b4VnJ2Ka3cm9GoicrH1xDSGv7UO9SivZtnC+AStQGi4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=FuKmzHxw; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4V117C3XMtz6Cnk8s;
	Thu, 21 Mar 2024 22:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711061829; x=1713653830; bh=iM2qeI+ui3Vbrt27py8b64OK
	LBb2MmCyRQfCRIKf4iM=; b=FuKmzHxw5Jxjk4rPcul7KSeqGFDAQpT5K5GDIi5e
	B70s7YAde0Pjs8Heccm789nqwqZ1rsljO0blxb32XOHHS/rxGaX+XbIlsxOpr+aW
	HUyG0gSsUAugyuKx2WjlfhSqceAtyJwObmDkVJJtUZMEGTK8bKUSBe50aJCgmsSs
	Tsri80UCDmMHS9EopksxTRs7CCfouevmoAzZN4bVEHxysmmjvR9ufzYixlcofr2d
	AJTrXMuNJ90RbuQRDjLXl4Bry8LQMr6/uFEFhoORp+5XG5uCzsj2GnxsDulBpg7h
	vQoNR28d/uoXzYuzdE88IxzTS4d9muss0aGqvJgWPZlykw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id XusnDFQ3gysA; Thu, 21 Mar 2024 22:57:09 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4V11775CY9z6Cnk8m;
	Thu, 21 Mar 2024 22:57:07 +0000 (UTC)
Message-ID: <e50d7215-3abe-48a7-82e7-0eb775484829@acm.org>
Date: Thu, 21 Mar 2024 15:57:06 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Improve IOPS by removing the fairness code
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
 Yu Kuai <yukuai3@huawei.com>
References: <20240321224605.107783-1-bvanassche@acm.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240321224605.107783-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/24 15:46, Bart Van Assche wrote:
> There is an algorithm in the block layer for maintaining fairness
> across queues that share a tag set. The sbitmap implementation has
> improved so much that we don't need the block layer fairness algorithm
> anymore and that we can rely on the sbitmap implementation to guarantee
> fairness.

A regression test is available here:
https://github.com/osandov/blktests/pull/135

Bart.


