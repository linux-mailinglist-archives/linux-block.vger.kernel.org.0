Return-Path: <linux-block+bounces-18585-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE40A66AEE
	for <lists+linux-block@lfdr.de>; Tue, 18 Mar 2025 07:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBA117BE1D
	for <lists+linux-block@lfdr.de>; Tue, 18 Mar 2025 06:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F250B38FA6;
	Tue, 18 Mar 2025 06:56:10 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552663CF58
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 06:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742280970; cv=none; b=q/Xvjl1HYUVJLG+1yeAeK++6e6+2rXzII8DcwY7NPDPHFytcl5oQ/5pq6Mxc4c2bASy5mugfECmvBMEuSzd2CSq8nYWjQZ61TsRsE31GE81tN09hAs0W4P9HLnhH4p4wL1Ht2wp3ktvQo352bfXc6KA8AzzYMFMWE0HULLiJ7wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742280970; c=relaxed/simple;
	bh=aRyJA/UjGdbf/EBp1G8/i1DE3KvtKDiRKzJR6mkoqRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVr3dFPZYp9rXhtoMeiwlkg5XOGGQLefVP2zb180/YjXNTDqeS3zvtDLsRPSH8TibPGbIryMHqrpk8qNXW8CRaj3XSf1s717grdILO+VoDgoqfZbHkDt6pemcDv9yYVHhx4rY07CcoaFxkjN5IMvCxePDqI3sgUkp+LjStYTQu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1C02468AA6; Tue, 18 Mar 2025 07:56:04 +0100 (CET)
Date: Tue, 18 Mar 2025 07:56:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Marzinski <bmarzins@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 3/6] block: make queue_limits_set() optionally
 return old limits
Message-ID: <20250318065603.GA16259@lst.de>
References: <20250317044510.2200856-1-bmarzins@redhat.com> <20250317044510.2200856-4-bmarzins@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317044510.2200856-4-bmarzins@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 17, 2025 at 12:45:07AM -0400, Benjamin Marzinski wrote:
> A future device-mapper patch will make use of this new argument. No
> functional changes intended in this patch.

If you care about the old limits just use a queue_limits_start_update +
queue_limits_commit_update{,frozen} pair.


