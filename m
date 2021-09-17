Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B73940F7F8
	for <lists+linux-block@lfdr.de>; Fri, 17 Sep 2021 14:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238634AbhIQMiw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 17 Sep 2021 08:38:52 -0400
Received: from verein.lst.de ([213.95.11.211]:44897 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230483AbhIQMip (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Sep 2021 08:38:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 67E4467357; Fri, 17 Sep 2021 14:37:19 +0200 (CEST)
Date:   Fri, 17 Sep 2021 14:37:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] scsi: core: cleanup request queue before releasing
 gendisk
Message-ID: <20210917123719.GA17003@lst.de>
References: <20210915134008.GA13933@lst.de> <YUKfl9Qqsluh+5FX@T590> <20210916101451.GA26782@lst.de> <YUM6uFHqfjWMM5BH@T590> <20210916142009.GA12603@lst.de> <YUQOBKa67R9pEunr@T590.Home> <20210917065305.GA24012@lst.de> <YURGkXQndMxDEWxW@T590.Home> <20210917075650.GA28455@lst.de> <YURSj0G5gMiSAo5j@T590.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YURSj0G5gMiSAo5j@T590.Home>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 17, 2021 at 04:32:15PM +0800, Ming Lei wrote:
> > Is it?  For the typical case the second free in blk_cleanp_queue will
> > be bsically free because there is no pending I/O.  The only case
> > where that matters if if there is pending passthrough I/O again,
> > which can only happen with SCSI, and even there is highly unusual.
> 
> RCU grace period is involved in blk_freeze_queue().

where?

> One way you can
> avoid it is to keep the percpu ref at atomic mode when running
> blk_mq_unfreeze_queue() in del_gendisk().
> 
> 
> 
> Thanks,
> Ming
---end quoted text---
