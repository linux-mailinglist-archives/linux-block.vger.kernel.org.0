Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5DA38E1DD
	for <lists+linux-block@lfdr.de>; Mon, 24 May 2021 09:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhEXHj5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 24 May 2021 03:39:57 -0400
Received: from verein.lst.de ([213.95.11.211]:53574 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232266AbhEXHj4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 03:39:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E504C67373; Mon, 24 May 2021 09:38:27 +0200 (CEST)
Date:   Mon, 24 May 2021 09:38:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCHv3 1/4] block: support polling through blk_execute_rq
Message-ID: <20210524073827.GA24440@lst.de>
References: <20210521202145.3674904-1-kbusch@kernel.org> <20210521202145.3674904-2-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521202145.3674904-2-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 21, 2021 at 01:21:42PM -0700, Keith Busch wrote:
> Poll for completions if the request's hctx is a polling type.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
