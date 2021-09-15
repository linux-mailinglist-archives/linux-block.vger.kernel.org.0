Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9CD40C689
	for <lists+linux-block@lfdr.de>; Wed, 15 Sep 2021 15:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbhIONla (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Sep 2021 09:41:30 -0400
Received: from verein.lst.de ([213.95.11.211]:36398 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233520AbhIONl3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 09:41:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 48BC967357; Wed, 15 Sep 2021 15:40:08 +0200 (CEST)
Date:   Wed, 15 Sep 2021 15:40:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] scsi: core: cleanup request queue before releasing
 gendisk
Message-ID: <20210915134008.GA13933@lst.de>
References: <20210915092547.990285-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915092547.990285-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 15, 2021 at 05:25:47PM +0800, Ming Lei wrote:
> gendisk instance has to be released after request queue is cleaned up
> because bdi is referred from gendisk since commit edb0872f44ec ("block:
> move the bdi from the request_queue to the gendisk").
> 
> For sd and sr, gendisk can be removed in the release handler(sd_remove/
> sr_remove) of sdev->sdev_gendev, which is triggered in device_del(sdev->sdev_gendev)
> in __scsi_remove_device(), when the request queue isn't cleaned up yet.
> 
> So kernel oops could be triggered when referring bdi via gendisk.
> 
> Fix the issue by moving blk_cleanup_queue() into sd_remove() and
> sr_remove().

This looks like a bit of a bandaid to me.  I think the proper fix
is to move the parts of blk_cleanup_queue that need a disk or bdi
to del_gendisk.
