Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E765A1D2564
	for <lists+linux-block@lfdr.de>; Thu, 14 May 2020 05:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgENDVu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 May 2020 23:21:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgENDVu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 23:21:50 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10D1A20690;
        Thu, 14 May 2020 03:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589426510;
        bh=pEHRxV6E0LaeTGW1HZ2t8iGaCBo+BzULASxoN/vP9vU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qrzWWHZvMsV8guzUT0JfHk7zkDHuvsd9LNr6ML8E1599lpT3cyGJd5JRR3YMPt3tW
         bgM6X0+pweWpRJjQKRHN+QBzEP7bNiaSxKk+pR5SjSjGwM2rGUl2x1ubsjQXO1cPLh
         WwA+5vR4ySNp+OvMNg7Hd4RetdFcM6v+V8ZccK1k=
Date:   Thu, 14 May 2020 12:21:43 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [PATCH 3/9] blk-mq: don't predicate last flag in
 blk_mq_dispatch_rq_list
Message-ID: <20200514032143.GA1833@redsun51.ssa.fujisawa.hgst.com>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
 <20200513095443.2038859-4-ming.lei@redhat.com>
 <20200513122753.GC23958@infradead.org>
 <20200514020955.GH2073570@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514020955.GH2073570@T590>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 14, 2020 at 10:09:55AM +0800, Ming Lei wrote:
> However, why is .commit_rqs() required? Why doesn't .queue_rq() handle the batching
> submission before non-STS_OK is returned?

Wouldn't the driver need to know that the request is !first in that case
so that it doesn't commit nothing if the first request fails?
