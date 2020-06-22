Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5907B2044B8
	for <lists+linux-block@lfdr.de>; Tue, 23 Jun 2020 01:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbgFVXrU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 22 Jun 2020 19:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731477AbgFVXrL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jun 2020 19:47:11 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAEE0207BC;
        Mon, 22 Jun 2020 23:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592869631;
        bh=zuAl0hZaesLweDDqN9N64XfiecF7aWEc6rnzWcjyJNE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V6xcK0T46oJBmyvem6+iGQS/7nBYzaRFJxGNHfqHqRwvQluS9j6fK/wSYce/HhyW7
         NyskHl15RmCBvINQMJsWvfRQM3U2UHdLdapQjTbGvebpc1U9XDhtuZa8y/nvc3QvqK
         stt7ZjXoOjZkxh+MvRQ3yqcL/wMZ+ECqpnXcqQa4=
Date:   Tue, 23 Jun 2020 08:47:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ming Lei <tom.leiming@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: kprobe: __blkdev_put probe is missed
Message-Id: <20200623084706.e6e99e99d7da6690e7a6c199@kernel.org>
In-Reply-To: <20200622090148.6e0f2ac9@oasis.local.home>
References: <20200618125438.GA191266@T590>
        <20200618225602.3f2cca3f0ed48427fc0a483b@kernel.org>
        <20200618231901.GA196099@T590>
        <20200619141239.56f6dda0976453b790190ff7@kernel.org>
        <20200619072859.GA205278@T590>
        <20200619081954.3d72a252@oasis.local.home>
        <20200619133240.GA351476@T590>
        <20200620003509.9521053fbd384f4f5d23408f@kernel.org>
        <20200619232820.GE353853@T590>
        <20200620103747.fb83f804083ef9956740acee@kernel.org>
        <20200622002753.GC670933@T590>
        <20200622090148.6e0f2ac9@oasis.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 22 Jun 2020 09:01:48 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 22 Jun 2020 08:27:53 +0800
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > Can you kprobe guys improve the implementation for covering this case?
> > For example, put probe on 3) in case the above situation is recognized.
> 
> To do so would require solving the halting problem.
> 
>   https://en.wikipedia.org/wiki/Halting_problem
> 
> Or perhaps reading the DWARF output of the compiler to determine if it
> optimized the location you are looking for.

As far as I can see, gcc-9.3 doesn't generate this information :(
Maybe the optimizer forgot to push the tail-call callsite information
to dwarf generator when making a recursive tail-call to a loop.

> The first case is impossible to solve, the second would take a lot of
> work, (are you going to fund it?)

What I can provide is "--skip-prologue" option for the perf-probe
which will be similar to the "-P" option. If the compiler correctly
generates the information, we can enable it automatically. But
as far as I can see, it doesn't.

[OT] DWARF has its option(and GNU extension) but it seems not correctly
implemented yet.
 
http://www.dwarfstd.org/ShowIssue.php?issue=100909.2

What I found on __blkdev_put and the callers, the "tail-call to other
function" were recorded as a call-site DIE with DW_AT_tail_call. But
if the "tail-call to itself (recursive call)" was expanded as a loop,
it was just disappeared. No call-site information, nor the DW_AT_tail_call.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
