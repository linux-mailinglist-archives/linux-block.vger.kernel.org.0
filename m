Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521FB7CDB52
	for <lists+linux-block@lfdr.de>; Wed, 18 Oct 2023 14:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjJRMKJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 18 Oct 2023 08:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjJRMKJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Oct 2023 08:10:09 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B157BA;
        Wed, 18 Oct 2023 05:10:07 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C4F2267373; Wed, 18 Oct 2023 14:10:02 +0200 (CEST)
Date:   Wed, 18 Oct 2023 14:10:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/5] block: move bdev_mark_dead out of
 disk_check_media_change
Message-ID: <20231018121002.GB9581@lst.de>
References: <20231017184823.1383356-1-hch@lst.de> <20231017184823.1383356-4-hch@lst.de> <ZS9ODABLaRVcI5iy@fedora> <20231018064646.GA18710@lst.de> <ZS+iOA//0ShbY7Fk@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS+iOA//0ShbY7Fk@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 18, 2023 at 05:15:36PM +0800, Ming Lei wrote:
> > Yes. It has to be a non-exclusive open, though, and how is that going
> > to help us with any general use case?  If we really want to make the
> > media change notifications any useful we'd better just do the work
> > straight from the workqueue that polls for it.
> 
> Given ->mark_dead() is added recently, userspace shouldn't depend on
> this behavior, so this patch looks fine:

While the method is new, disk_check_media_change called
__invalidate_device before, which ended up both taking s_umount and
thrashing the buffer cache under the fs.
