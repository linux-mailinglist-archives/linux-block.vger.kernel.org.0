Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F902542A8
	for <lists+linux-block@lfdr.de>; Thu, 27 Aug 2020 11:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgH0JoS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 27 Aug 2020 05:44:18 -0400
Received: from verein.lst.de ([213.95.11.211]:37523 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728303AbgH0JoS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 05:44:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C109068B02; Thu, 27 Aug 2020 11:44:15 +0200 (CEST)
Date:   Thu, 27 Aug 2020 11:44:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] block: Add a new helper to attempt to merge a
 bio
Message-ID: <20200827094415.GA16058@lst.de>
References: <cover.1597727255.git.baolin.wang@linux.alibaba.com> <7749d6068b9e5404ef59bacfcb278d604f84af75.1597727255.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7749d6068b9e5404ef59bacfcb278d604f84af75.1597727255.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 18, 2020 at 01:45:29PM +0800, Baolin Wang wrote:
> Meanwhile move the blk_mq_bio_list_merge() into blk-merge.c and
> rename it as a generic name.

That should probably a separate patch.

> +		if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) == BIO_MERGE_OK)
> +			return true;

This adds an overly long line.

> -		if (merged)
> +		switch (blk_attempt_bio_merge(q, rq, bio, nr_segs, true)) {
> +		default:
> +		case BIO_MERGE_NONE:
> +			continue;
> +		case BIO_MERGE_OK:
>  			return true;
> +		case BIO_MERGE_FAILED:
> +			return false;
> +		}

I don't think we need a default statement here as we handle all
possible values of the enum.
