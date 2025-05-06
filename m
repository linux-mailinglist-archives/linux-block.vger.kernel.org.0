Return-Path: <linux-block+bounces-21364-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4172AAC5AC
	for <lists+linux-block@lfdr.de>; Tue,  6 May 2025 15:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6131B61522
	for <lists+linux-block@lfdr.de>; Tue,  6 May 2025 13:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718F1280CD6;
	Tue,  6 May 2025 13:19:46 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9A6280006;
	Tue,  6 May 2025 13:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537586; cv=none; b=OZ/ejP4xb3G6tt9zHfWalSy5LLyiNvMHPvfEPBr4ABPL5gy88pbcY1CWpiCFndeQabOJJ3g0ukwWyeR6hFgObe20Xlt+jAQtxWsh8xTkJP7NL4ClXu2pfCbjGNYkfR9EEtvX7IFcVd0QyT98U8iCy+nsEpHtLJlML5pCDkWzTCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537586; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZugAOXBxZS1CWA0p9v4FhUZH3rcL/lUvj2AhEE6MK2ZwPUGSH7TFWWT/EufohnR05MJ+DrTq80Nkl0c3zgKkND7KcHKhQw9+sJEmiOLjZ2U9GOkPrKwem8UOkw90XRScg03aRIXvGW2vgEi1LnggOBJPIRDkL06+8BW4Jtz1RDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A4A0A68B05; Tue,  6 May 2025 15:19:37 +0200 (CEST)
Date: Tue, 6 May 2025 15:19:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, agk@redhat.com, song@kernel.org, hch@lst.de,
	john.g.garry@oracle.com, hare@suse.de, xni@redhat.com,
	pmenzel@molgen.mpg.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH 4/9] block: cleanup blk_mq_in_flight_rw()
Message-ID: <20250506131936.GA26876@lst.de>
References: <20250506124658.2537886-1-yukuai1@huaweicloud.com> <20250506124903.2540268-1-yukuai1@huaweicloud.com> <20250506124903.2540268-5-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506124903.2540268-5-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


