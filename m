Return-Path: <linux-block+bounces-4818-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 801088863DD
	for <lists+linux-block@lfdr.de>; Fri, 22 Mar 2024 00:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269131F2293A
	for <lists+linux-block@lfdr.de>; Thu, 21 Mar 2024 23:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696D3566A;
	Thu, 21 Mar 2024 23:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="hsAYp96V"
X-Original-To: linux-block@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D74C53B8
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 23:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711062244; cv=none; b=kCPIUIE0i/l3D9WWyvdjC1OWtw9CYEhWn5/Vctafxd0EXEP3jMUOZM08f0iwJSOMqUKcvNqb7ts7DGmPMKRNm9trTmlSiKQXuZPbpbgl7zRuW+FkOLL/fxsYyLesN00ZmygiZmf1Sqwsckih14QPNvbIMwK6zQmWdyD8yRbDsVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711062244; c=relaxed/simple;
	bh=qUR7hWKRv+fhs6BHG/kYqfeZYc6epEJtHMByIKkvt0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=naZMmz7LPeprCWKQOupP06YtnFE1nwAzk5AOpitHMZY1pwQ6zsQ5nudkQKrKYOGsGw3WVggt7Qb6rjutOyrGRUYdZCefLgXmSc57O9YvAoxE+H+JKVoIf0uO2Bn7SdQ7lUSZARClL9e2m9FDPpOcikb7oxE/6JbrhRocCxnOAVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=hsAYp96V; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4V11H56lpSz6Cnk8s;
	Thu, 21 Mar 2024 23:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711062239; x=1713654240; bh=qoljGiP4nxr0HS+IMXKvWWTy
	vH9RfqX/5fOs8svAsV4=; b=hsAYp96VFp9hf5V0+8j6Tmk2OCItQ/HaJv77lZ9P
	MtMSaglikTBenF7aeT7vp8ZCja7v+n41YYxPxT6ie37R1p3OtoCLzgjJWnAPqsra
	POneZ64/fZZch2OMQr1aAogI3t2sXOVI7yCbTuJ4nfgdweogg3wx6LjoHt6I3McT
	/SVKnVmd3oyELJ4JSepzissZupq7SovmDeHERxlQDzcwRWJKgSJPA5agK5HIDd5K
	WJr+tMiwPVbKsLLLHFOUVZauNtYrtSpjuUVZ+G8DZmnYlc7HEsh7Sz4XAod94cli
	BSSRkibhZU+fpRQauTxUgz+4VRJYobwFhM9EYZlrarfnWg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id CVTOQ99OBS3C; Thu, 21 Mar 2024 23:03:59 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4V11H11Ytjz6Cnk8m;
	Thu, 21 Mar 2024 23:03:56 +0000 (UTC)
Message-ID: <13f47d63-2140-4927-8933-009dae21f7e6@acm.org>
Date: Thu, 21 Mar 2024 16:03:55 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Improve IOPS by removing the fairness code
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
 Yu Kuai <yukuai3@huawei.com>
References: <20240321224605.107783-1-bvanassche@acm.org>
 <20240321224814.GA23127@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240321224814.GA23127@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/24 15:48, Christoph Hellwig wrote:
> On Thu, Mar 21, 2024 at 03:46:05PM -0700, Bart Van Assche wrote:
>> There is an algorithm in the block layer for maintaining fairness
>> across queues that share a tag set. The sbitmap implementation has
>> improved so much that we don't need the block layer fairness algorithm
>> anymore and that we can rely on the sbitmap implementation to guarantee
>> fairness.
> 
> IFF that was true it would be awesome.  But do you have proof for that
> assertation?

Hi Christoph,

Is the test in this pull request sufficient as evidence that we don't
need the request queue fairness code anymore:
https://github.com/osandov/blktests/pull/135?

That test does the following:
* Create two request queues with a shared tag set and with different
   completion times (1 ms and 100 ms).
* Submit I/O to both request queues simultaneously and set the queue
   depth for both tests to the number of tags. This creates contention
   on tag allocation.
* After I/O finished, check that the fio job with the shortest
   completion time submitted the most requests.

Thanks,

Bart.


