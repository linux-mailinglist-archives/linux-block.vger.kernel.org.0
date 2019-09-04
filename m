Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 049B8A7AF5
	for <lists+linux-block@lfdr.de>; Wed,  4 Sep 2019 07:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbfIDFuf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 4 Sep 2019 01:50:35 -0400
Received: from verein.lst.de ([213.95.11.211]:36131 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbfIDFuf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Sep 2019 01:50:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B3E39227A8A; Wed,  4 Sep 2019 07:50:32 +0200 (CEST)
Date:   Wed, 4 Sep 2019 07:50:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, hch@lst.de, sagi@grimberg.me,
        shlomin@mellanox.com, israelr@mellanox.com
Subject: Re: [PATCH 4/4] nvmet-loop: fix possible leakage during error flow
Message-ID: <20190904055032.GB10553@lst.de>
References: <1567523655-23989-1-git-send-email-maxg@mellanox.com> <1567523655-23989-4-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567523655-23989-4-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 03, 2019 at 06:14:15PM +0300, Max Gurtovoy wrote:
> During nvme_loop_queue_rq error flow, one must call nvme_cleanup_cmd since
> it's symmetric to nvme_setup_cmd.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>

This seems independent from the rest of the series.  Looks good,
and we should queue it up ASAP:

Reviewed-by: Christoph Hellwig <hch@lst.de>
