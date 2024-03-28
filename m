Return-Path: <linux-block+bounces-4572-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A876487E04D
	for <lists+linux-block@lfdr.de>; Sun, 17 Mar 2024 22:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CDD21F21C15
	for <lists+linux-block@lfdr.de>; Sun, 17 Mar 2024 21:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0BC208A4;
	Sun, 17 Mar 2024 21:25:05 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D899208A0;
	Sun, 17 Mar 2024 21:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710710705; cv=none; b=ZnDA/AIpXEWh51ciKczjUnCMUjoczfzmG2JK5bvQn6IxhgquJ5Tw9BuQ1x3iv4juYbfvEtMNKNyPnGfQnqmTeYV47luylJfhrCnUbkL/Z+4zxUL7aRtxnSSwzpeDhdYKcUhLaOU6lIBRS90OEI/C1iiJLPN39KBsDWcAXQ29cKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710710705; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeBiFAnrCtfNfvKJkpFSUmk//FQga82oOOG6RwbdidvRz2INsw1S6jTpjzD03MQd4BgvjWjD/Ihct9kKs+CWiXcW+FGFsty+4Mo4EVe16KLhr7+/Zh+2bWdBNCauUF70dE+MB2mSvnvcn4zIaBCFGu9W3GtRUxXVNU/lz8YM6Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 29A3368BEB; Sun, 17 Mar 2024 22:25:01 +0100 (CET)
Date: Sun, 17 Mar 2024 22:25:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 10/19] s390/dasd: use bdev api in
 dasd_format()
Message-ID: <20240317212500.GJ8963@lst.de>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com> <20240222124555.2049140-11-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-11-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

