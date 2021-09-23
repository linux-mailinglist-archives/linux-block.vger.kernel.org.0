Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CE8415806
	for <lists+linux-block@lfdr.de>; Thu, 23 Sep 2021 07:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbhIWGBH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 23 Sep 2021 02:01:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46386 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhIWGBG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 02:01:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7E18F222EE;
        Thu, 23 Sep 2021 05:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632376774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NeEO+zbxiuOqpxAJH7FNgi1ZW98mHpsyLMzfL6fobho=;
        b=sXP8wGaAMVb4cyR9F7lk83rI48Jxr6JzYhknER8hdpRbIq0DwRtwjyOFq5qd5ohwJPIOJP
        0ra1/0D1CqPpxNodb0c9ljHxmBYigutbF9TSdqSgAKs038BW4XebUTx+O3DBtxGNwtH9E8
        cmITjBdJ5DJTOUIRw9r8qtmV1YJF7Sw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632376774;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NeEO+zbxiuOqpxAJH7FNgi1ZW98mHpsyLMzfL6fobho=;
        b=qvdLBS4HAOrQn+LV/Jx9dNZW3HzjxfkBElN7kfxUcfMqX6VYyJZMfs2FLnNt1EKxeIDkKX
        JrZNpuO3REMZrPAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3DC113DBC;
        Thu, 23 Sep 2021 05:59:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5n2wLsIXTGEqUgAAMHmgww
        (envelope-from <colyli@suse.de>); Thu, 23 Sep 2021 05:59:30 +0000
Subject: Too large badblocks sysfs file (was: [PATCH v3 0/7] badblocks
 improvement for multiple bad block ranges)
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     antlists@youngman.org.uk, Dan Williams <dan.j.williams@intel.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        NeilBrown <neilb@suse.de>, Richard Fan <richard.fan@suse.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org
References: <20210913163643.10233-1-colyli@suse.de>
From:   Coly Li <colyli@suse.de>
Message-ID: <a0f7b021-4816-6785-a9a4-507464b55895@suse.de>
Date:   Thu, 23 Sep 2021 13:59:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210913163643.10233-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all the kernel gurus, and folks in mailing lists,

This is a question about exporting 4KB+ text information via sysfs 
interface. I need advice on how to handle the problem.

Recently I work on the bad blocks API (block/badblocks.c) improvement, 
there is a sysfs file to export the bad block ranges for me raid. E.g 
for a md raid1 device, file
     /sys/block/md0/md/rd0/bad_blocks
may contain the following text content,
     64 32
    128 8
The above lines mean there are two bad block ranges, one starts at LBA 
64, length 32 sectors, another one starts at LBA 128 and length 8 
sectors. All the content is generated from the internal bad block 
records with 512 elements. In my testing the worst case only 185 from 
512 records can be displayed via the sysfs file if the LBA string is 
very long, e.g.the following content,
   17668164135030776 512
   17668164135029776 512
   17668164135028776 512
   17668164135027776 512
   ... ...
The bad block ranges stored in internal bad blocks array are correct, 
but the output message is truncated. This is the problem I encountered.

I don't see sysfs has seq_file support (correct me if I am wrong), and I 
know it is improper to transfer 4KB+ text via sysfs interface, but the 
code is here already for long time.

There are 2 ideas to fix showing up in my brain,
1) Do not fix the problem
     Normally it is rare that a storage media has 100+ bad block ranges, 
maybe in real world all the existing bad blocks information won't exceed 
the page size limitation of sysfs file.
2) Add seq_file support to sysfs interface if there is no

It is probably there is other better solution to fix. So I do want to 
get hint/advice from you.

Thanks in advance for any comment :-)

Coly Li

On 9/14/21 12:36 AM, Coly Li wrote:
> This is the second effort to improve badblocks code APIs to handle
> multiple ranges in bad block table.
>
> There are 2 changes from previous version,
> - Fixes 2 bugs in front_overwrite() which are detected by the user
>    space testing code.
> - Provide the user space testing code in last patch.
>
> There is NO in-memory or on-disk format change in the whole series, all
> existing API and data structures are consistent. This series just only
> improve the code algorithm to handle more corner cases, the interfaces
> are same and consistency to all existing callers (md raid and nvdimm
> drivers).
>
> The original motivation of the change is from the requirement from our
> customer, that current badblocks routines don't handle multiple ranges.
> For example if the bad block setting range covers multiple ranges from
> bad block table, only the first two bad block ranges merged and rested
> ranges are intact. The expected behavior should be all the covered
> ranges to be handled.
>
> All the patches are tested by modified user space code and the code
> logic works as expected. The modified user space testing code is
> provided in last patch. The testing code detects 2 defects in helper
> front_overwrite() and fixed in this version.
>
> The whole change is divided into 6 patches to make the code review more
> clear and easier. If people prefer, I'd like to post a single large
> patch finally after the code review accomplished.
>
> This version is seriously tested, and so far no more defect observed.
>
>
> Coly Li
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Richard Fan <richard.fan@suse.com>
> Cc: Vishal L Verma <vishal.l.verma@intel.com>
> ---
> Changelog:
> v3: add tester Richard Fan <richard.fan@suse.com>
> v2: the improved version, and with testing code.
> v1: the first completed version.
>
>
> Coly Li (6):
>    badblocks: add more helper structure and routines in badblocks.h
>    badblocks: add helper routines for badblock ranges handling
>    badblocks: improvement badblocks_set() for multiple ranges handling
>    badblocks: improve badblocks_clear() for multiple ranges handling
>    badblocks: improve badblocks_check() for multiple ranges handling
>    badblocks: switch to the improved badblock handling code
> Coly Li (1):
>    test: user space code to test badblocks APIs
>
>   block/badblocks.c         | 1599 ++++++++++++++++++++++++++++++-------
>   include/linux/badblocks.h |   32 +
>   2 files changed, 1340 insertions(+), 291 deletions(-)
>

