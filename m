Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37D0408489
	for <lists+linux-block@lfdr.de>; Mon, 13 Sep 2021 08:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbhIMGOV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 13 Sep 2021 02:14:21 -0400
Received: from verein.lst.de ([213.95.11.211]:53563 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237256AbhIMGOV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 02:14:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6F1E067373; Mon, 13 Sep 2021 08:13:03 +0200 (CEST)
Date:   Mon, 13 Sep 2021 08:13:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lihong Kou <koulihong@huawei.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] block: nvme: fix the NULL ptr bug in
 bio_integrity_verify_fn
Message-ID: <20210913061303.GA4324@lst.de>
References: <20210911024906.1125259-1-koulihong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911024906.1125259-1-koulihong@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -	blk_integrity_unregister(disk);
> +	if (blk_get_integrity(disk))
> +		blk_integrity_unregister(disk);

Instead of open coding this in the callers I think we should make
blk_integrity_unregister a no-op if no integrity profile was registered.
Also please split this into two logically separate patches.
