Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460ED1D87C0
	for <lists+linux-block@lfdr.de>; Mon, 18 May 2020 21:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgERS7t (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 18 May 2020 14:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbgERS7k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 14:59:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9421FC061A0C
        for <linux-block@vger.kernel.org>; Mon, 18 May 2020 11:59:40 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jakz6-0002L7-67; Mon, 18 May 2020 20:59:32 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 9E621100606; Mon, 18 May 2020 20:59:31 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 5/9] blk-mq: don't set data->ctx and data->hctx in blk_mq_alloc_request_hctx
In-Reply-To: <20200518184543.GA26157@lst.de>
References: <20200518093155.GB35380@T590> <87imgty15d.fsf@nanos.tec.linutronix.de> <20200518115454.GA46364@T590> <20200518131634.GA645@lst.de> <20200518141107.GA50374@T590> <20200518165619.GA17465@lst.de> <87o8qlw0kz.fsf@nanos.tec.linutronix.de> <20200518184543.GA26157@lst.de>
Date:   Mon, 18 May 2020 20:59:31 +0200
Message-ID: <87eerhvzl8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:
> On Mon, May 18, 2020 at 08:38:04PM +0200, Thomas Gleixner wrote:
>> > Shouldn't all the per-cpu kthreads also stop as part of the offlining?
>> > If they don't quiesce before the new blk-mq stop state I think we need
>> > to make sure they do.  It is rather pointless to quiesce the requests
>> > if a thread that can submit I/O is still live.
>> 
>> Which kthreads are you talking about?
>
> I think PF_KTHREAD threads bound to single cpu will usually be
> workqueues, yes.
>
>> Workqueues? CPU bound workqueues are shut down in
>> CPUHP_AP_WORKQUEUE_ONLINE state.
>
> That's what I mean.  If we shut down I/O before that happend we'd have
> a problem, but as I expected your state machine is smarter than that :)

It would have been a problem with the old notifier mess to actually
figure out what runs when. But with the explicit states it should be
pretty easy to find a spot which meets your requirements :)

Thanks,

        tglx
