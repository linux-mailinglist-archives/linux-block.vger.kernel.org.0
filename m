Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2DA1AD952
	for <lists+linux-block@lfdr.de>; Fri, 17 Apr 2020 11:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbgDQI7N (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 17 Apr 2020 04:59:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:42364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729890AbgDQI7N (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Apr 2020 04:59:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CE6EFAC22;
        Fri, 17 Apr 2020 08:59:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E272B1E0E58; Fri, 17 Apr 2020 10:59:09 +0200 (CEST)
Date:   Fri, 17 Apr 2020 10:59:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] bdi: add a ->dev_name field to struct
 backing_dev_info
Message-ID: <20200417085909.GA12234@quack2.suse.cz>
References: <20200416165453.1080463-1-hch@lst.de>
 <20200416165453.1080463-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416165453.1080463-4-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 16-04-20 18:54:48, Christoph Hellwig wrote:
> Cache a copy of the name for the life time of the backing_dev_info
> structure so that we can reference it even after unregistering.
> 
> Fixes: 68f23b89067f ("memcg: fix a crash in wb_workfn when a device disappears")
> Reported-by: Yufen Yu <yuyufen@huawei.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

...

> @@ -938,7 +938,8 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
>  	if (bdi->dev)	/* The driver needs to use separate queues per device */
>  		return 0;
>  
> -	dev = device_create_vargs(bdi_class, NULL, MKDEV(0, 0), bdi, fmt, args);
> +	vsnprintf(bdi->dev_name, sizeof(bdi->dev_name), fmt, args);
> +	dev = device_create(bdi_class, NULL, MKDEV(0, 0), bdi, bdi->dev_name);
>  	if (IS_ERR(dev))
>  		return PTR_ERR(dev);
>  

This can have a sideeffect not only bdi->dev_name will be truncated to 64
chars (which generally doesn't matter) but possibly also kobject name will
be truncated in the same way.  Which may have user visible effects. E.g.
for fs/vboxsf 64 chars need not be enough. So shouldn't we rather do it the
other way around - i.e., let device_create_vargs() create the device name
and then copy to bdi->dev_name whatever fits?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
