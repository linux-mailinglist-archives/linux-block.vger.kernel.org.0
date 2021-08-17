Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005C73EE5ED
	for <lists+linux-block@lfdr.de>; Tue, 17 Aug 2021 06:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhHQEwy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Aug 2021 00:52:54 -0400
Received: from verein.lst.de ([213.95.11.211]:57018 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhHQEwx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Aug 2021 00:52:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AEC7F6736F; Tue, 17 Aug 2021 06:52:18 +0200 (CEST)
Date:   Tue, 17 Aug 2021 06:52:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/7] genirq/affinity: move group_cpus_evenly() into lib/
Message-ID: <20210817045218.GE3874@lst.de>
References: <20210814123532.229494-6-ming.lei@redhat.com> <202108150001.EBuNGcQ8-lkp@intel.com> <YRm5lXfnukXU8Ebh@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRm5lXfnukXU8Ebh@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 16, 2021 at 09:04:21AM +0800, Ming Lei wrote:
> But the above symbol is exported via EXPORT_SYMBOL_GPL(), in current
> kernel tree, we usually keep such exported symbol as global, or is there
> some change in kernel coding style recently?

This is about prototypes.  You need to include group_cpus.h in
group_cpus.c so that the prototype is visible at the implementation site.
