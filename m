Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524903EE5E0
	for <lists+linux-block@lfdr.de>; Tue, 17 Aug 2021 06:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbhHQEuP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Aug 2021 00:50:15 -0400
Received: from verein.lst.de ([213.95.11.211]:57006 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhHQEuP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Aug 2021 00:50:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 398676736F; Tue, 17 Aug 2021 06:49:40 +0200 (CEST)
Date:   Tue, 17 Aug 2021 06:49:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/7] genirq/affinity: don't pass irq_affinity_desc
 array to irq_build_affinity_masks
Message-ID: <20210817044940.GC3874@lst.de>
References: <20210814123532.229494-1-ming.lei@redhat.com> <20210814123532.229494-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210814123532.229494-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Aug 14, 2021 at 08:35:28PM +0800, Ming Lei wrote:
> Prepare for abstracting irq_build_affinity_masks() into one public helper
> for assigning all CPUs evenly into several groups. Don't passing

s/passing/pass/

> irq_affinity_desc array to irq_build_affinity_masks, instead returning

s/returning/return/

> one cpumask array by storing each assigned group into one element of

s/one/a/

> the array.
> 
> This way helps us to provide generic interface for grouping all CPUs

s/way //

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
