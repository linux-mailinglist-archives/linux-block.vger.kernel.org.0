Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D161A53A480
	for <lists+linux-block@lfdr.de>; Wed,  1 Jun 2022 14:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351673AbiFAMB2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 1 Jun 2022 08:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237306AbiFAMB2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 08:01:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53340DC
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 05:01:27 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DD07568AA6; Wed,  1 Jun 2022 14:01:23 +0200 (CEST)
Date:   Wed, 1 Jun 2022 14:01:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org,
        syzbot+3e3f419f4a7816471838@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: disable the elevator int del_gendisk
Message-ID: <20220601120123.GA12335@lst.de>
References: <20220531160535.3444915-1-hch@lst.de> <Ypa4xrAHUslpQPhN@T590> <20220601064329.GB22915@lst.de> <YpcQpjUlX/CTORmp@T590> <20220601071429.GA24431@lst.de> <YpcsaRDNN0LeVNny@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpcsaRDNN0LeVNny@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 01, 2022 at 05:07:53PM +0800, Ming Lei wrote:
> > > I am afraid the above way may slow down disk shutdown a lot, see
> > > the following commit, that is also the reason why I moved it into disk
> > > release handler, when any sync io submission are done.
> > 
> > SCSI devices that are just probed and never had a disk attached will
> > not have q->elevator set and not hit this quiesce at all.
> 
> Yes, but host with hundreds of real LUNs may be shutdown slowly too
> since sd_remove() won't be called in async way.

So maybe teardown will slow down.  But we fix a reproducable bug, and
do get the lifetimes right.  The sched request are enabled in add_disk
(or when a scheduler is enabled if there was none after that) so we
should tear it down in del_gendisk.  The fact that we've been playing
so lose with these lifetime rules in the block layer has been a constant
source of bugs.
