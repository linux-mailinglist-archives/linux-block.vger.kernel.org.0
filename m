Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F39047783F
	for <lists+linux-block@lfdr.de>; Thu, 16 Dec 2021 17:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbhLPQTc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 Dec 2021 11:19:32 -0500
Received: from verein.lst.de ([213.95.11.211]:33021 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238764AbhLPQTb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Dec 2021 11:19:31 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 55EFC68B05; Thu, 16 Dec 2021 17:19:29 +0100 (CET)
Date:   Thu, 16 Dec 2021 17:19:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: fix error handling for device_add_disk
Message-ID: <20211216161928.GB31879@lst.de>
References: <c614deb3-ce75-635e-a311-4f4fc7aa26e3@i-love.sakura.ne.jp> <20211216161806.GA31879@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216161806.GA31879@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 16, 2021 at 05:18:06PM +0100, Christoph Hellwig wrote:
> >  out_disk_release_events:
> > -	disk_release_events(disk);
> > +	/* disk_release() will call disk_release_events(). */
> >  out_free_ext_minor:
> >  	if (disk->major == BLOCK_EXT_MAJOR)
> >  		blk_free_ext_minor(disk->first_minor);
> 
> .. actually while you're at it - blk_free_ext_minor is also done
> by bdev_free_inode called from disk_release.
> 
> So we can just remove the out_disk_release_events and out_free_ext_minor
> labels entirely. 

... of course we can't.  But we should return after the
device_del instead of falling through to the other resource cleanups.
