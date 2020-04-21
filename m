Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CB51B2FEA
	for <lists+linux-block@lfdr.de>; Tue, 21 Apr 2020 21:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDUTQw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 21 Apr 2020 15:16:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgDUTQw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 15:16:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E2C8206D9;
        Tue, 21 Apr 2020 19:16:51 +0000 (UTC)
Date:   Tue, 21 Apr 2020 15:16:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] blk-iocost: Fix systemtap error on iocost_ioc_vrate_adj
Message-ID: <20200421151649.11300568@gandalf.local.home>
In-Reply-To: <22ccb042-7d6f-3717-4024-9ec094b2f363@redhat.com>
References: <20200421130755.18370-1-longman@redhat.com>
        <20200421105948.4f5a36f5@gandalf.local.home>
        <22ccb042-7d6f-3717-4024-9ec094b2f363@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 21 Apr 2020 14:36:29 -0400
Waiman Long <longman@redhat.com> wrote:

> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> >
> > -- Steve
> >  
> OK, will send a v2 patch to update the commit log. Thanks for the review.

I think Jens already took this patch.  Doesn't sound like a v2 is needed.

-- Steve
