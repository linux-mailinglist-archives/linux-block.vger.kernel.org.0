Return-Path: <linux-block+bounces-18367-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B234FA5F4BD
	for <lists+linux-block@lfdr.de>; Thu, 13 Mar 2025 13:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E59C19C0317
	for <lists+linux-block@lfdr.de>; Thu, 13 Mar 2025 12:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03E978F59;
	Thu, 13 Mar 2025 12:42:36 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EB46EB7C
	for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869756; cv=none; b=bamJn3J8HvVMoZXwq6LW/ldNQExXUwbyjg9quvkE2oZiGB6mgQDJ7STR90x1g8rel6Ve8z2wEEMx0gNfDzQcs0ua/fK6+adM4wqtQWhy8X6GeLUdBGqtdbDRMK4XAN/YF8e21hw1q44EkvNKfjlWekdaWiT1hVrNco3NBykS8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869756; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBB3aA2q1fWMZ1tKPjLJDRIKpetl5n0uIngn2PeHE+4nl6CpOGlwRoIp96V7gLzDg7LAPzQ4tO+oASCOr44fpclrRzI8GfXnqcPxcv3GlCcEd1wsm4RDYTvV44K8Dd/LlLWCTEtKWIIX6mv3K9ZCbd3KfO2mvw8J8ab7mcpn0wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0581167373; Thu, 13 Mar 2025 13:42:31 +0100 (CET)
Date: Thu, 13 Mar 2025 13:42:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com,
	dlemoal@kernel.org, hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv2 3/3] block: protect debugfs attribute method
 hctx_busy_show
Message-ID: <20250313124230.GD3841@lst.de>
References: <20250313115235.3707600-1-nilay@linux.ibm.com> <20250313115235.3707600-4-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313115235.3707600-4-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


