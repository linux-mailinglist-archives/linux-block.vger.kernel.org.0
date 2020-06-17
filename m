Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE061FD52E
	for <lists+linux-block@lfdr.de>; Wed, 17 Jun 2020 21:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgFQTJF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 17 Jun 2020 15:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgFQTJF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 15:09:05 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5CAC06174E
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 12:09:04 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dr13so3717816ejc.3
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 12:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FFx/vI6yWI+LuFRqxqYPZp/PkhUJ0eHXNVCiah0a8uw=;
        b=aHHnWaHXIPi+Us8oBr2ZdPnwnmV3zIl92JjoxwvN2RoouHYj2/gONuuZxOk/3j6g6R
         t+N3raQ2CfbHuCzOejQTipcOdtaELkvhfq/No7vaHsyKaseYVZA1wkl1T/oac1FMfQYs
         3dR1dwFTt1+D3nKa2E/dD4EiRTlUYUkvylmAI/Elm8wgdqb04w5Bst/45+0CoRoeeLBu
         AD8pW9N1Doa4PUYoB6E6lrTKxwzidDZSijQa5Fp+i0CjdrhynnEMcUDrC+VZjb7J+dMz
         rAPGopDzg6kb04GhAMsG0+wFsQVefArQXUV4uaRne9eHL8ZW2g6PV8jr8zxT9ec+bRYA
         dukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FFx/vI6yWI+LuFRqxqYPZp/PkhUJ0eHXNVCiah0a8uw=;
        b=Ts/nmnrcNUa330lGs0yylC76V+PcpcxmaafYHN312pxgY/ml9c2inypMt1g8JEIZKU
         3Pb1ZKVjB1M9JkR4o/rPDygn/1hljMDwAi1z7PSgjblBiy0CdkDtRHdNXPd1iGFNR4ZE
         aYZXowZhW8iITodgYMutA7bj1KO8Q5a8FY1N5rNZoscDIpBaTto4Tm/jhhGzwq57TI0P
         FN8ssuuOodeU0kz3JjCOfI1V7B33ZUPQQhkB+M7pQOzN1XE/O/BGmpJa/LY171sTrhwG
         sHWNrO99aimYCwayxTaFW4uwJcXuGJPWRFFwYCxoKPmswyokW725wGCalEqZIqAgOwHA
         a2qw==
X-Gm-Message-State: AOAM53231gZwIV2iw7cBlY3VIMX49P3Cv3C7w+8kCNvwtauzGlrDwUOl
        Ay44tP3gYG8/O3H2J6NuiPLQlg==
X-Google-Smtp-Source: ABdhPJyVGcrXkG9XtRoXVdKirgsUu/18NGTD37yaPYl5eTwg+LbCZyjnvsemDrsu0Kztv3kquQMyNg==
X-Received: by 2002:a17:906:8684:: with SMTP id g4mr540800ejx.431.1592420943252;
        Wed, 17 Jun 2020 12:09:03 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id y12sm556555ejp.39.2020.06.17.12.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 12:09:02 -0700 (PDT)
Date:   Wed, 17 Jun 2020 21:09:01 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Matias Bjorling <Matias.Bjorling@wdc.com>
Cc:     Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <Keith.Busch@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Judy Brock <judy.brock@samsung.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200617190901.zpss2lsh6qsu5zuf@mpHalley.local>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <20200617074328.GA13474@lst.de>
 <20200617144230.ojzk4f5gcwqonzrf@mpHalley.localdomain>
 <f1bc34e0-c059-6127-d69f-e31c91ce6a9f@lightnvm.io>
 <20200617182841.jnbxgshi7bawfzls@mpHalley.localdomain>
 <MN2PR04MB62236DC26A04A65A242A80D2F19A0@MN2PR04MB6223.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR04MB62236DC26A04A65A242A80D2F19A0@MN2PR04MB6223.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 17.06.2020 18:55, Matias Bjorling wrote:
>> -----Original Message-----
>> From: Javier González <javier@javigon.com>
>> Sent: Wednesday, 17 June 2020 20.29
>> To: Matias Bjørling <mb@lightnvm.io>
>> Cc: Christoph Hellwig <hch@lst.de>; Keith Busch <Keith.Busch@wdc.com>;
>> linux-nvme@lists.infradead.org; linux-block@vger.kernel.org; Damien Le Moal
>> <Damien.LeMoal@wdc.com>; Matias Bjorling <Matias.Bjorling@wdc.com>;
>> Sagi Grimberg <sagi@grimberg.me>; Jens Axboe <axboe@kernel.dk>; Hans
>> Holmberg <Hans.Holmberg@wdc.com>; Dmitry Fomichev
>> <Dmitry.Fomichev@wdc.com>; Ajay Joshi <Ajay.Joshi@wdc.com>; Aravind
>> Ramesh <Aravind.Ramesh@wdc.com>; Niklas Cassel
>> <Niklas.Cassel@wdc.com>; Judy Brock <judy.brock@samsung.com>
>> Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
>>
>> On 17.06.2020 19:57, Matias Bjørling wrote:
>> >On 17/06/2020 16.42, Javier González wrote:
>> >>On 17.06.2020 09:43, Christoph Hellwig wrote:
>> >>>On Tue, Jun 16, 2020 at 12:41:42PM +0200, Javier González wrote:
>> >>>>On 16.06.2020 08:34, Keith Busch wrote:
>> >>>>>Add support for NVM Express Zoned Namespaces (ZNS) Command Set
>> >>>>>defined in NVM Express TP4053. Zoned namespaces are discovered
>> >>>>>based on their Command Set Identifier reported in the namespaces
>> >>>>>Namespace Identification Descriptor list. A successfully discovered
>> >>>>>Zoned Namespace will be registered with the block layer as a host
>> >>>>>managed zoned block device with Zone Append command support. A
>> >>>>>namespace that does not support append is not supported by the driver.
>> >>>>
>> >>>>Why are we enforcing the append command? Append is optional on the
>> >>>>current ZNS specification, so we should not make this mandatory in
>> >>>>the implementation. See specifics below.
>> >>>
>> >>>Because Append is the way to go and we've moved the Linux zoned block
>> >>>I/O stack to required it, as should have been obvious to anyone
>> >>>following linux-block in the last few months.  I also have to say I'm
>> >>>really tired of the stupid politics tha your company started in the
>> >>>NVMe working group, and will say that these do not matter for Linux
>> >>>development at all.  If you think it is worthwhile to support devices
>> >>>without Zone Append you can contribute support for them on top of
>> >>>this series by porting the SCSI Zone Append Emulation code to NVMe.
>> >>>
>> >>>And I'm not even going to read the rest of this thread as I'm on a
>> >>>vacation that I badly needed because of the Samsung TWG bullshit.
>> >>
>> >>My intention is to support some Samsung ZNS devices that will not
>> >>enable append. I do not think this is an unreasonable thing to do. How
>> >>/ why append ended up being an optional feature in the ZNS TP is
>> >>orthogonal to this conversation. Bullshit or not, it ends up on
>> >>devices that we would like to support one way or another.
>> >
>> >I do not believe any of us have said that it is unreasonable to
>> >support. We've only asked that you make the patches for it.
>> >
>> >All of us have communicated why Zone Append is a great addition to the
>> >Linux kernel. Also, as Christoph points out, this has not been a secret
>> >for the past couple of months, and as Martin pointed out, have been a
>> >wanted feature for the past decade in the Linux community.
>>
>> >
>> >I do want to politely point out, that you've got a very clear signal
>> >from the key storage maintainers. Each of them is part of the planet's
>> >best of the best and most well-respected software developers, that
>> >literally have built the storage stack that most of the world depends
>> >on. The storage stack that recently sent manned rockets into space.
>> >They each unanimously said that the Zone Append command is the right
>> >approach for the Linux kernel to reduce the overhead of I/O tracking
>> >for zoned block devices. It may be worth bringing this information to
>> >your engineering organization, and also potentially consider Zone
>> >Append support for devices that you intend to used with the Linux
>> >kernel storage stack.
>>
>> I understand and I have never said the opposite.
>>
>> Append is a great addition that
>
>One may have interpreted your SDC EMEA talk the opposite. It was not
>very neutral towards Zone Append, but that is of cause one of its least
>problems. But I am happy to hear that you've changed your opinion.

As you are well aware, there are some cases where append introduces
challenges. This is well-documented on the bibliography around nameless
writes. Part of the talk was on presenting an alternative for these
particular use cases.

This said, I am not afraid of changing my point of view when I am proven
wrong.

>
>> we also have been working on for several months (see patches additions from
>> today). We just have a couple of use cases where append is not required and I
>> would like to make sure that they are supported.
>>
>> At the end of the day, the only thing I have disagreed on is that the NVMe
>> driver rejects ZNS SSDs that do not support append, as opposed to doing this
>> instead when an in-kernel user wants to utilize the drive (e.g., formatting a FS
>> with zoned support) This would allow _today_
>> ioctl() passthru to work for normal writes.
>>
>> I still believe the above would be a more inclusive solution with the current ZNS
>> specification, but I can see that the general consensus is different.
>
>The comment from the community, including me, is that there is a
>general requirement for Zone Append command when utilizing Zoned
>storage devices. This is similar to implement an API that one wants to
>support. It is not a general consensus or opinion. It is hard facts and
>how the Linux kernel source code is implemented at this point. One must
>implement support for ZNS SSDs that do not expose the Zone Append
>command natively. Period.

Again, I am not saying the opposite. Read the 2 lines below...

>>
>> So we will go back, apply the feedback that we got and return with an
>> approach that better fits the ecosystem.
>>
>> >
>> >Another approach, is to use SPDK, and bypass the Linux kernel. This
>> >might even be an advantage, your customers does not have to wait on the
>> >Linux distribution being released with a long term release, before they
>> >can even get started and deploy in volume. I.e., they will actually get
>> >faster to market, and your company will be able to sell more drives.
>>
>> I think I will refrain from discussing our business strategy on an open mailing
>> list. Appreciate the feedback though. Very insightful.
>
>I am not asking for you to discuss your business strategy on the mailing list. My comment was to give you genuinely advise that may save a lot of work, and might even get better results.
>
>>
>> Thanks,
>> Javier

