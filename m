Return-Path: <linux-block+bounces-397-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CC97F6304
	for <lists+linux-block@lfdr.de>; Thu, 23 Nov 2023 16:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7D51C21131
	for <lists+linux-block@lfdr.de>; Thu, 23 Nov 2023 15:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BFD14A8D;
	Thu, 23 Nov 2023 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF3C2694
	for <linux-block@vger.kernel.org>; Thu, 23 Nov 2023 07:30:12 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 92247227AAD; Thu, 23 Nov 2023 16:30:08 +0100 (CET)
Date: Thu, 23 Nov 2023 16:30:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: "kundan.kumar" <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de,
	linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH] block: skip QUEUE_FLAG_STATS and rq-qos for
 passthrough io
Message-ID: <20231123153007.GA3853@lst.de>
References: <CGME20231123103102epcas5p2aee268735dc9e0c357e6d3b98d16fe21@epcas5p2.samsung.com> <20231123102431.6804-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123102431.6804-1-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 23, 2023 at 03:54:31PM +0530, kundan.kumar wrote:
> -	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
> +	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)
> +			&& !blk_rq_is_passthrough(rq)) {

&& goes on the starting line in the kernel code style.

The rest looks good, but that stats overhead seems pretty horrible..


