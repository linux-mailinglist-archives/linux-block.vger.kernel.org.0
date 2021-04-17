Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334B6362CF2
	for <lists+linux-block@lfdr.de>; Sat, 17 Apr 2021 04:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhDQCj6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 16 Apr 2021 22:39:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231997AbhDQCj6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 22:39:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA8A161003;
        Sat, 17 Apr 2021 02:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618627172;
        bh=pSDKr/liJyVbO63YqO2P1N7S8zwfLxAGDsxPHIyOWNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jNEBNTAwlPifNx9srHY82kEe1rEG5u2s3TDCy2+kZ0ghCMaJzK4lLDBc7ZuOVuxk1
         tWH7XBIDUk80UmK5Ae3t7JFHwSCGFoAWWIPEDJWBXdtRXY3LgLacyA7Q2QKWD/UIIJ
         B04WXlt44f8TTrbZ57y1rdYxhhfusbSDIYHTqvGwusqC58ScbhbRW/0DOJOzuhFwHe
         rHVYHbSnOBIom0Qrw4YFSLDIdxjVSBXKFqHpvyTKwLmYkKMxfKjRMQCR5PSQk/JOvR
         /cSbfg10aJ1z5S0Tfb83OYPxGanri3VTxGHgtVg5ivWd8vCSMg17pgHIt4WeehIrlI
         heeGrWqrmaJIg==
Date:   Sat, 17 Apr 2021 11:39:29 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Casey Chen <cachen@purestorage.com>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, sagi@grimberg.me,
        yzhong@purestorage.com
Subject: Re: [PATCH 2/2] nvme: use return value from blk_execute_rq()
Message-ID: <20210417023929.GD32082@redsun51.ssa.fujisawa.hgst.com>
References: <CALCePG0y1REA8xXX1ymTwAZhrbSyUh41zfpOmFQViuyPGf5ePg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCePG0y1REA8xXX1ymTwAZhrbSyUh41zfpOmFQViuyPGf5ePg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 16, 2021 at 07:04:34PM -0700, Casey Chen wrote:
> > On Fri, Apr 16, 2021 at 10:12:11AM -0700, Yuanyuan Zhong wrote:
> > > >         if (poll)
> > > >                 nvme_execute_rq_polled(req->q, NULL, req, at_head);
> > > You may need to audit other completion handlers for blk_execute_rq_nowait().
> >
> > Why? Those callers already provide their own callback that directly get
> > the error.
> 
> We should make sure all callbacks provided to blk_execute_rq_nowait()
> carry error back. i.e. by reusing rq->end_io_data.
>
> > > How to get error ret from polled rq?
> >
> > Please see nvme_end_sync_rq() for that driver's polled handler callback.
> > It already has the error.
> 
> nvme_end_sync_rq() currently doesn't store error in rq->end_io_data as
> you proposed in patch 1.

The question was how the error gets back to the caller, and they already
have it.

Patch 1 is specific to the sync execution. All the async users' handling
of the provided error are implementation specific. If they're not using
it correctly, then they can be fixed too.
