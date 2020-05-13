Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863551D1206
	for <lists+linux-block@lfdr.de>; Wed, 13 May 2020 13:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgEML6f (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 May 2020 07:58:35 -0400
Received: from verein.lst.de ([213.95.11.211]:46063 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbgEML6f (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 07:58:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 976CF68BEB; Wed, 13 May 2020 13:58:32 +0200 (CEST)
Date:   Wed, 13 May 2020 13:58:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V11 06/12] blk-mq: prepare for draining IO when hctx's
 all CPUs are offline
Message-ID: <20200513115832.GB6297@lst.de>
References: <20200513034803.1844579-1-ming.lei@redhat.com> <20200513034803.1844579-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513034803.1844579-7-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I think the flag should be inverted, indicated managed irqs if set.
And we should fine a a way to automatically set it from the managed
IRQ blk_mq_*_map_queues helpers instead of leaving the decisions to
the driver author that is most likely going to get it wrong, especially
for SCSI, where the actual driver can't even get at the current flag.
