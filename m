Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E5E1C6574
	for <lists+linux-block@lfdr.de>; Wed,  6 May 2020 03:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgEFBYo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 5 May 2020 21:24:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48612 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729457AbgEFBYn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 May 2020 21:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588728282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tt4i4Nh4xWPSAsQ3lja/irt2LqFsTaeYy4zp5iGG8yk=;
        b=DeEFxxGc+8HDQXdCE1RkRQJLinkXTQE5SB23tlCzMDw0+9DAPxuX3ZnqbILgtA84LYxAGd
        pqlrz6FjQ52bnQHKWjbdyQ1zMXaeEfSnLvWiu5fuCilG8CjF/fZHBJQYhcsigLMjLOV3q5
        qrG8nw3xBoD24cid5dCkSnfzuXth9rQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-285rhgcbONKCUKzQNhiBeg-1; Tue, 05 May 2020 21:24:40 -0400
X-MC-Unique: 285rhgcbONKCUKzQNhiBeg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38CA5800687;
        Wed,  6 May 2020 01:24:39 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CAD8264431;
        Wed,  6 May 2020 01:24:30 +0000 (UTC)
Date:   Wed, 6 May 2020 09:24:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org
Subject: Re: [PATCH V8 07/11] blk-mq: stop to handle IO and drain IO before
 hctx becomes inactive
Message-ID: <20200506012425.GA1177270@T590>
References: <20200429021612.GD671522@T590>
 <20200429080728.GB29143@willie-the-truck>
 <20200429094616.GB700644@T590>
 <20200429122757.GA30247@willie-the-truck>
 <20200429134327.GC700644@T590>
 <20200429173400.GC30247@willie-the-truck>
 <20200430003945.GA719313@T590>
 <20200430110429.GI19932@willie-the-truck>
 <20200430140254.GA996887@T590>
 <20200505154618.GA3644@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505154618.GA3644@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 05, 2020 at 05:46:18PM +0200, Christoph Hellwig wrote:
> On Thu, Apr 30, 2020 at 10:02:54PM +0800, Ming Lei wrote:
> > BLK_MQ_S_INACTIVE is only set when the last cpu of this hctx is becoming
> > offline, and blk_mq_hctx_notify_offline() is called from cpu hotplug
> > handler. So if there is any request of this hctx submitted from somewhere,
> > it has to this last cpu. That is done by blk-mq's queue mapping.
> > 
> > In case of direct issue, basically blk_mq_get_driver_tag() is run after
> > the request is allocated, that is why I mentioned the chance of
> > migration is very small.
> 
> "very small" does not cut it, it has to be zero.  And it seems the
> new version still has this hack.

But smp_mb() is used for ordering the WRITE and READ, so it is correct.

barrier() is enough when process migration doesn't happen.

thank, 
Ming

