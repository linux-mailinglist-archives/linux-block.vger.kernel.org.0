Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B2A3888D0
	for <lists+linux-block@lfdr.de>; Wed, 19 May 2021 09:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243177AbhESH6Y (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 19 May 2021 03:58:24 -0400
Received: from verein.lst.de ([213.95.11.211]:37157 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234405AbhESH6Y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 03:58:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1202A67373; Wed, 19 May 2021 09:57:03 +0200 (CEST)
Date:   Wed, 19 May 2021 09:57:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-block@vger.kernel.org, jasowang@redhat.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH] virtio-blk: limit seg_max to a safe value
Message-ID: <20210519075702.GA4225@lst.de>
References: <20210518150415.152730-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518150415.152730-1-stefanha@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 18, 2021 at 04:04:15PM +0100, Stefan Hajnoczi wrote:
> +	/* Prevent integer overflows and excessive blk-mq req cmd_size */
> +	sg_elems = min_t(u32, sg_elems, SG_MAX_SEGMENTS);

Please pick your own constant here instead of abusing some kernel
implementation detail (that is fairly SCSI specific to start with).

It might be useful to also document such limits, even if just advisory,
in the virtio spec.
