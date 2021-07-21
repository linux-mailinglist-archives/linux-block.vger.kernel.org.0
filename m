Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCED3D1182
	for <lists+linux-block@lfdr.de>; Wed, 21 Jul 2021 16:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239165AbhGUN4m (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 21 Jul 2021 09:56:42 -0400
Received: from verein.lst.de ([213.95.11.211]:59013 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238646AbhGUN4m (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jul 2021 09:56:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D2CD467373; Wed, 21 Jul 2021 16:37:16 +0200 (CEST)
Date:   Wed, 21 Jul 2021 16:37:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 2/3] blk-mq: mark if one queue map uses managed irq
Message-ID: <20210721143716.GB11058@lst.de>
References: <20210721091723.1152456-1-ming.lei@redhat.com> <20210721091723.1152456-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721091723.1152456-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 21, 2021 at 05:17:22PM +0800, Ming Lei wrote:
> +	/* So far RDMA doesn't use managed irq */
> +	map->use_managed_irq = false;

It certainly did when I wrote this code.  The comment should be
something "sigh, someone fucked up the rdma queue mapping.  No managed
irqs for now".

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
