Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABFD110637
	for <lists+linux-block@lfdr.de>; Tue,  3 Dec 2019 22:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfLCVAU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 3 Dec 2019 16:00:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727244AbfLCVAT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 3 Dec 2019 16:00:19 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4948820661;
        Tue,  3 Dec 2019 21:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575406819;
        bh=gUysKusgzrFNmv+/8bGhsRzSuomY46abKCaaMeiovoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HFZAGB273MaQvRnX9KzBLfl6Bydel/BD5QAwWyH+xkDVzLB/D443T0bLL3rhGXBpK
         ENbr7tNsMiwdo0PDs/ukfATW6Ucg6yKSNXYk3GSeTjpJPe8pl9HtLW4SPiH2MySWvG
         DTcy4q5SGQd+KnEGOUCWOXLnf4imb8r5fVJl0a+g=
Date:   Wed, 4 Dec 2019 06:00:15 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     "Meneghini, John" <John.Meneghini@netapp.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Jen Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Knight, Frederick" <Frederick.Knight@netapp.com>
Subject: Re: [PATCH V2] nvme: Add support for ACRE Command Interrupted status
Message-ID: <20191203210015.GA2691@redsun51.ssa.fujisawa.hgst.com>
References: <8D7B5AD6-F195-4E80-8F24-9B42DE68F664@netapp.com>
 <24E2530B-B88E-43E7-AFA2-4FDA417B6C1E@netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24E2530B-B88E-43E7-AFA2-4FDA417B6C1E@netapp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 03, 2019 at 05:38:04PM +0000, Meneghini, John wrote:
> This is an update to say that I've tested this patch and it works as expected. 
> 
> When the controller returns a Command Interrupted status the request is avoids nvme_failover_req()
> and goes down the nvme_retry_req() path where the CRD is implemented and the command is 
> retried after a delay.
> 
> If the controllers returns Command Interrupted too many times, and nvme_req(req)->retries
> runs down, this results in a device resource error returned to the block layer.  But I think we'll
> have this problem with any error.  

Why is the controller returning the same error so many times? Are we
not waiting the requested delay timed? If so, the controller told us
retrying should be successful.

It is possible we kick the requeue list early if one command error
has a valid CRD, but a subsequent retryable command does not. Is that
what's happening?

I'm just concerned because if we just skip counting the retry, a broken
device could have the driver retry the same command indefinitely, which
often leaves a task in an uninterruptible sleep state forever.

>     diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>     index 9696404a6182..24dc9ed1a11b 100644
>     --- a/drivers/nvme/host/core.c
>     +++ b/drivers/nvme/host/core.c
>     @@ -230,6 +230,8 @@ static blk_status_t nvme_error_status(u16 status)
>                     return BLK_STS_NEXUS;
>             case NVME_SC_HOST_PATH_ERROR:
>                     return BLK_STS_TRANSPORT;
>     +       case NVME_SC_CMD_INTERRUPTED:
>     +               return BLK_STS_DEV_RESOURCE;

Just for the sake of keeping this change isloted to nvme, perhaps use an
existing blk_status_t value that already maps to not path error, like
BLK_STS_TARGET.
