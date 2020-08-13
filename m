Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F9F243CBF
	for <lists+linux-block@lfdr.de>; Thu, 13 Aug 2020 17:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgHMPno (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 13 Aug 2020 11:43:44 -0400
Received: from verein.lst.de ([213.95.11.211]:46793 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgHMPnn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Aug 2020 11:43:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B397B68AFE; Thu, 13 Aug 2020 17:43:40 +0200 (CEST)
Date:   Thu, 13 Aug 2020 17:43:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Changpeng Liu <changpeng.liu@intel.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH V2 2/3] block: virtio_blk: fix handling single range
 discard request
Message-ID: <20200813154340.GB14200@lst.de>
References: <20200811234420.2297137-1-ming.lei@redhat.com> <20200811234420.2297137-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811234420.2297137-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 12, 2020 at 07:44:19AM +0800, Ming Lei wrote:
> 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support") starts
> to support multi-range discard for virtio-blk. However, the virtio-blk
> disk may report max discard segment as 1, at least that is exactly what
> qemu is doing.
> 
> So far, block layer switches to normal request merge if max discard segment
> limit is 1, and multiple bios can be merged to single segment. This way may
> cause memory corruption in virtblk_setup_discard_write_zeroes().
> 
> Fix the issue by handling single max discard segment in straightforward
> way.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
