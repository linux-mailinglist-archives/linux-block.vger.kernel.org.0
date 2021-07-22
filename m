Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE073D2742
	for <lists+linux-block@lfdr.de>; Thu, 22 Jul 2021 18:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbhGVP0X (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 22 Jul 2021 11:26:23 -0400
Received: from verein.lst.de ([213.95.11.211]:34817 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhGVP0W (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jul 2021 11:26:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id ED92A67373; Thu, 22 Jul 2021 18:06:54 +0200 (CEST)
Date:   Thu, 22 Jul 2021 18:06:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH V6 2/3] blk-mq: mark if one queue map uses managed irq
Message-ID: <20210722160654.GA8344@lst.de>
References: <20210722095246.1240526-1-ming.lei@redhat.com> <20210722095246.1240526-3-ming.lei@redhat.com> <20210722130609.GB26872@lst.de> <YPmRY1DvFyIpQ8uM@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPmRY1DvFyIpQ8uM@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 22, 2021 at 11:40:19PM +0800, Ming Lei wrote:
> On Thu, Jul 22, 2021 at 03:06:09PM +0200, Christoph Hellwig wrote:
> > On Thu, Jul 22, 2021 at 05:52:45PM +0800, Ming Lei wrote:
> > 	 and nvme rdma driver can allocate
> > > +	 * and submit requests on specified hctx via
> > > +	 * blk_mq_alloc_request_hctx
> > 
> > Why does that matter for this setting?
> 
> blk_mq_alloc_request_hctx() has been broken for long time, which
> can only work if the hctx isn't driven by non-managed irq.

The qla2xxx and lpfc drivers uses managed interrupt.  I'm not quite
sure if the nvme-fc queues directly map to those interrupts, though.
