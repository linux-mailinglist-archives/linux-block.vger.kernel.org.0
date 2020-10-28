Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A76C29E19B
	for <lists+linux-block@lfdr.de>; Thu, 29 Oct 2020 03:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgJ1Vsw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 28 Oct 2020 17:48:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57330 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgJ1VnN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Oct 2020 17:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tjSu2r9Bd9biMwop8Y+5xZtR8qA8hCA/zD7QW3Q6gMw=; b=CgD2LZ1Y5veuIIAid305ik/pa9
        YXiupXv3xMxxpXUTfAwvU+hMTAVV2/HgYkdQbRyLz9K5Nem7UQbJmwNvO3LZbqNWk+RenntYKH0ln
        G2f2QmL58EDN678aOzhm51beGQZBXKhme+/jAIaUz2dKbeWdkbo2zMG91Uj09Z2BpZok6/ZcJTbnG
        rqKR4oINLS8FplmKtv/6T0j+feA87E24fqyA1taK+unANSq1wiRvkRDnQ2vrPQ6ANp1dBHptlJg0N
        Rj67qcm6NlEFuRJZ53tI9Wzpbr8pEoYbfOtLG2FkiJ8iX89BFgWBGR2+qVyd6z6GF+04LBUDLZuNr
        q3JRKBnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXiJa-0003mv-N5; Wed, 28 Oct 2020 10:04:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DCEF9300455;
        Wed, 28 Oct 2020 11:04:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C57CC20B28590; Wed, 28 Oct 2020 11:04:20 +0100 (CET)
Date:   Wed, 28 Oct 2020 11:04:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH RFC] blk-mq: Don't IPI requests on PREEMPT_RT
Message-ID: <20201028100420.GY2628@hirez.programming.kicks-ass.net>
References: <20201021175059.GA4989@hmbx>
 <20201023110400.bx3uzsb7xy5jtsea@linutronix.de>
 <20201023112130.GA23790@infradead.org>
 <20201023135219.mzzl76eqqy6tqwhe@linutronix.de>
 <20201027092606.GA20805@infradead.org>
 <20201027101102.cvczdb3mkvtoguo5@linutronix.de>
 <20201027160742.GA19073@infradead.org>
 <87eelj1tx0.fsf@nanos.tec.linutronix.de>
 <20201027172309.GA15004@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027172309.GA15004@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 27, 2020 at 05:23:09PM +0000, Christoph Hellwig wrote:
> Ok.  I was hoping we could hide this in core code somehow, especially
> a peterz didn't like the use of smp_call_function_single_async in the
> blk-mq completion code very much.

It's smp_call_function_single_async() in general that I don't much like.
But Linus seemed unconvinced, so we'll keep it for a while I suppose.
