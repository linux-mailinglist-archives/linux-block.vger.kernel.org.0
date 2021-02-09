Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48122314E55
	for <lists+linux-block@lfdr.de>; Tue,  9 Feb 2021 12:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhBILnC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 9 Feb 2021 06:43:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43674 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbhBILhB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Feb 2021 06:37:01 -0500
Date:   Tue, 9 Feb 2021 12:35:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612870535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DixppWAKwCGRCyN3/wjo8fEQOat/YyMxvwTe82uIifQ=;
        b=UM8QInTylCa75oFCFtfwnoIWu4ujgiNcS4dPQO8ljzOU6+DngUc1Za5W0SENKLaL/PC99O
        FruCrcDq5ZRZrEmEObVFQlwxPnU6/hxXgjT7AKhVK3lYngtk0cyrN5MzvXMeWA83hrDGzw
        ew2OPW9F+JgvqWDbB0+iGt/JEmeKaHqc5nk8fvGUK/rxyPPRhIlddIknb9sw68UOQEZ36H
        Grxbz8oqOox15HG2EKYVIsJHbYPMKyu53eP84j9nHIbwOtlB+MnIZfKihFilVE1sLxhcpe
        IX93pvAc4O5Ci2b25jF3bLyikkldSo3pcI6QHlpkkVuo2xxhgJhsvdRK5SSCuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612870535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DixppWAKwCGRCyN3/wjo8fEQOat/YyMxvwTe82uIifQ=;
        b=jZHFHRvPw1zbucga3ykmn0KGytb/vEzO+JpJ0TSphrp+oLuhhls9qv2gVTxyA8ldJnFVXr
        D2DpRxaYPHgnXaBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/3] smp: Process pending softirqs in
 flush_smp_call_function_from_idle()
Message-ID: <20210209113533.hgjztse5afs4snxz@linutronix.de>
References: <20210123201027.3262800-1-bigeasy@linutronix.de>
 <20210123201027.3262800-2-bigeasy@linutronix.de>
 <YCJdoovwxhlbJ4ln@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCJdoovwxhlbJ4ln@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021-02-09 11:02:10 [+0100], Peter Zijlstra wrote:
> Fair enough. I'll stick this in tip/sched/smp for Jens and merge that
> into tip/sched/core.

Thank you.

> Thanks!

Sebastian
