Return-Path: <linux-block+bounces-15620-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5FE9F73EE
	for <lists+linux-block@lfdr.de>; Thu, 19 Dec 2024 06:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E361B1884220
	for <lists+linux-block@lfdr.de>; Thu, 19 Dec 2024 05:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6999219B5B1;
	Thu, 19 Dec 2024 05:33:57 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A2A7E575
	for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 05:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734586437; cv=none; b=EpS69pQknGHIS4nnDzZVgAioXJrMdWCKPCeO7v05Vu7chbadABZX6umhrIb+TE2pj/GqTV3X9F9NmwlwWgYIUfVL8hD38bWMCs4AjEWrbF676LlI+nV8E0ii+ItlbAnfUPheelYIJHX6oNPlrKyCsZxneqZdOqG0kytXz0XiAoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734586437; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+l2MUJLD7gzkNeAmw+1rSGhabt4Ax8e2yI3QODuBnNyeOOxJW1mt/tQCeHRuKSUSTmXA3bolosfl6XAlqJ7HIYns9OukU7VqHzIZgfjivYE3qfzfKegkjwIlSiUyUowOHQAo68yp9KmjMY8tL8kilLUIepfWTGrnc86ji5yiNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B6B7568AFE; Thu, 19 Dec 2024 06:33:48 +0100 (CET)
Date: Thu, 19 Dec 2024 06:33:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 1/2] block: Reorder the request allocation code in
 blk_mq_submit_bio()
Message-ID: <20241219053348.GA18792@lst.de>
References: <20241218212246.1073149-1-bvanassche@acm.org> <20241218212246.1073149-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218212246.1073149-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

