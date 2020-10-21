Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E6B29538D
	for <lists+linux-block@lfdr.de>; Wed, 21 Oct 2020 22:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444164AbgJUUjU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 21 Oct 2020 16:39:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439488AbgJUUjU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Oct 2020 16:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603312757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XFu7nKGWfgR41NTGeZhISUfmva0FXZ+FWfy7+zaFqEM=;
        b=Ek0LNcar+wUFY67rfS8yasuOnZ2g8wyI7GrKvlplD3eq8LSCQXlv++6tYZvgMgqFqmAdoX
        HZwbv/gdndd/j6cNXi/AEVljEIXa+JboGTYgG+oUotjK0XeTQfu4HTsXCqpozoFa2no9+n
        Bj/mSvKAchzFXqB9/V1aWpzP8fMKhmg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-O-udNqsyOlqVR3QBMTYdhg-1; Wed, 21 Oct 2020 16:39:13 -0400
X-MC-Unique: O-udNqsyOlqVR3QBMTYdhg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EF39107AFA5;
        Wed, 21 Oct 2020 20:39:12 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B70895B4B1;
        Wed, 21 Oct 2020 20:39:07 +0000 (UTC)
Date:   Wed, 21 Oct 2020 16:39:07 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, dm-devel@redhat.com,
        joseph.qi@linux.alibaba.com, xiaoguang.wang@linux.alibaba.com,
        haoxu@linux.alibaba.com
Subject: Re: [RFC 0/3] Add support of iopoll for dm device
Message-ID: <20201021203906.GA10896@redhat.com>
References: <20201020065420.124885-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020065420.124885-1-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 20 2020 at  2:54am -0400,
Jeffle Xu <jefflexu@linux.alibaba.com> wrote:

> This patch set adds support of iopoll for dm device.
> 
> This is only an RFC patch. I'm really looking forward getting your
> feedbacks on if you're interested in supporting iopoll for dm device,
> or if there's a better design to implement that.
> 
> Thanks.
> 
> 
> [Purpose]
> IO polling is an important mode of io_uring. Currently only mq devices
> support iopoll. As for dm devices, only dm-multipath is request-base,
> while others are all bio-based and have no support for iopoll.
> Supporting iopoll for dm devices can be of great meaning when the
> device seen by application is dm device such as dm-linear/dm-stripe,
> in which case iopoll is not usable for io_uring.

I appreciate you taking the initiative on this; polling support is on my
TODO so your work serves as a nice reminder to pursue this more
urgently.

> [Design Notes]
> 
> cookie
> ------
> Let's start from cookie. Cookie is one important concept in iopoll. It
> is used to identify one specific request in one specific hardware queue.
> The concept of cookie is initially designed as a per-bio concept, and
> thus it doesn't work well when bio-split involved. When bio is split,
> the returned cookie is indeed the cookie of one of the split bio, and
> the following polling on this returned cookie can only guarantee the
> completion of this specific split bio, while the other split bios may
> be still uncompleted. Bio-split is also resolved for dm device, though
> in another form, in which case the original bio submitted to the dm
> device may be split into multiple bios submitted to the underlying
> devices.
> 
> In previous discussion, Lei Ming has suggested that iopoll should be
> disabled for bio-split. This works for the normal bio-split (done in
> blk_mq_submit_bio->__blk_queue_split), while iopoll will never be
> usable for dm devices if this also applies for dm device.
> 
> So come back to the design of the cookie for dm devices. At the very
> beginning I want to refactor the design of cookie, from 'unsigned int'
> type to the pointer type for dm device, so that cookie can point to
> something, e.g. a list containing all cookies of one original bio,
> something like this:
> 
> struct dm_io { // the returned cookie points to dm_io
> 	...
> 	struct list_head cookies; 
> };
> 
> In this design, we can fetch all cookies of one original bio, but the
> implementation can be difficult and buggy. For example, the
> 'struct dm_io' structure may be already freed when the returned cookie
> is used in blk_poll(). Then what if maintain a refcount in struct dm_io
> so that 'struct dm_io' structure can not be freed until blk_poll()
> called? Then the 'struct dm_io' structure will never be freed if the
> IO polling is not used at all.

I'd have to look closer at the race in the code you wrote (though you
didn't share it); but we cannot avoid properly mapping a cookie to each
split bio.  Otherwise you resort to inefficiently polling everything.

Seems your attempt to have the cookie point to a dm_io object was likely
too coarse-grained (when bios are split they get their own dm_io on
recursive re-entry to DM core from ->submit_bio); but isn't having a
list of cookies still too imprecise for polling purposes?  You could
easily have a list that translates to many blk-mq queues.  Possibly
better than your current approach of polling everything -- but not
much.

> So finally I gived up refactoring the design of cookie and maintain all
> cookies of one original bio. The initial design of cookie gets retained.
> The returned cookie is still the cookie of one of the split bio, and thus
> it is not used at all when polling dm devices. The polling of dm device,
> is indeed iterating and polling on all hardware queues (in polling mode)
> of all underlying target devices.
>
> This design is simple and easy to implement. But I'm not sure if the
> performance can be an issue if one dm device mapped to too many target
> devices or the dm stack depth grows.

You showed 40% performance improvement but it really just does the bare
minimum of implementing polling.  It is so simplistic that I really
don't think the design even serves as a starting point for what will be
needed.  So this needs further design time.

What you've _done_ could serve as a stop-gap but I'd really rather we
get it properly designed from the start.

> REQ_NOWAIT
> ----------
> The polling bio will set REQ_NOWAIT in bio->bi_flags, and the device
> need to be capable of handling REQ_NOWAIT. Commit 021a24460dc2
> ("block: add QUEUE_FLAG_NOWAIT") and commit 6abc49468eea ("dm: add
> support for REQ_NOWAIT and enable it for linear target") add this
> support for dm device, and currently only dm-linear supports that.
> 
> hybrid polling
> --------------
> When execute hybrid polling, cookie is used to fetch the request,
> and check if the request has completed or not. In the design for
> dm device described above, the returned cookie is still the cookie
> of one of the split bios, and thus we have no way checking if all
> the split bios have completed or not. Thus in the current
> implementation, hybrid polling is not supported for dm device.

I'll look closer at all this.  But DM targets do allow for additional
target specific per-bio-data to be added to the overall per-bio-data
size (via ti->per_io_data_size).  DM core _could_ internalize adding
additional space to per-bio-data for storing a unique cookie per
split/clone bio.

Conversely, block-core's bio cloning could manage this so long as it
knew how to access the offset into the established per-bio-data.  But
that might be more challenging to do without impacting use-cases outside
of DM.

Thanks,
Mike


> [Performance]
> I test 4k-randread on a dm-linear mapped to only one nvme device.
> 
> SSD: INTEL SSDPEDME800G4
> dm-linear:dmsetup create testdev --table "0 209715200 linear /dev/nvme0n1 0"
> 
> fio configs:
> ```
> ioengine=io_uring
> iodepth=128
> numjobs=1
> thread
> rw=randread
> direct=1
> registerfiles=1
> #hipri=1 with iopoll enabled, hipri=0 with iopoll disabled
> bs=4k
> size=100G
> runtime=60
> time_based
> group_reporting
> randrepeat=0
> 
> [device]
> filename=/dev/mapper/testdev
> ```
> 
> The test result shows that there's ~40% performance growth when iopoll
> enabled.
> 
> test | iops | bw | avg lat
> ---- | ---- | ---- | ----
> iopoll-disabled | 244k | 953MiB/s  | 524us
> iopoll-enabled  | 345k | 1349MiB/s | 370us
> 
> [TODO]
> The store method of "io_poll"/"io_poll_delay" has not been adapted
> for dm device.
> 
> 
> Jeffle Xu (3):
>   block/mq: add iterator for polling hw queues
>   block: add back ->poll_fn in request queue
>   dm: add support for IO polling
> 
>  block/blk-mq.c         | 30 ++++++++++++++++++++++++------
>  drivers/md/dm-core.h   |  1 +
>  drivers/md/dm-table.c  | 30 ++++++++++++++++++++++++++++++
>  drivers/md/dm.c        | 40 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/blk-mq.h |  6 ++++++
>  include/linux/blkdev.h |  3 +++
>  6 files changed, 104 insertions(+), 6 deletions(-)
> 
> -- 
> 2.27.0
> 

