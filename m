Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B183F2585
	for <lists+linux-block@lfdr.de>; Fri, 20 Aug 2021 06:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhHTEFm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 20 Aug 2021 00:05:42 -0400
Received: from verein.lst.de ([213.95.11.211]:39532 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232187AbhHTEFm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Aug 2021 00:05:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E7DC86736F; Fri, 20 Aug 2021 06:05:00 +0200 (CEST)
Date:   Fri, 20 Aug 2021 06:05:00 +0200
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
Subject: Re: [PATCH 3/9] sg: do not allocate a gendisk
Message-ID: <20210820040500.GA26305@lst.de>
References: <20210816131910.615153-1-hch@lst.de> <20210816131910.615153-4-hch@lst.de> <YR7OJ+lmps2H2fN/@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR7OJ+lmps2H2fN/@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 19, 2021 at 02:33:27PM -0700, Luis Chamberlain wrote:
> -	retval = scsi_ioctl(STp->device, STp->disk, file->f_mode, cmd_in, p);
> +	retval = scsi_ioctl(STp->device, NULL, file->f_mode, cmd_in, p);

Only in linux-next.  The change to pass the gendisk to scsi_ioctl is
only in the scsi tree, not the block tree.
