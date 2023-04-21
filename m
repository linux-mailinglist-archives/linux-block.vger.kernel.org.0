Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1837A6EA148
	for <lists+linux-block@lfdr.de>; Fri, 21 Apr 2023 03:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjDUBwa (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 Apr 2023 21:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjDUBwa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 21:52:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DB41BCE
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 18:52:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24C0C64C61
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2023 01:52:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F27BC433D2;
        Fri, 21 Apr 2023 01:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682041938;
        bh=fk3Tw243RNAngStyyRixVc4B6qKh1JwbJ3bHjv8dkyA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=scM5/lAenEX6ZkyyfIbmHBanWr3vHghJ3lh1jjbtciH2EuAcv3ok7XgX6fZo/Fpgh
         yuEcHZGCwp8lZalZPeYdc93RtRxg7KbVRo1d6qAJoxtGfsDWOA2zTyCpD9BfBsRkjD
         fUM4Iu2cwAc5orZmGGgUEPKliMbfR/QZ5LQJqZttjYnTO3RIQVSY/L3Q3T+EPaqOa+
         QNSEsC/W2K9z2z9ZH1m66Tk68UKOAqNWz4wYsNsiva+DIfzDLLfVh//IEtBZwM0rVl
         O5qBpWtsyorL4Oj48DWN95RklepdQicVHvdC2TdTaGMwIgX9V8OT/FkL7M5IyYSYh0
         iyfa3YhAal/yQ==
Message-ID: <c12582e0-f2c8-d001-1fc1-6f7e17eeba7c@kernel.org>
Date:   Fri, 21 Apr 2023 10:52:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 10/11] block: Add support for the zone capacity concept
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <nks@flawful.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Matias Bjorling <mb@lightnvm.io>
References: <20230418224002.1195163-1-bvanassche@acm.org>
 <20230418224002.1195163-11-bvanassche@acm.org> <ZEEEm/5+i7x2i8a5@x1-carbon>
 <f9d35d19-d0ba-fcb7-e44b-f0b8c55ba399@acm.org>
 <141aee35-4288-1670-6424-e6c41c8ef4c9@kernel.org>
 <ec7cdc7d-9eb7-65a4-6ba9-1ae6cf6f43d2@acm.org>
 <a5d9a370-6264-ebdf-f9f8-7b3263c2b6f0@kernel.org>
 <490ed061-6d82-f9fb-2050-4a386e2e4c8e@acm.org>
 <c4a52bff-5cab-5029-ad7f-e5f9452bc0e2@kernel.org>
 <ZEHY2PIRCCLOZsC4@google.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZEHY2PIRCCLOZsC4@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/21/23 09:29, Jaegeuk Kim wrote:
> On 04/21, Damien Le Moal wrote:
>> On 4/21/23 08:44, Bart Van Assche wrote:
>>> On 4/20/23 16:37, Damien Le Moal wrote:
>>>> Why would you need to handle the max active zone number restriction in the
>>>> scheduler ? That is the user responsibility. btrfs does it (that is still buggy
>>>> though, working on it).
>>>
>>> Hi Damien,
>>>
>>> If the user (filesystem) restricts the number of active zones, the code 
>>> for restricting the number of active zones will have to be duplicated 
>>> into every filesystem that supports zoned devices. Wouldn't it be better 
>>> if the I/O scheduler tracks the number of active zones?
>>
>> I do not think so. The reason is that for a file system, the block allocator
>> must be aware of any active zone limit of the underlying device to make the best
>> decision possible regarding where to allocate blocks for files and metadata. For
> 
> Well, I'm wondering what kind of decision FS can make when allocating zones?

Not sure what you mean... It is very similar to regular block device case. The
FS does block allocation based on whatever block placement policy it wants/need
to implement. With zoned devices, the FS block management object are mapped to
zones (btrfs: block group == zone, f2fs: section == zone) and the active zone
limits simply adds one more constraint regarding the selection of block groups
for allocating blocks. This is a resource management issue.

>> btrfs, we added "active block groups" management for that purpose. And we have
>> tracking of a block group active state so that the block allocator can start
>> using new block groups (inactive ones) when previously used ones become full. We
>> also have a "finish block group" for cases when there is not enough remaining
>> free blocks in a group/zone (this does a finish zone operation to make a
>> non-full zone full, that is, inactive).
>>
>> Even if the block IO scheduler were to track active zones, the FS would still
>> need to do its own tracking (e.g. to be able to finish zones when needed). So I
> 
> Why does FS also need to track the # of open zones redundantly? I have two

Because the FS should not be issuing writes to a zone that cannot be activated
on the device, e.g. starting writing to an empty zone when there are already N
zones being written or partly written, with N >= max active zones, will result
in IO failures. Even if you have active zone tracking in the block IO scheduler,
there is absolutely NOTHING that the scheduler can do to prevent such errors.
E.g. think of this simple case:
1) Let's take a device with max active zones = N (N != 0)
2) The FS implements a block allocation policy which results in new files being
written to empty block groups, with 1 block group == 1 zone
3) User writes N files of 4KB

After step 3, the device has N active zones. So if the user tries to write a new
file, it will fail (cannot write to an empty zone as that will result in an
error because that zone cannot be activated by the device). AND the FS cannot
write metadata for these files into a metadata block group.

There is nothing that the IO scheduler can do about all this. The FS has to be
more intelligent and do block allocation also based on the current
active/inactive state of the zones used by block groups.

> concerns if FS needs to force it:
> 1) performance - waiting for finish_zone before allocating a new zone can break
> the IO pipeline and block FS operations.

The need to perform a zone finish is purely an optimization if, for instance,
you want to reduce fragmentation. E.g., if there is only 4K of free space left
in a zone and need to write a 1MB extent, you can write the last 4K of that
zone, making it inactive and write the remaining 1MB - 4KB in another zone and
you are guaranteed that this other zone can be written since you just
deactivated one zone.

But if you do not want to fragment that 1MB extent, then you must finish that
zone with only 4KB left first, to ensure that another zone can be activated.

This of course also depends on the current number of active zones N. If N < max
active zone limit, then there is no need to finish a zone.

> 2) multiple partition support - if F2FS uses two partitions, one on conventional
> partition while the other on zoned partition, we have to maintain such tracking
> mechanism on zoned partition only which gives some code complexity.

Conventional zones have no concept of active zones. All active zone resources
can be allocated to the sequential zones. And zoned block devices do not support
partitions anyway.

> In general, doesn't it make sense that FS (not zoned-device FS) just needs to
> guarantee sequential writes per zone, while IO scheduler needs to limit the #
> of open zones gracefully?

No. That will never work. See the example above: you can endup in a situation
where the drive becomes read-only (all writes failing) if the FS does not direct
block allocation & writes to zones that are already active. No amount of
trickery in the IO scheduler can change that fact.

If you want to hide the active zone limit to the FS, then what is needed is a
device mapper that remaps blocks. That is a lot more overhead that implementing
that support in the FS, and the FS can do a much better job at optimizing block
placement.
