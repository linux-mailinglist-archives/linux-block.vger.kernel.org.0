Return-Path: <linux-block+bounces-16736-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CCFA23929
	for <lists+linux-block@lfdr.de>; Fri, 31 Jan 2025 05:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CA2E166148
	for <lists+linux-block@lfdr.de>; Fri, 31 Jan 2025 04:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837FF18E25;
	Fri, 31 Jan 2025 04:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="PCPw4qxx"
X-Original-To: linux-block@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9118A17591
	for <linux-block@vger.kernel.org>; Fri, 31 Jan 2025 04:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738298438; cv=none; b=TdPvHgTI5nTiBsVV4tmpS15amT6kLpeR78kGojxNy/lPFi3YKS4RiLTGUKbTNmuQz39WbFNd+zYfVQ0alppOXPFy2ORlr+N79xfUbCNIhOZ/C1w8Wt3UIu7FZ69Z5AYYY896Ffa0ngqNBhLE52D3YoV0E0trf1OsYwDWjmYOuFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738298438; c=relaxed/simple;
	bh=UCGyZjQy6WQrIu39YraJAcmxRCphUxJx3w6t9kNiL8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkm6mjFIsIUap/Uf8vnEqWad03MJQL2q56LLQgjwUH8JZZyxibzeoyCv/a99xOIWnMp1XfDUn6AfXUsAgAaXVQ47v34ZKZgN2vlR0xHLPYxUiIm1qSB8bvAmsbkS4MKJdI8f4VFmYG8Zn5AY1L6gwfLaoBInSRCIG/ItfPM4Cgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=PCPw4qxx; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([12.221.73.181])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50V4eFhe029357
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 23:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1738298419; bh=NIu5WVUHGLf9gfdTWvOvNK/xFsqLPRxW7J/Q8nhUDO0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=PCPw4qxxsROGw2PX/NHKbAd85xP/Eidk7VIu5PmPz2yaHhuHymcZRPeRp1kJsika/
	 BmqpzMAIc0jLKRf6+bbvE5E3gSl2Oyl8hUwV8oRXF6TdPdRuZc8wqkpOHi4Xd7ZlUE
	 Ke23JkbUo3zBiBMJtO0oWIxFqFoyNZh33Ap7QBgCm4hdFFxMs6pWx00dp/YfquqtT7
	 EazfVXTezzvo0+RmgElK4dTsjdsBLIEC6oXdnSbMl9i+iXFCVjf4tjCB/Tjhv9jz30
	 sBGW4sSgoDuRMfKYGvk6yaYyF0rdvp4UNqoP8IIZxgYEyuR7izjO2NZZjZD4jLQh/5
	 YZieu+n0RShxQ==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 0DD8B344FF0; Thu, 30 Jan 2025 20:40:15 -0800 (PST)
Date: Thu, 30 Jan 2025 20:40:15 -0800
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, lsf-pc@lists.linux-foundation.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        josef@toxicpanda.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <20250131044015.GB416991@mit.edu>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <yq1r04knj7a.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1r04knj7a.fsf@ca-mkp.ca.oracle.com>

On Thu, Jan 30, 2025 at 03:39:20PM -0500, Martin K. Petersen wrote:
> It already works that way. If a device advertises being
> integrity-capable, the block layer will automatically generate
> protection information on write and verify received protection
> information on read. Leveraging hardware-accelerated CRC calculation if
> the CPU is capable (PCLMULQDQ, etc.).

So I'm confused.  If that's the case, why do we need Kanchan Joshi's
patch to set some magic bio flag and adding a mount option to btrfs?

      	     	  	    	     	    - Ted

