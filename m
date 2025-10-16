Return-Path: <linux-block+bounces-28599-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7972BE27CF
	for <lists+linux-block@lfdr.de>; Thu, 16 Oct 2025 11:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C25D54E8315
	for <lists+linux-block@lfdr.de>; Thu, 16 Oct 2025 09:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C9D2C326A;
	Thu, 16 Oct 2025 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O/wYBWsf"
X-Original-To: linux-block@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22510251793
	for <linux-block@vger.kernel.org>; Thu, 16 Oct 2025 09:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608081; cv=none; b=jRPYpIKrlMzD2S8FS6y2bF3osDpTAkpEV59OPhjvr7e5Vv3SA3ChxCTzyBBf/txa7EDCO+Er3EQrv5OanqywdhiN3d0ly9LN5pVVb0/K/sF2V/YHQSwtQeSQ7m9PReV2D9re0ZLRAFgZnG9CRBAoGCMnad2YXszyK+gl6U12bJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608081; c=relaxed/simple;
	bh=r5zW8p2/gtwEWnmFZIGgblAkeLsxf4w2Cx17U/3XFJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=g9E8J59pyI7+3ufcuFp5Z/DdMmkxcOkTQpJn9G2elDsndeOQcKPK9v1rw+KNXcfKdAt7R0S4K7ozEjizwqmRtjvafohvedjb4Tb6y7BLc/TkDmYp5WNQVsT5NPKJ2SSZLNKLU/OK2AOy1fUdcQ5vasidH3GhsCfhhSRZKHzgNy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=O/wYBWsf; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20251016094756epoutp0102f5eb0c73f684ffc10820b0369c7a1f~u77fIkjD81006610066epoutp01E
	for <linux-block@vger.kernel.org>; Thu, 16 Oct 2025 09:47:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20251016094756epoutp0102f5eb0c73f684ffc10820b0369c7a1f~u77fIkjD81006610066epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760608077;
	bh=FdnjNgdjCzHvat6P4B2OHjvq6mtqbABYBpymUlWcR74=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=O/wYBWsfCV8M7qzUOpO8xsS02ozbzaZBrzmEinVochWkR1b3yBmGoSmd2EBY6L3oC
	 QP3MkmPF2m2GhL8IfPM1Ybe1DZsOFS6YPyGiN33LUJyE1vUWEyLaH8VeN2XzRjFyvT
	 JKU90iCKQAUXnXdausK5h1cZrSQB9dVW9M2ON1Hc=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20251016094756epcas5p169092388b1a89e9d653c87d2e433c617~u77el4Huz1743217432epcas5p1N;
	Thu, 16 Oct 2025 09:47:56 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.87]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cnNRb4nRWz6B9m5; Thu, 16 Oct
	2025 09:47:55 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20251016094755epcas5p3c9384b2342d1be98f572bf2c97f0e363~u77dcONG80525205252epcas5p3H;
	Thu, 16 Oct 2025 09:47:55 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251016094752epsmtip1ebeb57d27dffe43e2ae75ce3aedfd0d5~u77bA-O3y1091410914epsmtip1x;
	Thu, 16 Oct 2025 09:47:52 +0000 (GMT)
Message-ID: <78e760ed-1ba3-4a06-ac51-45b4cd2c05e0@samsung.com>
Date: Thu, 16 Oct 2025 15:17:50 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] fs: propagate write stream
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, brauner@kernel.org,
	josef@toxicpanda.com, jack@suse.cz, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250812082404.GD22212@lst.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251016094755epcas5p3c9384b2342d1be98f572bf2c97f0e363
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250729145338epcas5p4da42906a341577997f39aa8453252ea3
References: <20250729145135.12463-1-joshi.k@samsung.com>
	<CGME20250729145338epcas5p4da42906a341577997f39aa8453252ea3@epcas5p4.samsung.com>
	<20250729145135.12463-5-joshi.k@samsung.com> <20250812082404.GD22212@lst.de>

On 8/12/2025 1:54 PM, Christoph Hellwig wrote:
> On Tue, Jul 29, 2025 at 08:21:34PM +0530, Kanchan Joshi wrote:
>> bio->bi_write_stream is not set by the filesystem code.
>> Use inode's write stream value to do that.
> Just passing it through is going to create problems.  i.e. when
> the file system does it's own placement or reserves ids.  We'll need
> an explicit intercept point between the user write stream and what
> does into the bio.
> 

For that intercept point - will you prefer a generic helper, say 
fs_resolve_write_stream(), that will call a new inode operation that 
filesystem will implement?

