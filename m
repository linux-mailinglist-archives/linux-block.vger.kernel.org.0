Return-Path: <linux-block+bounces-1093-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33791811F8F
	for <lists+linux-block@lfdr.de>; Wed, 13 Dec 2023 20:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35292815F3
	for <lists+linux-block@lfdr.de>; Wed, 13 Dec 2023 19:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C2C6828A;
	Wed, 13 Dec 2023 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlPmjWfp"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDAD5FF18
	for <linux-block@vger.kernel.org>; Wed, 13 Dec 2023 19:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57C6C433C8;
	Wed, 13 Dec 2023 19:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702497449;
	bh=S+s9WiqhFrQqzTa37glB4EKXWjxpjTJ1+yD+u+AfsXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mlPmjWfp1Bgbrdo16JSX6di7M3RQ/kcbltbPJ8cLeZEuyYUHkGAeeQtcu0OylPfET
	 o/2s/jdr84tX5NByLx3RMbHHzY6VH2KLfK+jlS7MaYH4+GNwqAmG71SMj+eXUQBv98
	 7GvYrTQty4gzyFO+LWhVRhwaN8DdHKg6IBO5bltHF7vGaibElluhCin2zKKFu/npdu
	 LY6H+2wZP1QmEURpPIgLqPE6YxaDpo6Az+OOByzJbcWtfu/NByUDhwgpQ8smvcq5/9
	 9W30uA794ykQ9oJjDkpKq2g06hB2WAmWDbAmpnc0zLcwQE7Tfy212u8K+IxW+gOkgq
	 JX8mb+VOI09Jg==
Date: Wed, 13 Dec 2023 11:57:27 -0800
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] block: Use pr_info() instead of printk(KERN_INFO ...)
Message-ID: <ZXoMp7mYbSWnwdJu@kbusch-mbp>
References: <20231213194702.90381-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213194702.90381-1-bvanassche@acm.org>

On Wed, Dec 13, 2023 at 11:47:02AM -0800, Bart Van Assche wrote:
> Switch to the modern style of printing kernel messages. Use %u instead
> of %d to print unsigned integers.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

