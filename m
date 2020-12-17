Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46BCC2DD5AB
	for <lists+linux-block@lfdr.de>; Thu, 17 Dec 2020 18:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgLQRGO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 17 Dec 2020 12:06:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:53356 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbgLQRGO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 12:06:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3850AACA5;
        Thu, 17 Dec 2020 17:05:33 +0000 (UTC)
Date:   Thu, 17 Dec 2020 18:05:32 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
Message-ID: <20201217170532.fp2ual5e5tpkvln4@beryllium.lan>
References: <20201204191356.2516405-1-bigeasy@linutronix.de>
 <20201204191356.2516405-3-bigeasy@linutronix.de>
 <de7f392a-fbac-f7bc-662a-5f40dd4c0aa6@kernel.dk>
 <20201208131319.GB22219@infradead.org>
 <20201217164308.ueki3scv3oxt4uta@linutronix.de>
 <e3ca3c82-cddc-ea06-39ae-48605abc77eb@kernel.dk>
 <20201217165844.z4sikj43pf6d3c57@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217165844.z4sikj43pf6d3c57@linutronix.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 17, 2020 at 05:58:44PM +0100, Sebastian Andrzej Siewior wrote:
> On 2020-12-17 09:55:08 [-0700], Jens Axboe wrote:
> > 
> > Yeah, I think we're good at this point. I'll queue this up for 5.11.
> Thank you very much.
> Thank you Daniel for running all these tests.

np. Glad I can contribute to the -rt project :)
