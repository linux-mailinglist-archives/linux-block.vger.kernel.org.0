Return-Path: <linux-block+bounces-13458-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885E19BAD3C
	for <lists+linux-block@lfdr.de>; Mon,  4 Nov 2024 08:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 265C8B20BCA
	for <lists+linux-block@lfdr.de>; Mon,  4 Nov 2024 07:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A617219645C;
	Mon,  4 Nov 2024 07:36:29 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A68197549;
	Mon,  4 Nov 2024 07:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730705789; cv=none; b=ZQ8fLfhltB+AVhrlLLTb2eIqJrEx+WlsgDlVUR2wRTVhZxSoa2QVYECz0mq4peCc6jeihhz8cK3SAL+KZdIupYkKHRWvR3VjBJe5EPHwNjmy8vNoMiNEgeaWga3qnSiT8IylroyaKMhMSW8ARDUhZJqJcNtb46dEcLWWMTq3HuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730705789; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjELY2Bmcw0pzNecPr89D6wSQsLtAkxugprKyUHxMjVzTb1RP7JHGUNQD/B/ygYY/L1JBBUi2Y5XOheMrWmubxbhv9ujw2EwsJDS4J5rbPBx0CsOjMTnLMVgAm2jj8A0FVyvLBX0WCocaCJNFxWoOE6HMWYWSnAQtojYK7hs6QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2882A68C7B; Mon,  4 Nov 2024 08:36:22 +0100 (CET)
Date: Mon, 4 Nov 2024 08:36:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, song@kernel.org, yukuai3@huawei.com, hch@lst.de,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCH v3 2/5] block: Support atomic writes limits for stacked
 devices
Message-ID: <20241104073621.GB20614@lst.de>
References: <20241101144616.497602-1-john.g.garry@oracle.com> <20241101144616.497602-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101144616.497602-3-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


