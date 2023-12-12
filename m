Return-Path: <linux-block+bounces-1030-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF5680F15A
	for <lists+linux-block@lfdr.de>; Tue, 12 Dec 2023 16:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B66E280FFC
	for <lists+linux-block@lfdr.de>; Tue, 12 Dec 2023 15:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98C876DC6;
	Tue, 12 Dec 2023 15:41:46 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ABF9F
	for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 07:41:43 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 289D668BFE; Tue, 12 Dec 2023 16:41:41 +0100 (CET)
Date: Tue, 12 Dec 2023 16:41:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Message-ID: <20231212154140.GB20933@lst.de>
References: <20231205053213.522772-1-bvanassche@acm.org> <20231205053213.522772-4-bvanassche@acm.org> <20231211165720.GC26039@lst.de> <177773fd-c8ed-4822-9344-3058e820ddf0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177773fd-c8ed-4822-9344-3058e820ddf0@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 12, 2023 at 07:40:02AM +0900, Damien Le Moal wrote:
> The latter is I think better than the former as CGs can change without the FS
> being aware (as far as I know), and such support would need to be implemented
> for all FSes that support zone writing using regular writes (f2fs and zonefs).

How is cse 2 any kind of problem when using the proper append model?
Except when blk-zoned delays it so much that we really need to close
the zone becaue it's timing out, but that would really be configuration
issue.

