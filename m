Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E853E5E5A
	for <lists+linux-block@lfdr.de>; Tue, 10 Aug 2021 16:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240734AbhHJOse (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 10 Aug 2021 10:48:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241888AbhHJOsb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 10:48:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4835560F25;
        Tue, 10 Aug 2021 14:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628606889;
        bh=BCaw6jsYR+1+ch9MuRv11DN73c0NzIIA0uUPkD5qS+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aejb1GlEF8xfjZg3Dr67Ia/+4GKCFO8u3xGOqykZ1QOXFXvGioKaoWlknitlue5jy
         qP6VTMWyAJbbfpGq7Os9IMYLQhtpH92htrvSy6mCEvGJMjWoGnbD2YsYH5f7kgir9r
         XT4G8X93IOY/K4TixaZ117wv82K9ARjVLNNzBJ1g=
Date:   Tue, 10 Aug 2021 16:48:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     axboe@kernel.dk, kernelnewbies@kernelnewbies.org,
        Ian Pilcher <arequipeno@gmail.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        pavel@ucw.cz, pali@kernel.org, hch@lst.de,
        linux-leds@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/10] Add configurable block device LED triggers
Message-ID: <YRKRpQdLRJmAb5kZ@kroah.com>
References: <20210809033217.1113444-1-arequipeno@gmail.com>
 <20210809205633.4300bbea@thinkpad>
 <81c128a1-c1b8-0f1e-a77b-6704bade26c0@gmail.com>
 <20210810004331.0f0094a5@thinkpad>
 <7b5f3509-5bcd-388b-8d3b-4ea95a9483ad@gmail.com>
 <YRIeHH1SLl6tYCeY@kroah.com>
 <20210810153840.42419d06@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210810153840.42419d06@thinkpad>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 10, 2021 at 03:38:40PM +0200, Marek Beh�n wrote:
> On Tue, 10 Aug 2021 08:35:08 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Mon, Aug 09, 2021 at 06:50:44PM -0500, Ian Pilcher wrote:
> > > On 8/9/21 5:43 PM, Marek Beh�n wrote:  
> > > > I confess that I am not very familiar with internal blkdev API.  
> > > 
> > > It's mainly a matter of symbol visibility.  See this thread from a few
> > > months ago:
> > > 
> > >   https://www.spinics.net/lists/linux-leds/msg18244.html
> > > 
> > > Now ... my code currently lives in block/, so there isn't actually
> > > anything technically preventing it from iterating through the block
> > > devices.
> > > 
> > > The reactions to Enzo's patch (which you can see in that thread) make me
> > > think that anything that iterates through all block devices is likely to
> > > be rejected, but maybe I'm reading too much into it.
> > > 
> > > 
> > > Greg / Christoph -
> > > 
> > > (As you were the people who expressed disapproval of Enzo's patch to
> > > export block_class and disk_type ...)
> > > 
> > > Can you weigh in on the acceptability of iterating through the block
> > > devices (searching by name) from LED trigger code within the block
> > > subsystem (i.e. no new symbols would need to be exported)?
> > > 
> > > This would allow the trigger to implement the sysfs API that Marek and
> > > Pavel want.  
> > 
> > No idea, let's see the change first, we can never promise anything :)
> 
> Hi Greg,
> 
> Can't we use blkdev_get_by_path() (or blk_lookup_devt() with
> blkdev_get_by_dev())?
> This would open the block device and return a struct block_device *.
> When the LED trigger is disabled, it would also have to release the
> device.

But what about when the device is removed from the system first?  Be
careful about that...

Anyway, sure, try those functions, I really do not know, all I
originally complained about was those exports which did not need to be
exported.

thanks,

greg k-h
