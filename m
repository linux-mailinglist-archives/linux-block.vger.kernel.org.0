Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB443D872F
	for <lists+linux-block@lfdr.de>; Wed, 28 Jul 2021 07:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhG1FjT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 28 Jul 2021 01:39:19 -0400
Received: from verein.lst.de ([213.95.11.211]:52376 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229814AbhG1FjT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jul 2021 01:39:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B9F1067357; Wed, 28 Jul 2021 07:39:15 +0200 (CEST)
Date:   Wed, 28 Jul 2021 07:39:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nbd: do del_gendisk() asynchronously
Message-ID: <20210728053915.GA3374@lst.de>
References: <20210728044211.115787-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728044211.115787-1-houtao1@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks,

this looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
