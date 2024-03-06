Return-Path: <linux-block+bounces-4170-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0413A873A8D
	for <lists+linux-block@lfdr.de>; Wed,  6 Mar 2024 16:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E5C6B22EFB
	for <lists+linux-block@lfdr.de>; Wed,  6 Mar 2024 15:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494AF80605;
	Wed,  6 Mar 2024 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwjPXmX2"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD0812FF88
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709738403; cv=none; b=WqL6fU/eOU5U3KAO9CRGVh5MRri1wkuwmYFQoe2r55zDbwV//9dNq/DX9oM/q3oGbFpEfmAHvveNeYqY89nNnBWDWUrYMsh322CP7m6Qg2kD3v67RriUOAJ59UcvuNVDn8ER6QHPOUNu75ZQydEpQkBLaKsdmhP/KchcKYtvXpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709738403; c=relaxed/simple;
	bh=rHAdrEuObQpnvEX9h3DrGGAM2P4rW4PGKgvenW1gyoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXqNiHq3KlGDEmZ4EuD/YGX4a83DMzWicLSnK0oDBXkkIJM/BmujgbvbTzRs/qKJUDngdik/99tPzZVH6TeiCpNZKLW/ednWjB2jdleTCUUgQ6wsP7Glo/XVQwNV/ESGTagHEOqcsN99CwB4MRBdixzz6hXF0K7fRZoLXxb9YtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwjPXmX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E73C43390;
	Wed,  6 Mar 2024 15:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709738402;
	bh=rHAdrEuObQpnvEX9h3DrGGAM2P4rW4PGKgvenW1gyoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LwjPXmX28r/xjWJMKwvRLdwyC+ePDbVuLDtsJF6g95+x9ZU5vbyulcCW13PaaFUZf
	 ulwpBx+jAMUstZSw0ZZd6TQgFCbMeGJeXOa2q6bQ15biV/e8NLNd0xfCAMtZbnf72n
	 6aFuxko8gVjNnTKxK8bBEbzRmEIJu1KzHbpDmROy3W0HFIgIDXqSghSanzxw3TzEBS
	 CeGg0FHw3zrRLPXzWtFV+zlC2/d7BcJHQtdL1aHxLvRVnMQrbHMPmCu38dmhjEKB5f
	 oL5gIoMXinHhRK9oiW+qQAQ+yjvnK24nz8gaCnsPuHs48IWOdzj6yCYbKuGKvBCOj0
	 fzSC8TEIPbhsQ==
Date: Wed, 6 Mar 2024 08:19:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: hch@lst.de, axboe@fb.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH RESEND] nvme-pci: Fix EEH failure on ppc after subsystem
 reset
Message-ID: <ZeiJn6PIHVT4pYZD@kbusch-mbp>
References: <20240209050342.406184-1-nilay@linux.ibm.com>
 <Zd4p_E8cPFpr1M--@kbusch-mbp>
 <4bc44911-afc2-4886-86cc-e0adb6be4457@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bc44911-afc2-4886-86cc-e0adb6be4457@linux.ibm.com>

On Wed, Mar 06, 2024 at 04:50:10PM +0530, Nilay Shroff wrote:
> Hi Keith and Christoph,

Sorry for the delay, been very busy recently. I'll revisit this this
week.

