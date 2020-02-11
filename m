Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFF31159AFE
	for <lists+linux-block@lfdr.de>; Tue, 11 Feb 2020 22:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgBKVNl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 11 Feb 2020 16:13:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:46838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729774AbgBKVNl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Feb 2020 16:13:41 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 096D820708;
        Tue, 11 Feb 2020 21:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581455621;
        bh=YRD6EX30aAEYnrKsqlSvjT7BpNRAhFZ2g2HPWAxpFHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FczeLMqxGFnNCHmXjx5KxTeNhecsxXBg/6LkmOQ9UmnZC3Zilz1OCLNhE2bF7imrS
         WnoIbyjEN2g7osH4KDq9Gao5/gPPevCFCB029toKvR4SWcjjmyZqkWqDabIgsFZaQr
         RqDxH6cPr+NCkRsCBhcFL8h62S712J7JHtbhjhBo=
Date:   Wed, 12 Feb 2020 06:13:34 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Cc:     axboe@kernel.dk, song@kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Subject: Re: [PATCH v2 2/2] md: enable io polling
Message-ID: <20200211211334.GB3837@redsun51.ssa.fujisawa.hgst.com>
References: <20200211191729.4745-1-andrzej.jakowski@linux.intel.com>
 <20200211191729.4745-3-andrzej.jakowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211191729.4745-3-andrzej.jakowski@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 11, 2020 at 12:17:29PM -0700, Andrzej Jakowski wrote:
> +static int md_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
> +{
> +	struct mddev *mddev = q->queuedata;
> +	struct md_rdev *rdev;
> +	int ret = 0;
> +	int rv;
> +
> +	rdev_for_each(rdev, mddev) {
> +		if (rdev->raid_disk < 0 || test_bit(Faulty, &rdev->flags))
> +			continue;
> +
> +		rv = blk_poll(bdev_get_queue(rdev->bdev), cookie, false);
> +		if (rv < 0) {
> +			ret = rv;
> +			break;
> +		}
> +		ret += rv;
> +	}
> +
> +	return ret;
> +}

I must be missing something: md's make_request_fn always returns
BLK_QC_T_NONE for the cookie, and that couldn't get past blk_poll's
blk_qc_t_valid(cookie) check. How does the initial blk_poll() caller get
a valid cookie for an md backing device's request_queue? And how is the
same cookie valid for more than one request_queue?

Since this is using the same cookie with different request_queues, I'm
really concerned about what happens if you managed to successfully poll
an nvme queue that wasn't designated for polling: blk_qc_t_to_queue_num()
may return a valid poll hctx for one nvme request_queue, but the same
queue_num for a different nvme device may be an IRQ driven context. That
could lead to douple completions and corrupted queues.
