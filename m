Return-Path: <linux-block+bounces-1034-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC9B80F44E
	for <lists+linux-block@lfdr.de>; Tue, 12 Dec 2023 18:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7AE1C20930
	for <lists+linux-block@lfdr.de>; Tue, 12 Dec 2023 17:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89B47B3D9;
	Tue, 12 Dec 2023 17:18:53 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF3BB9
	for <linux-block@vger.kernel.org>; Tue, 12 Dec 2023 09:18:50 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3570468AFE; Tue, 12 Dec 2023 18:18:47 +0100 (CET)
Date: Tue, 12 Dec 2023 18:18:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Message-ID: <20231212171846.GA28682@lst.de>
References: <20231205053213.522772-1-bvanassche@acm.org> <20231205053213.522772-4-bvanassche@acm.org> <20231211165720.GC26039@lst.de> <177773fd-c8ed-4822-9344-3058e820ddf0@kernel.org> <20231212154140.GB20933@lst.de> <42054848-2e8d-4856-b404-c042a4365097@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42054848-2e8d-4856-b404-c042a4365097@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 12, 2023 at 09:15:48AM -0800, Bart Van Assche wrote:
> As mentioned before, UFS devices implement the SCSI command set and hence do not
> support write append operations. If anyone else standardizes a write append
> command for SCSI we can ask UFS vendors to implement that command. However, as
> far as I know nobody in T10 is working on standardizing a write append command.

The actual hardware support does not matter, it's the programming model.
Even with the zone append emulation in sd you don't need to care about
reordering due to I/O priorities.

