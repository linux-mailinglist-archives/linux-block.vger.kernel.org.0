Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAE710499D
	for <lists+linux-block@lfdr.de>; Thu, 21 Nov 2019 05:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfKUEMl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 20 Nov 2019 23:12:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60145 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726358AbfKUEMk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Nov 2019 23:12:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574309559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CZUIqBMR6wLsrB1pzvMspDtsS2uxJ9Z3B895d3xxyhE=;
        b=A0awJzPuCi29v5Gk4mNRffgYUpux1f9ynGRO6No2m8fKzxAlOkTBadHFsQa4QjUwPe2hLt
        P/OcHGqT6ysCynV2VQZteh3+iP4qFh7yLbkpXkIO8DT/nMoGiM0y20x7g2UqGZe/CXPecF
        69qpyagtonT2qCo/BjymdXLKqsr99mc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-GjDFkWbaOa24NTmzCEj4lg-1; Wed, 20 Nov 2019 23:12:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD8ED107ACC4;
        Thu, 21 Nov 2019 04:12:34 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 131516CE4D;
        Thu, 21 Nov 2019 04:12:22 +0000 (UTC)
Date:   Thu, 21 Nov 2019 12:12:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: single aio thread is migrated crazily by scheduler
Message-ID: <20191121041218.GK24548@ming.t460p>
References: <20191114113153.GB4213@ming.t460p>
 <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
 <20191115234005.GO4614@dread.disaster.area>
 <20191118092121.GV4131@hirez.programming.kicks-ass.net>
 <20191118204054.GV4614@dread.disaster.area>
 <20191120191636.GI4097@hirez.programming.kicks-ass.net>
 <20191120220313.GC18056@pauld.bos.csb>
MIME-Version: 1.0
In-Reply-To: <20191120220313.GC18056@pauld.bos.csb>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: GjDFkWbaOa24NTmzCEj4lg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 20, 2019 at 05:03:13PM -0500, Phil Auld wrote:
> Hi Peter,
>=20
> On Wed, Nov 20, 2019 at 08:16:36PM +0100 Peter Zijlstra wrote:
> > On Tue, Nov 19, 2019 at 07:40:54AM +1100, Dave Chinner wrote:
> > > On Mon, Nov 18, 2019 at 10:21:21AM +0100, Peter Zijlstra wrote:
> >=20
> > > > We typically only fall back to the active balancer when there is
> > > > (persistent) imbalance and we fail to migrate anything else (of
> > > > substance).
> > > >=20
> > > > The tuning mentioned has the effect of less frequent scheduling, IO=
W,
> > > > leaving (short) tasks on the runqueue longer. This obviously means =
the
> > > > load-balancer will have a bigger chance of seeing them.
> > > >=20
> > > > Now; it's been a while since I looked at the workqueue code but one
> > > > possible explanation would be if the kworker that picks up the work=
 item
> > > > is pinned. That would make it runnable but not migratable, the exac=
t
> > > > situation in which we'll end up shooting the current task with acti=
ve
> > > > balance.
> > >=20
> > > Yes, that's precisely the problem - work is queued, by default, on a
> > > specific CPU and it will wait for a kworker that is pinned to that
> >=20
> > I'm thinking the problem is that it doesn't wait. If it went and waited
> > for it, active balance wouldn't be needed, that only works on active
> > tasks.
>=20
> Since this is AIO I wonder if it should queue_work on a nearby cpu by=20
> default instead of unbound. =20

When the current CPU isn't busy enough, there is still cost for completing
request remotely.

Or could we change queue_work() in the following way?

 * We try to queue the work to the CPU on which it was submitted, but if th=
e
 * CPU dies or is saturated enough it can be processed by another CPU.

Can we decide in a simple or efficient way if the current CPU is saturated
enough?

Thanks,
Ming

