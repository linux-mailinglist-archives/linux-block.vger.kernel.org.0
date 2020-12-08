Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062622D2BDF
	for <lists+linux-block@lfdr.de>; Tue,  8 Dec 2020 14:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgLHN2M (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 8 Dec 2020 08:28:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:55822 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgLHN2L (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Dec 2020 08:28:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C3186AC9A;
        Tue,  8 Dec 2020 13:27:30 +0000 (UTC)
Date:   Tue, 8 Dec 2020 14:27:30 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
Message-ID: <20201208132730.pus73xdemgkdq45u@beryllium.lan>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-3-bigeasy@linutronix.de>
 <de7f392a-fbac-f7bc-662a-5f40dd4c0aa6@kernel.dk>
 <20201208082220.hhel5ubeh4uqrwnd@linutronix.de>
 <20201208084409.koeftbpnvesp4xtv@beryllium.lan>
 <20201208113653.awqz4zggmy37vbog@beryllium.lan>
 <20201208114936.sfe2jpmbjulcpyjk@linutronix.de>
 <20201208124148.4dxdu6dp5m3mudff@beryllium.lan>
 <20201208125224.m2xt66ladp63fa3t@linutronix.de>
 <20201208125709.5epgbpmqp56bf243@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208125709.5epgbpmqp56bf243@linutronix.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 08, 2020 at 01:57:09PM +0100, Sebastian Andrzej Siewior wrote:
> Yes, you are right. Even cross-CPU completion for single-queue was
> already completing in softirq. So the only change is for multiqueue
> devices which you just demonstrated that it does not happen.

It can happen if there are less hardware queues than CPUs. But I'd bet
that application which care about performance are well aware of this and
try to keep the work vertical aligned.
