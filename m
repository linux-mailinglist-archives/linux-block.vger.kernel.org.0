Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802841EB89B
	for <lists+linux-block@lfdr.de>; Tue,  2 Jun 2020 11:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgFBJck (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Jun 2020 05:32:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51481 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726160AbgFBJcj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Jun 2020 05:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591090358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TFWjKIMdFdJZWGgZdtocEHHPeEjsTXlm/AnSis5pGbA=;
        b=cPojZ8o6cpyPgYj4MFHF5p+GGRP56XTQwk/p7iYi+vhhrjDOSVbqkEoSQBosFfxmjS95wr
        xUu8mMALb/wbDceneSVDHI3tcZwxdWVuV1XPSohly1JdvtIht/MrM7u2P98u/gnQs3Ss1W
        TzJUXsq+0ZcpMs6xhUyn+se080oO1eE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-Jo54iAL-PR2_3KygAnGMcQ-1; Tue, 02 Jun 2020 05:32:36 -0400
X-MC-Unique: Jo54iAL-PR2_3KygAnGMcQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC5D8801504;
        Tue,  2 Jun 2020 09:32:34 +0000 (UTC)
Received: from T590 (ovpn-12-167.pek2.redhat.com [10.72.12.167])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 844515D9CC;
        Tue,  2 Jun 2020 09:32:25 +0000 (UTC)
Date:   Tue, 2 Jun 2020 17:32:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH V4 2/6] blk-mq: pass hctx to blk_mq_dispatch_rq_list
Message-ID: <20200602093220.GE1384911@T590>
References: <20200602091502.1822499-1-ming.lei@redhat.com>
 <20200602091502.1822499-3-ming.lei@redhat.com>
 <CY4PR04MB37517114D6BD53D212D8F0B2E78B0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR04MB37517114D6BD53D212D8F0B2E78B0@CY4PR04MB3751.namprd04.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 02, 2020 at 09:25:01AM +0000, Damien Le Moal wrote:
> On 2020/06/02 18:15, Ming Lei wrote:
> > All requests in the 'list' of blk_mq_dispatch_rq_list belong to same
> > hctx, so it is better to pass hctx instead of request queue, because
> > blk-mq's dispatch target is hctx instead of request queue.
> > 
> > Cc: Sagi Grimberg <sagi@grimberg.me>
> > Cc: Baolin Wang <baolin.wang7@gmail.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> > Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > Tested-by: Baolin Wang <baolin.wang7@gmail.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq-sched.c | 14 ++++++--------
> >  block/blk-mq.c       |  6 +++---
> >  block/blk-mq.h       |  2 +-
> >  3 files changed, 10 insertions(+), 12 deletions(-)
> > 
> > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > index a31e281e9d31..632c6f8b63f7 100644
> > --- a/block/blk-mq-sched.c
> > +++ b/block/blk-mq-sched.c
> > @@ -96,10 +96,9 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> >  	struct elevator_queue *e = q->elevator;
> >  	LIST_HEAD(rq_list);
> >  	int ret = 0;
> > +	struct request *rq;
> >  
> >  	do {
> > -		struct request *rq;
> > -
> >  		if (e->type->ops.has_work && !e->type->ops.has_work(hctx))
> >  			break;
> >  
> > @@ -131,7 +130,7 @@ static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> >  		 * in blk_mq_dispatch_rq_list().
> >  		 */
> >  		list_add(&rq->queuelist, &rq_list);
> > -	} while (blk_mq_dispatch_rq_list(q, &rq_list, true));
> > +	} while (blk_mq_dispatch_rq_list(rq->mq_hctx, &rq_list, true));
> 
> Why not use the hctx argument passed to the function instead of rq->mq_hctx ?

e->type->ops.dispatch_request(hctx) may return one request which's
.mq_hctx isn't same with the 'hctx' argument, so far bfq and deadline
may do that.


Thanks,
Ming

