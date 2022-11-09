Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5553B622C0E
	for <lists+linux-block@lfdr.de>; Wed,  9 Nov 2022 14:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiKINBn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 9 Nov 2022 08:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiKINBm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Nov 2022 08:01:42 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05A315727
        for <linux-block@vger.kernel.org>; Wed,  9 Nov 2022 05:01:41 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8AE9768AA6; Wed,  9 Nov 2022 14:01:38 +0100 (CET)
Date:   Wed, 9 Nov 2022 14:01:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] block: untangle request_queue refcounting from
 sysfs
Message-ID: <20221109130138.GC32628@lst.de>
References: <20221105080815.775721-1-hch@lst.de> <20221105080815.775721-2-hch@lst.de> <Y2ljMMNLLy3lG8VA@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2ljMMNLLy3lG8VA@sol.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 07, 2022 at 11:57:36AM -0800, Eric Biggers wrote:
> On Sat, Nov 05, 2022 at 09:08:14AM +0100, Christoph Hellwig wrote:
> > @@ -811,7 +772,8 @@ int blk_register_queue(struct gendisk *disk)
> >  
> >  	mutex_lock(&q->sysfs_dir_lock);
> >  
> > -	ret = kobject_add(&q->kobj, &disk_to_dev(disk)->kobj, "queue");
> > +	kobject_init(&disk->queue_kobj, &blk_queue_ktype);
> > +	ret = kobject_add(&disk->queue_kobj, &disk_to_dev(disk)->kobj, "queue");
> 
> Use kobject_init_and_add()?

I never found a good reason to use that over the two calls.  It doesn't
clear up what is done, and doesn't save code size either.

> Also, kobject_put() needs to be called on error.

Indeed.  Also for the later error cases.
