Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653E036D99B
	for <lists+linux-block@lfdr.de>; Wed, 28 Apr 2021 16:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbhD1ObJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 28 Apr 2021 10:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57476 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234075AbhD1ObI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 10:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619620223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UnjY68Lbp98u7Ut/sgDdv+wbwkjz0iBwPJ5omp0Ic+Y=;
        b=B/jPgsNOmDFxeuFZ1dNobrIpRZ3ixkP2t82HNJJ9tltkN2ztvliaBVwAwRZ9+61d/rU6kK
        2elqFGAZIB31FtUQHSBc65pnW3waTr5Du9CmITKvu6ltwm6uMhv8wMaU4s96lpkWSLY4aS
        fjEKSOAUy36l6KAYxpAIdde/0rvHiyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-H-M_CUqnNRev3HAR0FpSDA-1; Wed, 28 Apr 2021 10:30:21 -0400
X-MC-Unique: H-M_CUqnNRev3HAR0FpSDA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31AA0107ACF9;
        Wed, 28 Apr 2021 14:30:20 +0000 (UTC)
Received: from redhat (ovpn-117-200.rdu2.redhat.com [10.10.117.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DE0610016FC;
        Wed, 28 Apr 2021 14:30:15 +0000 (UTC)
Date:   Wed, 28 Apr 2021 10:30:13 -0400
From:   David Jeffery <djeffery@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH V3 3/3] blk-mq: clear stale request in tags->rq[] before
 freeing one request pool
Message-ID: <20210428143013.GA31155@redhat>
References: <20210427151058.2833168-1-ming.lei@redhat.com>
 <20210427151058.2833168-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427151058.2833168-4-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 27, 2021 at 11:10:58PM +0800, Ming Lei wrote:
> 
> refcount_inc_not_zero() in bt_tags_iter() still may read one freed
> request.
> 
> Fix the issue by the following approach:
> 
> 1) hold a per-tags spinlock when reading ->rqs[tag] and calling
> refcount_inc_not_zero in bt_tags_iter()
> 

This method of closing the race still in my original patch is very nice.
It's a great improvement.

> 2) clearing stale request referred via ->rqs[tag] before freeing
> request pool, the per-tags spinlock is held for clearing stale
> ->rq[tag]
> 
> So after we cleared stale requests, bt_tags_iter() won't observe
> freed request any more, also the clearing will wait for pending
> request reference.
> 
> The idea of clearing ->rqs[] is borrowed from John Garry's previous
> patch and one recent David's patch.
>

However, when you took my original cmpxchg patch and merged my separate
function to do the cmpxchg cleaning into blk_mq_clear_rq_mapping, you
missed why it was a separate function.  Your patch will clean out the
static_rqs requests which are being freed, but it doesn't clean out the
special flush request that gets allocated individually by a
request_queue.  The flush request can be put directly into the rqs[]
array so it also needs to be cleaned when a request_queue is being
torn down.  This was the second caller of my separated cleaning function.

With that portion of my original patch removed, a stale pointer to a
freed flush request can still remain after a request_queue is released.

David Jeffery

