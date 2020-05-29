Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CD91E89B7
	for <lists+linux-block@lfdr.de>; Fri, 29 May 2020 23:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgE2VMp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 29 May 2020 17:12:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728040AbgE2VMp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 17:12:45 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16E24206A4;
        Fri, 29 May 2020 21:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590786764;
        bh=O6cQO5tlO36gsHjj1jLNoFC04gY2apWmhvaGhlMaXd0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZvcT9Y/WNAMnfrUmU/Kfg1oTNlvf0Rqu77+5g4B273ssf0F3fhvJtgaOEtltpsTeh
         hLLMCGr7Xp1XRKwpIv759+2c2h0pttmmfYAeW7K7T9St/ZSBV9gBHUM22X7djMmfV+
         zTGnxTujmn+ivQQFpbdziNO9CvhpawKBZPKf3y5M=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 00AFC3522A6E; Fri, 29 May 2020 14:12:43 -0700 (PDT)
Date:   Fri, 29 May 2020 14:12:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] blk-mq: drain I/O when all CPUs in a hctx are offline
Message-ID: <20200529211243.GG2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200528014601.GC933147@T590>
 <1ec7922c-f2b0-08ec-5849-f4eb7f71e9e7@acm.org>
 <20200528051932.GA1008129@T590>
 <4fb6f0cf-a356-833e-25ab-47f9131c729b@acm.org>
 <20200528172121.GN2869@paulmck-ThinkPad-P72>
 <20200529015304.GC1075489@T590>
 <20200529030728.GW2869@paulmck-ThinkPad-P72>
 <20200529035315.GD1075489@T590>
 <20200529181352.GF2869@paulmck-ThinkPad-P72>
 <00b74229-f943-fb4b-ade4-3f4511c33146@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b74229-f943-fb4b-ade4-3f4511c33146@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 29, 2020 at 12:55:43PM -0700, Bart Van Assche wrote:
> On 2020-05-29 11:13, Paul E. McKenney wrote:
> > On Fri, May 29, 2020 at 11:53:15AM +0800, Ming Lei wrote:
> >> Another pair is in blk_mq_get_tag(), and we expect the following two
> >> memory OPs are ordered:
> >>
> >> 1) set bit in successful test_and_set_bit_lock(), which is called
> >> from sbitmap_get()
> >>
> >> 2) test_bit(BLK_MQ_S_INACTIVE, &data->hctx->state)
> >>
> >> Do you think that the above two OPs are ordered?
> > 
> > Given that he has been through the code, I would like to hear Bart's
> > thoughts, actually.
> 
> Hi Paul,
> 
> My understanding of the involved instructions is as follows (see also
> https://lore.kernel.org/linux-block/b98f055f-6f38-a47c-965d-b6bcf4f5563f@huawei.com/T/#t
> for the entire e-mail thread):
> * blk_mq_hctx_notify_offline() sets the BLK_MQ_S_INACTIVE bit in
> hctx->state, calls smp_mb__after_atomic() and waits in a loop until all
> tags have been freed. Each tag is an integer number that has a 1:1
> correspondence with a block layer request structure. The code that
> iterates over block layer request tags relies on
> __sbitmap_for_each_set(). That function examines both the 'word' and
> 'cleared' members of struct sbitmap_word.
> * What blk_mq_hctx_notify_offline() waits for is freeing of tags by
> blk_mq_put_tag(). blk_mq_put_tag() frees a tag by setting a bit in
> sbitmap_word.cleared (see also sbitmap_deferred_clear_bit()).
> * Tag allocation by blk_mq_get_tag() relies on test_and_set_bit_lock().
> The actual allocation happens by sbitmap_get() that sets a bit in
> sbitmap_word.word. blk_mg_get_tag() tests the BLK_MQ_S_INACTIVE bit
> after tag allocation succeeded.
> 
> What confuses me is that blk_mq_hctx_notify_offline() uses
> smp_mb__after_atomic() to enforce the order of memory accesses while
> blk_mq_get_tag() relies on the acquire semantics of
> test_and_set_bit_lock(). Usually ordering is enforced by combining two
> smp_mb() calls or by combining a store-release with a load-acquire.
> 
> Does the Linux memory model provide the expected ordering guarantees
> when combining load-acquire with smp_mb__after_atomic() as used in patch
> 8/8 of this series?

Strictly speaking, smp_mb__after_atomic() works only in combination
with a non-value-returning atomic operation. Let's look at a (silly)
example where smp_mb__after_atomic() would not help in conjunction
with smp_store_release():

void thread1(void)
{
	smp_store_release(&x, 1);
	smp_mb__after_atomic();
	r1 = READ_ONCE(y);
}

void thread2(void)
{
	smp_store_release(&y, 1);
	smp_mb__after_atomic();
	r2 = READ_ONCE(x);
}

Even on x86 (or perhaps especially on x86) it is quite possible that
execution could end with r1 == r2 == 0 because on x86 there is no
ordering whatsoever from smp_mb__after_atomic().  In this case,
the CPU is well within its rights to reorder each thread's store
with its later load.  Yes, even x86.

On the other hand, suppose that the stores are non-value-returning
atomics:

void thread1(void)
{
	atomic_inc(&x);
	smp_mb__after_atomic();
	r1 = READ_ONCE(y);
}

void thread2(void)
{
	atomic_inc(&y);
	smp_mb__after_atomic();
	r2 = READ_ONCE(x);
}

In this case, for all architectures, there would be the equivalent
of an smp_mb() full barrier associated with either the atomic_inc()
or the smp_mb__after_atomic(), which would rule out the case where
execution ends with r1 == r2 == 0.

Does that help?

							Thanx, Paul
