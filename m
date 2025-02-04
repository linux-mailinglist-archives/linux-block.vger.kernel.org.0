Return-Path: <linux-block+bounces-16873-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C7CA26B7B
	for <lists+linux-block@lfdr.de>; Tue,  4 Feb 2025 06:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3BD3A7923
	for <lists+linux-block@lfdr.de>; Tue,  4 Feb 2025 05:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E22E1D516A;
	Tue,  4 Feb 2025 05:45:29 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB4C43172;
	Tue,  4 Feb 2025 05:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738647929; cv=none; b=fVuEeKLK9OsR2fNGGKLhMhv90+7ZUAH2RNE3Mu7/Uwlv1ewSQH/GSYp3OOhU6TaT8Wn6Vhj1Rg502q2zmwOrByHjpInov+Vwt+Vkd3CGDju6OhtoFHYDUG7ggEHRDsikDSsgoQrk4f2pS2uffljBFJ/iWb9FIlYjjbnUKkfWrOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738647929; c=relaxed/simple;
	bh=aIsXSz3h+h6XF2CZYPxHMXyo2Vy1uQYDeOZtSFW9IAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExgnAnfVBCF90uEBr3YadRWeeNKXcyCyDA4fQ125qvhoxCMI9UIx+IiiUly8ctAtYGbXCxN1LiLPLEis+T0XWZJ+qRjtnNxM+JQA9hzmfwOQguz9ZPvofIqgA4ZP2mYAc7G8RfsVvhsQdJ9nTBnZrHZYWlQTGLJc0xF2y5Uj69M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1344868AFE; Tue,  4 Feb 2025 06:45:22 +0100 (CET)
Date: Tue, 4 Feb 2025 06:45:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>, Kanchan Joshi <joshi.k@samsung.com>,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH 2/3] block: move the block layer auto-integrity code
 into a new file
Message-ID: <20250204054521.GA28971@lst.de>
References: <20250131122436.1317268-1-hch@lst.de> <20250131122436.1317268-3-hch@lst.de> <yq1v7tqj00w.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1v7tqj00w.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 03, 2025 at 02:41:25PM -0500, Martin K. Petersen wrote:
> I'm not sure I'm so keen on integrity-default.c, though. But naming is
> hard. bio-integrity-auto.c, maybe?

Fine with me.


