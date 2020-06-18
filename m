Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016611FF129
	for <lists+linux-block@lfdr.de>; Thu, 18 Jun 2020 14:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgFRMFH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 Jun 2020 08:05:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:38294 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726919AbgFRMFG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 08:05:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3EC96AD76;
        Thu, 18 Jun 2020 12:05:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 81A891E12A6; Thu, 18 Jun 2020 14:05:05 +0200 (CEST)
Date:   Thu, 18 Jun 2020 14:05:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH] blktrace: Provide event for request merging
Message-ID: <20200618120505.GB9664@quack2.suse.cz>
References: <20200617135823.980-1-jack@suse.cz>
 <20200618065359.GA24943@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618065359.GA24943@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 17-06-20 23:53:59, Christoph Hellwig wrote:
> On Wed, Jun 17, 2020 at 03:58:23PM +0200, Jan Kara wrote:
> >  	blk_account_io_merge_request(next);
> >  
> > +	trace_block_rq_merge(q, next);
> 
> q can be derived from next, no need to explicitly pass it.  And yes,
> I know a lot of existing tracepoints do so, but I plan to fix that up
> as well.

OK, I'll update the patch.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
