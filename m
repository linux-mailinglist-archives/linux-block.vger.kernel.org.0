Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB19F3237E4
	for <lists+linux-block@lfdr.de>; Wed, 24 Feb 2021 08:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhBXH1H (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 24 Feb 2021 02:27:07 -0500
Received: from verein.lst.de ([213.95.11.211]:36446 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232823AbhBXH0q (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 02:26:46 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6539B68D0A; Wed, 24 Feb 2021 08:26:03 +0100 (CET)
Date:   Wed, 24 Feb 2021 08:26:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org, Tom Seewald <tseewald@gmail.com>
Subject: Re: [PATCH] block: reopen the device in blkdev_reread_part
Message-ID: <20210224072603.GA32368@lst.de>
References: <20210223151822.399791-1-hch@lst.de> <20210224015202.GA2166@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224015202.GA2166@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 24, 2021 at 10:52:02AM +0900, Minwoo Im wrote:
> On 21-02-23 16:18:22, Christoph Hellwig wrote:
> > Historically the BLKRRPART ioctls called into the now defunct ->revalidate
> > method, which caused the sd driver to check if any media is present.
> > When the ->revalidate method was removed this revalidation was lost,
> > leading to lots of I/O errors when using the eject command.  Fix this by
> > reopening the device to rescan the partitions, and thus calling the
> > revalidation logic in the sd driver.
> 
> It looks like a related issue that I've reported in [1].  And this looks
> much better!

I don't think it fixes the block size issue, does it?
