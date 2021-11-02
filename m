Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953B3442BD9
	for <lists+linux-block@lfdr.de>; Tue,  2 Nov 2021 11:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhKBKwY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Nov 2021 06:52:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229770AbhKBKwX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Nov 2021 06:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635850188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Stb4+fCHX8yk7t0HzWUpLzpD3VwfDrSQlVWYPWZfL2E=;
        b=NcCH7NSL5wry56x9J1FgN1H6oep60xL7ROTnQvFqZhdYeLOpaDmwYdngtLxq4PL9frMuIQ
        rocSTiHcbIyJKKMZgt4SvZjcL34PZRviGCKuABw1Wi4wINxPii5X16oPf8UDPyjpp+GaBD
        rgyWusGSHaYviQgCY/lQPBtpaZGEOLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-AMrEnV7aOHuGHcnOfv7-VQ-1; Tue, 02 Nov 2021 06:49:45 -0400
X-MC-Unique: AMrEnV7aOHuGHcnOfv7-VQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 650DF101F001;
        Tue,  2 Nov 2021 10:49:44 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2054F60C0F;
        Tue,  2 Nov 2021 10:48:35 +0000 (UTC)
Date:   Tue, 2 Nov 2021 18:48:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, ming.lei@redhat.com
Subject: Re: [bug report] block/005 hangs with NVMe device and
 linux-block/for-next
Message-ID: <YYEXfnqi+mgVv54X@T590>
References: <20211101083417.fcttizyxpahrcgov@shindev>
 <30d7ccec-c798-3936-67bd-e66ae59c318b@kernel.dk>
 <f56c7b71-cef4-10be-7804-b171929cfb76@kernel.dk>
 <20211102022214.7hetxsg4z2yqafyd@shindev>
 <YYC0ESdW1+B/dDTs@T590>
 <20211102082846.m632phnsaqnwtaec@shindev>
 <20211102090246.5own2pqinv3lw6qg@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102090246.5own2pqinv3lw6qg@shindev>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 02, 2021 at 09:02:47AM +0000, Shinichiro Kawasaki wrote:
> Let me add linux-nvme, Keith and Christoph to the CC list.
> 
> -- 
> Best Regards,
> Shin'ichiro Kawasaki
> 
> 
> On Nov 02, 2021 / 17:28, Shin'ichiro Kawasaki wrote:
> > On Nov 02, 2021 / 11:44, Ming Lei wrote:
> > > On Tue, Nov 02, 2021 at 02:22:15AM +0000, Shinichiro Kawasaki wrote:
> > > > On Nov 01, 2021 / 17:01, Jens Axboe wrote:
> > > > > On 11/1/21 6:41 AM, Jens Axboe wrote:
> > > > > > On 11/1/21 2:34 AM, Shinichiro Kawasaki wrote:
> > > > > >> I tried the latest linux-block/for-next branch tip (git hash b43fadb6631f and
> > > > > >> observed a process hang during blktests block/005 run on a NVMe device.
> > > > > >> Kernel message reported "INFO: task check:1224 blocked for more than 122
> > > > > >> seconds." with call trace [1]. So far, the hang is 100% reproducible with my
> > > > > >> system. This hang is not observed with HDDs or null_blk devices.
> > > > > >>
> > > > > >> I bisected and found the commit 4f5022453acd ("nvme: wire up completion batching
> > > > > >> for the IRQ path") triggers the hang. When I revert this commit from the
> > > > > >> for-next branch tip, the hang disappears. The block/005 test case does IO
> > > > > >> scheduler switch during IO, and the completion path change by the commit looks
> > > > > >> affecting the scheduler switch. Comments for solution will be appreciated.
> > > > > > 
> > > > > > I'll take a look at this.
> > > > > 
> > > > > I've tried running various things most of the day, and I cannot
> > > > > reproduce this issue nor do I see what it could be. Even if requests are
> > > > > split between batched completion and one-by-one completion, it works
> > > > > just fine for me. No special care needs to be taken for put_many() on
> > > > > the queue reference, as the wake_up() happens for the ref going to zero.
> > > > > 
> > > > > Tell me more about your setup. What does the runtimes of the test look
> > > > > like? Do you have all schedulers enabled? What kind of NVMe device is
> > > > > this?
> > > > 
> > > > Thank you for spending your precious time. With the kernel without the hang,
> > > > the test case completes around 20 seconds. When the hang happens, the check
> > > > script process stops at blk_mq_freeze_queue_wait() at scheduler change, and fio
> > > > workload processes stop at __blkdev_direct_IO_simple(). The test case does not
> > > > end, so I need to reboot the system for the next trial. While waiting the test
> > > > case completion, the kernel repeats the same INFO message every 2 minutes.
> > > > 
> > > > Regarding the scheduler, I compiled the kernel with mq-deadline and kyber.
> > > > 
> > > > The NVMe device I use is a U.2 NVMe ZNS SSD. It has a zoned name space and
> > > > a regular name space, and the hang is observed with both name spaces. I have
> > > > not yet tried other NVME devices, so I will try them.
> > > > 
> > > > > 
> > > > > FWIW, this is upstream now, so testing with Linus -git would be
> > > > > preferable.
> > > > 
> > > > I see. I have switched from linux-block for-next branch to the upstream branch
> > > > of Linus. At git hash 879dbe9ffebc, and still the hang is observed.
> > > 
> > > Can you post the blk-mq debugfs log after the hang is triggered?
> > > 
> > > (cd /sys/kernel/debug/block/nvme0n1 && find . -type f -exec grep -aH . {} \;)
> > 
> > Thanks Ming. When I ran the command above, the grep command stopped when it
> > opened tag related files in the debugfs tree. That grep command looked hanking
> > also. So I used the find command below instead to exclude the tag related files.
> > 
> > # find . -type f -not -name *tag* -exec grep -aH . {} \;
> > 
> > Here I share the captured log.
> > 

It is a bit odd since batching completion shouldn't be triggered in case
of io sched, but blk_mq_end_request_batch() does not restart hctx, so
maybe you can try the following patch:


diff --git a/block/blk-mq.c b/block/blk-mq.c
index 07eb1412760b..4c0c9af9235e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -846,16 +846,20 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
 		rq_qos_done(rq->q, rq);
 
 		if (nr_tags == TAG_COMP_BATCH || cur_hctx != rq->mq_hctx) {
-			if (cur_hctx)
+			if (cur_hctx) {
 				blk_mq_flush_tag_batch(cur_hctx, tags, nr_tags);
+				blk_mq_sched_restart(cur_hctx);
+			}
 			nr_tags = 0;
 			cur_hctx = rq->mq_hctx;
 		}
 		tags[nr_tags++] = rq->tag;
 	}
 
-	if (nr_tags)
+	if (nr_tags) {
 		blk_mq_flush_tag_batch(cur_hctx, tags, nr_tags);
+		blk_mq_sched_restart(cur_hctx);
+	}
 }
 EXPORT_SYMBOL_GPL(blk_mq_end_request_batch);
 


-- 
Ming

