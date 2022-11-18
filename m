Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C9462F553
	for <lists+linux-block@lfdr.de>; Fri, 18 Nov 2022 13:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242001AbiKRMs5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 18 Nov 2022 07:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241993AbiKRMsz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2022 07:48:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07588903B4
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2022 04:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668775674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QuJM6Q+PvGZmgsUmn5eTgKuDeG5FBgtl0wlJyelxxdU=;
        b=cKdOOQQAzKIo5PdFAgc5vy0bQx9AsmYJKVTPpNR/H2tXuKN1PMjKnBgW6XgxrQpwYbkdvE
        q/R8DBeKxPsnOaN2wP6jvlRcanRHtgiwPTcICDY+3ne9C3mhvgj/39iTw+M2+mIwAvRM//
        YWlxa+uQ4tARF0ipqs/h12goFqydmpA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-5Bcfl6QBM_S9WLa8rmvSzg-1; Fri, 18 Nov 2022 07:47:53 -0500
X-MC-Unique: 5Bcfl6QBM_S9WLa8rmvSzg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 515558339C8;
        Fri, 18 Nov 2022 12:47:53 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7189E40C6EC3;
        Fri, 18 Nov 2022 12:47:48 +0000 (UTC)
Date:   Fri, 18 Nov 2022 20:47:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Andreas Hindborg <andreas.hindborg@wdc.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: Reordering of ublk IO requests
Message-ID: <Y3d+78qMOusdYUAG@T590>
References: <Y3X2M3CSULigQr4f@T590>
 <87k03u7x3r.fsf@wdc.com>
 <Y3YfUjrrLJzPWc4H@T590>
 <87fseh92aa.fsf@wdc.com>
 <Y3cGM0es14vj3n3N@T590>
 <2f86eb58-148b-03ac-d2bf-d67c5756a7a6@opensource.wdc.com>
 <Y3chDDdbuN99l7v7@T590>
 <8735ag8ueg.fsf@wdc.com>
 <Y3dscKle5oqLjSNT@T590>
 <87v8nc79cv.fsf@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8nc79cv.fsf@wdc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 18, 2022 at 12:49:15PM +0100, Andreas Hindborg wrote:
> 
> Ming Lei <ming.lei@redhat.com> writes:
> 
> > CAUTION: This email originated from outside of Western Digital. Do not click on
> > links or open attachments unless you recognize the sender and know that the
> > content is safe.
> >
> >
> > On Fri, Nov 18, 2022 at 10:41:31AM +0100, Andreas Hindborg wrote:
> >>
> >> Ming Lei <ming.lei@redhat.com> writes:
> >>
> >> > CAUTION: This email originated from outside of Western Digital. Do not click on
> >> > links or open attachments unless you recognize the sender and know that the
> >> > content is safe.
> >> >
> >> >
> >> > On Fri, Nov 18, 2022 at 01:35:29PM +0900, Damien Le Moal wrote:
> >> >> On 11/18/22 13:12, Ming Lei wrote:
> >> >> [...]
> >> >> >>> You can only assign it to zoned write request, but you still have to check
> >> >> >>> the sequence inside each zone, right? Then why not just check LBAs in
> >> >> >>> each zone simply?
> >> >> >>
> >> >> >> We would need to know the zone map, which is not otherwise required.
> >> >> >> Then we would need to track the write pointer for each open zone for
> >> >> >> each queue, so that we can stall writes that are not issued at the write
> >> >> >> pointer. This is in effect all zones, because we cannot track when zones
> >> >> >> are implicitly closed. Then, if different queues are issuing writes to
> >> >> >
> >> >> > Can you explain "implicitly closed" state a bit?
> >> >> >
> >> >> > From https://zonedstorage.io/docs/introduction/zoned-storage, only the
> >> >> > following words are mentioned about closed state:
> >> >> >
> >> >> >     ```Conversely, implicitly or explicitly opened zoned can be transitioned to the
> >> >> >     closed state using the CLOSE ZONE command.```
> >> >>
> >> >> When a write is issued to an empty or closed zone, the drive will
> >> >> automatically transition the zone into the implicit open state. This is
> >> >> called implicit open because the host did not (explicitly) issue an open
> >> >> zone command.
> >> >>
> >> >> When there are too many implicitly open zones, the drive may choose to
> >> >> close one of the implicitly opened zone to implicitly open the zone that
> >> >> is a target for a write command.
> >> >>
> >> >> Simple in a nutshell. This is done so that the drive can work with a
> >> >> limited set of resources needed to handle open zones, that is, zones that
> >> >> are being written. There are some more nasty details to all this with
> >> >> limits on the number of open zones and active zones that a zoned drive may
> >> >> have.
> >> >
> >> > OK, thanks for the clarification about implicitly closed, but I
> >> > understand this close can't change the zone's write pointer.
> >>
> >> You are right, it does not matter if the zone is implicitly closed, I
> >> was mistaken. But we still have to track the write pointer of every zone
> >> in open or active state, otherwise we cannot know if a write that arrive
> >> to a zone with no outstanding IO is actually at the write pointer, or
> >> whether we need to hold it.
> >>
> >> >
> >> >>
> >> >> >
> >> >> > zone info can be cached in the mapping(hash table)(zone sector is the key, and zone
> >> >> > info is the value), which can be implemented as one LRU style. If any zone
> >> >> > info isn't hit in the mapping table, ioctl(BLKREPORTZONE) can be called for
> >> >> > obtaining the zone info.
> >> >> >
> >> >> >> the same zone, we need to sync across queues. Userspace may have
> >> >> >> synchronization in place to issue writes with multiple threads while
> >> >> >> still hitting the write pointer.
> >> >> >
> >> >> > You can trust mq-dealine, which guaranteed that write IO is sent to ->queue_rq()
> >> >> > in order, no matter MQ or SQ.
> >> >> >
> >> >> > Yes, it could be issue from multiple queues for ublksrv, which doesn't sync
> >> >> > among multiple queues.
> >> >> >
> >> >> > But per-zone re-order still can solve the issue, just need one lock
> >> >> > for each zone to cover the MQ re-order.
> >> >>
> >> >> That lock is already there and using it, mq-deadline will never dispatch
> >> >> more than one write per zone at any time. This is to avoid write
> >> >> reordering. So multi queue or not, for any zone, there is no possibility
> >> >> of having writes reordered.
> >> >
> >> > oops, I miss the single queue depth point per zone, so ublk won't break
> >> > zoned write at all, and I agree order of batch IOs is one problem, but
> >> > not hard to solve.
> >>
> >> The current implementation _does_ break zoned write because it reverses
> >> batched writes. But if it is an easy fix, that is cool :)
> >
> > Please look at Damien's comment:
> >
> >>> That lock is already there and using it, mq-deadline will never dispatch
> >>> more than one write per zone at any time. This is to avoid write
> >>> reordering. So multi queue or not, for any zone, there is no possibility
> >>> of having writes reordered.
> >
> > For zoned write, mq-deadline is used to limit at most one inflight write
> > for each zone.
> >
> > So can you explain a bit how the current implementation breaks zoned
> > write?
> 
> Like Damien wrote in another email, mq-deadline will only impose
> ordering for requests submitted in batch. The flow we have is the
> following:
> 
>  - Userspace sends requests to ublk gendisk
>  - Requests go through block layer and is _not_ reordered when using
>    mq-deadline. They may be split.
>  - Requests hit ublk_drv and ublk_drv will reverse order of _all_
>    batched up requests (including split requests).

For ublk-zone, ublk driver needs to be exposed as zoned device by
calling disk_set_zoned() finally, which definitely isn't supported now,
so mq-deadline at most sends one write IO for each zone after ublk-zone
is supported, see blk_req_can_dispatch_to_zone().

>  - ublk_drv sends request to ublksrv in _reverse_ order.
>  - ublksrv sends requests _not_ batched up to target device.
>  - Requests that enter mq-deadline at the same time are reordered in LBA
>    order, that is all good.
>  - Requests that enter the kernel in different batches are not reordered
>    in LBA order and end up missing the write pointer. This is bad.

Again, please read Damien's comment:

>> That lock is already there and using it, mq-deadline will never dispatch
>> more than one write per zone at any time.

Anytime, there is at most one write IO for each zone, how can the single
write IO be re-order?


Thanks,
Ming

