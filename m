Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB3E39BC3
	for <lists+linux-block@lfdr.de>; Sat,  8 Jun 2019 10:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbfFHITf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 8 Jun 2019 04:19:35 -0400
Received: from verein.lst.de ([213.95.11.211]:60583 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbfFHITf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 8 Jun 2019 04:19:35 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DED3068C7B; Sat,  8 Jun 2019 10:19:07 +0200 (CEST)
Date:   Sat, 8 Jun 2019 10:19:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 1/2] blk-mq: Remove blk_mq_put_ctx()
Message-ID: <20190608081907.GB19573@lst.de>
References: <20190604181736.903-1-bvanassche@acm.org> <20190604181736.903-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604181736.903-2-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 04, 2019 at 11:17:35AM -0700, Bart Van Assche wrote:
> No code that occurs between blk_mq_get_ctx() and blk_mq_put_ctx() depends
> on preemption being disabled for its correctness. Since removing the CPU
> preemption calls does not measurably affect performance, simplify the
> blk-mq code by removing the blk_mq_put_ctx() function and also by not
> disabling preemption in blk_mq_get_ctx().

I like the idea behinds this, but I think it makes some small issues
we have in the current code even worse.  As far as I can tell the idea
behind this call was that we operate on the same blk_mq_ctx for the
duration of the I/O submission.  Now it should not matter which one,
that is we don't care if we get preempted, but it should stay the same.

To actually make this work properly we'll need to pass down the
blk_mq_ctx into the I/O scheduler merge path, which dereference it.
Note that I also have an outstanding series to pass down an additional
parameter there (the bi_phys_segments removal) so we'll need to
coordinate that.
