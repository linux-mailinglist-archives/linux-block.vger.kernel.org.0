Return-Path: <linux-block+bounces-10349-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F202948EE4
	for <lists+linux-block@lfdr.de>; Tue,  6 Aug 2024 14:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A12EB28377
	for <lists+linux-block@lfdr.de>; Tue,  6 Aug 2024 12:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21131C9DF1;
	Tue,  6 Aug 2024 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Zu5iJCOo"
X-Original-To: linux-block@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64821C9DFF
	for <linux-block@vger.kernel.org>; Tue,  6 Aug 2024 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722946362; cv=none; b=K2MlIgxUukMWSAfEzCrPqd/1yiZ/nkxtuBDRYDUg/iMD4oezdVpTL5lCBBSY6F07RB/2uMD3giVIhH+mlo2+merJR3cYZPMSpyNqvyKwpm8SkwOhnLKuSFMXGmWEXMsTW5ePELTglIG6se1p7kvW6ue0sNzSkyeZ+SYhTyvCPgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722946362; c=relaxed/simple;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=XIFlEL867uhRLiHhAw+mXD3fnCsmd1JGPeGnLXjDH6cJAVl0M4ImZtxLFJ7xW3Tpr8nmHU3nutIUmov1kQ21FCPgNks4W77aw9m0Vt1H9MCqTE6LGugit91rQAP+u0/esbcGlQFppRIDDby225f1qYlqqOPdwRDSDCBBfWE3hhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Zu5iJCOo; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240806121238epoutp030f8d4e89033c6c555908b9a831996fb7~pIpW4ztVu2344423444epoutp03P
	for <linux-block@vger.kernel.org>; Tue,  6 Aug 2024 12:12:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240806121238epoutp030f8d4e89033c6c555908b9a831996fb7~pIpW4ztVu2344423444epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722946358;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Zu5iJCOofF57uMsiMZHHyv2Upwxma0l/Lftxuk8eDRZqUqiGXzgUEaS/bMRzfWU4D
	 W3qRa3WiTUW9uHgSVNgT+565Hit+SB34R1QZjez4dmZHMMAUdyyuH/oJ3zVaRy3NL7
	 IiDbAmXr6vJDutjwM6FaUMFABtwFxscfxlv72sk4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240806121238epcas5p101c691ad6ae30057620a8ca02c109713~pIpWu1cgP2663726637epcas5p1j;
	Tue,  6 Aug 2024 12:12:38 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WdXHn4nbtz4x9Pp; Tue,  6 Aug
	2024 12:12:37 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	31.E5.08855.53312B66; Tue,  6 Aug 2024 21:12:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240806121237epcas5p197db97c5df4b111a3a1a2ee1e2d0b200~pIpVZ7fQP1546115461epcas5p1x;
	Tue,  6 Aug 2024 12:12:37 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240806121237epsmtrp12820d862db5b77ca247cd462861b84c7~pIpVZTZ1U0258802588epsmtrp1n;
	Tue,  6 Aug 2024 12:12:37 +0000 (GMT)
X-AuditID: b6c32a44-15fb870000002297-c9-66b213350bc4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	45.EA.07567.53312B66; Tue,  6 Aug 2024 21:12:37 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240806121235epsmtip2e97b04a07d5f0df954c15df3e8e1ed6e~pIpUHaOnL1208512085epsmtip2z;
	Tue,  6 Aug 2024 12:12:35 +0000 (GMT)
Message-ID: <d6b35805-dbae-1b14-f295-4f99204592a2@samsung.com>
Date: Tue, 6 Aug 2024 17:42:34 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 1/2] scsi: sd: Don't check if a write for REQ_ATOMIC
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240805113315.1048591-2-john.g.garry@oracle.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTQ9dUeFOawa7VKhar7/azWWzs57C4
	8GsHo8XeW9oWl3fNYbPovr6DzWL58X9MDuwe0yadYvO4fLbU4+PTWywenzfJBbBEZdtkpCam
	pBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAK1XUihLzCkFCgUk
	Fhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRnnNqxlKnA
	qOLa3D6mBkbdLkZODgkBE4nfB1ayg9hCArsZJW6cMO1i5AKyPzFK7J31mQ3C+cYo8f7yZXaY
	ju7VbxkhEnsZJa6uO8wO4bxllPix9wwTSBWvgJ3Ey61/mEFsFgEViUubzjNCxAUlTs58wgJi
	iwokS/zsOsAGYgsLeEj0L2gAq2EWEJe49WQ+2BwRgTqJE6u7oOLREs82LAaKc3CwCWhKXJhc
	ChLmFLCX6Po8hQmiRF5i+9s5zCD3SAj8ZJeYOuMtG0i9hICLxJM+HYgHhCVeHd8C9YyUxMv+
	Nig7W+LBowcsEHaNxI7NfawQtr1Ew58brCBjmIHWrt+lD7GKT6L39xMmiOm8Eh1tQhDVihL3
	Jj2F6hSXeDhjCZTtIfH30ScWSEgdZ5T4teQ10wRGhVlIgTILyfOzkHwzC2HzAkaWVYySqQXF
	uempyaYFhnmp5fDITs7P3cQITplaLjsYb8z/p3eIkYmD8RCjBAezkghvV+mGNCHelMTKqtSi
	/Pii0pzU4kOMpsDYmcgsJZqcD0zaeSXxhiaWBiZmZmYmlsZmhkrivK9b56YICaQnlqRmp6YW
	pBbB9DFxcEo1MPlKV2S/1/jmuCfj+cxnapaF9zpmXPsf6xL3fPGd3RLVLOGJR+a6VYi8vPJO
	fK/YP5M+k4v7H/0Oatgnt/T6t0ptrbmpfU84NuzWsd7RYGvt2Zu4cNWSl1fTv83YGFn0eOKR
	K3PULK9sPLBy3alQ7ZdvVpXtv7VzdwQ/b/7k2kTfh0JTtYRmLeDkWd+auJft5xvn5+b2IiX9
	9284FqZuOLmAuU/s6bN9zYdnrTa7yO6s8e5t+uWLudNKuo1PpPvWb7z1ou/kj8U/zG8v55Gu
	TTDwvs8mwrk1bO/2KGkuqWcbT81cdu6gR1LnxZ1xPYIRV/lNk5J6SrbOlL6hls30R/rQro2v
	jBKskrVfPq/yvDRZiaU4I9FQi7moOBEAhRK2KyIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSvK6p8KY0gyNvuSxW3+1ns9jYz2Fx
	4dcORou9t7QtLu+aw2bRfX0Hm8Xy4/+YHNg9pk06xeZx+Wypx8ent1g8Pm+SC2CJ4rJJSc3J
	LEst0rdL4Mo4tWMpU4FRxbW5fUwNjLpdjJwcEgImEt2r3zJ2MXJxCAnsZpTY/2sWM0RCXKL5
	2g92CFtYYuW/5+wQRa8ZJf5sawIr4hWwk3i59Q+YzSKgInFp03lGiLigxMmZT1hAbFGBZImX
	fyaCDRIW8JDoX9AAVsMMtODWk/lMILaIQJ3E3wlLgeZwAMWjJT5tiIfYdZxRYurb4ywgcTYB
	TYkLk0tByjkF7CW6Pk9hghhjJtG1tQtqpLzE9rdzmCcwCs1CcsUsJNtmIWmZhaRlASPLKkbJ
	1ILi3PTcZMMCw7zUcr3ixNzi0rx0veT83E2M4AjR0tjBeG/+P71DjEwcjIcYJTiYlUR4u0o3
	pAnxpiRWVqUW5ccXleakFh9ilOZgURLnNZwxO0VIID2xJDU7NbUgtQgmy8TBKdXApHeq7c/D
	1Z3B2Rk7tl7ZPmUnp90f0S+vefZFs/jE8zbvOc4WyLgxR/eGp36m7qGgyEMBnLu+l/24s+z8
	qyke+6LFUqZ8MT20esPxQHUOLzk5fV9OVYfmg8+8szKzbnivfPBoTeNfnaoZP1J/XeW353nh
	V3X7wz0tRo/V09dvD5rd+mSLYxuDfkPG/x2OTxbEMFu+nKEoEcJ45Ouae55lgTrNHx7/Fwpr
	THrMEvZh7WX+jJcfnnWVr0zKWbVGYlG5l8LFnQt/WFalX5OZU3vncr33vs2y+WyB71WFpkX9
	1tNlN7ol47REQ3H9F2X5mnNHVO7kP/97f3GPT4RdQA+fzTGxmadMjKc/dtdt3qnzUomlOCPR
	UIu5qDgRALpkES//AgAA
X-CMS-MailID: 20240806121237epcas5p197db97c5df4b111a3a1a2ee1e2d0b200
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240805113402epcas5p39206892b600bfa2dbd927b0a5b0f6b7e
References: <20240805113315.1048591-1-john.g.garry@oracle.com>
	<CGME20240805113402epcas5p39206892b600bfa2dbd927b0a5b0f6b7e@epcas5p3.samsung.com>
	<20240805113315.1048591-2-john.g.garry@oracle.com>

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

