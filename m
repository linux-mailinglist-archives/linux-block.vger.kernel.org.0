Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFF47326C3
	for <lists+linux-block@lfdr.de>; Fri, 16 Jun 2023 07:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjFPFsG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 16 Jun 2023 01:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjFPFsG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 01:48:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D58A270C
        for <linux-block@vger.kernel.org>; Thu, 15 Jun 2023 22:48:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EBAB267373; Fri, 16 Jun 2023 07:48:00 +0200 (CEST)
Date:   Fri, 16 Jun 2023 07:48:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH 1/4] blk-mq: add API of blk_mq_unfreeze_queue_force
Message-ID: <20230616054800.GA28499@lst.de>
References: <20230615143236.297456-1-ming.lei@redhat.com> <20230615143236.297456-2-ming.lei@redhat.com> <ZIsrSyEqWMw8/ikq@kbusch-mbp.dhcp.thefacebook.com> <ZIsxt7Q2nmiLNTX2@ovpn-8-16.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIsxt7Q2nmiLNTX2@ovpn-8-16.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 15, 2023 at 11:43:51PM +0800, Ming Lei wrote:
> On Thu, Jun 15, 2023 at 09:16:27AM -0600, Keith Busch wrote:
> > On Thu, Jun 15, 2023 at 10:32:33PM +0800, Ming Lei wrote:
> > > NVMe calls freeze/unfreeze in different contexts, and controller removal
> > > may break in-progress error recovery, then leave queues in frozen state.
> > > So cause IO hang in del_gendisk() because pending writeback IOs are
> > > still waited in bio_queue_enter().
> > 
> > Shouldn't those writebacks be unblocked by the existing check in
> > bio_queue_enter, test_bit(GD_DEAD, &disk->state))? Or are we missing a
> > disk state update or wakeup on this condition?
> 
> GD_DEAD is only set if the device is really dead, then all pending IO
> will be failed.

del_gendisk also sets GD_DEAD early on.
