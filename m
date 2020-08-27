Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C37253F88
	for <lists+linux-block@lfdr.de>; Thu, 27 Aug 2020 09:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgH0HsE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 27 Aug 2020 03:48:04 -0400
Received: from verein.lst.de ([213.95.11.211]:37012 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgH0HsD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 03:48:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EC6DB68C65; Thu, 27 Aug 2020 09:47:58 +0200 (CEST)
Date:   Thu, 27 Aug 2020 09:47:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Xianting Tian <xianting_tian@126.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: fix block device size update serialization v2
Message-ID: <20200827074758.GA8009@lst.de>
References: <20200823091043.2600261-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200823091043.2600261-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens, can you consider this for 5.9?  It reliably fixes the reported
hangs with nvme hotremoval that we've had for a few releases.

On Sun, Aug 23, 2020 at 11:10:40AM +0200, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series fixes how we update i_size for the block device inodes (and
> thus the block device).  Different helpers use two different locks
> (bd_mutex and i_rwsem) to protect the update, and it appears device
> mapper uses yet another internal lock.  A lot of the drivers do the
> update handcrafted in often crufty ways.  And in addition to that mess
> it turns out that the "main" lock, bd_mutex is pretty dead lock prone
> vs other spots in the block layer that acquire it during revalidation
> operations, as reported by Xianting.
> 
> Fix all that by adding a dedicated spinlock just for the size updates.
> 
> Changes since v1:
>  - don't call __invalidate_device under the new spinlock
>  - don't call into the file system code from the nvme removal code
---end quoted text---
