Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BD3495C02
	for <lists+linux-block@lfdr.de>; Fri, 21 Jan 2022 09:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiAUIfF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 21 Jan 2022 03:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349378AbiAUIeZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jan 2022 03:34:25 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8974DC06173F
        for <linux-block@vger.kernel.org>; Fri, 21 Jan 2022 00:34:24 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id a18so39882657edj.7
        for <linux-block@vger.kernel.org>; Fri, 21 Jan 2022 00:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MaJVMg+g5DUUOUdBu9/Df9/RFBs/TIbTQZzIsKw2iKg=;
        b=P7QTTv7hHfbbe2OClT1Kjb3kRatE9n4kVuBrYAX+TSocdmc/pPPmPArC+eBY8j45O3
         /SqBaFXkywgPJ+2rC3PruZ4LR45txQGneJk3zC45MIi26yOLkRREZX8IsvAT7tkdrxP5
         uoblK4HfmWm0avFOSwpzGyoUMzGHyvAP1s3g/3zm9BRNVjxt9WiYwhbKz5KuLrqOuYh7
         tHag4GlgjUnKmV+cBLPaJ+enEnDmJxHSDFo+1/0HV+VCGvlilYuI/RlY22HlbJhKLVdC
         p4cbHOrTY4GL975OpWwwVb/paJISTARLDu193tj/pGhcRcg0khuHika8wQ2RFnrWcS6S
         f4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MaJVMg+g5DUUOUdBu9/Df9/RFBs/TIbTQZzIsKw2iKg=;
        b=th8R/RiQK1GQggni1Rr/3kZ9TTjPkyzA5I2kvTV3BL7UHEAocAq8LYvNhCX6Pi7OZx
         GLkLiyrfHDlGzk0uuKrekMT/CUoTmD66buQoy+gMwXWUSYn0T++Xgz9dpLYoXotSOM/h
         wOg18ks8p+N80zwpO256RXw3Tgms2Ww4ClSKpmQZ7Ovjvocj3Yth/PsjT3Rr0ahJ63gw
         LTyVTfnD24VVPgqpvgrnuF4PnG/mnBMxjtr5fM4cDkJVwkc/eDvb7P0lo6jmFXm0S8Vd
         q/Zi0mPcti/KC6aedXoT1pP6b0k7VrBSDKT/r+bDyxVtfOv4x7bqflDG1GpI+Ssv0OWU
         /sdA==
X-Gm-Message-State: AOAM532AbjD/00AK64IYfqKXDsT7OyAIQxam5WPf6DhG7q7I6NS5HxfL
        OSR3t3JTfCsQagVwTqQBj4LJ9tP/rwGqmxpQGwGV
X-Google-Smtp-Source: ABdhPJyiX2tettfsCx6cHZABS+yVxwDmnEePfNEcWEOW8c+9z8wtNNeaipYQcpTYt5p4LaunCbPSBLMmhR3jLYdlnO0=
X-Received: by 2002:a05:6402:4495:: with SMTP id er21mr3388511edb.298.1642754063092;
 Fri, 21 Jan 2022 00:34:23 -0800 (PST)
MIME-Version: 1.0
References: <20211227091241.103-1-xieyongji@bytedance.com> <Ycycda8w/zHWGw9c@infradead.org>
 <CACycT3usfTdzmK=gOsBf3=-0e8HZ3_0ZiBJqkWb_r7nki7xzYA@mail.gmail.com>
 <YdMgCS1RMcb5V2RJ@localhost.localdomain> <CACycT3vYt0XNV2GdjKjDS1iyWieY_OV4h=W1qqk_AAAahRZowA@mail.gmail.com>
 <YdSMqKXv0PUkAwfl@localhost.localdomain> <CACycT3tPZOSkCXPz-oYCXRJ_EOBs3dC0+Juv=FYsa6qRS0GVCw@mail.gmail.com>
In-Reply-To: <CACycT3tPZOSkCXPz-oYCXRJ_EOBs3dC0+Juv=FYsa6qRS0GVCw@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Fri, 21 Jan 2022 16:34:11 +0800
Message-ID: <CACycT3tTKBpS_B5vVJ8MZ1iuaF2bf-01=9+tAdxUddziF2DQ-g@mail.gmail.com>
Subject: Re: [PATCH v2] nbd: Don't use workqueue to handle recv work
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ping.

On Wed, Jan 5, 2022 at 1:36 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Wed, Jan 5, 2022 at 2:06 AM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Tue, Jan 04, 2022 at 01:31:47PM +0800, Yongji Xie wrote:
> > > On Tue, Jan 4, 2022 at 12:10 AM Josef Bacik <josef@toxicpanda.com> wrote:
> > > >
> > > > On Thu, Dec 30, 2021 at 12:01:23PM +0800, Yongji Xie wrote:
> > > > > On Thu, Dec 30, 2021 at 1:35 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > > > >
> > > > > > On Mon, Dec 27, 2021 at 05:12:41PM +0800, Xie Yongji wrote:
> > > > > > > The rescuer thread might take over the works queued on
> > > > > > > the workqueue when the worker thread creation timed out.
> > > > > > > If this happens, we have no chance to create multiple
> > > > > > > recv threads which causes I/O hung on this nbd device.
> > > > > >
> > > > > > If a workqueue is used there aren't really 'receive threads'.
> > > > > > What is the deadlock here?
> > > > >
> > > > > We might have multiple recv works, and those recv works won't quit
> > > > > unless the socket is closed. If the rescuer thread takes over those
> > > > > works, only the first recv work can run. The I/O needed to be handled
> > > > > in other recv works would be hung since no thread can handle them.
> > > > >
> > > >
> > > > I'm not following this explanation.  What is the rescuer thread you're talking
> > >
> > > https://www.kernel.org/doc/html/latest/core-api/workqueue.html#c.rescuer_thread
> > >
> >
> > Ahhh ok now I see, thanks, I didn't know this is how this worked.
> >
> > So what happens is we do the queue_work(), this needs to do a GFP_KERNEL
> > allocation internally, we are unable to satisfy this, and thus the work gets
> > pushed onto the rescuer thread.
> >
> > Then the rescuer thread can't be used in the future because it's doing this long
> > running thing.
> >
>
> Yes.
>
> > I think the correct thing to do here is simply drop the WQ_MEM_RECLAIM bit.  It
> > makes sense for workqueue's that are handling the work of short lived works that
> > are in the memory reclaim path.  That's not what these workers are doing, yes
> > they are in the reclaim path, but they run the entire time the device is up.
> > The actual work happens as they process incoming requests.  AFAICT
> > WQ_MEM_RECLAIM doesn't affect the actual allocations that the worker thread
> > needs to do, which is what I think the intention was in using WQ_MEM_RECLAIM,
> > which isn't really what it's used for.
> >
> > tl;dr, just remove thee WQ_MEM_RECLAIM flag completely and I think that's good
> > enough?  Thanks,
> >
>
> In the reconnect case, we still need to call queue_work() while the
> device is running. So it looks like we can't simply remove the
> WQ_MEM_RECLAIM flag.
>
> Thanks,
> Yongji
