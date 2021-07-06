Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7313BC620
	for <lists+linux-block@lfdr.de>; Tue,  6 Jul 2021 07:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhGFFlG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Jul 2021 01:41:06 -0400
Received: from verein.lst.de ([213.95.11.211]:59159 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230004AbhGFFlG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jul 2021 01:41:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CA00568BEB; Tue,  6 Jul 2021 07:38:25 +0200 (CEST)
Date:   Tue, 6 Jul 2021 07:38:25 +0200
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
        Damien Le Moal <damien.lemoal@wdc.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
        Don Brace <don.brace@microchip.com>,
        James Smart <james.smart@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Nilesh Javali <njavali@marvell.com>
Subject: Re: [PATCH V2 4/6] scsi: set shost->use_managed_irq if driver uses
 managed irq
Message-ID: <20210706053825.GB17027@lst.de>
References: <20210702150555.2401722-1-ming.lei@redhat.com> <20210702150555.2401722-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702150555.2401722-5-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Only megaraid_sas actually ever uses more than a single blk-mq
queue, so this looks weird?
