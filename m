Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2F9E189D5
	for <lists+linux-block@lfdr.de>; Thu,  9 May 2019 14:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfEIMe0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 9 May 2019 08:34:26 -0400
Received: from verein.lst.de ([213.95.11.211]:45581 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbfEIMe0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 May 2019 08:34:26 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E3F8968AFE; Thu,  9 May 2019 14:34:06 +0200 (CEST)
Date:   Thu, 9 May 2019 14:34:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, keith.busch@intel.com,
        sagi@grimberg.me, axboe@fb.com, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] nvme-pci: fix single segment detection
Message-ID: <20190509123406.GB21483@lst.de>
References: <20190509110409.19647-1-hch@lst.de> <20190509112410.GA20711@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509112410.GA20711@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 09, 2019 at 07:24:12PM +0800, Ming Lei wrote:
> I'd suggest to fix block layer instead of working around the issue here,
> then any driver may benefit from the fix.

That is my plan, and I started on it.  But the fix isn't trivial, and
will probably take a while and be invasive.

> Especially checking bio->bi_vcnt is just a hack, and drivers should
> never use .bi_vcnt.

That is why it is explicitly commented as a hack.  But a good enough
one to still speed up typical 4K I/Os - one a bio has been cloned
chances are very high we don't care about the fast path any more.
