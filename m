Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0846D3E7BFD
	for <lists+linux-block@lfdr.de>; Tue, 10 Aug 2021 17:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242898AbhHJPUv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 10 Aug 2021 11:20:51 -0400
Received: from verein.lst.de ([213.95.11.211]:36760 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242850AbhHJPUt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 11:20:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 535C768B05; Tue, 10 Aug 2021 17:20:23 +0200 (CEST)
Date:   Tue, 10 Aug 2021 17:20:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nbd: do del_gendisk() asynchronously for
 NBD_DESTROY_ON_DISCONNECT
Message-ID: <20210810152023.GA14320@lst.de>
References: <20210805021215.855751-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805021215.855751-1-houtao1@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
