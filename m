Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916CD39EE1B
	for <lists+linux-block@lfdr.de>; Tue,  8 Jun 2021 07:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhFHF2e (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 8 Jun 2021 01:28:34 -0400
Received: from verein.lst.de ([213.95.11.211]:49151 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230160AbhFHF2e (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jun 2021 01:28:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EC1E267373; Tue,  8 Jun 2021 07:26:39 +0200 (CEST)
Date:   Tue, 8 Jun 2021 07:26:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Kanchan Joshi <joshiiitr@gmail.com>,
        linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCHv3 2/4] nvme: use blk_execute_rq() for passthrough
 commands
Message-ID: <20210608052639.GC13828@lst.de>
References: <20210521202145.3674904-1-kbusch@kernel.org> <20210521202145.3674904-3-kbusch@kernel.org> <CA+1E3rJM3sGLsOuPbYVH6kaTR8S9ogfe+wryuyWpqnA-pgDsEw@mail.gmail.com> <20210607161512.GB21631@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607161512.GB21631@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 08, 2021 at 01:15:12AM +0900, Keith Busch wrote:
> > The new code doesn't retain this flag.
> > Looks good otherwise.
> 
> The flag is only used to select an apporpriate hctx. We've explicitly
> selected a polling hctx in this path already, so the flag is
> unnecessary.

I think setting the flag would still be useful, if only to prevent issues
with new callers and/or better document what we are doing.
