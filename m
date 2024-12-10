Return-Path: <linux-block+bounces-15133-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB7F9EAA1D
	for <lists+linux-block@lfdr.de>; Tue, 10 Dec 2024 08:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E67E2834B3
	for <lists+linux-block@lfdr.de>; Tue, 10 Dec 2024 07:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C561D5CCF;
	Tue, 10 Dec 2024 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cIq6dr+I"
X-Original-To: linux-block@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ACB233123
	for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 07:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733817506; cv=none; b=tyuPi5fBpXXW1FsQrsaGDGH1GKUHa9Gtbz0jKXBtWXPPvcrb9pvgNYgrTmyk8ANwbQGtzMGDttWnygt2yIfUNiV73oEqItow5Pb/4oXAVSDc8WgyZrbd7r5FnOxbJZjONhyLapPzsc0Ibj5w25aHKjCsdPJhfZH0/JAOsMz+4II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733817506; c=relaxed/simple;
	bh=Io1dmVRWP7SKH3/f0/rglBYCl5Tr0Zgn2Zk4fLy1Ne4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=ItLnpYOOQ8am/ARGRYgB1oK5G5vm6BYoo9xKpQ4HztT4PfIdfnEPIKfwz3g+rCSFlg8fll5pUk8Pr5kiITEylLwOBTbeoty4wdNZpviAvDY/JeL1ASkZMtJx7PH0iRVYMVo9Uw3DVbevQwXrN/TGo079q0GTRO+1EpBIFXcz2ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cIq6dr+I; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241210075822epoutp01266455926164f96e5d3e672e3f3edd1d~PwdUxgqnP0461204612epoutp01g
	for <linux-block@vger.kernel.org>; Tue, 10 Dec 2024 07:58:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241210075822epoutp01266455926164f96e5d3e672e3f3edd1d~PwdUxgqnP0461204612epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733817503;
	bh=Io1dmVRWP7SKH3/f0/rglBYCl5Tr0Zgn2Zk4fLy1Ne4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cIq6dr+II2uWcjq5aISGlCxgvfhZNUnbebkjQjiFmo2aELTnBobuSHTDdzv9JLCNf
	 Y4oC+G3PnF669MfpEiB7YW3rjYN0KdLN5pV8zzTGXhCJFyznYg/NysegdBbAt2BoK8
	 cS9Ql2BRTIa6W9/kz+tG/SaJhQIrl81cf26yWN3o=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241210075822epcas5p22fa4b57d5c96923e971217a20018df5a~PwdUSioh72069920699epcas5p2_;
	Tue, 10 Dec 2024 07:58:22 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Y6rhD5dCnz4x9Q2; Tue, 10 Dec
	2024 07:58:20 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	84.23.29212.A94F7576; Tue, 10 Dec 2024 16:58:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20241210074213epcas5p22330d197c3e7058e9c2226f28fdb1475~PwPNkpvtR2558425584epcas5p2O;
	Tue, 10 Dec 2024 07:42:13 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241210074213epsmtrp1e300b5305edfb75406213617537015d1~PwPNj6CUU0312003120epsmtrp1Q;
	Tue, 10 Dec 2024 07:42:13 +0000 (GMT)
X-AuditID: b6c32a50-801fa7000000721c-5f-6757f49af1cb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F5.98.18949.5D0F7576; Tue, 10 Dec 2024 16:42:13 +0900 (KST)
Received: from ubuntu (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241210074211epsmtip290c7b0d6cc0bf48bb4d64e1074f40473~PwPLye_ld2843028430epsmtip2e;
	Tue, 10 Dec 2024 07:42:11 +0000 (GMT)
Date: Tue, 10 Dec 2024 13:04:17 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, sagi@grimberg.me, asml.silence@gmail.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv12 03/12] block: add a bi_write_stream field
Message-ID: <20241210073417.xz2tpzqhvhgkwjid@ubuntu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241206221801.790690-4-kbusch@meta.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmhu6sL+HpBot2qFk0TfjLbDFn1TZG
	i9V3+9ksVq4+ymTxrvUci8XR/2/ZLCYdusZocebqQhaLvbe0LfbsPcliMX/ZU3aLda/fszjw
	eOycdZfd4/y9jSwel8+Wemxa1cnmsXlJvcfumw1sHucuVnj0bVnF6PF5k1wAZ1S2TUZqYkpq
	kUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QvUoKZYk5pUChgMTi
	YiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IzPu94wFnSx
	VhydvomlgfEASxcjB4eEgInE5ifSXYxcHEICexgl9t/vYe9i5ARyPjFKfHoZC5H4xigx7+V+
	sARIw9vGCYwQib2MEs9+bGSB6HjCKDFxE1gRi4CqxOzZZ9hBNrAJaEuc/s8BEhYRUJQ4DwwH
	kF5mgYlMEr8PNYHVCws4SJyf+4kNxOYFWnDwTSMzhC0ocXLmE7D5nAJmEj0Le8CaJQRWckg0
	/jvGDHGRi8TctX8ZIWxhiVfHt0BdKiXxsr8Nyi6XWDllBVRzC6PErOuzoBrsJVpP9YMNYhbI
	kLhz/h4LRFxWYuqpdUwQcT6J3t9PmCDivBI75sHYyhJr1i9gg7AlJa59b4SyPSTu3d7GDAmi
	rYwS1ydfYp3AKDcLyUezkOyDsK0kOj80sc4ChhizgLTE8n8cEKamxPpd+gsYWVcxSqUWFOem
	pyabFhjq5qWWw2M5OT93EyM4DWsF7GBcveGv3iFGJg7GQ4wSHMxKIrwc3qHpQrwpiZVVqUX5
	8UWlOanFhxhNgVE0kVlKNDkfmAnySuINTSwNTMzMzEwsjc0MlcR5X7fOTRESSE8sSc1OTS1I
	LYLpY+LglGpg0imr22cUs3ta76rK4uW2K31XcOsZ5XyZ8U/+R9mexCrW0vXOim681UtPzghS
	DvU50v6bQ3nz52MPWM6pJM5i/LC4zKvkZImh4Nss0Tk1v+SrRSTEWm9xXtwZtG3OvxzH0zEJ
	0UbXzq23+PTN2slZqtaQe8Oc3Htmj7v/vXxucuvSlWVcm9bIRp06fC1ErqTvf870E3zOHUcy
	1wTsF5pW9SLrRIjo2mdZKf/jJCfudA/rcF57Nfg2z+aFSk+eirhf3OXheLlErmrt5Cn7vh3N
	nv340j8r76Vci3fv5jp4NLDh5rNrmyxvv56y6pOje/m68KzlxUc7L01wl5sezKtR3Lv/vX12
	qEa/nKjHk+tnqpVYijMSDbWYi4oTAcAIHdxMBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWy7bCSvO7VD+HpBkdWsVo0TfjLbDFn1TZG
	i9V3+9ksVq4+ymTxrvUci8XR/2/ZLCYdusZocebqQhaLvbe0LfbsPcliMX/ZU3aLda/fszjw
	eOycdZfd4/y9jSwel8+Wemxa1cnmsXlJvcfumw1sHucuVnj0bVnF6PF5k1wAZxSXTUpqTmZZ
	apG+XQJXxvx5L9gK9jBVPG3vYmpg7GHqYuTkkBAwkXjbOIERxBYS2M0ocaBBECIuKbHs7xFm
	CFtYYuW/5+xdjFxANY8YJXbPPwGWYBFQlZg9+wxQgoODTUBb4vR/DpCwiICixHmga0DqmQUm
	M0k8n3mMBSQhLOAgcX7uJzYQmxdo8cE3jcwQixMl9q2+xQgRF5Q4OfMJWD2zgJnEvM0PmUHm
	MwtISyz/BzafEyjcs7CHbQKjwCwkHbOQdMxC6FjAyLyKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0
	L10vOT93EyM4drS0djDuWfVB7xAjEwfjIUYJDmYlEV4O79B0Id6UxMqq1KL8+KLSnNTiQ4zS
	HCxK4rzfXvemCAmkJ5akZqemFqQWwWSZODilGph0j1jYt1ywXONg4ZTjd5D/ydwvU7UuHeWY
	sUsvj0t+rl94+urvOcp80xfMCav7crJZUK0le8/9mdIJTzvyGWb+zf+uV7l+3vEXx6zOFl7W
	tZTnauIwatbsufr61KUMwxy+xQX2gcVh6XPmG5zVm7D3wPHvc9OPzXTQPG/h+PR51yH+on9T
	Z8tKy6XUF53UbNJt1bw4QTwjgSvXaqVm+gbGrdPq9h39zJxlvn9m4w2pwuXFUvzvO+SKRDlU
	z9vNeMzZIVpwZXXq07U3qqYtT3p37WdVQfnGFxo3jn02SD3z22z+3aSrodVh+/jFjy3b8OZV
	rYzjB7HTqVP79tdvf/vfK+RA6IHXPiEHTfbn2BsosRRnJBpqMRcVJwIA3Zn+mgwDAAA=
X-CMS-MailID: 20241210074213epcas5p22330d197c3e7058e9c2226f28fdb1475
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----K2gkAqOuxZFCoC8EFRwgD_6KeXKZsv69xmv6PgBjcdVDR2et=_713ca_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241210074213epcas5p22330d197c3e7058e9c2226f28fdb1475
References: <20241206221801.790690-1-kbusch@meta.com>
	<20241206221801.790690-4-kbusch@meta.com>
	<CGME20241210074213epcas5p22330d197c3e7058e9c2226f28fdb1475@epcas5p2.samsung.com>

------K2gkAqOuxZFCoC8EFRwgD_6KeXKZsv69xmv6PgBjcdVDR2et=_713ca_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 06/12/24 02:17PM, Keith Busch wrote:
>From: Christoph Hellwig <hch@lst.de>
>
>Add the ability to pass a write stream for placement control in the bio.
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>
>Signed-off-by: Keith Busch <kbusch@kernel.org>
>---
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------K2gkAqOuxZFCoC8EFRwgD_6KeXKZsv69xmv6PgBjcdVDR2et=_713ca_
Content-Type: text/plain; charset="utf-8"


------K2gkAqOuxZFCoC8EFRwgD_6KeXKZsv69xmv6PgBjcdVDR2et=_713ca_--

