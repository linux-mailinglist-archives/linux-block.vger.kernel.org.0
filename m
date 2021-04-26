Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C34136B52C
	for <lists+linux-block@lfdr.de>; Mon, 26 Apr 2021 16:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbhDZOoB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 26 Apr 2021 10:44:01 -0400
Received: from verein.lst.de ([213.95.11.211]:41591 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233501AbhDZOoA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 10:44:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2752468C4E; Mon, 26 Apr 2021 16:43:17 +0200 (CEST)
Date:   Mon, 26 Apr 2021 16:43:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv2 5/5] nvme: allow user passthrough commands to poll
Message-ID: <20210426144316.GE20668@lst.de>
References: <20210423220558.40764-1-kbusch@kernel.org> <20210423220558.40764-6-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423220558.40764-6-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 23, 2021 at 03:05:58PM -0700, Keith Busch wrote:
> The block layer knows how to deal with polled requests. Let the NVMe
> driver use the previously reserved user "flags" fields to define an
> option to allocate the request from the polled hardware contexts. If
> polling is not enabled, then the block layer will automatically fallback
> to a non-polled request.

So this only support synchronous polling for a single command.  What
use case do we have for that?  I think io_uring based polling would
be much more useful once we support NVMe passthrough through that.
