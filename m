Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E5D2FE544
	for <lists+linux-block@lfdr.de>; Thu, 21 Jan 2021 09:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbhAUIlv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 21 Jan 2021 03:41:51 -0500
Received: from verein.lst.de ([213.95.11.211]:59631 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbhAUIlm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 03:41:42 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7E4E067373; Thu, 21 Jan 2021 09:40:59 +0100 (CET)
Date:   Thu, 21 Jan 2021 09:40:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chao Leng <lengchao@huawei.com>
Cc:     linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        axboe@kernel.dk
Subject: Re: [PATCH v3 1/5] blk-mq: introduce blk_mq_set_request_complete
Message-ID: <20210121084059.GA25963@lst.de>
References: <20210121070330.19701-1-lengchao@huawei.com> <20210121070330.19701-2-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210121070330.19701-2-lengchao@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 21, 2021 at 03:03:26PM +0800, Chao Leng wrote:
> nvme drivers need to set the state of request to MQ_RQ_COMPLETE when
> directly complete request in queue_rq.
> So add blk_mq_set_request_complete.

So I'm not happy with this helper.  It should at least:

 a) be named and documented to only apply for the ->queue_rq faіlure case
 b) check that the request is in MQ_RQ_IDLE state
