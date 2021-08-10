Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B4E3D8878
	for <lists+linux-block@lfdr.de>; Wed, 28 Jul 2021 09:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbhG1HDS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 28 Jul 2021 03:03:18 -0400
Received: from verein.lst.de ([213.95.11.211]:52604 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229939AbhG1HDP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jul 2021 03:03:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C555868AFE; Wed, 28 Jul 2021 09:03:11 +0200 (CEST)
Date:   Wed, 28 Jul 2021 09:03:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hou Tao <houtao1@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: Re: [PATCH] nbd: do del_gendisk() asynchronously
Message-ID: <20210728070311.GB4815@lst.de>
References: <20210728044211.115787-1-houtao1@huawei.com> <20210728053915.GA3374@lst.de> <3b55c3e6-d286-9c64-46bf-3018929c7a54@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b55c3e6-d286-9c64-46bf-3018929c7a54@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 28, 2021 at 02:56:48PM +0800, Hou Tao wrote:
> Hi,
> 
> Thanks for your review.
> 
> Now I am not sure whether or not it is a better idea that doing synchronous or asynchronous del_gendisk()
> 
> according to NBD_CFLAG_DESTROY_ON_DISCONNECT, and will wait for some feedback from Josef.

The other option would be to add a variant of del_gendisk that does
expect the open_mutex to be held over the whole operation.  But I'd be
happy if we could avoid that.
