Return-Path: <linux-block+bounces-4582-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B6D87E06C
	for <lists+linux-block@lfdr.de>; Sun, 17 Mar 2024 22:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53FA41C20C32
	for <lists+linux-block@lfdr.de>; Sun, 17 Mar 2024 21:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F11E208B0;
	Sun, 17 Mar 2024 21:37:02 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA511C6BC;
	Sun, 17 Mar 2024 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710711422; cv=none; b=jyGYINIUVLA3as1nuMRUsqRROYuAFwBPDm4KB/o0WjyzKOLdQSIQBqHWIawqon1d/npNFnJ0J5op7izV8MAF3vutGJQuG1r9JsZtQ1HkhiCj0mI68OFlVBwIsxkdxZ9px+WQfqC4SlG1qpmy8aGyAU5gtQo8ZuNfm++8Yb/WY6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710711422; c=relaxed/simple;
	bh=592dZ7WAUIsHG3MEKADuylxxO7ldI3EWhVAbE9SjKao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSVWhJBxjA80IUCNr2dneoKE/wgWOWf6F+AWxT3DcbseyhJRGlxmynKiHxIOFJQ69vko0PZl0IMpJ7pJHjUz6L4B3FmecXHs8tWogGrsaw2t9TPvkkqpneOBwRJkYTH4Jys7sM+XAh3Gd9sJx2d+k3+Is6XMMPh8LUXV9KVAKs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 28A9168BEB; Sun, 17 Mar 2024 22:36:58 +0100 (CET)
Date: Sun, 17 Mar 2024 22:36:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 18/19] scsi: factor out a helper
 bdev_read_folio() from scsi_bios_ptable()
Message-ID: <20240317213657.GC10665@lst.de>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com> <20240222124555.2049140-19-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-19-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Can you split this in a block layer patch adding the helper and scsi
one using it?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

