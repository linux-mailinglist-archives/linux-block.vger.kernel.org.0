Return-Path: <linux-block+bounces-7552-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 860888CA4F6
	for <lists+linux-block@lfdr.de>; Tue, 21 May 2024 01:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98771C2121B
	for <lists+linux-block@lfdr.de>; Mon, 20 May 2024 23:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72011384A2;
	Mon, 20 May 2024 23:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="1/EwDtHV"
X-Original-To: linux-block@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EAB13848B;
	Mon, 20 May 2024 23:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716247519; cv=none; b=bYXsyCAuZblid7TDgOvj1VcR0BGdnrSK2xKCSXkxA2h5KVmPvW31zEtlOec5Kf+QwogNx7bM/DIPQbgIT4nCwjN5CV8PckDNoyDQ01JPF6t/FBiUG8U4MWaZpG6TF9gUyWsiFL76seDA6s1BK7/Pd7quFgY4+9caX4ZZNXxvynA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716247519; c=relaxed/simple;
	bh=ijJgz4CBGLhb/HVy0yww/S8sCF0i5ebWHafePyrDQfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZ7agw5cMe1O/WoDLQ6MzIV5ciGl9YPQtSB2uE3OcU8AaR2rczAmCI2NPuzxVBPiG0HIeiHpzwXlGjyds1dtYVLKKnpNnnNtHOleWGwEziXBpQphkrh+MfYghJ8k+OqVDBgwcmhlt6Q0fE3wBLZ3XOJRnVx2XhMWLbCnsRMUDAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=1/EwDtHV; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Vjtvx5QCMz6Cnk8t;
	Mon, 20 May 2024 23:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716247511; x=1718839512; bh=ijJgz4CBGLhb/HVy0yww/S8s
	CF0i5ebWHafePyrDQfQ=; b=1/EwDtHV0WPmqtf8mplzj1czPHU6HOd2g2nDQaoh
	J166e8sXbsEPka3Wveo2nm0+5su3HFv//Qve0LRX9/AHRWrDeFlAqfmcFr/37feT
	NHzJVUf9VZxQE76xUSi0cEaT9pmXVrXbTKuc1Lwh5wTk3CX9LuuCE8CSSkpoVVpt
	BhrLRwGJ1cig5Jr6kZixW2G72zykgYIPibiIFxmsk6lcvlqUAENMezqYJ+OfAUxp
	FYtzfptMZcNSFCbbQD2xbhDLRNyYeRlcp7MQ/nw5ORwEv4qSGgjWTtRtn8zXFra0
	0GdpBdqmsAh/XgGsKgSiovwE+jMaenvMaMg4dc2gL4DNRQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id q3O6tu1vG9Fr; Mon, 20 May 2024 23:25:11 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Vjtvh4pRCz6Cnk8s;
	Mon, 20 May 2024 23:25:04 +0000 (UTC)
Message-ID: <017a9853-6e42-4250-9cfa-1d6ad5786556@acm.org>
Date: Mon, 20 May 2024 16:25:02 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 10/12] dm: Enable copy offload for dm-linear target
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
 damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520103016epcas5p31b9a0f3637959626d49763609ebda6ef@epcas5p3.samsung.com>
 <20240520102033.9361-11-nj.shetty@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240520102033.9361-11-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/24 03:20, Nitesh Shetty wrote:
> Setting copy_offload_supported flag to enable offload.

I think that the description of this patch should explain why it is safe
to set the 'copy_offload_supported' flag for the dm-linear driver.

Thanks,

Bart.


