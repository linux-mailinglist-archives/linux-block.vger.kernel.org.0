Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61F2F6370F
	for <lists+linux-block@lfdr.de>; Tue,  9 Jul 2019 15:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfGINhf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 9 Jul 2019 09:37:35 -0400
Received: from verein.lst.de ([213.95.11.211]:42989 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbfGINhf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Jul 2019 09:37:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4108A227A81; Tue,  9 Jul 2019 15:37:34 +0200 (CEST)
Date:   Tue, 9 Jul 2019 15:37:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <matias.bjorling@wdc.com>
Subject: Re: [PATCH] block: Fix potential overflow in blk_report_zones()
Message-ID: <20190709133734.GB2201@lst.de>
References: <20190709075348.24823-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709075348.24823-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 09, 2019 at 04:53:48PM +0900, Damien Le Moal wrote:
> For large values of the number of zones reported, the sector increment
> calculated with "blk_queue_zone_sectors(q) * n" can overflow the
> unsigned int type used. Fix this with a cast to sector_t type.

How about just returning a sector_t from blk_queue_zone_sectors, turning
this into an automatic implicit cast for all callers?
