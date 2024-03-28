Return-Path: <linux-block+bounces-5310-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D07288F86B
	for <lists+linux-block@lfdr.de>; Thu, 28 Mar 2024 08:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB99C29426A
	for <lists+linux-block@lfdr.de>; Thu, 28 Mar 2024 07:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4888D27459;
	Thu, 28 Mar 2024 07:15:58 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3EC22EED
	for <linux-block@vger.kernel.org>; Thu, 28 Mar 2024 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711610158; cv=none; b=lm88MjrxDuH0VM4rdKLDbjp8R/RgqD8GWHW9i+HH58JEiOAUfRu2nT3INkZEU98kffV3NjHZlj061wc7el7jUhP0hu3KeGTm1QEHEoYWEs40HA95IFtWayFWKNh+S1Qyr6zIeTAaJdCqDBh73H1SElQJE3dDNfvvGMTRz/grOLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711610158; c=relaxed/simple;
	bh=yKhldeN3EJtKzhgZNtoLqqrqn5JXVC90ecM1aDun/Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VL/VaRbDZbvkASxPnswOo4vFUWD02MoQ2QiVmwXM3hpxOyMqLwJg3InoiuS9opmQN1bPQAoeUUEl2dAUzyZ25kaxmymGtVAvqHsz1Go1pWInTrAfxqemperBjvx7W/5f+8RaT+Er3AQ2w9n6PNOhSDLPjzoVNdM3j+ua1XlFqCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 65B7768B05; Thu, 28 Mar 2024 08:15:52 +0100 (CET)
Date: Thu, 28 Mar 2024 08:15:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@fb.com, Gregory Joyce <gjoyce@ibm.com>
Subject: Re: [Bug Report] nvme-cli commands fails to open head disk node
 and print error
Message-ID: <20240328071552.GA18319@lst.de>
References: <c0750d96-6bae-46b5-a1cc-2ff9d36eccb3@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0750d96-6bae-46b5-a1cc-2ff9d36eccb3@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 28, 2024 at 12:00:07PM +0530, Nilay Shroff wrote:
> One of namespaces has zero disk capacity:
> 
> # nvme id-ns /dev/nvme0 -n 0x3
> NVME Identify Namespace 3:
> nsze    : 0
> ncap    : 0
> nuse    : 0
> nsfeat  : 0x14
> nlbaf   : 4
> flbas   : 0
> <snip>

How can you have a namespace with a zero capacity?  NCAP is used
as the check for legacy pre-ns scan controllers to check that
the namespace exists.


