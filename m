Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2298624642E
	for <lists+linux-block@lfdr.de>; Mon, 17 Aug 2020 12:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgHQKOp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 17 Aug 2020 06:14:45 -0400
Received: from verein.lst.de ([213.95.11.211]:56127 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgHQKOo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 06:14:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B16CE68B02; Mon, 17 Aug 2020 12:14:41 +0200 (CEST)
Date:   Mon, 17 Aug 2020 12:14:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 3/3] block: rename blk_discard_mergable as
 blk_discard_support_multi_range
Message-ID: <20200817101441.GA25336@lst.de>
References: <20200817095241.2494763-1-ming.lei@redhat.com> <20200817095241.2494763-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817095241.2494763-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 17, 2020 at 05:52:41PM +0800, Ming Lei wrote:
> Name of blk_discard_mergable() is very confusing, and this function
> actually means if the queue supports multi_range discard. Also there
> are two kinds of discard merge:
> 
> 1) multi range discard, bios in one request won't have to be contiguous,
> and actually each bio is thought as one range
> 
> 2) single range discard, all bios in one request have to be contiguous
> just like normal RW request's merge
> 
> Rename blk_discard_mergable() for not confusing people, and avoiding
> to introduce bugs in future.

I agree the current name is not good, but I find the new one pretty
clumsy too.  Not sure the rename is worth it, but also no strict NAK
from me.
