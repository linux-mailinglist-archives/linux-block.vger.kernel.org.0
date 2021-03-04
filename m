Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED6232D63F
	for <lists+linux-block@lfdr.de>; Thu,  4 Mar 2021 16:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbhCDPO2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 4 Mar 2021 10:14:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233860AbhCDPOO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Mar 2021 10:14:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614870768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1PKccDZxJZzWf6UmdzAmg+0FIgtiX2+VOvVVUPxQTIc=;
        b=HioaUvLi3FsYd6bXzhPUMfxK8FR98jM+0aIf/6iyqSwnoiZ8K42U369UgUtcDCLh7tOACe
        uA6pYLgb4QySnMcrHSsqqKqLgXUaWI6X8zAMuIZe6dvVRiSWxoixobgc859/MWxVmHGOBE
        6C8kya+LuvQWVIgpCfyyNkWpoOeUi6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-1E2bZhY3MzeKp9yjMtNiIQ-1; Thu, 04 Mar 2021 10:12:44 -0500
X-MC-Unique: 1E2bZhY3MzeKp9yjMtNiIQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76EB21018F70;
        Thu,  4 Mar 2021 15:12:43 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FED860CCB;
        Thu,  4 Mar 2021 15:12:40 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 124FCdF3007183;
        Thu, 4 Mar 2021 10:12:39 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 124FCdDr007179;
        Thu, 4 Mar 2021 10:12:39 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 4 Mar 2021 10:12:39 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Jeff Moyer <jmoyer@redhat.com>
cc:     JeffleXu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <msnitzer@redhat.com>,
        Heinz Mauelshagen <heinzm@redhat.com>, axboe@kernel.dk,
        caspar@linux.alibaba.com, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com,
        dm-devel@redhat.com, hch@lst.de
Subject: Re: [dm-devel] [PATCH 4/4] dm: support I/O polling
In-Reply-To: <x49o8fzklnx.fsf@segfault.boston.devel.redhat.com>
Message-ID: <alpine.LRH.2.02.2103041008440.31824@file01.intranet.prod.int.rdu2.redhat.com>
References: <20210302190555.201228400@debian-a64.vm> <33fa121a-88a8-5c27-0a43-a7efc9b5b3e3@linux.alibaba.com> <alpine.LRH.2.02.2103030505460.29593@file01.intranet.prod.int.rdu2.redhat.com> <x49o8fzklnx.fsf@segfault.boston.devel.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Thu, 4 Mar 2021, Jeff Moyer wrote:

> Hi, Mikulas,
> 
> Mikulas Patocka <mpatocka@redhat.com> writes:
> 
> > On Wed, 3 Mar 2021, JeffleXu wrote:
> >
> >> 
> >> 
> >> On 3/3/21 3:05 AM, Mikulas Patocka wrote:
> >> 
> >> > Support I/O polling if submit_bio_noacct_mq_direct returned non-empty
> >> > cookie.
> >> > 
> >> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> >> > 
> >> > ---
> >> >  drivers/md/dm.c |    5 +++++
> >> >  1 file changed, 5 insertions(+)
> >> > 
> >> > Index: linux-2.6/drivers/md/dm.c
> >> > ===================================================================
> >> > --- linux-2.6.orig/drivers/md/dm.c	2021-03-02 19:26:34.000000000 +0100
> >> > +++ linux-2.6/drivers/md/dm.c	2021-03-02 19:26:34.000000000 +0100
> >> > @@ -1682,6 +1682,11 @@ static void __split_and_process_bio(stru
> >> >  		}
> >> >  	}
> >> >  
> >> > +	if (ci.poll_cookie != BLK_QC_T_NONE) {
> >> > +		while (atomic_read(&ci.io->io_count) > 1 &&
> >> > +		       blk_poll(ci.poll_queue, ci.poll_cookie, true)) ;
> >> > +	}
> >> > +
> >> >  	/* drop the extra reference count */
> >> >  	dec_pending(ci.io, errno_to_blk_status(error));
> >> >  }
> >> 
> >> It seems that the general idea of your design is to
> >> 1) submit *one* split bio
> >> 2) blk_poll(), waiting the previously submitted split bio complets
> >
> > No, I submit all the bios and poll for the last one.
> 
> What happens if the last bio completes first?  It looks like you will
> call blk_poll with a cookie that already completed, and I'm pretty sure
> that's invalid.
> 
> Thanks,
> Jeff

If the last bio completes first, the other bios will use interrupt-driven 
endio.

Calling blk_poll with already completed cookie is IMHO legal - it happens 
with the current direct-io code too. The direct-io code will check for bio 
completion and if the bio is not completed, call blk_poll. The bio may be 
completed from an interrupt after the check and before blk_poll - in this 
case, we will call blk_poll with already completed cookie.

Mikulas

