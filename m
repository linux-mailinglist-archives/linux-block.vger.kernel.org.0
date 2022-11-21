Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923E86319FB
	for <lists+linux-block@lfdr.de>; Mon, 21 Nov 2022 08:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiKUHCu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 21 Nov 2022 02:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKUHCt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2022 02:02:49 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5583FDF01
        for <linux-block@vger.kernel.org>; Sun, 20 Nov 2022 23:02:47 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 839B768AA6; Mon, 21 Nov 2022 08:02:44 +0100 (CET)
Date:   Mon, 21 Nov 2022 08:02:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org
Subject: Re: untangle the request_queue refcounting from the queue kobject
 v2
Message-ID: <20221121070244.GA23563@lst.de>
References: <20221114042637.1009333-1-hch@lst.de> <Y3g9P8NB+ubuKaqA@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3g9P8NB+ubuKaqA@ZenIV>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 19, 2022 at 02:19:43AM +0000, Al Viro wrote:
> > Changes since v1:
> >  - also change the blk_crypto_sysfs_unregister prototype
> >  - add two patches to fix the error handling in blk_register_queue
> 
> Umm...  Do we ever want access to queue parameters of the stuff that has
> a queue, but no associated gendisk?  SCSI tape, for example...

What do you mean with "access queue parameters"?  The sysfs access can
since day one only happen through the queue.

> 	Re refcounting: AFAICS, blk_mq_alloc_disk_for_queue() is broken.
> __alloc_disk_node() consumes queue reference (and stuffs it into gendisk->queue)
> on success; on failure it leaves the reference alone.  E.g. this

Yes, it needs a put_queue for the error handler. 
