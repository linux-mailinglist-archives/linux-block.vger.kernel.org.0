Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF902E9231
	for <lists+linux-block@lfdr.de>; Mon,  4 Jan 2021 09:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbhADI4R (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 Jan 2021 03:56:17 -0500
Received: from verein.lst.de ([213.95.11.211]:56920 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbhADI4R (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Jan 2021 03:56:17 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 835886736F; Mon,  4 Jan 2021 09:55:35 +0100 (CET)
Date:   Mon, 4 Jan 2021 09:55:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] block: don't allocate inline bvecs if this bioset
 needn't bvecs
Message-ID: <20210104085535.GB28949@lst.de>
References: <20201230003255.3450874-1-ming.lei@redhat.com> <20201230003255.3450874-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230003255.3450874-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 30, 2020 at 08:32:52AM +0800, Ming Lei wrote:
> The inline bvecs won't be used if user needn't bvecs by not passing
> BIOSET_NEED_BVECS, so don't allocate bvecs in this situation.

Looks sensible.

> -	bs->bio_slab = bio_find_or_create_slab(front_pad + back_pad);
> +	bs->bio_slab = bio_find_or_create_slab(bs->front_pad + bs->back_pad);

Passing the bioset to bio_find_or_create_slab and returning an errno
might be a nicer calling convention now.
