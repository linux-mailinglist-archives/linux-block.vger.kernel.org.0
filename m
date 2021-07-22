Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4691C3D2450
	for <lists+linux-block@lfdr.de>; Thu, 22 Jul 2021 15:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbhGVMYw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 22 Jul 2021 08:24:52 -0400
Received: from verein.lst.de ([213.95.11.211]:34208 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231738AbhGVMYw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jul 2021 08:24:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 963DF68D06; Thu, 22 Jul 2021 15:05:25 +0200 (CEST)
Date:   Thu, 22 Jul 2021 15:05:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V6 1/3] genirq: add device_has_managed_msi_irq
Message-ID: <20210722130525.GA26872@lst.de>
References: <20210722095246.1240526-1-ming.lei@redhat.com> <20210722095246.1240526-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722095246.1240526-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 22, 2021 at 05:52:44PM +0800, Ming Lei wrote:
> irq vector allocation with managed affinity may be used by driver, and
> blk-mq needs this info for draining queue because genirq core will shutdown
> managed irq when all CPUs in the affinity mask are offline.
> 
> The info of using managed irq is often produced by drivers, and it is
> consumed by blk-mq, so different subsystems are involved in this info flow.
> 
> Address this issue by adding one helper of device_has_managed_msi_irq()
> which is suggested by John Garry.

This implies non-MSI irqs can't be managed, which is true right now.
If the irq maintaines are fine with that:

Reviewed-by: Christoph Hellwig <hch@lst.de>
