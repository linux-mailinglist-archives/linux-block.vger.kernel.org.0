Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE303C50C8
	for <lists+linux-block@lfdr.de>; Mon, 12 Jul 2021 12:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241450AbhGLHfP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 12 Jul 2021 03:35:15 -0400
Received: from verein.lst.de ([213.95.11.211]:51495 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242549AbhGLHbp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jul 2021 03:31:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B7F6D67373; Mon, 12 Jul 2021 09:28:53 +0200 (CEST)
Date:   Mon, 12 Jul 2021 09:28:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH V3 01/10] blk-mq: rename blk-mq-cpumap.c as blk-mq-map.c
Message-ID: <20210712072853.GA12347@lst.de>
References: <20210709081005.421340-1-ming.lei@redhat.com> <20210709081005.421340-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709081005.421340-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 09, 2021 at 04:09:56PM +0800, Ming Lei wrote:
> Firstly the name of cpumap isn't very useful because all kinds of map
> helpers(pci, rdma, virtio) are for mapping cpu(s) to hw queue.
> 
> Secondly prepare for moving physical device related mapping into its
> own subsystems, and we will put all map related functions/helpers into
> this renamed source file.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

I don't really see much of a point in this - we still create the cpu
maps, and if there is more code here that doesn't matter much, does it?
