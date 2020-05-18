Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23AC1D7984
	for <lists+linux-block@lfdr.de>; Mon, 18 May 2020 15:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgERNSt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 18 May 2020 09:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgERNSt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 09:18:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7483BC061A0C
        for <linux-block@vger.kernel.org>; Mon, 18 May 2020 06:18:49 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jaffA-0001wR-Jv; Mon, 18 May 2020 15:18:36 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 0378E100606; Mon, 18 May 2020 15:18:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 5/9] blk-mq: don't set data->ctx and data->hctx in blk_mq_alloc_request_hctx
In-Reply-To: <20200518115454.GA46364@T590>
References: <20200518093155.GB35380@T590> <87imgty15d.fsf@nanos.tec.linutronix.de> <20200518115454.GA46364@T590>
Date:   Mon, 18 May 2020 15:18:35 +0200
Message-ID: <877dx9xtxw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ming Lei <ming.lei@redhat.com> writes:
> On Mon, May 18, 2020 at 12:42:54PM +0200, Thomas Gleixner wrote:
>> Ming Lei <ming.lei@redhat.com> writes:
>> > If request is allocated from one cpu which is going to offline, we can't
>> > handle that easily.
>> 
>> That's a pretty handwavy explanation and does not give any reason why
>> this needs to be a smp function call and cannot be solved otherwise,
>> e.g. by delegating this to a work queue.
>
> I guess I misunderstood your point, sorry for that.
>
> The requirement is just that the request needs to be allocated on one online
> CPU after INACTIVE is set, and we can use a workqueue to do that.

That'd be great.

>> >> be problematic vs. RT. Same applies to the explicit preempt_disable() in
>> >> patch 7.
>> >
>> > I think it is true and the reason is same too, but the period is quite short,
>> > and it is just taken for iterating several bitmaps for finding one free bit.
>> 
>> And takes spinlocks along the way.... See:
>> 
>>   https://www.kernel.org/doc/html/latest/locking/locktypes.html
>> 
>> for a full explanation why this can't work on RT. And that's the same
>> reason why the smp function call will fall apart on a RT enabled kernel.
>
> We do want to avoid the cost of any lock, because it is in the fast IO path.
>
> Looks preempt_disable in patch 7 can't be avoided.

Well are you concerned about preemption or do you just need to make sure
that the task can't be migrated?

Thanks,

        tglx
