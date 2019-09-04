Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC60FA7AF7
	for <lists+linux-block@lfdr.de>; Wed,  4 Sep 2019 07:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfIDFv3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 4 Sep 2019 01:51:29 -0400
Received: from verein.lst.de ([213.95.11.211]:36140 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfIDFv3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Sep 2019 01:51:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B0AEE227A8A; Wed,  4 Sep 2019 07:51:26 +0200 (CEST)
Date:   Wed, 4 Sep 2019 07:51:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, hch@lst.de, sagi@grimberg.me,
        shlomin@mellanox.com, israelr@mellanox.com
Subject: Re: [PATCH 2/4] nvme-rdma: simplify error flow in
 nvme_rdma_queue_rq
Message-ID: <20190904055126.GC10553@lst.de>
References: <1567523655-23989-1-git-send-email-maxg@mellanox.com> <1567523655-23989-2-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567523655-23989-2-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 03, 2019 at 06:14:13PM +0300, Max Gurtovoy wrote:
> Make the error flow symmetric to the good flow by moving the call to
> nvme_cleanup_cmd from nvme_rdma_unmap_data function.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>

Looks good, and also independent from the PI changes:

Reviewed-by: Christoph Hellwig <hch@lst.de>
