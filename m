Return-Path: <linux-block+bounces-8253-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDCE8FC536
	for <lists+linux-block@lfdr.de>; Wed,  5 Jun 2024 09:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE20E1C22615
	for <lists+linux-block@lfdr.de>; Wed,  5 Jun 2024 07:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2806E18F2CF;
	Wed,  5 Jun 2024 07:55:18 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB3D15E5A2
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 07:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574118; cv=none; b=WzwSHP51Bo5a7qiklQnLZVTNqSnmY8klsePaDNeKw2iWG8uiR7SZxH6nbtlgIY2UYtM2Wvte7LuMDUwhyvTCUHHVqqInPiyN/gNSAnx+lQnYQAu4mzxQCFroXfkWDL2+CWPzKEbG6MzKGH9N75sAP6BXjSutIzBl0Oah1SVyP3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574118; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMGfgWonOXIq45xq0djz3p89494S/GvlBnZsYGOdfN5350qPmGk47v5YN8gkgD91d9INiNXABg91EARXGVnMq98yhf0HsPo2oN8ccvZRpkCWRfmlRZh9eDRb4u6pxmeOUf1tTennuEQzteg9s23AvSwKDdoAOv7lM2cxfDMJ/w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9BBBA68D0D; Wed,  5 Jun 2024 09:55:13 +0200 (CEST)
Date: Wed, 5 Jun 2024 09:55:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Benjamin Marzinski <bmarzins@redhat.com>
Subject: Re: [PATCH v4 2/3] dm: Improve zone resource limits handling
Message-ID: <20240605075513.GB18465@lst.de>
References: <20240605075144.153141-1-dlemoal@kernel.org> <20240605075144.153141-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605075144.153141-3-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

