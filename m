Return-Path: <linux-block+bounces-1975-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882C6831311
	for <lists+linux-block@lfdr.de>; Thu, 18 Jan 2024 08:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2E81C20901
	for <lists+linux-block@lfdr.de>; Thu, 18 Jan 2024 07:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4768B9476;
	Thu, 18 Jan 2024 07:24:27 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F1E944D
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 07:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705562667; cv=none; b=BOdPGefhRlrJARpDYK62/sUX71nBODYOnIHFvsIC/jJ5jL5Hx2oc8MBCvKbIFLfVlTjtovsW7hyajrRhCP+ZMMSs67apXt/rV2oYMmxrs9Pcv2WdwM39GjhJZalyP/ojtb0Zv5PkgOrLhH8Bgq9dnAnR8BsytzDsExMAKNWviDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705562667; c=relaxed/simple;
	bh=EtlDlI0gPBVP12ub9ah8vZwtAxq1iZmbmAqfye0lRDA=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 User-Agent; b=P8xci7B2QOgU2xF/ofFEJQ9AnJknUXsdmfONnl2TSROlLnU2RPE6YLoZp9JqmZH4xaWiG7IkcuRJQfWEWXqzyqLR91uvUyfqLjjY2DJUW2PkzuyhKcxUq/ZmHuKCk7TaNeo0vXk6dJpZnoG8IaU7Ph40xLYpxjVJypf//b28c8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C883168C7B; Thu, 18 Jan 2024 08:24:19 +0100 (CET)
Date: Thu, 18 Jan 2024 08:24:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, linux-block@vger.kernel.org
Subject: Re: [RFC 0/1] nvme: Add NVMe LBA Fault Injection
Message-ID: <20240118072419.GA21315@lst.de>
References: <20240116232728.3392996-1-alan.adamson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116232728.3392996-1-alan.adamson@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 16, 2024 at 03:27:27PM -0800, Alan Adamson wrote:
> It has been requested that the NVMe fault injector be able to inject faults when accessing
> specific Logical Block Addresses (LBA).

Curious, but who has requested this?  Because injecting errors really
isn't the drivers job.


