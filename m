Return-Path: <linux-block+bounces-964-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 502C080D304
	for <lists+linux-block@lfdr.de>; Mon, 11 Dec 2023 17:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056C31F21574
	for <lists+linux-block@lfdr.de>; Mon, 11 Dec 2023 16:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B724CDE1;
	Mon, 11 Dec 2023 16:57:25 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507F9C7
	for <linux-block@vger.kernel.org>; Mon, 11 Dec 2023 08:57:23 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4EA5868B05; Mon, 11 Dec 2023 17:57:20 +0100 (CET)
Date: Mon, 11 Dec 2023 17:57:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Message-ID: <20231211165720.GC26039@lst.de>
References: <20231205053213.522772-1-bvanassche@acm.org> <20231205053213.522772-4-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205053213.522772-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 04, 2023 at 09:32:13PM -0800, Bart Van Assche wrote:
> Fix the following two issues:
> - Even with prio_aging_expire set to zero, I/O priorities still affect the
>   request order.
> - Assigning I/O priorities with the ioprio cgroup policy breaks zoned
>   storage support in the mq-deadline scheduler.

Not it doesn't, how would it?  Or do you mean your f2fs hacks where you
assume there is some order kept?  You really need to get rid of them
and make sure f2fs doesn't care about reordering by writing the
metadata that records the data location only at I/O completion time.
Not only does that make zoned I/O trivially right, it also fixes the
stale data exposures you are almost guaranteed to have even on
conventional devices without that.

