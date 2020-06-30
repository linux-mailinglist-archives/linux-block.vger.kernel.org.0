Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C6B20EF11
	for <lists+linux-block@lfdr.de>; Tue, 30 Jun 2020 09:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbgF3HMC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 30 Jun 2020 03:12:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:41342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730637AbgF3HMC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 03:12:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B5E4FAAC5;
        Tue, 30 Jun 2020 07:12:00 +0000 (UTC)
Date:   Tue, 30 Jun 2020 09:11:59 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v3 16/20] iocost: Use sequence counter with associated
 spinlock
Message-ID: <20200630071159.llgfzs3n4xekexcw@beryllium.lan>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200630054452.3675847-1-a.darwish@linutronix.de>
 <20200630054452.3675847-17-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630054452.3675847-17-a.darwish@linutronix.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 30, 2020 at 07:44:48AM +0200, Ahmed S. Darwish wrote:
> A sequence counter write side critical section must be protected by some
> form of locking to serialize writers. A plain seqcount_t does not
> contain the information of which lock must be held when entering a write
> side critical section.
> 
> Use the new seqcount_spinlock_t data type, which allows to associate a
> spinlock with the sequence counter. This enables lockdep to verify that
> the spinlock used for writer serialization is held when the write side
> critical section is entered.
> 
> If lockdep is disabled this lock association is compiled out and has
> neither storage size nor runtime overhead.
> 
> Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
