Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A3C249192
	for <lists+linux-block@lfdr.de>; Wed, 19 Aug 2020 01:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgHRXws (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 18 Aug 2020 19:52:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31558 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726847AbgHRXwo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 19:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597794762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=12ZjQO3Axk/8sMfzhnyHEKArwKJhI19Sv/UUSIBdQRU=;
        b=UAAdI+GB83OQZ2NvJGN12yhfuQR2rF1CsbIzC+vGVVZ2yZhQiArKCnOjpu+STgaX/qsHXq
        MUS9C5FS07AYhwcVx49AAEsGYJYxXxKUR3DaTtfsYQqG/ZGpCrXmaxTRzV99N0MFaLCeE2
        zBsRvTjsy6zrKrckVNtVG6RsH2wiGoo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-9srHYHzvPpybmrWNBh91cg-1; Tue, 18 Aug 2020 19:52:38 -0400
X-MC-Unique: 9srHYHzvPpybmrWNBh91cg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A98E41005E65;
        Tue, 18 Aug 2020 23:52:37 +0000 (UTC)
Received: from T590 (ovpn-12-56.pek2.redhat.com [10.72.12.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E0F3D39A75;
        Tue, 18 Aug 2020 23:52:24 +0000 (UTC)
Date:   Wed, 19 Aug 2020 07:52:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>, dm-devel@redhat.com
Subject: Re: [PATCH RESEND] blk-mq: insert request not through ->queue_rq
 into sw/scheduler queue
Message-ID: <20200818235220.GA2712797@T590>
References: <20200818090728.2696802-1-ming.lei@redhat.com>
 <92162ee6-0fa0-dafd-69b1-af285ee61044@kernel.dk>
 <20200818152022.GB6842@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818152022.GB6842@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 18, 2020 at 11:20:22AM -0400, Mike Snitzer wrote:
> On Tue, Aug 18 2020 at 10:50am -0400,
> Jens Axboe <axboe@kernel.dk> wrote:
> 
> > On 8/18/20 2:07 AM, Ming Lei wrote:
> > > c616cbee97ae ("blk-mq: punt failed direct issue to dispatch list") supposed
> > > to add request which has been through ->queue_rq() to the hw queue dispatch
> > > list, however it adds request running out of budget or driver tag to hw queue
> > > too. This way basically bypasses request merge, and causes too many request
> > > dispatched to LLD, and system% is unnecessary increased.
> > > 
> > > Fixes this issue by adding request not through ->queue_rq into sw/scheduler
> > > queue, and this way is safe because no ->queue_rq is called on this request
> > > yet.
> > > 
> > > High %system can be observed on Azure storvsc device, and even soft lock
> > > is observed. This patch reduces %system during heavy sequential IO,
> > > meantime decreases soft lockup risk.
> > 
> > Applied, thanks Ming.
> 
> Hmm, strikes me as strange that this is occurring given the direct
> insertion into blk-mq queue (bypassing scheduler) is meant to avoid 2
> layers of IO merging when dm-mulipath is stacked on blk-mq path(s).  The
> dm-mpath IO scheduler does all merging and underlying paths' blk-mq
> request_queues are meant to just dispatch the top-level's requests.
> 
> So this change concerns me.  Feels like this design has broken down.
> 

'bypass_insert' is 'true' when blk_insert_cloned_request() is
called from device mapper code, so this patch doesn't affect dm.

> Could be that some other entry point was added for the
> __blk_mq_try_issue_directly() code?  And it needs to be untangled away
> from the dm-multipath use-case?

__blk_mq_try_issue_directly() can be called from blk-mq directly, that
is the case this patch is addressing, if one request can't be queued to
LLD because of running out of budget or driver tag, it should be added to
scheduler queue for improving io merge, meantime we can avoid too many
requests dispatched to hardware.


Thanks,
Ming

