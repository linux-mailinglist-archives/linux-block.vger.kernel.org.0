Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15113C5245
	for <lists+linux-block@lfdr.de>; Mon, 12 Jul 2021 12:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241917AbhGLHpV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 12 Jul 2021 03:45:21 -0400
Received: from verein.lst.de ([213.95.11.211]:51520 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234130AbhGLHh6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Jul 2021 03:37:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D1CA467373; Mon, 12 Jul 2021 09:35:02 +0200 (CEST)
Date:   Mon, 12 Jul 2021 09:35:01 +0200
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
Subject: Re: [PATCH V3 03/10] blk-mq: pass use managed irq info to
 blk_mq_dev_map_queues
Message-ID: <20210712073501.GC12347@lst.de>
References: <20210709081005.421340-1-ming.lei@redhat.com> <20210709081005.421340-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709081005.421340-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As requested by me and Thomas please just add a flag in struct device
to propagate this information in a way that does not require all this
error probe boilerplate code.
