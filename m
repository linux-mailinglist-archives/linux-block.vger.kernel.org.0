Return-Path: <linux-block+bounces-21286-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C105BAABA53
	for <lists+linux-block@lfdr.de>; Tue,  6 May 2025 09:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0EF1C00C1A
	for <lists+linux-block@lfdr.de>; Tue,  6 May 2025 07:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B9415575C;
	Tue,  6 May 2025 04:46:25 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E90A233D91
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 04:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746506651; cv=none; b=cjBG0HaXdtxUvBWsT+Qo9Vxj9YjYnVl+UhMbMQTI7gW2VllKQjeCOT/h+1McDgkoY+NKWnYOSQ9SswYzTQzP1krDtLx7ET5m6WpdIZmkCs5WiL6RqOtT42NwL2xn5ts7rlugS7Q3N3aTfZ2hV3Hn5fHHgj759dEXsqYz6RRaKYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746506651; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCIhyKmHQdequSmDGxfbPIvXfoHC+ZC8/A5qbltocOi13QQP6CBVLInGCGRcRkzqV5sLef6SSzGx/sek6fD8tiR7056YqkjU3jXnvSOCT/5Dp6+mUiBdZxEq0W7kcK2r8z6tjTwHkOTffo+CI+AKMvVeDJTjE7OZ5ukkjU6fHkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 17A1967373; Tue,  6 May 2025 06:44:06 +0200 (CEST)
Date: Tue, 6 May 2025 06:44:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 23/25] block: don't acquire ->elevator_lock in
 blk_mq_map_swqueue and blk_mq_realloc_hw_ctxs
Message-ID: <20250506044405.GG27061@lst.de>
References: <20250505141805.2751237-1-ming.lei@redhat.com> <20250505141805.2751237-24-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505141805.2751237-24-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

