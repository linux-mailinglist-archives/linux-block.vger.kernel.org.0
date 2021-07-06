Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9323BC639
	for <lists+linux-block@lfdr.de>; Tue,  6 Jul 2021 07:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhGFFzJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Jul 2021 01:55:09 -0400
Received: from verein.lst.de ([213.95.11.211]:59218 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230050AbhGFFzH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jul 2021 01:55:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 027F768BEB; Tue,  6 Jul 2021 07:52:27 +0200 (CEST)
Date:   Tue, 6 Jul 2021 07:52:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: Re: [PATCH 2/6] loop: conver timer for monitoring idle worker into
 dwork
Message-ID: <20210706055227.GG17027@lst.de>
References: <20210705102607.127810-1-ming.lei@redhat.com> <20210705102607.127810-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705102607.127810-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 05, 2021 at 06:26:03PM +0800, Ming Lei wrote:
> +static void loop_free_idle_workers(struct work_struct *work)
> +{
> +	struct loop_device *lo = container_of(work, struct loop_device,
> +			idle_work.work);
> +	struct loop_worker *pos, *worker;
> +
> +	spin_lock(&lo->lo_work_lock);
> +	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
> +				idle_list) {
> +		if (time_is_after_jiffies(worker->last_ran_at +
> +						LOOP_IDLE_WORKER_TIMEOUT))
> +			break;
> +		list_del(&worker->idle_list);
> +		rb_erase(&worker->rb_node, &lo->worker_tree);
> +		css_put(worker->blkcg_css);
> +		kfree(worker);
> +	}
> +	if (!list_empty(&lo->idle_worker_list))
> +		loop_set_timer(lo);
> +	spin_unlock(&lo->lo_work_lock);
> +}
> +
> +

Double empty line.  But that whole fact that the loop driver badly
reimplements work queues is just fucked up.  We need to revert this
shit.
