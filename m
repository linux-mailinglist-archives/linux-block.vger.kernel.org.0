Return-Path: <linux-block+bounces-10819-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5F195CAD3
	for <lists+linux-block@lfdr.de>; Fri, 23 Aug 2024 12:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1011F23E0A
	for <lists+linux-block@lfdr.de>; Fri, 23 Aug 2024 10:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B02E18732C;
	Fri, 23 Aug 2024 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EO/QF1wU"
X-Original-To: linux-block@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735DF1862B2
	for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724410109; cv=none; b=GFyg6JTvA4zNgeT85fj7VwvdazNkExnQDiBrY3V5kkrKTEB55t6UQ4LsFo2liUGIzuWhqQYO3UbHSeg57J1Z2+PC3KBhB/55OC6ZHOokp19rzVIo4qa151dUxbE3LHhHGduwaxaalsQXtGbVbpzt0DlzLCKFk6YNCgYG0OAiL/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724410109; c=relaxed/simple;
	bh=Q7UzLGf8MKdCLyKP3dqKL//JTDm9JhtgAu8TQCvTKUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=O116omAHo2YcXWS88UXxR0EbipX3YErAu/WQu6Rx/YurNTACISM5jZNb42mUGCx5mbMmLc9ex3i1UaS1CW9ofpOtuyTQIcaJ9J2hxtkmZP5DPmP/Fid/0q8jP1TuvRvhiJp3ocOItLSFocuJwfA+jO3F2M+Q7Jc0pyVWqiIStT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EO/QF1wU; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240823104825epoutp016e64fcac7e777431d8ab954dc8e12f82~uVdrb2gI90208302083epoutp01a
	for <linux-block@vger.kernel.org>; Fri, 23 Aug 2024 10:48:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240823104825epoutp016e64fcac7e777431d8ab954dc8e12f82~uVdrb2gI90208302083epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724410105;
	bh=dHflLZxFjxBERw9P6UhrJ3VAQJqBtBlBCjawxtTo9Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EO/QF1wUbe3umRcH6D9vxbbBpds0lw041Uy/4QpzTwA37577rcMc8ZUDXsPIWT7qJ
	 SW5vBOmJT9IAg8baGgLDLpHTNp20FicX0rQNEclHPrUHN9uTdoXUip0eDSaNyGI2zI
	 auwSa3Pn1ak3uypEUSyiC8IIsSI8I1Qaju2Gj3dE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240823104825epcas5p2e2c56889cac00a48fd239e910c09a317~uVdq70haN1947219472epcas5p2F;
	Fri, 23 Aug 2024 10:48:25 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Wqxcl20Gcz4x9Pr; Fri, 23 Aug
	2024 10:48:23 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	59.8A.19863.7F868C66; Fri, 23 Aug 2024 19:48:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240823104624epcas5p40c1b0f3516100f69cbd31d45867cd289~uVb60yNDG1989019890epcas5p4R;
	Fri, 23 Aug 2024 10:46:24 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240823104624epsmtrp22e6120f2aec0add88e82ca28503226a9~uVb60Jd690122301223epsmtrp2J;
	Fri, 23 Aug 2024 10:46:24 +0000 (GMT)
X-AuditID: b6c32a50-c73ff70000004d97-0f-66c868f7ae1b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	08.50.19367.08868C66; Fri, 23 Aug 2024 19:46:24 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240823104622epsmtip28ea9f66138f2e61ca934e1bd02c34d4c~uVb4_dOD31442714427epsmtip2b;
	Fri, 23 Aug 2024 10:46:22 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, krisman@suse.de
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v3 05/10] block: define meta io descriptor
Date: Fri, 23 Aug 2024 16:08:05 +0530
Message-Id: <20240823103811.2421-6-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823103811.2421-1-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRmVeSWpSXmKPExsWy7bCmhu73jBNpBqs+8ljMWbWN0WL13X42
	i5sHdjJZrFx9lMniXes5Fouj/9+yWUw6dI3RYvuZpcwWe29pW8xf9pTdovv6DjaL5cf/MTnw
	eOycdZfd4/LZUo9NqzrZPDYvqffYfbOBzePj01ssHn1bVjF6bD5d7fF5k1wAZ1S2TUZqYkpq
	kUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QvUoKZYk5pUChgMTi
	YiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE7Iyjs2+zFHSy
	Vzw/u5O9gfEDaxcjJ4eEgInE5KM9TF2MXBxCAnsYJR5/62GFcD4xSpxeNIEdzvl0uxeu5djj
	XywQiZ2MElPn/4Zq+cwosf7zSxaQKjYBdYkjz1sZQWwRgUqJ57t+gHUwC2xhlGhet5gdJCEs
	YCXx6f9DMJtFQFVi25kfzCA2r4CFxMe5DcwQ6+QlZl76DlbDKWAp0TS7gQWiRlDi5MwnYDYz
	UE3z1tnMIAskBOZySHxoWcIE0ewisXn/N6i7hSVeHd/CDmFLSXx+t5cNwk6X+HH5KVR9gUTz
	sX2MELa9ROupfqChHEALNCXW79KHCMtKTD21jgliL59E7+8nUK28EjvmwdhKEu0r50DZEhJ7
	zzVA2R4Sz+acZYaEVg+jxLyed0wTGBVmIflnFpJ/ZiGsXsDIvIpRKrWgODc9Ndm0wFA3L7Uc
	HtHJ+bmbGMHJWCtgB+PqDX/1DjEycTAeYpTgYFYS4U26dzRNiDclsbIqtSg/vqg0J7X4EKMp
	MMQnMkuJJucD80FeSbyhiaWBiZmZmYmlsZmhkjjv69a5KUIC6YklqdmpqQWpRTB9TBycUg1M
	2gf2cFSe7t+++fuKlBUsBR57m8Tm77bOuD2/5MajZqEOPuPU9yuX3v4sycB+qniD8IcqC3ax
	pRoTRBNVt+b+FN14ktc9zKLz33uZ9Q2Lpk8NEvnKnbSApez9Eyv3udN55P0COTQ6tfc8s2qY
	vu9SoV+fmKWcwsU1K67OarzBfkfhvLXpRZmSPY+MWjkm6K/dWO3a7r7H41nY/74rRjmO91Nn
	bPy0v2Ji0uoJ4bdXrDxhvun5Gf37X+5fK+S+W6V16OGjCblFx/Z0ijYLyby7ply3g7FWMSOS
	q2LNMs/tZaafGcO6AxQN1jfP2D+hJvBS9us9DmunTDBXzZ/iLLXiLrfDJbsl17gu3Nlse9U1
	VYmlOCPRUIu5qDgRAOGXo0xPBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSvG5Dxok0g9Z9hhZzVm1jtFh9t5/N
	4uaBnUwWK1cfZbJ413qOxeLo/7dsFpMOXWO02H5mKbPF3lvaFvOXPWW36L6+g81i+fF/TA48
	Hjtn3WX3uHy21GPTqk42j81L6j1232xg8/j49BaLR9+WVYwem09Xe3zeJBfAGcVlk5Kak1mW
	WqRvl8CVcXT2bZaCTvaK52d3sjcwfmDtYuTkkBAwkTj2+BdLFyMXh5DAdkaJ1vaHLBAJCYlT
	L5cxQtjCEiv/PWeHKPrIKDHrUx8TSIJNQF3iyPNWRpCEiEAjo8SW5i9go5gFdjFKzN36jRmk
	SljASuLT/4fsIDaLgKrEtjM/wOK8AhYSH+c2MEOskJeYeek7WA2ngKVE0+wGsDOEgGqWLT/D
	CFEvKHFy5hOwODNQffPW2cwTGAVmIUnNQpJawMi0ilE0taA4Nz03ucBQrzgxt7g0L10vOT93
	EyM4SrSCdjAuW/9X7xAjEwfjIUYJDmYlEd6ke0fThHhTEiurUovy44tKc1KLDzFKc7AoifMq
	53SmCAmkJ5akZqemFqQWwWSZODilGpjqpC4nXjULMdz95LPOpAcfJFdsWPkvUtaOR4D77BLF
	djmWL4wLFL5ayoey1OjatDBNdKjer8696W/58ut1LImG7UvLqycEnPsWFLKGpem20RMZtpN3
	6ubpsPrWv0nP4QxR9MpSfq/gKe6fs/9K7v7X/2fyHqnZ1Nzyucpm+3bVQ+Gn1h3v4/x8Y8my
	KP8f340vuOSFiHclrTLQO71n17W/zs2PDW8ma1TV608PKmFwCFSsjTT7q+cTGHlmSYq4fivn
	0y1Z+o6miw62VZs0CZb98J81VerjzKs2M24dcK/WdDy5TPrPL7t9Yirdq10vaVk4SbjctJzn
	L1BfKmosaBY0Z51wtGMrK39PtqqcEktxRqKhFnNRcSIAvJ82tAEDAAA=
X-CMS-MailID: 20240823104624epcas5p40c1b0f3516100f69cbd31d45867cd289
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240823104624epcas5p40c1b0f3516100f69cbd31d45867cd289
References: <20240823103811.2421-1-anuj20.g@samsung.com>
	<CGME20240823104624epcas5p40c1b0f3516100f69cbd31d45867cd289@epcas5p4.samsung.com>

From: Kanchan Joshi <joshi.k@samsung.com>

Introduces a new 'uio_meta' structure that upper layer can
use to pass the meta/integrity information.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 include/linux/bio-integrity.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index 5313811dc1ce..a1a9031a5985 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -30,6 +30,15 @@ struct bio_integrity_payload {
 	struct bio_vec		bip_inline_vecs[];/* embedded bvec array */
 };
 
+/* flags for integrity meta */
+typedef __u16 __bitwise meta_flags_t;
+
+struct uio_meta {
+	meta_flags_t	flags;
+	u16		app_tag;
+	struct		iov_iter iter;
+};
+
 #define BIP_CLONE_FLAGS (BIP_MAPPED_INTEGRITY | BIP_CTRL_NOCHECK | \
 			 BIP_DISK_NOCHECK | BIP_IP_CHECKSUM)
 
-- 
2.25.1


