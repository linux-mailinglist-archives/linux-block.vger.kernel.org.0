Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A353F2589
	for <lists+linux-block@lfdr.de>; Fri, 20 Aug 2021 06:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhHTEGo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 20 Aug 2021 00:06:44 -0400
Received: from verein.lst.de ([213.95.11.211]:39544 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhHTEGo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Aug 2021 00:06:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0EC686736F; Fri, 20 Aug 2021 06:06:05 +0200 (CEST)
Date:   Fri, 20 Aug 2021 06:06:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/9] nvme: use blk_mq_alloc_disk
Message-ID: <20210820040604.GB26305@lst.de>
References: <20210816131910.615153-1-hch@lst.de> <20210816131910.615153-2-hch@lst.de> <YR7h0w6rJc9GYpaf@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YR7h0w6rJc9GYpaf@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 19, 2021 at 03:57:23PM -0700, Luis Chamberlain wrote:
> >  		if (nvme_nvm_register(ns, disk->disk_name, node)) {
> >  			dev_warn(ctrl->device, "LightNVM init failure\n");
> > -			goto out_put_disk;
> > +			goto out_unlink_ns;
> >  		}
> >  	}
> 
> This hunk will fail because of the now removed NVME_QUIRK_LIGHTNVM. The
> last part of the patch  then can be removed to apply to linux-next.

So this is not in the for-5.15/block tree, just the drivers one.

Jens, do you want to start a -late branch ontop of the block and drivers
branches so that we can pre-resolve these mergeѕ?
