Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0163E206EC0
	for <lists+linux-block@lfdr.de>; Wed, 24 Jun 2020 10:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390327AbgFXINg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 24 Jun 2020 04:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390323AbgFXINf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 04:13:35 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441E6C061755
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2020 01:13:35 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id q198so1086522qka.2
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2020 01:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YiwAw5rf1diC6i54PRBuyM8/xbCVl7h6LSmw94lDr8M=;
        b=DLNnplMZTclq3Qu41yzxfjHqZxOrk1DU+y+luEo+7KmlVHvLHuvdtKEvab9Yn8iIf9
         h7k2rv2GRt+e0qBArwvSGj9sTnX37oqP7KFHi1MJAFHqrF3q7NMt62BE+LPptI0PU3yz
         47Gd6tdJZ/LyEtctL/O7p0BQ/cqnmm4TQB1Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=YiwAw5rf1diC6i54PRBuyM8/xbCVl7h6LSmw94lDr8M=;
        b=DeyLNvkXzpcqZE7o0zR8u+DpTj9xcVnPKJT5M7Bxw0AROdyWdDad+fZo/EbojBjjNS
         kgCPh/+jEG5sHQ1I6yShd0xlpWwUGTB7tYoTl3p5/47eWnDI49M6n3R1XuRCygyKi3gt
         S8HARj4+3JeckGcHRM8npf5CrGcw6C9oYQWHOOHkY3PEbyeGkvuI5elZPy4nZqMz8AQY
         Upn0Gg71YmZGb0kh+Vu4+Kp3ceDbm42mYNb2MczZ5djvW0TLxGLgKkqpUkHsGGdYe7Q4
         DDCl5f9otzhiltr9kBk/NbIXWzlsrGOKV2Kgy46XmKaulXtiEPS//IyLcOMleUxPiQft
         Zbhw==
X-Gm-Message-State: AOAM531xlVls0m+eulSq6qqgeor6CMXPCPiUTeX7OjgL85Ttlvg7+4Hs
        i1V/uIHBa0poq9ftmLk5i4vv8QFmu4eFk5HjLZJ6Ow==
X-Google-Smtp-Source: ABdhPJxkQXodkQPbyTvdNGDhaEwudHE8iAT5slMQ6pIZ5w/cSLJ1YyE1BC7yCMb/u68Ecxgl2kE45xoOkKLgQB+5NU4=
X-Received: by 2002:a37:494c:: with SMTP id w73mr22819291qka.27.1592986414110;
 Wed, 24 Jun 2020 01:13:34 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <1591810159-240929-1-git-send-email-john.garry@huawei.com>
 <1591810159-240929-3-git-send-email-john.garry@huawei.com>
 <20200611025759.GA453671@T590> <6ef76cdf-2fb3-0ce8-5b5a-0d7af0145901@huawei.com>
 <8ef58912-d480-a7e1-f04c-da9bd85ea0ae@huawei.com> <eaf188d5-dac0-da44-1c83-31ff2860d8fa@suse.de>
In-Reply-To: <eaf188d5-dac0-da44-1c83-31ff2860d8fa@suse.de>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQBVjmvxAE7FMYb7GtMRWGcwtMcECgJRJzAeAmYD0J0CUmtFnQMQPP3WAliipVSrhUrmoA==
Date:   Wed, 24 Jun 2020 13:43:32 +0530
Message-ID: <e42da0e714c808c80e9a055f3f065e44@mail.gmail.com>
Subject: RE: [PATCH RFC v7 02/12] blk-mq: rename blk_mq_update_tag_set_depth()
To:     Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com,
        don.brace@microsemi.com, Sumit Saxena <sumit.saxena@broadcom.com>,
        bvanassche@acm.org, hare@suse.com, hch@lst.de,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        esc.storagedev@microsemi.com, chenxiang66@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>
> On 6/23/20 1:25 PM, John Garry wrote:
> > On 11/06/2020 09:26, John Garry wrote:
> >> On 11/06/2020 03:57, Ming Lei wrote:
> >>> On Thu, Jun 11, 2020 at 01:29:09AM +0800, John Garry wrote:
> >>>> From: Hannes Reinecke <hare@suse.de>
> >>>>
> >>>> The function does not set the depth, but rather transitions from
> >>>> shared to non-shared queues and vice versa.
> >>>> So rename it to blk_mq_update_tag_set_shared() to better reflect
> >>>> its purpose.
> >>>
> >>> It is fine to rename it for me, however:
> >>>
> >>> This patch claims to rename blk_mq_update_tag_set_shared(), but also
> >>> change blk_mq_init_bitmap_tags's signature.
> >>
> >> I was going to update the commit message here, but forgot again...
> >>
> >>>
> >>> So suggest to split this patch into two or add comment log on
> >>> changing blk_mq_init_bitmap_tags().
> >>
> >> I think I'll just split into 2x commits.
> >
> > Hi Hannes,
> >
> > Do you have any issue with splitting the undocumented changes into
> > another patch as so:
> >
> No, that's perfectly fine.
>
> Kashyap, I've also attached an updated patch for the elevator_count patch=
;
> if
> you agree John can include it in the next version.

Hannes - Patch looks good.   Header does not include problem statement. How
about adding below in header ?

High CPU utilization on "native_queued_spin_lock_slowpath" due to lock
contention is possible in mq-deadline and bfq io scheduler when nr_hw_queue=
s
is more than one.
It is because kblockd work queue can submit IO from all online CPUs (throug=
h
blk_mq_run_hw_queues) even though only one hctx has pending commands.
Elevator callback "has_work" for mq-deadline and bfq scheduler consider
pending work if there are any IOs on request queue and it does not account
hctx context.

I have not seen performance drop after this patch, but I will continue
further testing.

John - One more thing, I am working on megaraid_sas driver to provide both
host_tagset =3D 1 and 0 option through module parameter.

Kashyap

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke            Teamlead Storage & Networking
> hare@suse.de                               +49 911 74053 688
> SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg HRB 3680=
9
> (AG N=C3=BCrnberg), Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer
