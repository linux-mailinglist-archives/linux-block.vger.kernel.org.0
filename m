Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8784258B13
	for <lists+linux-block@lfdr.de>; Tue,  1 Sep 2020 11:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgIAJKZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 1 Sep 2020 05:10:25 -0400
Received: from verein.lst.de ([213.95.11.211]:52584 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgIAJKY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Sep 2020 05:10:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C240F68CEC; Tue,  1 Sep 2020 11:10:20 +0200 (CEST)
Date:   Tue, 1 Sep 2020 11:10:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ilya Dryomov <idryomov@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] block: release disk reference in hd_struct_free_work
Message-ID: <20200901091020.GA4639@lst.de>
References: <20200901090033.313997-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901090033.313997-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 01, 2020 at 05:00:33PM +0800, Ming Lei wrote:
>  	struct hd_struct *part =
>  		container_of(to_rcu_work(work), struct hd_struct, rcu_work);
> +	struct gendisk *disk = part_to_disk(part);
> +
> +	/*
> +	 * Release disk reference grabbed in delete_partition, and it should
> +	 * have been done in hd_struct_free(), however device's release
> +	 * handler can't be run in percpu_ref's ->release() callback because
> +	 * it is run via call_rcu().
> +	 */
> +	put_device(disk_to_dev(disk));

The fix looks good, but the comment reads a little strange.  What about:

	/*
	 * Release the disk reference acquired in delete_partition here.
	 * We can't release it in hd_struct_free because the final put_device
	 * needs process context and thus can't be run directly from a
	 * percpu_ref ->release handler.
	 */
