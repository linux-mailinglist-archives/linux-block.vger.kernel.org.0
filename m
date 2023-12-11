Return-Path: <linux-block+bounces-962-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E955E80D2EC
	for <lists+linux-block@lfdr.de>; Mon, 11 Dec 2023 17:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C52281A5B
	for <lists+linux-block@lfdr.de>; Mon, 11 Dec 2023 16:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9100648CEB;
	Mon, 11 Dec 2023 16:54:50 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF4CC7
	for <linux-block@vger.kernel.org>; Mon, 11 Dec 2023 08:54:48 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id D9C1368B05; Mon, 11 Dec 2023 17:54:44 +0100 (CET)
Date: Mon, 11 Dec 2023 17:54:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 1/3] block/mq-deadline: Use dd_rq_ioclass() instead of
 open-coding it
Message-ID: <20231211165444.GA26039@lst.de>
References: <20231205053213.522772-1-bvanassche@acm.org> <20231205053213.522772-2-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205053213.522772-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

