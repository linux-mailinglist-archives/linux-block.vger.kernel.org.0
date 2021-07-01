Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2998A3B8F59
	for <lists+linux-block@lfdr.de>; Thu,  1 Jul 2021 11:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbhGAJFF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 1 Jul 2021 05:05:05 -0400
Received: from verein.lst.de ([213.95.11.211]:46864 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235067AbhGAJFF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Jul 2021 05:05:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6433A6736F; Thu,  1 Jul 2021 11:02:32 +0200 (CEST)
Date:   Thu, 1 Jul 2021 11:02:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: grab a device refcount in disk_uevent
Message-ID: <20210701090232.GA31321@lst.de>
References: <20210701081638.246552-1-hch@lst.de> <20210701081638.246552-2-hch@lst.de> <YN2CrbtFEKwDGff0@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YN2CrbtFEKwDGff0@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 01, 2021 at 04:54:05PM +0800, Ming Lei wrote:
> On Thu, Jul 01, 2021 at 10:16:37AM +0200, Christoph Hellwig wrote:
> > Sending uevents requires the struct device to be alive.  To
> > ensure that grab the device refcount instead of just an inode
> > reference.
> > 
> > Fixes: bc359d03c7ec ("block: add a disk_uevent helper")
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  block/genhd.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/block/genhd.c b/block/genhd.c
> > index 79aa40b4c39c..af4d2ab4a633 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -365,12 +365,12 @@ void disk_uevent(struct gendisk *disk, enum kobject_action action)
> >  	xa_for_each(&disk->part_tbl, idx, part) {
> >  		if (bdev_is_partition(part) && !bdev_nr_sectors(part))
> >  			continue;
> > -		if (!bdgrab(part))
> > +		if (!kobject_get_unless_zero(&part->bd_device.kobj))
> >  			continue;
> 
> ->bd_device is embedded in the block device, and it has same lifetime
> with the block device, even part_release() calls bdput() to release this
> device, so why doesn't work by holding a inode reference?

Because sending a uevent on a device that has device_del called on it
is going to blow up.
