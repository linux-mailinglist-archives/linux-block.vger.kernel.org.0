Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE21E3D2C98
	for <lists+linux-block@lfdr.de>; Thu, 22 Jul 2021 21:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhGVSf6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 22 Jul 2021 14:35:58 -0400
Received: from verein.lst.de ([213.95.11.211]:35721 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230307AbhGVSf6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jul 2021 14:35:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8473D67373; Thu, 22 Jul 2021 21:16:30 +0200 (CEST)
Date:   Thu, 22 Jul 2021 21:16:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Doug Gilbert <dgilbert@interlog.com>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 18/24] scsi_ioctl: move all "block layer" SCSI ioctl
 handling to drivers/scsi
Message-ID: <20210722191630.GB15065@lst.de>
References: <20210712054816.4147559-1-hch@lst.de> <20210712054816.4147559-19-hch@lst.de> <yq1im12w7ik.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1im12w7ik.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 22, 2021 at 02:06:40PM -0400, Martin K. Petersen wrote:
> > +static int blk_fill_sghdr_rq(struct request_queue *q, struct request *rq,
> > +			     struct sg_io_hdr *hdr, fmode_t mode)
> 
> [...]
> 
> > +static int blk_complete_sghdr_rq(struct request *rq, struct sg_io_hdr *hdr,
> > +				 struct bio *bio)
> > +{
> 
> Another couple of peculiar naming vestiges. These probably shouldn't
> have a "blk_" prefix now that they are under SCSI. Since they are
> internal to scsi_ioctl.c I propose you either drop the prefix completely
> or make it "scsi_".

Ok.  I'll keep __blk_send_generic and its callers for now as they'll
get removed later in the series.
