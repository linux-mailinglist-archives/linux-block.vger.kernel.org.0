Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32412741A5
	for <lists+linux-block@lfdr.de>; Tue, 22 Sep 2020 13:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgIVL4g (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Sep 2020 07:56:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32268 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726509AbgIVL4f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 07:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600775794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/JZrYZ81YgVFloXcyhTomUWcDPKMgpRn5ZJV671EDqk=;
        b=dfGuiSheHNl/j58JNLYP1ZwaABmix/uBh1SPyeCAlYCzvW69G4p6yHAjkNOwdE57rhIWZW
        PXRoVdgCXACsvy0/3dDCHKo2j4TlsWiz5915qS6YzxXsJav8DLV20dH9ISrS8eVOwzqQkn
        Zf3nDxIsbGtFb9r1faQ8BWaExzBEsek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-6UXm3_MXPwy2Bw8lZtrUJA-1; Tue, 22 Sep 2020 07:56:32 -0400
X-MC-Unique: 6UXm3_MXPwy2Bw8lZtrUJA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54029802B70;
        Tue, 22 Sep 2020 11:56:31 +0000 (UTC)
Received: from T590 (ovpn-12-168.pek2.redhat.com [10.72.12.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FFFB5C1A3;
        Tue, 22 Sep 2020 11:56:26 +0000 (UTC)
Date:   Tue, 22 Sep 2020 19:56:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [RFC] block: enqueue splitted bios into same cpu
Message-ID: <20200922115622.GA1484750@T590>
References: <20200911032958.125068-1-jefflexu@linux.alibaba.com>
 <20200911110101.GA143560@T590>
 <e787faa8-d31f-04e7-f722-5013a52dc8ab@linux.alibaba.com>
 <20200913140017.GA230984@T590>
 <c709e970-c711-11b7-e897-c66a12be454e@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c709e970-c711-11b7-e897-c66a12be454e@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 22, 2020 at 12:43:37PM +0800, JeffleXu wrote:
> Thanks for replying. Comments embedded below.
> 
> 
> On 9/13/20 10:00 PM, Ming Lei wrote:
> > On Fri, Sep 11, 2020 at 07:40:14PM +0800, JeffleXu wrote:
> > > Thanks for replying ;)
> > > 
> > > 
> > > On 9/11/20 7:01 PM, Ming Lei wrote:
> > > > On Fri, Sep 11, 2020 at 11:29:58AM +0800, Jeffle Xu wrote:
> > > > > Splitted bios of one source bio can be enqueued into different CPU since
> > > > > the submit_bio() routine can be preempted or fall asleep. However this
> > > > > behaviour can't work well with iopolling.
> > > > Do you have user visible problem wrt. io polling? If yes, can you
> > > > provide more details?
> > > No, there's no practical example yet. It's only a hint from the code base.
> > > 
> > > 
> > > > > Currently block iopolling only polls the hardwar queue of the input bio.
> > > > > If one bio is splitted to several bios, one (bio 1) of which is enqueued
> > > > > into CPU A, while the others enqueued into CPU B, then the polling of bio 1
> > > > > will cotinuously poll the hardware queue of CPU A, though the other
> > > > > splitted bios may be in other hardware queues.
> > > > If it is guaranteed that the returned cookie is from bio 1, poll is
> > > > supposed to work as expected, since bio 1 is the chained head of these
> > > > bios, and the whole fs bio can be thought as done when bio1 .end_bio
> > > > is called.
> > > Yes, it is, thanks for your explanation. But except for polling if the input
> > > bio has completed, one of the
> > > 
> > > important work of polling logic is to reap the completion queue. Let's say
> > > one bio is split into
> > > 
> > > two bios, bio 1 and bio 2, both of which are enqueued into the same hardware
> > > queue.When polling bio1,
> > > 
> > > though we have no idea about bio2 at all, the polling logic itself is still
> > > reaping the completion queue of
> > > 
> > > this hardware queue repeatedly, in which case the polling logic still
> > > stimulates reaping bio2.
> > > 
> > > 
> > > Then what if these two split bios enqueued into two different hardware
> > > queue? Let's say bio1 is enqueued
> > > 
> > > into hardware queue A, while bio2 is enqueued into hardware queue B. When
> > > polling bio1, though the polling
> > > 
> > > logic is repeatedly reaping the completion queue of hardware queue A, it
> > > doesn't help reap bio2. bio2 is reaped
> > > 
> > > by IRQ as usual. This certainly works currently, but this behavior may
> > > deviate the polling design? I'm not sure.
> > > 
> > > 
> > > In other words, if we can ensure that all split bios are enqueued into the
> > > same hardware queue, then the polling
> > > 
> > > logic *may* be faster.
> > __submit_bio_noacct_mq() returns cookie from the last bio in current->bio_list, and
> > this bio should be the bio passed to __submit_bio_noacct_mq() when bio splitting happens.
> > 
> > Suppose CPU migration happens during bio splitting, the last bio should be
> > submitted to LLD much late than other bios, so when blk_poll() finds
> > completion on the hw queue of the last bio, usually other bios should
> > be completed already most of times.
> > 
> > Also CPU migration itself causes much bigger latency, so it is reasonable to
> > not expect good IO performance when CPU migration is involved. And CPU migration
> > on IO task shouldn't have been done frequently. That said it should be
> > fine to miss the poll in this situation.
> 
> Yes you're right. After diving into the code of nvme driver, currently nvme
> driver indeed allocate interrupt for polling queues,

No, nvme driver doesn't allocate interrupt for poll queues, please see
nvme_setup_irqs().

> 
> that is, reusing the interrupt used by admin queue.
> 
> Jens had ever said that the interrupt may be disabled for queues working in
> polling mode someday (from my colleague). If
> 
> that is true, then this may become an issue. But at least now this indeed
> works.

What is the issue?


Thanks, 
Ming

