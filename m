Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D292FFED2
	for <lists+linux-block@lfdr.de>; Fri, 22 Jan 2021 09:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbhAVI44 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 22 Jan 2021 03:56:56 -0500
Received: from verein.lst.de ([213.95.11.211]:35682 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbhAVInN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jan 2021 03:43:13 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id DB33168B05; Fri, 22 Jan 2021 09:42:31 +0100 (CET)
Date:   Fri, 22 Jan 2021 09:42:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@wdc.com>
Subject: Re: [PATCH v3 3/3] zonefs: use zone write granularity as block size
Message-ID: <20210122084231.GB15710@lst.de>
References: <20210122080014.174391-1-damien.lemoal@wdc.com> <20210122080014.174391-4-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122080014.174391-4-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
