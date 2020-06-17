Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B5D1FC767
	for <lists+linux-block@lfdr.de>; Wed, 17 Jun 2020 09:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgFQH3o (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 17 Jun 2020 03:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFQH3n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Jun 2020 03:29:43 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FC5C061573
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 00:29:41 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dr13so1209396ejc.3
        for <linux-block@vger.kernel.org>; Wed, 17 Jun 2020 00:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=b+yVpNszDOoVz6zY+nD6raMCFtePmU7vtf9BNU07uy8=;
        b=EdSKN96Q09DaLPC6njlBTqkeE4WUfXqFkfAt1qX7X9lWmLuNVBctPXv2Y8J7HuBc1z
         PPZe27H4tzyK7eGDaTHB01yDMtaZZx/BgkE7Qk4+T4o143XbfXbkjJgkSAHUfal7hdRg
         mYRrrlGOEWngpfYJ6Ic2Q66jzXLKvJtxYK91dw/+ThETBzIl0/BGkgHhu7sB5dsLlXdJ
         RhFxh0+ILWdED9QGooUTNrAxo4hYYBXd5EpNk75CkHEwMrenrTcLytbiXRUPO20FAuUD
         APR4sHGAlcCw04Pg057AjkL5kb7FsHVkkqJZ638A6oYVtzRCV5yqPL+OraGCBs2rOcOE
         I+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=b+yVpNszDOoVz6zY+nD6raMCFtePmU7vtf9BNU07uy8=;
        b=ZI+gfXbn/cs9rK8WmfJfPN0rpltykcBiJGo0yTul9nbipbnAZFqYH+nbjst+GpeeUb
         Z1Cn2NFxGDS+ft9JLLzm3JMQ5oMDvuC6h7EtEvKwm+Z68zADYkxxbd495WenzTGvf/h3
         Zfn/udL06pHOwev7Lqp+9TnklrYHQGlhDlOL/CfmyE0e9d5w+36WuZH3c+U2wkdLP8AZ
         OFEycdillAeCv1A4d3Ahu9/qC5n46qHZ3KECT8RcPwjtCfETLGnZjI9Dp48yt4MMfKnV
         U0/8PGgDo1QkP6A9bZKDgMYuPAKijwh1kjG1H+Dg3zXt7gn+jWeMNvrzc8ER2eO1zATB
         nM7w==
X-Gm-Message-State: AOAM532VOtbNwdDNmLdYrBrcxqTXsyP8IpnCa4Z+XXsN8SiIMLVrufx7
        DxkRDbq1MZ4bIjbHq0KP60w6jw==
X-Google-Smtp-Source: ABdhPJyJJs8thfIDxK+0Rq9dcJto8cBwSHswftUlmpfAK3QMXPbQUvs/RJEtHPE05jyoe1zTQGIEFA==
X-Received: by 2002:a17:906:118b:: with SMTP id n11mr6417411eja.328.1592378980345;
        Wed, 17 Jun 2020 00:29:40 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id b26sm12608676eju.6.2020.06.17.00.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 00:29:39 -0700 (PDT)
Date:   Wed, 17 Jun 2020 09:29:39 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <Keith.Busch@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200617072939.lvlqa24sd2ab4iy3@mpHalley.localdomain>
References: <20200616122448.4e3slfghv4cojafq@mpHalley.local>
 <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616141620.omqf64up523of35t@MacBook-Pro.localdomain>
 <CY4PR04MB37512BCDD74996057697F5CAE79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616150217.inezhntsehtcbjsw@MacBook-Pro.localdomain>
 <CY4PR04MB37513B2D2B7AAE343ABF14C1E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200617060953.ypviiz75cua4bt25@mpHalley.localdomain>
 <CY4PR04MB375154B897296A3A4C82503DE79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200617070234.jbeex2i7hs5urbqt@mpHalley.localdomain>
 <CY4PR04MB3751827E66EDECCE9268F8C9E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR04MB3751827E66EDECCE9268F8C9E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 17.06.2020 07:24, Damien Le Moal wrote:
>On 2020/06/17 16:02, Javier González wrote:
>> On 17.06.2020 06:47, Damien Le Moal wrote:
>>> On 2020/06/17 15:10, Javier González wrote:
>>>> On 17.06.2020 00:14, Damien Le Moal wrote:
>>>>> On 2020/06/17 0:02, Javier González wrote:
>>>>>> On 16.06.2020 14:42, Damien Le Moal wrote:
>>>>>>> On 2020/06/16 23:16, Javier González wrote:
>>>>>>>> On 16.06.2020 12:35, Damien Le Moal wrote:
>>>>>>>>> On 2020/06/16 21:24, Javier González wrote:
>>>>>>>>>> On 16.06.2020 14:06, Matias Bjørling wrote:
>>>>>>>>>>> On 16/06/2020 14.00, Javier González wrote:
>>>>>>>>>>>> On 16.06.2020 13:18, Matias Bjørling wrote:
>>>>>>>>>>>>> On 16/06/2020 12.41, Javier González wrote:
>>>>>>>>>>>>>> On 16.06.2020 08:34, Keith Busch wrote:
>>>>>>>>>>>>>>> Add support for NVM Express Zoned Namespaces (ZNS) Command Set defined
>>>>>>>>>>>>>>> in NVM Express TP4053. Zoned namespaces are discovered based on their
>>>>>>>>>>>>>>> Command Set Identifier reported in the namespaces Namespace
>>>>>>>>>>>>>>> Identification Descriptor list. A successfully discovered Zoned
>>>>>>>>>>>>>>> Namespace will be registered with the block layer as a host managed
>>>>>>>>>>>>>>> zoned block device with Zone Append command support. A namespace that
>>>>>>>>>>>>>>> does not support append is not supported by the driver.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Why are we enforcing the append command? Append is optional on the
>>>>>>>>>>>>>> current ZNS specification, so we should not make this mandatory in the
>>>>>>>>>>>>>> implementation. See specifics below.
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> There is already general support in the kernel for the zone append
>>>>>>>>>>>>> command. Feel free to submit patches to emulate the support. It is
>>>>>>>>>>>>> outside the scope of this patchset.
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> It is fine that the kernel supports append, but the ZNS specification
>>>>>>>>>>>> does not impose the implementation for append, so the driver should not
>>>>>>>>>>>> do that either.
>>>>>>>>>>>>
>>>>>>>>>>>> ZNS SSDs that choose to leave append as a non-implemented optional
>>>>>>>>>>>> command should not rely on emulated SW support, specially when
>>>>>>>>>>>> traditional writes work very fine for a large part of current ZNS use
>>>>>>>>>>>> cases.
>>>>>>>>>>>>
>>>>>>>>>>>> Please, remove this virtual constraint.
>>>>>>>>>>>
>>>>>>>>>>> The Zone Append command is mandatory for zoned block devices. Please
>>>>>>>>>>> see https://lwn.net/Articles/818709/ for the background.
>>>>>>>>>>
>>>>>>>>>> I do not see anywhere in the block layer that append is mandatory for
>>>>>>>>>> zoned devices. Append is emulated on ZBC, but beyond that there is no
>>>>>>>>>> mandatory bits. Please explain.
>>>>>>>>>
>>>>>>>>> This is to allow a single write IO path for all types of zoned block device for
>>>>>>>>> higher layers, e.g file systems. The on-going re-work of btrfs zone support for
>>>>>>>>> instance now relies 100% on zone append being supported. That significantly
>>>>>>>>> simplifies the file system support and more importantly remove the need for
>>>>>>>>> locking around block allocation and BIO issuing, allowing to preserve a fully
>>>>>>>>> asynchronous write path that can include workqueues for efficient CPU usage of
>>>>>>>>> things like encryption and compression. Without zone append, file system would
>>>>>>>>> either (1) have to reject these drives that do not support zone append, or (2)
>>>>>>>>> implement 2 different write IO path (slower regular write and zone append). None
>>>>>>>>> of these options are ideal, to say the least.
>>>>>>>>>
>>>>>>>>> So the approach is: mandate zone append support for ZNS devices. To allow other
>>>>>>>>> ZNS drives, an emulation similar to SCSI can be implemented, with that emulation
>>>>>>>>> ideally combined to work for both types of drives if possible.
>>>>>>>>
>>>>>>>> Enforcing QD=1 becomes a problem on devices with large zones. In
>>>>>>>> a ZNS device that has smaller zones this should not be a problem.
>>>>>>>
>>>>>>> Let's be precise: this is not running the drive at QD=1, it is "at most one
>>>>>>> write *request* per zone". If the FS is simultaneously using multiple block
>>>>>>> groups mapped to different zones, you will get a total write QD > 1, and as many
>>>>>>> reads as you want.
>>>>>>>
>>>>>>>> Would you agree that it is possible to have a write path that relies on
>>>>>>>> QD=1, where the FS / application has the responsibility for enforcing
>>>>>>>> this? Down the road this QD can be increased if the device is able to
>>>>>>>> buffer the writes.
>>>>>>>
>>>>>>> Doing QD=1 per zone for writes at the FS layer, that is, at the BIO layer does
>>>>>>> not work. This is because BIOs can be as large as the FS wants them to be. Such
>>>>>>> large BIO will be split into multiple requests in the block layer, resulting in
>>>>>>> more than one write per zone. That is why the zone write locking is at the
>>>>>>> scheduler level, between BIO split and request dispatch. That avoids the
>>>>>>> multiple requests fragments of a large BIO to be reordered and fail. That is
>>>>>>> mandatory as the block layer itself can occasionally reorder requests and lower
>>>>>>> levels such as AHCI HW is also notoriously good at reversing sequential
>>>>>>> requests. For NVMe with multi-queue, the IO issuing process getting rescheduled
>>>>>>> on a different CPU can result in sequential IOs being in different queues, with
>>>>>>> the likely result of an out-of-order execution. All cases are avoided with zone
>>>>>>> write locking and at most one write request dispatch per zone as recommended by
>>>>>>> the ZNS specifications (ZBC and ZAC standards for SMR HDDs are silent on this).
>>>>>>>
>>>>>>
>>>>>> I understand. I agree that the current FSs supporting ZNS follow this
>>>>>> approach and it makes sense that there is a common interface that
>>>>>> simplifies the FS implementation. See the comment below on the part I
>>>>>> believe we see things differently.
>>>>>>
>>>>>>
>>>>>>>> I would be OK with some FS implementations to rely on append and impose
>>>>>>>> the constraint that append has to be supported (and it would be our job
>>>>>>>> to change that), but I would like to avoid the driver rejecting
>>>>>>>> initializing the device because current FS implementations have
>>>>>>>> implemented this logic.
>>>>>>>
>>>>>>> What is the difference between the driver rejecting drives and the FS rejecting
>>>>>>> the same drives ? That has the same end result to me: an entire class of devices
>>>>>>> cannot be used as desired by the user. Implementing zone append emulation avoids
>>>>>>> the rejection entirely while still allowing the FS to have a single write IO
>>>>>>> path, thus simplifying the code.
>>>>>>
>>>>>> The difference is that users that use a raw ZNS device submitting I/O
>>>>>> through the kernel would still be able to use these devices. The result
>>>>>> would be that the ZNS SSD is recognized and initialized, but the FS
>>>>>> format fails.
>>>>>
>>>>> I understand your point of view. Raw ZNS block device access by an application
>>>>> is of course a fine use case. SMR also has plenty of these.
>>>>>
>>>>> My point is that enabling this regular write/raw device use case should not
>>>>> prevent using btrfs or other kernel components that require zone append.
>>>>> Implementing zone append emulation in the NVMe/ZNS driver for devices without
>>>>> native support for the command enables *all* use cases without impacting the use
>>>>> case you are interested in.
>>>>>
>>>>> This approach is, in my opinion, far better. No one is left out and the user
>>>>> gains a flexible system with different setup capabilities. The user wins here.
>>>>
>>>> So, do you see a path where we enable the following:
>>>>
>>>>     1. We add the emulation layer to the NVMe driver for enabling FSs
>>>>        that currently support zoned devices
>>>>     2. We add a path from user-space (e.g., uring) to enable passthru
>>>>        commands to the NVMe driver to enable a raw ZNS path from the
>>>>        application. This path does not require the device to support
>>>>        append. An initial limitation is that I/Os must be of < 127 bio
>>>>        segments (same as append) to avod bio splits
>>>>     3. As per above, the NVMe driver allows ZNS drives without append
>>>>        support to be initialized and the check moves to the FS
>>>>        formatting.
>>>>
>>>> 2 and 3. is something we have on our end. We need to rebase on top of
>>>> the patches you guys submitted. 1. is something we can help with after
>>>> that.
>>>>
>>>> Does the above make sense to you?
>>>
>>> Doing (1) first will give you a regular nvme namespace block device that you can
>>> use to send passthrough commands with ioctl(). So (1) gives you (2).
>>>
>>> However, I do not understand what io-uring has to do with passthrough. io-uring
>>> being a block layer functionality, I do not think you can use it to send
>>> passthrough commands to the driver. I amy be wrong though, but my understanding
>>> is that for NVMe, passthrough is either ioctl() to device file or the entire
>>> driver in user space with SPDK.
>>
>> We would like to have an async() passthru I/O path and it seems possible
>> to do through uring. As mentioned on the other email, the goal is to
>> have the I/O go through the block layer for better integration, but this
>> work is still ongoing. See other thread.
>
>Indeed. I do not think that is special to ZNS at all.

Agree.

>
>>> As for (3), I do not understand your point. If you have (1), then an FS
>>> requiring zone append will work.
>>
>> In order to enable (2), we need the device to come up first. At the
>> moment the NVMe driver rejects ZNS devices without append support, so
>> either ioctl() or the uring path will not work.
>
>I repeat again here: if you implement zone append emulation, there is no reason
>to reject devices that do not have zone append native support. Zone append
>emulation gives you the block device, you can do ioctl(), implement the new
>async passthrough and file systems requiring zone append work too. All problems
>solved.
>

Ok. We will get started with this to recognize the device. I believe we
have enough for a first round of patches.

Thanks for the help Damien!

Javier
