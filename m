Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A213F453E
	for <lists+linux-block@lfdr.de>; Mon, 23 Aug 2021 08:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhHWGuV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 23 Aug 2021 02:50:21 -0400
Received: from verein.lst.de ([213.95.11.211]:46542 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231715AbhHWGuV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 02:50:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 46DD467373; Mon, 23 Aug 2021 08:49:36 +0200 (CEST)
Date:   Mon, 23 Aug 2021 08:49:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Doug Gilbert <dgilbert@interlog.com>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        oliver.sang@intel.com
Subject: Re: [PATCH 18/24] scsi_ioctl: move the "block layer" SCSI ioctl
 handling to drivers/scsi
Message-ID: <20210823064936.GA21806@lst.de>
References: <20210724072033.1284840-1-hch@lst.de> <20210724072033.1284840-19-hch@lst.de> <20210823084316.4bb224e0.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823084316.4bb224e0.pasic@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 23, 2021 at 08:43:16AM +0200, Halil Pasic wrote:
> I believe there is a small problem with this patch. I think it is
> easiest to explain with the diff that fixes it. Please see the patch
> at the end of this email.
> 
> Otherwise your patch looks great!
> 
> This may or may not be related to the problem reported here:
> https://lkml.org/lkml/2021/7/29/157
> Adding Oliver, maybe he can test if this fixes his testcases as well.
> (It did fix ours.:)
> 
> If you like I can respin my fix with an extended patch description.

No this looks good, but to make sure Martin picks it up please send it
as a separate thread.  It would be great it this fixes Olives issue,
but at least on my Debian systems blkid don't even call into SG_IO.
But maybe he has a different one or it is a cascading effect on that
particular setup.

Reviewed-by: Christoph Hellwig <hch@lst.de>
