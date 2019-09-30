Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8329C26A5
	for <lists+linux-block@lfdr.de>; Mon, 30 Sep 2019 22:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbfI3Uim (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 30 Sep 2019 16:38:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731193AbfI3Uim (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 16:38:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB3933082231;
        Mon, 30 Sep 2019 20:13:25 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 18B5A60F80;
        Mon, 30 Sep 2019 20:13:25 +0000 (UTC)
Date:   Mon, 30 Sep 2019 16:13:24 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 1/1] blk-mq: Inline request status checkers
Message-ID: <20190930201324.GA19526@redhat.com>
References: <1cd320dad54bd78cb6721f7fe8dd2e197b9fbfa2.1569830796.git.asml.silence@gmail.com>
 <e6fc239412811140c83de906b75689530661f65d.1569872122.git.asml.silence@gmail.com>
 <e4d452ad-da24-a1a9-7e2d-f9cd5d0733da@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4d452ad-da24-a1a9-7e2d-f9cd5d0733da@acm.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 30 Sep 2019 20:13:25 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 30 2019 at  3:53pm -0400,
Bart Van Assche <bvanassche@acm.org> wrote:

> On 9/30/19 12:43 PM, Pavel Begunkov (Silence) wrote:
> > @@ -282,7 +282,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
> >  	 * test and set the bit before assining ->rqs[].
> >  	 */
> >  	rq = tags->rqs[bitnr];
> > -	if (rq && blk_mq_request_started(rq))
> > +	if (rq && blk_mq_rq_state(rq) != MQ_RQ_IDLE)
> >  		return iter_data->fn(rq, iter_data->data, reserved);
> >  
> >  	return true>
> > @@ -360,7 +360,7 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
> >  {
> >  	unsigned *count = data;
> >  
> > -	if (blk_mq_request_completed(rq))
> > +	if (blk_mq_rq_state(rq) == MQ_RQ_COMPLETE)
> >  		(*count)++;
> >  	return true;
> >  }
> 
> Changes like the above significantly reduce readability of the code in
> the block layer core. I don't like this. I think this patch is a step
> backwards instead of a step forwards.

I agree, not helpful.
