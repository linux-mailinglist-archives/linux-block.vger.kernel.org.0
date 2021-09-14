Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C60740A6A1
	for <lists+linux-block@lfdr.de>; Tue, 14 Sep 2021 08:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240105AbhINGVa (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 14 Sep 2021 02:21:30 -0400
Received: from verein.lst.de ([213.95.11.211]:58626 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239868AbhINGV1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 02:21:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5A7FD67357; Tue, 14 Sep 2021 08:20:08 +0200 (CEST)
Date:   Tue, 14 Sep 2021 08:20:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     koulihong <koulihong@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe <axboe@kernel.dk>,
        kbusch <kbusch@kernel.org>, sagi <sagi@grimberg.me>,
        linux-block <linux-block@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] block: nvme: fix the NULL ptr bug in
 bio_integrity_verify_fn
Message-ID: <20210914062008.GA27421@lst.de>
References: <20210913061303.GA4324@lst.de> <ad51e8bf2bf04e9f9b1ff9ab36718935@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad51e8bf2bf04e9f9b1ff9ab36718935@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 14, 2021 at 06:15:19AM +0000, koulihong wrote:
> If we move the the conditional judgment to blk_integrity_unregister, we should do some
> cleanup work in md and nvme modules.  I will
> send the v3 patches two weeks later. I’m on a
> holiday, I have tow weeks off.

If you're fine with it I'll take over the series so that we can get
it queued up.
