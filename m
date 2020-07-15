Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EFA2208FB
	for <lists+linux-block@lfdr.de>; Wed, 15 Jul 2020 11:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgGOJju (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Jul 2020 05:39:50 -0400
Received: from verein.lst.de ([213.95.11.211]:58401 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728043AbgGOJju (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jul 2020 05:39:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0632F6736F; Wed, 15 Jul 2020 11:39:48 +0200 (CEST)
Date:   Wed, 15 Jul 2020 11:39:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: always remove partitions from
 blk_drop_partitions()
Message-ID: <20200715093947.GA27731@lst.de>
References: <20200715083619.624249-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715083619.624249-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 15, 2020 at 04:36:19PM +0800, Ming Lei wrote:
> In theory, when GENHD_FL_NO_PART_SCAN is set, no partitions can be created
> on one disk. However, ioctl(BLKPG, BLKPG_ADD_PARTITION) doesn't check
> GENHD_FL_NO_PART_SCAN, so partitions still can be added even though
> GENHD_FL_NO_PART_SCAN is set.
> 
> So far blk_drop_partitions() only removes partitions when disk_part_scan_enabled()
> return true. This way can make ghost partition on loop device after changing/clearing
> FD in case that PARTSCAN is disabled, such as partitions can be added
> via 'parted' on loop disk even though GENHD_FL_NO_PART_SCAN is set.
> 
> Fix this issue by always removing partitions in blk_drop_partitions(), and
> this way is correct because the current code supposes that no partitions
> can be added in case of GENHD_FL_NO_PART_SCAN.

The changelog has a few overly long lines.

Otherwise:

Reviewed-by: Christoph Hellwig <hch@lst.de>
