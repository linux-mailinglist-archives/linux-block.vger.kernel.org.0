Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55D7157E2B
	for <lists+linux-block@lfdr.de>; Thu, 27 Jun 2019 10:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfF0IZp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 27 Jun 2019 04:25:45 -0400
Received: from verein.lst.de ([213.95.11.211]:50577 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfF0IZp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 04:25:45 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5F27B68B20; Thu, 27 Jun 2019 10:25:13 +0200 (CEST)
Date:   Thu, 27 Jun 2019 10:25:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V4 1/3] block: Allow mapping of vmalloc-ed buffers
Message-ID: <20190627082513.GA11043@lst.de>
References: <20190627024910.23987-1-damien.lemoal@wdc.com> <20190627024910.23987-2-damien.lemoal@wdc.com> <20190627074720.GB24671@ming.t460p> <BYAPR04MB581604217983C81B2BA5BA4FE7FD0@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB581604217983C81B2BA5BA4FE7FD0@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 27, 2019 at 08:17:08AM +0000, Damien Le Moal wrote:
> > Are your sure that invalidate[|flush]_kernel_vmap_range is needed for
> > bio_copy_kernel? The vmalloc buffer isn't involved in IO, and only
> > accessed by CPU.
> 
> Not sure at all. I am a little out of my league here.
> Christoph mentioned that this is necessary.
> 
> Christoph, can you confirm ?

Ming is right.  Sorry for misleading you.
