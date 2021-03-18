Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03F4340630
	for <lists+linux-block@lfdr.de>; Thu, 18 Mar 2021 13:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhCRM4s (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 Mar 2021 08:56:48 -0400
Received: from verein.lst.de ([213.95.11.211]:41586 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230477AbhCRM4T (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Mar 2021 08:56:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D84DC68C4E; Thu, 18 Mar 2021 13:56:17 +0100 (CET)
Date:   Thu, 18 Mar 2021 13:56:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        keescook@chromium.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: do not copy data to user when bi_status is error
Message-ID: <20210318125617.GC21262@lst.de>
References: <20210318122621.330010-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318122621.330010-1-yanaijie@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 18, 2021 at 08:26:21PM +0800, Jason Yan wrote:
> When the user submitted a request with unaligned buffer, we will
> allocate a new page and try to copy data to or from the new page.
> If it is a reading request, we always copy back the data to user's
> buffer, whether the result is good or error. So if the driver or
> hardware returns an error, garbage data is copied to the user space.
> This is a potential security issue which makes kernel info leaks.
> 
> So do not copy the uninitalized data to user's buffer if the
> bio->bi_status is not BLK_STS_OK in bio_copy_kern_endio_read().

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
