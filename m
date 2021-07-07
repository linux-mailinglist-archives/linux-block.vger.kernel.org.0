Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06473BE959
	for <lists+linux-block@lfdr.de>; Wed,  7 Jul 2021 16:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbhGGOIS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 7 Jul 2021 10:08:18 -0400
Received: from verein.lst.de ([213.95.11.211]:37066 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231618AbhGGOIR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Jul 2021 10:08:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B225068C7B; Wed,  7 Jul 2021 16:05:29 +0200 (CEST)
Date:   Wed, 7 Jul 2021 16:05:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH V2 5/6] virtio: add one field into virtio_device for
 recording if device uses managed irq
Message-ID: <20210707140529.GA24637@lst.de>
References: <20210702150555.2401722-1-ming.lei@redhat.com> <20210702150555.2401722-6-ming.lei@redhat.com> <20210706054203.GC17027@lst.de> <87bl7eqyr2.ffs@nanos.tec.linutronix.de> <YOV3HgWG6F3geECm@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOV3HgWG6F3geECm@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 07, 2021 at 05:42:54PM +0800, Ming Lei wrote:
> The problem is that how blk-mq looks at that flag, since the device
> representing the controller which allocates irq vectors isn't visible
> to blk-mq.

In blk_mq_pci_map_queues and similar helpers.
