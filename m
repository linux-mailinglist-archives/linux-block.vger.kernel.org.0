Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0B738EE6E
	for <lists+linux-block@lfdr.de>; Mon, 24 May 2021 17:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhEXPu4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 24 May 2021 11:50:56 -0400
Received: from verein.lst.de ([213.95.11.211]:55412 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233832AbhEXPsu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 May 2021 11:48:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0AF5767373; Mon, 24 May 2021 17:47:20 +0200 (CEST)
Date:   Mon, 24 May 2021 17:47:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-block@vger.kernel.org, Xie Yongji <xieyongji@bytedance.com>,
        Christoph Hellwig <hch@lst.de>,
        "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com
Subject: Re: [PATCH v2] virtio-blk: limit seg_max to a safe value
Message-ID: <20210524154719.GA8498@lst.de>
References: <20210524154020.98195-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524154020.98195-1-stefanha@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 24, 2021 at 04:40:20PM +0100, Stefan Hajnoczi wrote:
> The struct virtio_blk_config seg_max value is read from the device and
> incremented by 2 to account for the request header and status byte
> descriptors added by the driver.
> 
> In preparation for supporting untrusted virtio-blk devices, protect
> against integer overflow and limit the value to a safe maximum.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
