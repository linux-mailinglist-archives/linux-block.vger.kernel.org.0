Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C05539E35
	for <lists+linux-block@lfdr.de>; Wed,  1 Jun 2022 09:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350204AbiFAH2J (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 1 Jun 2022 03:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347233AbiFAH2I (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 03:28:08 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A8E38AD
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 00:28:07 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1A1D668AFE; Wed,  1 Jun 2022 09:14:30 +0200 (CEST)
Date:   Wed, 1 Jun 2022 09:14:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org,
        syzbot+3e3f419f4a7816471838@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: disable the elevator int del_gendisk
Message-ID: <20220601071429.GA24431@lst.de>
References: <20220531160535.3444915-1-hch@lst.de> <Ypa4xrAHUslpQPhN@T590> <20220601064329.GB22915@lst.de> <YpcQpjUlX/CTORmp@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpcQpjUlX/CTORmp@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 01, 2022 at 03:09:26PM +0800, Ming Lei wrote:
> > Yes, we probably need a blk_mq_quiesce_queue call like in the incremental
> > patch below.  Do you have any good reproducer, though?
> 
> blktests block/027 should cover this.

That did not trigger the problem for me.

> >  	if (q->elevator) {
> > +		blk_mq_quiesce_queue(q);
> > +
> >  		mutex_lock(&q->sysfs_lock);
> >  		elevator_exit(q);
> >  		mutex_unlock(&q->sysfs_lock);
> > +
> > +		blk_mq_unquiesce_queue(q);
> >  	}
> >  
> 
> I am afraid the above way may slow down disk shutdown a lot, see
> the following commit, that is also the reason why I moved it into disk
> release handler, when any sync io submission are done.

SCSI devices that are just probed and never had a disk attached will
not have q->elevator set and not hit this quiesce at all.
