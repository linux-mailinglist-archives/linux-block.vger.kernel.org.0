Return-Path: <linux-block+bounces-6840-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A448B99F5
	for <lists+linux-block@lfdr.de>; Thu,  2 May 2024 13:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B621C20B09
	for <lists+linux-block@lfdr.de>; Thu,  2 May 2024 11:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7655F874;
	Thu,  2 May 2024 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ExESGjMl"
X-Original-To: linux-block@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CAD604C8
	for <linux-block@vger.kernel.org>; Thu,  2 May 2024 11:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714649162; cv=none; b=dOzpE7hSNr4PnKDaIFsbcR4ZchQeD5zVPVkdQucxr3rbnr0p4Rl0qkE2KkWNbxKcGk2aVfkhnDg1J7a0oyu7sXtjLdXsyrUUhpgWQI7pos03JqZYzsWbkIGjr2QO6wfVMl3dzpmKxmaoT8ipdgLJgfWBLZTqx6wzS6GQl5J12uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714649162; c=relaxed/simple;
	bh=3OWxkBNAnenvh4JvV+yXOyokcoAi7gulvLZX7rk/yzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=aGUCJvox4tx6bOwddCCD/zqDrvub4kJq68Akr2oMoCLh4F+sj3/mU0DvrKeeMsXUgFRUsG1D+ZtlknqklZDAO7rR5WomKIy54K3p56g5ZdbHz2TyLzRSXZ0+0DrepToKitWYvtcoFXx3dNBW3fNwD5dv4Ry/YRofSnx61jH+kDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ExESGjMl; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240502112556epoutp02d3cf241ca30888075b3237714a10a2e4~LqFLYdSbO2988729887epoutp02O
	for <linux-block@vger.kernel.org>; Thu,  2 May 2024 11:25:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240502112556epoutp02d3cf241ca30888075b3237714a10a2e4~LqFLYdSbO2988729887epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714649156;
	bh=oSADBcr3ZJPU2BiG7UocfooJCyekOwTiO/XAqarOqSQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ExESGjMlfLkNjK1GK8l+hXyzti54+qNHOMiaHISc4iMIWMAcFHeEWujta0yrZ+USM
	 4zlRZKtUkNuourIrqO+3x2u3baLGMEIOjD7kfCawwPOBCQHjYHzJmx6mQ8rbVycj8p
	 aK+3/DKEWE0UgU52zP00nHUoDdAMYl+r2Ivheqqc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240502112556epcas5p1b7871898654050e3cc99852f0fe9a2d8~LqFKtiJW90047900479epcas5p12;
	Thu,  2 May 2024 11:25:56 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VVWpB3Bdwz4x9Pq; Thu,  2 May
	2024 11:25:54 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D6.4A.08600.24873366; Thu,  2 May 2024 20:25:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240502112553epcas5p1977bc184e01532a293b3344ee1605304~LqFIiy8En2963429634epcas5p12;
	Thu,  2 May 2024 11:25:53 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240502112553epsmtrp1d8cbce23669a2333f8769c36f1e64b50~LqFIiJiaL3006230062epsmtrp1j;
	Thu,  2 May 2024 11:25:53 +0000 (GMT)
X-AuditID: b6c32a44-6c3ff70000002198-aa-6633784267fb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	65.05.08390.14873366; Thu,  2 May 2024 20:25:53 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240502112552epsmtip2b44fc74b66895cf30a9214df11040b88~LqFHM8EBj1167711677epsmtip22;
	Thu,  2 May 2024 11:25:52 +0000 (GMT)
Message-ID: <cf433030-2cab-9301-7c8e-adef13efba66@samsung.com>
Date: Thu, 2 May 2024 16:55:51 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH] block: change rq_integrity_vec to respect the iterator
Content-Language: en-US
To: Mikulas Patocka <mpatocka@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <19d1b52a-f43e-5b41-ff1d-5257c7b3492@redhat.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmpq5ThXGawZ3Dohar7/azWSxYNJfF
	YtKha4wWe29pW8xf9pTdYmLHVSaLE7ekHdg9Lp8t9di0qpPNY/OSeo8Xm2cyerzfd5XN4/Mm
	uQC2qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKA7
	lBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYGRqZA
	hQnZGdOW3WIqmMtW0TL/JWMD43+WLkZODgkBE4ljc18ydzFycQgJ7GaUOPLhBBtIQkjgE6PE
	3omZEIlvjBJP3s+B62id/5gFIrGXUWLR1U1MEM5bRomW1TOZQKp4BewkLl5azgxiswioSCw7
	cI8FIi4ocXLmEzBbVCBZ4mfXAbB1wgLeEqeOrwGLMwuIS9x6Mh9sqIhAL6PEut5vrBCJaIkD
	b64BJTg42AQ0JS5MLgUJcwrYSqz/c40RokReYvvbOWD/SAh0ckhc3bCRGeJsF4nVxw4wQtjC
	Eq+Ob2GHsKUkXva3QdnJEpdmnmOCsEskHu85CGXbS7Se6mcG2csMtHf9Ln2IXXwSvb+fgJ0j
	IcAr0dEmBFGtKHFv0lNWCFtc4uGMJVC2h8TRD9fZIWE1gVFi6oLbrBMYFWYhBcssJO/PQvLO
	LITNCxhZVjFKphYU56anJpsWGOallsMjPDk/dxMjOJlquexgvDH/n94hRiYOxkOMEhzMSiK8
	UxbqpwnxpiRWVqUW5ccXleakFh9iNAXGz0RmKdHkfGA6zyuJNzSxNDAxMzMzsTQ2M1QS533d
	OjdFSCA9sSQ1OzW1ILUIpo+Jg1Oqgel4nf+KtirFyM+npVO2Vc3hMlzfrvgjzVfuqCXT8YO5
	Xkzyud9r+1P21D+atObmyod/Ixls37Ul+Aj4lln/O1/Kn/B9uWh2tG7imdubeHmzLyistLTZ
	aHrP1nJDtdo61qZZeZOUWVY5yk99LlDWwFWU9NrV6MDvYzprE+3UXEM3/q7YN/NNrGfcMZfy
	4oyEjSX59w936q3xydK1mT+L5dvhnw8iVVzkDqXfWLDT+Nr3m7Iz3ifND1Kvrd59Yc6C7XX7
	GmJCfiesEwmU23Tp/ZLpPkdTpe7vb9uZw3Zpb9391Fr73bd/vszteMH0vbREc0vRlLouMUOp
	E16LNnY6VU1x3PptWVN5o+rR90tqk5VYijMSDbWYi4oTAW7wMFovBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSvK5jhXGawbvp+har7/azWSxYNJfF
	YtKha4wWe29pW8xf9pTdYmLHVSaLE7ekHdg9Lp8t9di0qpPNY/OSeo8Xm2cyerzfd5XN4/Mm
	uQC2KC6blNSczLLUIn27BK6MactuMRXMZatomf+SsYHxP0sXIyeHhICJROv8x0A2F4eQwG5G
	iWfnZjFDJMQlmq/9YIewhSVW/nvODlH0mlHi6/wmRpAEr4CdxMVLy8EaWARUJJYduMcCEReU
	ODnzCZgtKpAs8fLPRLBBwgLeEqeOrwGLMwMtuPVkPhPIUBGBXkaJJe+Xs0EkoiWOH3nEDLFt
	AqPEosYVQNs4ONgENCUuTC4FqeEUsJVY/+caI0S9mUTX1i4oW15i+9s5zBMYhWYhuWMWkn2z
	kLTMQtKygJFlFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcOxoae1g3LPqg94hRiYO
	xkOMEhzMSiK8UxbqpwnxpiRWVqUW5ccXleakFh9ilOZgURLn/fa6N0VIID2xJDU7NbUgtQgm
	y8TBKdXA1JN/7a+6ddnfuUrb6mfJGbT+uJg8N3mN4bkK1SmpqVPsMo0btooJzdApOX4vuXyd
	2KoWFzPTRW//S34WFw9lay3nT7nl+edZArumXaJpZ/SZmdEG535G6L4uStmhfoORv2Cz7KHb
	f8/P/HLA/3FW83d52ful3ikl5wTDuFjfl0uUmkpNXRpqlin7mFelmKPYqEiQ02stp3gsx9Hr
	Tov/brzhHRvR2fbVMLEq+6fjknOCTK4Lrjmr/HhRWCG88kB39sMvb+8dOjKjX6rhrqWI39mt
	fxn3zt762jPo4dmN6XmPt6rGuE9QNbOJ+9g5d29i2IYN89ilk+zKTKq1P9SVv5x317d0+3WB
	4A1Kl5KVWIozEg21mIuKEwEn6qQhDAMAAA==
X-CMS-MailID: 20240502112553epcas5p1977bc184e01532a293b3344ee1605304
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240429183739epcas5p1181a2946641784305b188f320033c637
References: <CGME20240429183739epcas5p1181a2946641784305b188f320033c637@epcas5p1.samsung.com>
	<19d1b52a-f43e-5b41-ff1d-5257c7b3492@redhat.com>

Hi Mikulas

On 4/30/2024 12:07 AM, Mikulas Patocka wrote:
> Hi
> 
> I am changing dm-crypt, so that it can store the autenticated encryption
> tag directly into the NVMe metadata (without using dm-integrity). This
> will improve performance significantly, because we can avoid journaling
> done by dm-integrity. I've got it working, but I've found this bug, so I'm
> sending a patch for it.

As noted by others, there are couple of options to have this settled:

- I can borrow stuff from your commit description to patch #5 [1] and 
send that out separately
- Or you can add the changes that Anuj pointed and roll out v2
- Or you can take the route suggested by Christoph

Please choose.

[1] 
https://lore.kernel.org/linux-nvme/20240425183943.6319-6-joshi.k@samsung.com/


