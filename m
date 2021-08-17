Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FC23EE5CE
	for <lists+linux-block@lfdr.de>; Tue, 17 Aug 2021 06:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbhHQEqQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Aug 2021 00:46:16 -0400
Received: from verein.lst.de ([213.95.11.211]:56994 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238011AbhHQEqM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Aug 2021 00:46:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3A04A6736F; Tue, 17 Aug 2021 06:45:36 +0200 (CEST)
Date:   Tue, 17 Aug 2021 06:45:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/7] genirq/affinity: remove the 'firstvec' parameter
 from irq_build_affinity_masks
Message-ID: <20210817044536.GA3874@lst.de>
References: <20210814123532.229494-1-ming.lei@redhat.com> <20210814123532.229494-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210814123532.229494-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Aug 14, 2021 at 08:35:26PM +0800, Ming Lei wrote:
> The 'firstvec' parameter is always same with the parameter of
> 'startvec', so use 'startvec' directly inside irq_build_affinity_masks().
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
