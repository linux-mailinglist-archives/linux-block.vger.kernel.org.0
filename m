Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6010F41581A
	for <lists+linux-block@lfdr.de>; Thu, 23 Sep 2021 08:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239250AbhIWGK5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 23 Sep 2021 02:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239226AbhIWGKz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 02:10:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36D686115A;
        Thu, 23 Sep 2021 06:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632377364;
        bh=AtQTlBMq8A/bwaK7+ylBueGzhso1tQLgQ9j89A9siLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xwh+uEATwHdqF7NmcBcEwAddya1IyFP+R7sOYr0qkdwRpXqEYNk2n8/6crf/qYPRG
         9S3d4YTjpQNOSd/EsUQ+f0msDjM2Ak/mFCYS5r/Uxwhtz4YdeWGl3bOJ0C+eh27CB+
         R2JcmU8tVdILFYXJEi5TAI/8yscs9h95G5+TIQn0=
Date:   Thu, 23 Sep 2021 08:08:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Coly Li <colyli@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
        antlists@youngman.org.uk, Dan Williams <dan.j.williams@intel.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        NeilBrown <neilb@suse.de>, Richard Fan <richard.fan@suse.com>,
        Vishal L Verma <vishal.l.verma@intel.com>, rafael@kernel.org
Subject: Re: Too large badblocks sysfs file (was: [PATCH v3 0/7] badblocks
 improvement for multiple bad block ranges)
Message-ID: <YUwZ95Z+L5M3aZ9V@kroah.com>
References: <20210913163643.10233-1-colyli@suse.de>
 <a0f7b021-4816-6785-a9a4-507464b55895@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0f7b021-4816-6785-a9a4-507464b55895@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 23, 2021 at 01:59:28PM +0800, Coly Li wrote:
> Hi all the kernel gurus, and folks in mailing lists,
> 
> This is a question about exporting 4KB+ text information via sysfs
> interface. I need advice on how to handle the problem.

Please do not do that.  Seriously, that is not what sysfs is for, and is
an abuse of it.

sysfs is for "one value per file" and should never even get close to a
4kb limit.  If it does, you are doing something really really wrong and
should just remove that sysfs file from the system and redesign your
api.

> Recently I work on the bad blocks API (block/badblocks.c) improvement, there
> is a sysfs file to export the bad block ranges for me raid. E.g for a md
> raid1 device, file
>     /sys/block/md0/md/rd0/bad_blocks
> may contain the following text content,
>     64 32
>    128 8

Ick, again, that's not ok at all.  sysfs files should never have to be
parsed like this.

thanks,

greg k-h
