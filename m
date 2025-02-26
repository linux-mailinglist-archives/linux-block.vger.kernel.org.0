Return-Path: <linux-block+bounces-17703-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB5BA45B22
	for <lists+linux-block@lfdr.de>; Wed, 26 Feb 2025 11:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23043A7811
	for <lists+linux-block@lfdr.de>; Wed, 26 Feb 2025 10:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D2C238165;
	Wed, 26 Feb 2025 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IZDauMX0"
X-Original-To: linux-block@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2D122422D
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564281; cv=none; b=E5uFqkLupiQ8JA3H7nOrwMel0xwqIPlA7JSdze/0Agh+F6I+24B/X/h4GdjCfYTVr/s313O6itdBLongI5t9QOB5K69X2uBDGwGyIaKlZi9q3rq7K10KZDXx7QdVFS1Zq2QKmwd0NsYdnnRriDEKfWaIgJgKXJnEX8KktrIp1S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564281; c=relaxed/simple;
	bh=bHQ71mYTnYWYXnkC1BY4+6zLreszQsia4nWpThSltqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=dht53SencfgPxnEMTOq+uraXT5mHSaWpGVWvtIuPtn9HeD+UX+rUqG08DXVHPmpOh2EsO3vnXzSA5B+WJaRDxHuDAHsudrAYVmp+IWLnBzBYKquJi3fMU77pf/T3gqrB/+DMiR1NvbRqr+us6R5R0SF/fa/3cDbkzAXyG7EluTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IZDauMX0; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250226100436epoutp03c69006ce764aec5856637dd38c4749c6~nufzDkVMa2590325903epoutp03V
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 10:04:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250226100436epoutp03c69006ce764aec5856637dd38c4749c6~nufzDkVMa2590325903epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740564276;
	bh=INj5W51zgh1FIxocWoik6Y15c8y+Fy7shvMFa5Qemw0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=IZDauMX0DwFIbRvUdQweWb68N74fUkKzpkZvEXx0EUluSpro5OIWevOz55KRE7SYf
	 OVSoMfWui2wcbV4ZIojTpOUp4wGz765ZXOfoZwTxNjhX0hJcbaBjv4/ak/9fG9EBxb
	 46BiCY+UzS7PWgXMwlrlT6iC6BHaV8tKnOy2qnA0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250226100435epcas5p2b87b32e3caf5fb2f057b44ae875e3f61~nufynMmk71511515115epcas5p2J;
	Wed, 26 Feb 2025 10:04:35 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Z2qnt2vdGz4x9Q0; Wed, 26 Feb
	2025 10:04:34 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6F.84.29212.237EEB76; Wed, 26 Feb 2025 19:04:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250226100433epcas5p4d9815f65617e7214590034f4370cc48d~nufwaATgT2118021180epcas5p4O;
	Wed, 26 Feb 2025 10:04:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250226100433epsmtrp1d7ca71fd2cdfc610f3338e7398b6064c~nufwZb37u0671506715epsmtrp1y;
	Wed, 26 Feb 2025 10:04:33 +0000 (GMT)
X-AuditID: b6c32a50-7ebff7000000721c-9d-67bee73244fb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	06.B4.18729.137EEB76; Wed, 26 Feb 2025 19:04:33 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250226100432epsmtip2a5f0a5fbde450c5ef51bf84cbd3fa1b2~nufvdaStM2651726517epsmtip2e;
	Wed, 26 Feb 2025 10:04:32 +0000 (GMT)
Message-ID: <aa29b282-6e04-409d-bfe5-bf8e3ac3499d@samsung.com>
Date: Wed, 26 Feb 2025 15:34:31 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: sysfs integrity fields use
To: Milan Broz <gmazyland@gmail.com>, linux-block
	<linux-block@vger.kernel.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, Christoph Hellwig
	<hch@infradead.org>, "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <ba3840dd-e3a7-4896-89c9-0f131bb46fa5@gmail.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTU9fo+b50g/fXBC0WLJrLYnFs/yx2
	i9MTFjFZ7L2lbbH8+D8mB1aPnbPusntsXqHl8WLzTEaPj09vsXh83iQXwBqVbZORmpiSWqSQ
	mpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtFpJoSwxpxQoFJBYXKyk
	b2dTlF9akqqQkV9cYquUWpCSU2BSoFecmFtcmpeul5daYmVoYGBkClSYkJ3xYecFtoLPrBXd
	rT+YGhjPsHQxcnJICJhITLu+hLmLkYtDSGAPo8S8t4fYQBJCAp8YJb6/sodIfGOUOLp/NjNM
	x8wHzewQib2MEjtWz4Zy3jJK3H77jamLkYODV8BO4sdnMZAGFgFVicO7P4JN5RUQlDg58wnY
	alEBeYn7t2awg9jCAuoSD7Y+YASxRQQCJRp33gGbySwwlVFiyfcjTCAJZgFxiVtP5oPNZxPQ
	lLgwuRQkzClgK3HlwHaoEnmJ5q2zwd6REPjLLnH9ymVWiKtdJGZ+WQ/1s7DEq+Nb2CFsKYmX
	/W1QdrbEg0cPoGpqJHZs7oPqtZdo+HODFWQvM9De9bv0IXbxSfT+fgJ2joQAr0RHmxBEtaLE
	vUlPoTrFJR7OWAJle0hcP3OaCRK4Pxglfi+QncCoMAspVGYheXIWkm9mISxewMiyilEqtaA4
	Nz012bTAUDcvtRwe38n5uZsYwQlTK2AH4+oNf/UOMTJxMB5ilOBgVhLh5czcky7Em5JYWZVa
	lB9fVJqTWnyI0RQYPxOZpUST84EpO68k3tDE0sDEzMzMxNLYzFBJnLd5Z0u6kEB6Yklqdmpq
	QWoRTB8TB6dUA1OTV9nmkh3GTMm/kx/9Sitdn74kSO3yN7fFAhN2cK1duGy+8briVSYLlbSX
	8Gz2/DL1zrRX+a6Owm9r+qdPNExNerHwtdrzZcvTew88WvT4Ys3JJdEFc8o0m7dNVlTqu+n1
	oPbafW/LFOWF5ZO8DkdOq9E81RBvs3/Z3EM/o6dYB1zfFFoVxe45q/S08oI34oa+LCJuLqdk
	He5FPq39d8NSLfvY2ZYffPs7lifksdsolCWwhee/XnJHkltDZktoTMLcbVsUPu8Sez1Bf4+e
	koOWL0P8ph7JfedFF5U6eMQvd6mXi5whd5ZVY7eBduXjXSYPb4qulLB2upC27nCqwfrIHUZz
	pJgc+ip217Xc2KrEUpyRaKjFXFScCADRglv+IQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSvK7h833pBm+bxSwWLJrLYnFs/yx2
	i9MTFjFZ7L2lbbH8+D8mB1aPnbPusntsXqHl8WLzTEaPj09vsXh83iQXwBrFZZOSmpNZllqk
	b5fAlfFh5wW2gs+sFd2tP5gaGM+wdDFyckgImEjMfNDM3sXIxSEksJtRomPJO6iEuETztR/s
	ELawxMp/z6GKXjNK3LnUytjFyMHBK2An8eOzGEgNi4CqxOHdH9lAbF4BQYmTM5+AzREVkJe4
	f2sG2BxhAXWJB1sfMILYIgKBEv/mzgebySwwnVFi/7VVbBALfjBKzJ5zGayKGeiKW0/mM4Es
	YxPQlLgwuRQkzClgK3HlwHYmiBIzia6tXVDl8hLNW2czT2AUmoXkjllIJs1C0jILScsCRpZV
	jJKpBcW56bnFhgWGeanlesWJucWleel6yfm5mxjB8aGluYNx+6oPeocYmTgYDzFKcDArifBy
	Zu5JF+JNSaysSi3Kjy8qzUktPsQozcGiJM4r/qI3RUggPbEkNTs1tSC1CCbLxMEp1cDk/LeY
	V+CP5pn+N0fqrrWtnPHQQrPyvEPp0oO2VyN22Zevz6lxaHtwir9gyoNmRu3awHuREjK95jlG
	ijcZbqwQLbissX5BTJzOHa/9nK7pPOfu3Vjan5A/V0ZWZ7PbM93Km5ycZnc5e/tYb7rFnXj4
	f8aMpRY8Nu26tld5ZA+UFN0pP3Ny+SOPZuENUxh+3bE7Vq50993Rs04f1PfXLF65+XNThWj4
	kgMG27/xfpqjyjNVx5h3wWYPuWuXe03+n7xzNySofV+Ypaji2hmyKy/zCE9mqrC7xec1LYTj
	idDc211ZFbMOLJ+Vz3j4OV/grqvvYqqrbD5qv++e/+YU00++6/MnyW3R33ViW9XV4C0iSizF
	GYmGWsxFxYkA/To+D/4CAAA=
X-CMS-MailID: 20250226100433epcas5p4d9815f65617e7214590034f4370cc48d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250225092525epcas5p31dd0a19ffdfb39f3f2ce4acd1c6da7ee
References: <CGME20250225092525epcas5p31dd0a19ffdfb39f3f2ce4acd1c6da7ee@epcas5p3.samsung.com>
	<67795955-93a4-405b-b0b7-e6b5d921f35e@gmail.com>
	<823d3261-671d-41cb-ab15-10a361c48bca@samsung.com>
	<ba3840dd-e3a7-4896-89c9-0f131bb46fa5@gmail.com>

On 2/25/2025 4:33 PM, Milan Broz wrote:
> Sure, it is formatted to 4k data + 64 bytes metadata profile:
> 
> # nvme id-ns -H /dev/nvme0n1
> ...
> 
> LBA Format  0 : Metadata Size: 0   bytes - Data Size: 512 bytes - 
> Relative Performance: 0 Best
> LBA Format  1 : Metadata Size: 8   bytes - Data Size: 512 bytes - 
> Relative Performance: 0 Best
> LBA Format  2 : Metadata Size: 0   bytes - Data Size: 4096 bytes - 
> Relative Performance: 0 Best
> LBA Format  3 : Metadata Size: 64  bytes - Data Size: 4096 bytes - 
> Relative Performance: 0 Best (in use)
> 
> formatted with
> # nvme format --lbaf=3 --force /dev/nvme0n1

Since you're not passing "--pi=[1-3]", it takes 0 as default, which 
means protection-info is off.

