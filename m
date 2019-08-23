Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1703F9B89D
	for <lists+linux-block@lfdr.de>; Sat, 24 Aug 2019 00:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfHWWtf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 23 Aug 2019 18:49:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfHWWte (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Aug 2019 18:49:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7576F806CE;
        Fri, 23 Aug 2019 22:49:34 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E587318EF3;
        Fri, 23 Aug 2019 22:49:25 +0000 (UTC)
Date:   Sat, 24 Aug 2019 06:49:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH V2 6/6] block: split .sysfs_lock into two locks
Message-ID: <20190823224919.GA5152@ming.t460p>
References: <20190821091506.21196-1-ming.lei@redhat.com>
 <20190821091506.21196-7-ming.lei@redhat.com>
 <bf9762f7-1f1f-860e-cf98-b1838289e408@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf9762f7-1f1f-860e-cf98-b1838289e408@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 23 Aug 2019 22:49:34 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 23, 2019 at 09:46:48AM -0700, Bart Van Assche wrote:
> On 8/21/19 2:15 AM, Ming Lei wrote:
> > @@ -966,7 +966,7 @@ int blk_register_queue(struct gendisk *disk)
> >   		return ret;
> >   	/* Prevent changes through sysfs until registration is completed. */
> > -	mutex_lock(&q->sysfs_lock);
> > +	mutex_lock(&q->sysfs_dir_lock);
> >   	ret = kobject_add(&q->kobj, kobject_get(&dev->kobj), "%s", "queue");
> >   	if (ret < 0) {
> > @@ -987,26 +987,37 @@ int blk_register_queue(struct gendisk *disk)
> >   		blk_mq_debugfs_register(q);
> >   	}
> > -	kobject_uevent(&q->kobj, KOBJ_ADD);
> > -
> > -	wbt_enable_default(q);
> > -
> > -	blk_throtl_register_queue(q);
> > -
> > +	/*
> > +	 * The queue's kobject ADD uevent isn't sent out, also the
> > +	 * flag of QUEUE_FLAG_REGISTERED isn't set yet, so elevator
> > +	 * switch won't happen at all.
> > +	 */
> >   	if (q->elevator) {
> > -		ret = elv_register_queue(q);
> > +		ret = elv_register_queue(q, false);
> >   		if (ret) {
> 
> The above changes seems risky to me. In contrast with what the comment
> suggests, user space code is not required to wait for KOBJ_ADD event to
> start using sysfs attributes. I think user space code *can* write into the
> request queue I/O scheduler sysfs attribute after the kobject_add() call has
> finished and before kobject_uevent(&q->kobj, KOBJ_ADD) is called.

Yeah, one crazy userspace may simply poll on sysfs entres and start to
READ/WRITE before seeing the KOBJ_ADD event.

However, we have another protection via the queue flag QUEUE_FLAG_REGISTERED,
which is set after everything is done. So if userspace's early store
comes, elevator switch still can't happen because the flag is checked in
__elevator_change().

thanks,
Ming
