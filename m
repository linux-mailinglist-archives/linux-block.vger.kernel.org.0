Return-Path: <linux-block+bounces-963-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3039D80D2F8
	for <lists+linux-block@lfdr.de>; Mon, 11 Dec 2023 17:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4AA2B20FB5
	for <lists+linux-block@lfdr.de>; Mon, 11 Dec 2023 16:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3C64CDEB;
	Mon, 11 Dec 2023 16:55:42 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE50BD
	for <linux-block@vger.kernel.org>; Mon, 11 Dec 2023 08:55:39 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6289E68B05; Mon, 11 Dec 2023 17:55:37 +0100 (CET)
Date: Mon, 11 Dec 2023 17:55:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 2/3] block/mq-deadline: Introduce dd_bio_ioclass()
Message-ID: <20231211165537.GB26039@lst.de>
References: <20231205053213.522772-1-bvanassche@acm.org> <20231205053213.522772-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205053213.522772-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 04, 2023 at 09:32:12PM -0800, Bart Van Assche wrote:
> Prepare for disabling I/O prioritization in certain cases.

On it's own this looks pretty useless to be honest, an with just a
single caller it can't really make future patches significantly
simpler either.


