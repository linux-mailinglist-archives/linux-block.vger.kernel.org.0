Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E65389F98
	for <lists+linux-block@lfdr.de>; Thu, 20 May 2021 10:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhETIQK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 May 2021 04:16:10 -0400
Received: from verein.lst.de ([213.95.11.211]:41205 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhETIQK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 04:16:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0609367354; Thu, 20 May 2021 10:14:46 +0200 (CEST)
Date:   Thu, 20 May 2021 10:14:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     Gulam Mohamed <gulam.mohamed@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: Re: fix a race between del_gendisk and BLKRRPART v2
Message-ID: <20210520081446.GA30422@lst.de>
References: <20210514131842.1600568-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514131842.1600568-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,

can you take a look at these?

On Fri, May 14, 2021 at 03:18:40PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this is based of a patch from Gulam and suggestions from Ming and fixes a
> race between del_gendisk and BLKRRPART while also removing a global lock.
> 
> Changes since v1:
>  - fix the GENHD_FL_UP check in __blkdev_get
>  - don't change where remove_inode_hash is called for now
>  - improve the commit message
> 
> Diffstat:
>  block/genhd.c         |   11 +----------
>  fs/block_dev.c        |   18 ++++++++----------
>  include/linux/genhd.h |    2 --
>  3 files changed, 9 insertions(+), 22 deletions(-)
---end quoted text---
