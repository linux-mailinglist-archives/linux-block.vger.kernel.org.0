Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D764140D421
	for <lists+linux-block@lfdr.de>; Thu, 16 Sep 2021 09:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbhIPHzA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 Sep 2021 03:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234767AbhIPHzA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Sep 2021 03:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631778820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UbyhDf28XmyZ8Ks2SzbXEg6Z9yAKC+TTkrGxzB0H0wU=;
        b=coBjVGQLpDklQitWsPXAdGuUQK3Pt09VZ9GY3bQo3BD9sh7FW6DcrkDBAScwfFisHgNEMi
        i037PfIYz0n7KIhcNU8J2dENlkdy3GgTndreIUWYB7ZMbbMMBZcZS5rrjyZ8GGb1HWQTRO
        VLanfrQld1AZ8yIqKi8V8vhTkM7uXjk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-Qq4bf--nM5Gas6cLynZZHQ-1; Thu, 16 Sep 2021 03:53:39 -0400
X-MC-Unique: Qq4bf--nM5Gas6cLynZZHQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74734802C8F;
        Thu, 16 Sep 2021 07:53:37 +0000 (UTC)
Received: from T590 (ovpn-12-89.pek2.redhat.com [10.72.12.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08A0A838D9;
        Thu, 16 Sep 2021 07:53:06 +0000 (UTC)
Date:   Thu, 16 Sep 2021 15:53:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, hch@infradead.org,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v7 2/6] nbd: make sure request completion won't concurrent
Message-ID: <YUL37uANjYQbG382@T590>
References: <20210915092010.2087371-1-yukuai3@huawei.com>
 <20210915092010.2087371-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915092010.2087371-3-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 15, 2021 at 05:20:06PM +0800, Yu Kuai wrote:
> commit cddce0116058 ("nbd: Aovid double completion of a request")
> try to fix that nbd_clear_que() and recv_work() can complete a
> request concurrently. However, the problem still exists:
> 
> t1                    t2                     t3
> 
> nbd_disconnect_and_put
>  flush_workqueue
>                       recv_work
>                        blk_mq_complete_request
>                         blk_mq_complete_request_remote -> this is true
>                          WRITE_ONCE(rq->state, MQ_RQ_COMPLETE)
>                           blk_mq_raise_softirq
>                                              blk_done_softirq
>                                               blk_complete_reqs
>                                                nbd_complete_rq
>                                                 blk_mq_end_request
>                                                  blk_mq_free_request
>                                                   WRITE_ONCE(rq->state, MQ_RQ_IDLE)
>   nbd_clear_que
>    blk_mq_tagset_busy_iter
>     nbd_clear_req
>                                                    __blk_mq_free_request
>                                                     blk_mq_put_tag
>      blk_mq_complete_request -> complete again
> 
> There are three places where request can be completed in nbd:
> recv_work(), nbd_clear_que() and nbd_xmit_timeout(). Since they
> all hold cmd->lock before completing the request, it's easy to
> avoid the problem by setting and checking a cmd flag.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

