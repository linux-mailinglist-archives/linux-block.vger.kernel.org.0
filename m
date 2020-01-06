Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F28D6131677
	for <lists+linux-block@lfdr.de>; Mon,  6 Jan 2020 18:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgAFRHd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 6 Jan 2020 12:07:33 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:32859 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgAFRHd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Jan 2020 12:07:33 -0500
Received: by mail-il1-f194.google.com with SMTP id v15so43194391iln.0
        for <linux-block@vger.kernel.org>; Mon, 06 Jan 2020 09:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZHfMaYSoFvmYLiDLnniQwp5Jcc0dLCV9c9ledHZ8eU=;
        b=MUeK7d5YtD2lFnmxgOLSZuo/x6kf65GgzVij7FRkau6+dwrPiVwioAfvHRKTokwDH9
         1XK8iQuzCHiGuGU/9f1iC90bDNRf12JcDhZ4nZau3Wq7w9rdPWamPkGIuTMrFZLeY/xq
         eLMsV6D+oBS63L6HgcuQgVc0kKwqc+Ur2c3aMyLCoBu41I8eNVLHxbSO8x8LJK1UWM5n
         LW7AhHyZ6bPuI2seq7bWdOXBzZGWQDtc8w82/WXd+mK3jtlKqOnAsf+/xyEDJdj2P9Ed
         5fWc05Lj73R+L1ZC9+8b4LJLDA3QWr1r5yyyz9NPOh/U0+/UUFhxttLpiapdy4brFjQx
         ma3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZHfMaYSoFvmYLiDLnniQwp5Jcc0dLCV9c9ledHZ8eU=;
        b=lFPX1Aax2dMxfjcBQJkBx1lW6ei5HSdEqpD7/dLLOfM1ORJLe/gNEiTLLDOZiESSI1
         104IiGzxpS3k437JAg557wn46DorMBKODt9y6vyQ7692ygikYvgo9rFx7ho0XIdWoXKN
         s2uNI4ESU2ANq0ON44g63QbWy2n5gG4uTu2wfFoE3nCS4t5U5S4ITorFwszRagv1+LfK
         2+2wX0GZiejFYiST17hYMt7XI5YK4QK2FwYk9j/p8NIP3O7a+6RP5rrWkenKNNwDKhLJ
         cAQu1obTHqYLFxhhT6OxXta/MSxAsRcmf1TV6KswEER2HsyOJoVubUn0fhbkZX2XX1U3
         yXBw==
X-Gm-Message-State: APjAAAVgIiYtbY46S4EIf+qXO3PLxr432iD4oiMvsKh4JiguKxRcOlEo
        dpa3rFW2I8AXCXpD9xfNM1Eg1dyl8p+RGPPg3e9DTw==
X-Google-Smtp-Source: APXvYqxGIGJe3cC0TgJn54u78DisxF+DobqiIPRqA+VcoePJTIDq4lx+eFWLkwoYfelMNX5J4pLWmOQSXbmpHZldlzo=
X-Received: by 2002:a05:6e02:4d2:: with SMTP id f18mr83102168ils.54.1578330452530;
 Mon, 06 Jan 2020 09:07:32 -0800 (PST)
MIME-Version: 1.0
References: <20191220155109.8959-1-jinpuwang@gmail.com> <20200102181859.GC9282@ziepe.ca>
 <CAMGffE=h24jmi0RnYks_rur71qrXCxJnPB5+cCACR50hKF6QRA@mail.gmail.com> <d5be42e2-94d4-ad13-43ac-fcc1bb108ad0@acm.org>
In-Reply-To: <d5be42e2-94d4-ad13-43ac-fcc1bb108ad0@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 6 Jan 2020 18:07:21 +0100
Message-ID: <CAMGffEntYmFfGD8BGEtykoFXD_3DvNWQ8hrRmDoLtdr9ykTwug@mail.gmail.com>
Subject: Re: [PATCH v5 00/25] RTRS (former IBTRS) rdma transport library and
 the corresponding RNBD (former IBNBD) rdma network block device
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jack Wang <jinpuwang@gmail.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 3, 2020 at 5:29 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 1/3/20 4:39 AM, Jinpu Wang wrote:
> > Performance results for the v5.5-rc1 kernel are here:
> >    link: https://github.com/ionos-enterprise/ibnbd/tree/develop/performance/v5-v5.5-rc1
> >
> > Some workloads RNBD are faster, some workloads NVMeoF are faster.
>
> Thank you for having shared these graphs.
>
> Do the graphs in RNBD-SinglePath.pdf show that NVMeOF achieves similar
> or higher IOPS, higher bandwidth and lower latency than RNBD for
> workloads with a block size of 4 KB and also for mixed workloads with
> less than 20 disks, whether or not invalidation is enabled for RNBD?
Hi Bart,

Yes, that's the result on one pair of Server with Connect X4 HCA, I
did another test on another
2 servers with Connect X5 HCA, results are quite different, we will
double-check the
performance results also on old machines, will share new results later.


>
> Is it already clear why NVMeOF performance drops if the number of disks
> is above 25? Is that perhaps caused by contention on the block layer tag
> allocator because multiple NVMe namespaces share a tag set? Can that
> contention be avoided by increasing the NVMeOF queue depth further?
No yet, will check.
>
> Thanks,
>
> Bart.
>
>
Thanks
