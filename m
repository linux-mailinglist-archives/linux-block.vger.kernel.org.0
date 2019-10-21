Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB74DE2BD
	for <lists+linux-block@lfdr.de>; Mon, 21 Oct 2019 05:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfJUDos (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 20 Oct 2019 23:44:48 -0400
Received: from verein.lst.de ([213.95.11.211]:56456 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfJUDos (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Oct 2019 23:44:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 03CF868BE1; Mon, 21 Oct 2019 05:44:47 +0200 (CEST)
Date:   Mon, 21 Oct 2019 05:44:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/2 v2] nvme: Introduce nvme_lba_to_sect()
Message-ID: <20191021034446.GC11888@lst.de>
References: <20191021034004.11063-1-damien.lemoal@wdc.com> <20191021034004.11063-3-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021034004.11063-3-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 21, 2019 at 12:40:04PM +0900, Damien Le Moal wrote:
> Introduce the new helper function nvme_lba_to_sect() to convert a device
> logical block number to a 512B sector number. Use this new helper in
> obvious places, cleaning up the code.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
