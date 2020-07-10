Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C3421B9B5
	for <lists+linux-block@lfdr.de>; Fri, 10 Jul 2020 17:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgGJPm3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 10 Jul 2020 11:42:29 -0400
Received: from verein.lst.de ([213.95.11.211]:43774 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgGJPm2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jul 2020 11:42:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EF39968AEF; Fri, 10 Jul 2020 17:42:26 +0200 (CEST)
Date:   Fri, 10 Jul 2020 17:42:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org
Subject: Re: simplify block device claiming
Message-ID: <20200710154226.GA20144@lst.de>
References: <20200702084919.3720275-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702084919.3720275-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Any comments?

On Thu, Jul 02, 2020 at 10:49:15AM +0200, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series simplifies how we claim block devices for exclusive opens.
> 
> Diffstat:
>  drivers/block/loop.c   |    7 -
>  fs/block_dev.c         |  231 ++++++++++++++++---------------------------------
>  include/linux/blkdev.h |    3 
>  3 files changed, 81 insertions(+), 160 deletions(-)
---end quoted text---
