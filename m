Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1D330612B
	for <lists+linux-block@lfdr.de>; Wed, 27 Jan 2021 17:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhA0QmA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 27 Jan 2021 11:42:00 -0500
Received: from verein.lst.de ([213.95.11.211]:53687 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232283AbhA0QlF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 11:41:05 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2C0EE68B02; Wed, 27 Jan 2021 17:40:21 +0100 (CET)
Date:   Wed, 27 Jan 2021 17:40:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chao Leng <lengchao@huawei.com>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        axboe@kernel.dk
Subject: Re: [PATCH v4 1/5] blk-mq: introduce blk_mq_set_request_complete
Message-ID: <20210127164020.GA23417@lst.de>
References: <20210126081539.13320-1-lengchao@huawei.com> <20210126081539.13320-2-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126081539.13320-2-lengchao@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static inline void blk_mq_set_request_complete(struct request *rq)
> +{
> +	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
> +}

This function needs a detailed comment explaining the use case.
Otherwise we'll get lots of driver abuses.
