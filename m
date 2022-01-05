Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC47484DA9
	for <lists+linux-block@lfdr.de>; Wed,  5 Jan 2022 06:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbiAEFgV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 5 Jan 2022 00:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237508AbiAEFgU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jan 2022 00:36:20 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793F6C061761
        for <linux-block@vger.kernel.org>; Tue,  4 Jan 2022 21:36:20 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id bm14so157337322edb.5
        for <linux-block@vger.kernel.org>; Tue, 04 Jan 2022 21:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2VgHNMY/oH2D23eJ8YnQC9PGqKOxqMjg7ex0cwoNYvw=;
        b=TfQ+7KK7FadzF+6feiCdtVBGr2YKBJ0/m2Ewn/Ux2v8zcBGhMi+RcpbP0AQ7esNBj4
         5xzDRYlN+5MyqnGgDOEA6IqrM5gxUEhdS7f2dBGYW0j6jsrMCAObBYz42t+ur8TQRo9q
         MqHf9flC+EZvxDshS4nY8PW4CJ4mY10p9hE6ZLovgLr9zatjefgw45ob5ul/0PBtV67Q
         cBCa/ai//GY/fkoM4MWHbnG8h+o2ZhQ0bPxJbGUoaMDchkp2ug1qNrekTrQYyw512O3b
         NkLO668Y9OHPHfc4t14GJJtj0vcSL8CoCEmtNRLYyMtBwi28jTU51W6DWPy71IOMzRkL
         lPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2VgHNMY/oH2D23eJ8YnQC9PGqKOxqMjg7ex0cwoNYvw=;
        b=JNUL/RgEd77eIIpkKWDs0E1JHnc3gJlb44osR9yvxp96wQr2fJOL4ZaTBF3mmuo+Po
         SkFkS3OOu3DBNSGxHoBLc1hR4IBlsErEMy2yV4SdVspHn0a48vO40gZer+H9rOU6MTem
         +4ndtjEjm+OOwzExBtgfJUV2RxCqrl9fjTWFVqgDTz/34bNcZAYGMjGGF4G8t+ffpr1W
         XEnumCLLx4/cbFDcF14D1jNwr2dFekVeJ/46kpzwTAEcCvJfPJPexl1bNXEEdD8Hft3S
         +/D8W3De3pHAn246jnhWVLEvny57MWhBXvqZZbmHDVlIrR3X/YEJ+3ceTVvh/4c58Wkc
         n5ZQ==
X-Gm-Message-State: AOAM530DI/RfvExhr5Mu7VbtFLWrKANQp4WTNS17/K9ZXtz29xp00kP7
        QgleIMxyAikX5ZgxDIIqo9Uy9ZWKRdM0pTxCmQ8t
X-Google-Smtp-Source: ABdhPJyYoy8HVOUAZ3bFmvX8q1dsGo/xVnT1tb+flXEuXsAcD7mTwmYMK8G9qFzfKlw74DmZjaHIucIMHVeoTFYeCwQ=
X-Received: by 2002:a17:906:4e45:: with SMTP id g5mr40714474ejw.257.1641360979055;
 Tue, 04 Jan 2022 21:36:19 -0800 (PST)
MIME-Version: 1.0
References: <20211227091241.103-1-xieyongji@bytedance.com> <Ycycda8w/zHWGw9c@infradead.org>
 <CACycT3usfTdzmK=gOsBf3=-0e8HZ3_0ZiBJqkWb_r7nki7xzYA@mail.gmail.com>
 <YdMgCS1RMcb5V2RJ@localhost.localdomain> <CACycT3vYt0XNV2GdjKjDS1iyWieY_OV4h=W1qqk_AAAahRZowA@mail.gmail.com>
 <YdSMqKXv0PUkAwfl@localhost.localdomain>
In-Reply-To: <YdSMqKXv0PUkAwfl@localhost.localdomain>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 5 Jan 2022 13:36:08 +0800
Message-ID: <CACycT3tPZOSkCXPz-oYCXRJ_EOBs3dC0+Juv=FYsa6qRS0GVCw@mail.gmail.com>
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

On Wed, Jan 5, 2022 at 2:06 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Tue, Jan 04, 2022 at 01:31:47PM +0800, Yongji Xie wrote:
> > On Tue, Jan 4, 2022 at 12:10 AM Josef Bacik <josef@toxicpanda.com> wrote:
> > >
> > > On Thu, Dec 30, 2021 at 12:01:23PM +0800, Yongji Xie wrote:
> > > > On Thu, Dec 30, 2021 at 1:35 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > > >
> > > > > On Mon, Dec 27, 2021 at 05:12:41PM +0800, Xie Yongji wrote:
> > > > > > The rescuer thread might take over the works queued on
> > > > > > the workqueue when the worker thread creation timed out.
> > > > > > If this happens, we have no chance to create multiple
> > > > > > recv threads which causes I/O hung on this nbd device.
> > > > >
> > > > > If a workqueue is used there aren't really 'receive threads'.
> > > > > What is the deadlock here?
> > > >
> > > > We might have multiple recv works, and those recv works won't quit
> > > > unless the socket is closed. If the rescuer thread takes over those
> > > > works, only the first recv work can run. The I/O needed to be handled
> > > > in other recv works would be hung since no thread can handle them.
> > > >
> > >
> > > I'm not following this explanation.  What is the rescuer thread you're talking
> >
> > https://www.kernel.org/doc/html/latest/core-api/workqueue.html#c.rescuer_thread
> >
>
> Ahhh ok now I see, thanks, I didn't know this is how this worked.
>
> So what happens is we do the queue_work(), this needs to do a GFP_KERNEL
> allocation internally, we are unable to satisfy this, and thus the work gets
> pushed onto the rescuer thread.
>
> Then the rescuer thread can't be used in the future because it's doing this long
> running thing.
>

Yes.

> I think the correct thing to do here is simply drop the WQ_MEM_RECLAIM bit.  It
> makes sense for workqueue's that are handling the work of short lived works that
> are in the memory reclaim path.  That's not what these workers are doing, yes
> they are in the reclaim path, but they run the entire time the device is up.
> The actual work happens as they process incoming requests.  AFAICT
> WQ_MEM_RECLAIM doesn't affect the actual allocations that the worker thread
> needs to do, which is what I think the intention was in using WQ_MEM_RECLAIM,
> which isn't really what it's used for.
>
> tl;dr, just remove thee WQ_MEM_RECLAIM flag completely and I think that's good
> enough?  Thanks,
>

In the reconnect case, we still need to call queue_work() while the
device is running. So it looks like we can't simply remove the
WQ_MEM_RECLAIM flag.

Thanks,
Yongji
