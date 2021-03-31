Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BCA34C356
	for <lists+linux-block@lfdr.de>; Mon, 29 Mar 2021 07:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhC2FxY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 29 Mar 2021 01:53:24 -0400
Received: from verein.lst.de ([213.95.11.211]:52091 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230303AbhC2Fw4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Mar 2021 01:52:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 02C5768B05; Mon, 29 Mar 2021 07:27:57 +0200 (CEST)
Date:   Mon, 29 Mar 2021 07:27:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Keith Busch <kbusch@kernel.org>, Yufen Yu <yuyufen@huawei.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de,
        ming.lei@redhat.com
Subject: Re: [RFC PATCH] block: protect bi_status with spinlock
Message-ID: <20210329052757.GA26495@lst.de>
References: <20210329022337.3992955-1-yuyufen@huawei.com> <20210329030246.GA15392@redsun51.ssa.fujisawa.hgst.com> <a6a145cc-1ee6-5f13-1bf3-2d3083362c04@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6a145cc-1ee6-5f13-1bf3-2d3083362c04@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 28, 2021 at 08:49:29PM -0700, Bart Van Assche wrote:
> > I don't see a spin_lock_init() on this new lock, though a spinlock seems
> > overkill here. If you need an atomic update, you could do:
> > 
> > 	cmpxchg(&parent->bi_status, 0, bio->bi_status);
> 
> Hmm ... isn't cmpxchg() significantly slower than a spinlock?

That is (micro-)architecture-specific, but for common x86 CPU is
certainly is going to be at least as fast as the spinlock.
