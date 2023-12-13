Return-Path: <linux-block+bounces-1029-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ED980F155
	for <lists+linux-block@lfdr.de>; Tue, 12 Dec 2023 16:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7AE2816C6
	for <lists+linux-block@lfdr.de>; Tue, 12 Dec 2023 15:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B05576DC5;
	Tue, 12 Dec 2023 15:40:47 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7F795
	for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 07:40:44 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id AFB7768BFE; Tue, 12 Dec 2023 16:40:40 +0100 (CET)
Date: Tue, 12 Dec 2023 16:40:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Message-ID: <20231212154039.GA20933@lst.de>
References: <20231205053213.522772-1-bvanassche@acm.org> <20231205053213.522772-4-bvanassche@acm.org> <20231211165720.GC26039@lst.de> <7d323197-c85d-4692-83db-9867104c48fd@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d323197-c85d-4692-83db-9867104c48fd@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 11, 2023 at 09:20:00AM -0800, Bart Van Assche wrote:
> It seems like there is a misunderstanding. The issue addressed by this
> patch series is not F2FS-specific. The issue addressed by this patch
> series can be encountered by any software that submits REQ_OP_WRITE
> operations.

How so?

