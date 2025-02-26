Return-Path: <linux-block+bounces-17701-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E186FA45AD6
	for <lists+linux-block@lfdr.de>; Wed, 26 Feb 2025 10:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27121692A0
	for <lists+linux-block@lfdr.de>; Wed, 26 Feb 2025 09:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CFC26E633;
	Wed, 26 Feb 2025 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E+Jan8SC"
X-Original-To: linux-block@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAFA2459E0
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563602; cv=none; b=q9Yd7i4bUXvO5fIhbo9Swzr4m71M8TxHUbbl4QkCBZiI5YbHovSPXxT/jrHSeoRVneflT48N3hIaM5uh+4gSYVSzPry6DDRNLIPWZroSlnNotpPcKv/B9VsjHUEze+iof+l5Sx12HUE1jrHEyjxu4HWYmZ0qZiI64Q8OylfDQM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563602; c=relaxed/simple;
	bh=B8wxZcnCCEDroaQcsE3lsq746/Ba2NysP5sa1hgyYgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=rmwb7zRpAiMAeTq799SJnDJhhHwxw/XJ2HCj1a7VghJA/+XyvrKwbqgAyZLptBwC5WzwSFV5Vq7dKefARtQnN4qGY+5QSYIbZm0OsvNp0CnUjZZCEZvWVWC2lTQSvfx71NzboPpEqhkZ9BLw4H+yLVZH0pU3eetzrSlnl/NCAkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=E+Jan8SC; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250226095317epoutp04c6b9a933254422f6d445f224be0be23f~nuV6q9Hez1396613966epoutp04C
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 09:53:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250226095317epoutp04c6b9a933254422f6d445f224be0be23f~nuV6q9Hez1396613966epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740563597;
	bh=B8wxZcnCCEDroaQcsE3lsq746/Ba2NysP5sa1hgyYgM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=E+Jan8SCUAlvJBlPZZabV+Go4YvWz6wAKMPFUPrZhcW2a5hqXbkwoI8bbMy9O7ePn
	 2Co+vz0THe+UUuxy0Q4OSzLPPU35I/O8b3bB8WuUbXjpdN7nKTUTBjqIV6efGSti9t
	 gEupLrmPutQHY8OcmSZfTc+b1ytKub+0LC3YBMSA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250226095316epcas5p4be8b859f4c3462d5a74067e6a5613a49~nuV6R0fw91661416614epcas5p4O;
	Wed, 26 Feb 2025 09:53:16 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Z2qXp75hmz4x9Pp; Wed, 26 Feb
	2025 09:53:14 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0C.92.29212.A84EEB76; Wed, 26 Feb 2025 18:53:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250226095314epcas5p2b43c3651fa03ce7abfd65a1aa022b544~nuV4G0kGN1405814058epcas5p2F;
	Wed, 26 Feb 2025 09:53:14 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250226095314epsmtrp209ac66cd585af21b2d42d64b4180df26~nuV4FpsDv1836818368epsmtrp2s;
	Wed, 26 Feb 2025 09:53:14 +0000 (GMT)
X-AuditID: b6c32a50-7ebff7000000721c-c5-67bee48a4a65
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0D.92.23488.A84EEB76; Wed, 26 Feb 2025 18:53:14 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250226095312epsmtip2f97d947ce49eada1562a0e3fcaab0197~nuV2bHJPM1916819168epsmtip2f;
	Wed, 26 Feb 2025 09:53:12 +0000 (GMT)
Message-ID: <5ac8aa8d-e1de-44e6-831f-c25f2d7791ab@samsung.com>
Date: Wed, 26 Feb 2025 15:23:11 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] block: split struct bio_integrity_payload
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, Song Liu <song@kernel.org>, Yu Kuai
	<yukuai3@huawei.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, target-devel@vger.kernel.org, Hannes Reinecke
	<hare@suse.de>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250225154449.422989-4-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmum7Xk33pBptmmVqsvtvPZrFg0VwW
	iz2LJjFZrFx9lMli7y1ti/b5uxgtlh//x2QxseMqk8WJW9IWx5f/ZbNoXfqWyWLOQjYHHo+W
	I29ZPS6fLfXYtKqTzePF5pmMHrtvNrB5fHx6i8Xj/b6rbB6bT1d7fN4kF8AZlW2TkZqYklqk
	kJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SukkJZYk4pUCggsbhY
	Sd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE7Y++vNqaCRpaK
	7ZPuMzUwrmPuYuTkkBAwkVg47RsjiC0ksIdRomeyaBcjF5D9iVHi0bJv7BDON0aJTxPWwHVs
	n7aTCSKxl1Hi87TNjBDOW0aJBe+a2UCqeAXsJG6cnAvWwSKgKvF+1yJmiLigxMmZT1hAbFEB
	eYn7t2YAreDgEBZwklg6uwIkLCLgIDF7w1I2kJnMAleYJKZ8WgQ2k1lAXOLWk/lMIPVsApoS
	FyaXgoQ5BQwlZmxdwAxRIi+x/e0cZpBeCYEzHBJHvlxjgrjaReLm2l/sELawxKvjW6BsKYnP
	7/ayQdjZEg8ePWCBsGskdmzuY4Ww7SUa/txgBdnLDLR3/S59iF18Er2/n4CdIyHAK9HRJgRR
	rShxb9JTqE5xiYczlkDZHhKXnvyHBtVqRolJv/6xTmBUmIUUKrOQfDkLyTuzEDYvYGRZxSiV
	WlCcm56abFpgqJuXWg6P8OT83E2M4NSsFbCDcfWGv3qHGJk4GA8xSnAwK4nwcmbuSRfiTUms
	rEotyo8vKs1JLT7EaAqMn4nMUqLJ+cDskFcSb2hiaWBiZmZmYmlsZqgkztu8syVdSCA9sSQ1
	OzW1ILUIpo+Jg1OqgUklj9/GmGn99kf7Vc/dL7yxY1H88piqOc+WCS2dn3PI4mXqFL2jvTov
	b3tfZdp6aCkj162XfGKiLyx6X7O/mzbj9MdNLWstku7NFs87VFYgzLeC7cCxDOFNwR73pnIc
	CJxbasJSVfrs08SLpR7e3ItkWjd3nfp/ssNOdAfv4ZwD9SFSf7fsYfsvV+bIFdK3RVZrm9W3
	vqNrHA+e0jA05DfsEfHdfGZ76qWkDe/vB/QF8HU0cKv3WErkHb/LO9O8s3z2HFbes6l1Cn0p
	in//7Ciqzrv+4uxTb5tgF9f9Nvxhbxxi+OaUW2/eVLKbb/VxL/nqXb3vYnwXHHNaXMxVo1Pf
	/LfeukFBZf1213oxISWW4oxEQy3mouJEAKUB9PhWBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWy7bCSvG7Xk33pBou7JCxW3+1ns1iwaC6L
	xZ5Fk5gsVq4+ymSx95a2Rfv8XYwWy4//Y7KY2HGVyeLELWmL48v/slm0Ln3LZDFnIZsDj0fL
	kbesHpfPlnpsWtXJ5vFi80xGj903G9g8Pj69xeLxft9VNo/Np6s9Pm+SC+CM4rJJSc3JLEst
	0rdL4MrY+6uNqaCRpWL7pPtMDYzrmLsYOTkkBEwktk/bydTFyMUhJLCbUWLKkyNMEAlxieZr
	P9ghbGGJlf+es0MUvWaUePTpNRtIglfATuLGyblgk1gEVCXe71rEDBEXlDg58wkLiC0qIC9x
	/9YMoGYODmEBJ4mlsytAwiICDhKzNyxlA5nJLHCFSeJz100WiAWrGSWO/TnKCFLFDHTFrSfz
	mUCa2QQ0JS5MLgUJcwoYSszYuoAZosRMomtrF1S5vMT2t3OYJzAKzUJyxiwkk2YhaZmFpGUB
	I8sqRsnUguLc9NxkwwLDvNRyveLE3OLSvHS95PzcTYzgONTS2MH47luT/iFGJg7GQ4wSHMxK
	IrycmXvShXhTEiurUovy44tKc1KLDzFKc7AoifOuNIxIFxJITyxJzU5NLUgtgskycXBKNTA5
	d0aufLEobK+iaMKzvSxMTTfULj3qdPp6PvqEfganVcfUgkbXkwtY8m6+Elbw3lwkuT83ZVdl
	yAUP03drLrxSF9R1LD/fcnRTXK6XTsJJFdaupfo9jz6ovg5O3T5ne+x5yWnMeX2LrDJ3il95
	u2DNgXtKpk2vMqyqpyx680pbvdjzTWGI82mL2TU719+YsDlv1+/zEpOvuD6/llYi9Emq/cyf
	1ZdWMZZ2f5/Od+R0Qf6LKde46j7OX7tAQEZq9t+Vt/Ucy39N9Phb+PdF45x1UYnltbnz2Dkj
	NZia3p///ftd0M+1Nel1gY1esS2PjN9t7tc68Mw90emu5NFWr4iXmscW7ph2JKwyl4+z5nqU
	EktxRqKhFnNRcSIAvEktFjIDAAA=
X-CMS-MailID: 20250226095314epcas5p2b43c3651fa03ce7abfd65a1aa022b544
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250225154543epcas5p3c8c901d6069ea33bef42c2d2e78cf53c
References: <20250225154449.422989-1-hch@lst.de>
	<CGME20250225154543epcas5p3c8c901d6069ea33bef42c2d2e78cf53c@epcas5p3.samsung.com>
	<20250225154449.422989-4-hch@lst.de>

On 2/25/2025 9:14 PM, Christoph Hellwig wrote:
> Reduce struct bio_integrity_payload to the minimal structure needed in
> common code and create two separate containing structures for the
> automatically generated payload and the caller allocated payload.
> The latter is a simple wrapper for struct bio_integrity_payload and
> the bvecs, while the former contains the additional fields moved out
> of strut bio_integrity_payload.

nit: s/strut/struct

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

