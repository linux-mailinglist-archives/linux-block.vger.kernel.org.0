Return-Path: <linux-block+bounces-13200-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E104C9B5AD5
	for <lists+linux-block@lfdr.de>; Wed, 30 Oct 2024 05:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E72B1C2131A
	for <lists+linux-block@lfdr.de>; Wed, 30 Oct 2024 04:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE5818FC7F;
	Wed, 30 Oct 2024 04:47:58 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61969374F1
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 04:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730263678; cv=none; b=h5KWW6Nr1Q3ygw7SVApMeclmvpRsfAjLh0b5elsgDd4YLQngjI0a6b4CEKEENLZ87OlQS5O01vwwGpnBU6BjMLHsglPLWjD7bkDetYzEgRmopAPEvTsqJeP4oB4eq8FikUEctzSMspfZ9Fow8F7XKeyHrAI56Vq2c4DSLXTR9v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730263678; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jf28Q7xJ+utXMUNpzNnWNCK63bkdrwUkdfLforpAX7wemmPjYPx9THiJYNDRpNarot98uMi3ASFqCriFLhDrW3GcPYI0E9KK2JZ7sVdcEDfbeJfLNakTwgJL28dRiwCT/J6PNQh9JCEiosLrbwQVwK0ecEzzAgdHeI3YMzvXraw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B1B3F227A8E; Wed, 30 Oct 2024 05:47:53 +0100 (CET)
Date: Wed, 30 Oct 2024 05:47:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yang Erkun <yangerkun@huaweicloud.com>
Cc: axboe@kernel.dk, ulf.hansson@linaro.org, hch@lst.de, yukuai3@huawei.com,
	houtao1@huawei.com, penguin-kernel@i-love.sakura.ne.jp,
	linux-block@vger.kernel.org, yangerkun@huawei.com
Subject: Re: [PATCH v2] brd: defer automatic disk creation until module
 initialization succeeds
Message-ID: <20241030044753.GA32369@lst.de>
References: <20241030034914.907829-1-yangerkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030034914.907829-1-yangerkun@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


