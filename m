Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984B038E1E0
	for <lists+linux-block@lfdr.de>; Mon, 24 May 2021 09:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhEXHlA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 24 May 2021 03:41:00 -0400
Received: from verein.lst.de ([213.95.11.211]:53589 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232266AbhEXHk7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 03:40:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8CE7E67373; Mon, 24 May 2021 09:39:30 +0200 (CEST)
Date:   Mon, 24 May 2021 09:39:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCHv3 3/4] block: return errors from blk_execute_rq()
Message-ID: <20210524073930.GC24440@lst.de>
References: <20210521202145.3674904-1-kbusch@kernel.org> <20210521202145.3674904-4-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521202145.3674904-4-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 21, 2021 at 01:21:44PM -0700, Keith Busch wrote:
> The synchronous blk_execute_rq() had not provided a way for its callers
> to know if its request was successful or not. Return the blk_status_t
> result of the request.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
