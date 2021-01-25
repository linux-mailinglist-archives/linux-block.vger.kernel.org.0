Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C803F3034F8
	for <lists+linux-block@lfdr.de>; Tue, 26 Jan 2021 06:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbhAZFb3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 26 Jan 2021 00:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbhAYJgx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 04:36:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB1DC061793;
        Mon, 25 Jan 2021 00:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zGgRl2LgOrK08d1LlX0vwaKxdqZFCdwsDDwW3pCK04w=; b=A63P29axSeGvBYaQuSr4Z1mADH
        aTLPtQ6DtNCVre3pP7QIT5fd2Oag/WJkcrEHyVvNIfJq2vKZUPRzcyfB2Wqylv7D/V8cj/DNr+1Ts
        h7oKUycP2rePf8U0wqHGmbcj49Yv40r7KQkmHCTPgt8qV8dIAqDaLbD/gSJVtoW8cmeKtXxnuLm36
        22AW2HvZjNL0m/F/pMxCJpRGiWlVDayA399Q2a8YMUcxZWCm6MfG3wXo8MzHhAILtr/gsLPWFtyK5
        LgegfnCry02MugNTroJREw2on5XGPe2HgX91fh87DL8ThWlWPIQrJzM9908v9CrJYL+9b6dS3h4x4
        9plS3HCg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l3x9H-003xRk-RF; Mon, 25 Jan 2021 08:23:01 +0000
Date:   Mon, 25 Jan 2021 08:22:59 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
Message-ID: <20210125082259.GB942655@infradead.org>
References: <20210123201027.3262800-1-bigeasy@linutronix.de>
 <20210123201027.3262800-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123201027.3262800-3-bigeasy@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jan 23, 2021 at 09:10:26PM +0100, Sebastian Andrzej Siewior wrote:
> Controllers with multiple queues have their IRQ-handelers pinned to a
> CPU. The core shouldn't need to complete the request on a remote CPU.
> 
> Remove this case and always raise the softirq to complete the request.

What about changing blk_mq_trigger_softirq to take a void * argument
and thus removing __blk_mq_complete_request_remote entirely?
