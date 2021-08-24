Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635BF3F5829
	for <lists+linux-block@lfdr.de>; Tue, 24 Aug 2021 08:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhHXG0r (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 Aug 2021 02:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhHXG0p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 02:26:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B638C061575;
        Mon, 23 Aug 2021 23:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NKFJoeYTqWpvwgOnvXGlWBRk4r7Ma5K7sZ2OJmDpXzU=; b=U7bi6QnCeU8LmhajLwuLPmnZlS
        LjSyGkqk3km9uYYmJ7D5A9FFyl8qVqyLW2dfuD8Ey8BE2oTJ7QhvGHnt6NVlXtwcw0N/4OKry2xhN
        ba3337soV7oOg168NKc9dJPzJA1GboxJ1Qg8fj/tc7TI9Qcy7teO73MZ+eDQn7lsnB2FMUEps7QP0
        KaNE4SkdKl+SeKbKHrIYiizI5JxTpPKmjNEV88s8nzhoGAiwvVk2/fA1iL0kMowDCe/U8zlI41FuG
        QyC+3ZjOnn4G15hGXUmlVCQ6nZQOKtHTa5N3QvBQ3yFlhFGWpoMdoW17uzS4YCcvcRY36HbpEwDJc
        85FfU+PQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIPoQ-00AeEP-DQ; Tue, 24 Aug 2021 06:21:46 +0000
Date:   Tue, 24 Aug 2021 07:21:30 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
        kbusch@kernel.org, sagi@grimberg.me, adrian.hunter@intel.com,
        beanhuo@micron.com, ulf.hansson@linaro.org, avri.altman@wdc.com,
        swboyd@chromium.org, agk@redhat.com, snitzer@redhat.com,
        josef@toxicpanda.com, hch@infradead.org, hare@suse.de,
        bvanassche@acm.org, ming.lei@redhat.com,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-mmc@vger.kernel.org, dm-devel@redhat.com,
        nbd@other.debian.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] dm: add add_disk() error handling
Message-ID: <YSSP6ujNQttGN2sZ@infradead.org>
References: <20210823202930.137278-1-mcgrof@kernel.org>
 <20210823202930.137278-9-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823202930.137278-9-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 23, 2021 at 01:29:28PM -0700, Luis Chamberlain wrote:
> -	add_disk(md->disk);
> +	r = add_disk(md->disk);
> +	if (r)
> +		goto out_cleanup_disk;
>  
>  	r = dm_sysfs_init(md);
> -	if (r) {
> -		del_gendisk(md->disk);
> -		return r;
> -	}
> +	if (r)
> +		goto out_del_gendisk;
>  	md->type = type;
>  	return 0;
> +
> +out_cleanup_disk:
> +	blk_cleanup_disk(md->disk);
> +out_del_gendisk:
> +	del_gendisk(md->disk);
> +	return r;

I think the add_disk should just return r.  If you look at the
callers they eventualy end up in dm_table_destroy, which does
this cleanup.
