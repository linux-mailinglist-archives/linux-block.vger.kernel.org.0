Return-Path: <linux-block+bounces-1947-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3955A830CC4
	for <lists+linux-block@lfdr.de>; Wed, 17 Jan 2024 19:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D5D286D49
	for <lists+linux-block@lfdr.de>; Wed, 17 Jan 2024 18:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B63F22F0E;
	Wed, 17 Jan 2024 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DJ79lgBv"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE6C22EE3;
	Wed, 17 Jan 2024 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705516493; cv=none; b=OPE0iitIk069So3VMrQBudTyVtMr6/SvdHG9Ex9fambx6iN0c5d6cSuu7d70q8DFToAPbXhxFal0ErZzrGRPJLv1q4mA0V3QjJctsRM9c75SsNzHZEpZ/iwyIghocSAf57lo9zdzP5t11xes+tOPKc216DJkBiGf08lR/UKnIiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705516493; c=relaxed/simple;
	bh=w3ye9Lfs6lrVI9jf34MaHaq4xU4WMPmUMPs/Ih6w3xc=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite; b=HoxtXtUftPD9cG/+V5kDHlCsSrTlJdfQMWPUdny06k83XgndinTXZwh9Zg/FWRhWcVW8QLPGM3H1KFasmDW1m7rRf6A/umViCO7tCuz0PZwLmzSC+zLPo5qqYmHUYT7Aj47nvPXNdiYvOXxI6yKR/qd0AOA0QVk0scYzXI2EMLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DJ79lgBv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8KbCl+cL1HIU08ekeQETRW2iziUj3AHaE3YLzLQgqic=; b=DJ79lgBv5cumSm/F1s2Z3E82Ho
	Bl5IkMYk0+bzxewYn5KQAgmsZPzzPoGtFrKfWudCfngrpPrqjoZYfvkeoZaLdis0r6mdO/mQoqEeN
	JwmapxkwdaFT4tIo//q9v2ftvMRASdsFhvrpclJkVMMtRlKO/ugDaJvzJ1LatK+vzBiWHOVDPUq8t
	VKgkRa46n1QHVIS6fQHflO3YBqtMvACCTPX7oVQgJffjKMIvPIpsE7QYEyP35f3kPgf2NmQk491hu
	uP4hEWPRVHchr7OopCJWIcYNmW6C90ta/vv4N1IQ9DHitklALTeKA+HeAQDHTo7Fq2G7hhD1kKzz0
	1bcM5Ulg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rQAkP-000Ngy-2k;
	Wed, 17 Jan 2024 18:34:45 +0000
Date: Wed, 17 Jan 2024 10:34:45 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Allison Karlitskaya <allison.karlitskaya@redhat.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: PROBLEM: BLKPG_DEL_PARTITION with GENHD_FL_NO_PART used to
 return ENXIO, now returns EINVAL
Message-ID: <Zagdxacc9ffD7WtW@infradead.org>
References: <CAOYeF9VsmqKMcQjo1k6YkGNujwN-nzfxY17N3F-CMikE1tYp+w@mail.gmail.com>
 <ZaZesiKpbMEiiTrf@infradead.org>
 <210deda9-5439-244a-0ce2-af9dc8e5d7fe@huaweicloud.com>
 <592625f7-36d7-02e0-2ee6-8211334aa0f9@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <592625f7-36d7-02e0-2ee6-8211334aa0f9@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jan 16, 2024 at 09:46:21PM +0800, Yu Kuai wrote:
> Please ignore the patch from last email. Sorry for the noise...
> bdev_resize_partition() will also return -ENXIO if partition does't
> exist. So the right patch should be following:

Yes, this looks good.  I've also verified that historically
adding a partition always returned -EINVAL when beyond the maximum
number of partitions (which would have been 0 in this case).

