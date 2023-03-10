Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DE66B51C0
	for <lists+linux-block@lfdr.de>; Fri, 10 Mar 2023 21:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjCJUX4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 10 Mar 2023 15:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjCJUXt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Mar 2023 15:23:49 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6B15AB44
        for <linux-block@vger.kernel.org>; Fri, 10 Mar 2023 12:23:39 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id n6so6864804plf.5
        for <linux-block@vger.kernel.org>; Fri, 10 Mar 2023 12:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678479819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQF4MLI/F9HbiwBvFOYgMpG0a1e7/18h9Y3ojmNxgXg=;
        b=BxX0opqGCk7FiaakFzUj1Ab+S5npu3tq/aetv7nIYPxLoMNPiwUDPlzmVy/6xrX8eg
         h8iN2UTlUpLNK2YLa35isQkKrUusXzjCxQ7opCIhbw6BjQBFlzV5lJeMbtilw1o/rRHm
         xj3qUs9fxo3EJO0lFQNNQ5BA7fIH1peHzCl/K6iQn20SjLdSWm2u1ZhBq0BWCoZo3Dt2
         t/6TS8L+iW5VFdLr3OnGZ5ASRlQ3BXgC7ykmll8B8x7alv5LALhmj/aeUP/JOLcKtxuk
         H1DHgFuS490Xc6BPNSErDFCA8cJl/pJQGcW8OHjR8C9fa7M0dpr2hckTZZ2tx+BopFRV
         8i+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678479819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQF4MLI/F9HbiwBvFOYgMpG0a1e7/18h9Y3ojmNxgXg=;
        b=DwDlOZtlsHp7BmsdibaZNYDKME+k9STatr1D7B+ZakJorTQ5ukqxnNWD8zmRNLP4lc
         v5Y/MwmrPcm0hCOTr3l7ll68IUS5DLoMV8kSNsv/qmcSZv+1MYSK2tGoiyD1QgCGxImZ
         TXbBSQ4I9gGtplZusNJPn+GjyTECnHVq7papP3mIwAM4zJwa6cMgcZnINQY4XXtu8fEo
         CcI8jeXH0SPiAAu1NCpIXx0E4sjZ9B8VOrYTFfFB/UnLe2SLy73cQPj71zTaVTRhPTQ2
         jqseOT9T75dxF/W4jTso1CWQHhuz75zdhkpHju7op5YL0eNDe+5bDV6ETSpoWdvwNNmC
         BApw==
X-Gm-Message-State: AO0yUKW1v2rszgqgXR5wpKUkhzHzCCVHU9HBILSry/ASv2MX48U8egg6
        zFgQn8ftphSl9XYD8+i2uRFJUw==
X-Google-Smtp-Source: AK7set+BSEEuCXguHDcEHUyp1G+H25LASXMUmsCu7o8DUKcffWrWX5PNcYfogkDMT3nPpIDry7aU3w==
X-Received: by 2002:a05:6a20:440d:b0:cc:d44a:beb6 with SMTP id ce13-20020a056a20440d00b000ccd44abeb6mr4930491pzb.5.1678479818536;
        Fri, 10 Mar 2023 12:23:38 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k25-20020aa790d9000000b005aa60d8545esm215805pfk.61.2023.03.10.12.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 12:23:38 -0800 (PST)
Message-ID: <ad021e89-c05c-f85a-2210-555837473734@kernel.dk>
Date:   Fri, 10 Mar 2023 13:23:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Possible kernel fs block code regression in 6.2.3 umounting usb
 drives
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>,
        Mike Cloaked <mike.cloaked@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>
References: <CAOCAAm7AEY9tkZpu2j+Of91fCE4UuE_PqR0UqNv2p2mZM9kqKw@mail.gmail.com>
 <CAOCAAm4reGhz400DSVrh0BetYD3Ljr2CZen7_3D4gXYYdB4SKQ@mail.gmail.com>
 <ZAuPkCn49urWBN5P@sol.localdomain> <ZAuQOHnfa7xGvzKI@sol.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZAuQOHnfa7xGvzKI@sol.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/10/23 1:16 PM, Eric Biggers wrote:
> On Fri, Mar 10, 2023 at 12:14:10PM -0800, Eric Biggers wrote:
>> On Fri, Mar 10, 2023 at 07:33:37PM +0000, Mike Cloaked wrote:
>>> With kerne. 6.2.3 if I simply plug in a usb external drive, mount it
>>> and umount it, then the journal has a kernel Oops and I have submitted
>>> a bug report, that includes the journal output, at
>>> https://bugzilla.kernel.org/show_bug.cgi?id=217174
>>>
>>> As soon as the usb drive is unmounted, the kernel Oops occurs, and the
>>> machine hangs on shutdown and needs a hard reboot.
>>>
>>> I have reproduced the same issue on three different machines, and in
>>> each case downgrading back to kernel 6.2.2 resolves the issue and it
>>> no longer occurs.
>>>
>>> This would seem to be a regression in kernel 6.2.3
>>>
>>> Mike C
>>
>> Thanks for reporting this!  If this is reliably reproducible and is known to be
>> a regression between v6.2.2 and v6.2.3, any chance you could bisect it to find
>> out the exact commit that introduced the bug?
>>
>> For reference I'm also copying the stack trace from bugzilla below:
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000028
>>  #PF: supervisor read access in kernel mode
>>  #PF: error_code(0x0000) - not-present page
>>  PGD 0 P4D 0
>>  Oops: 0000 [#1] PREEMPT SMP PTI
>>  CPU: 9 PID: 1118 Comm: lvcreate Tainted: G                T  6.2.3-1>
>>  Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./Z370 Ex>
>>  RIP: 0010:blk_throtl_update_limit_valid+0x1f/0x110
> 
> BTW, the block/ commits between v6.2.2 and v6.2.3 were:
> 
> 	blk-mq: avoid sleep in blk_mq_alloc_request_hctx
> 	blk-mq: remove stale comment for blk_mq_sched_mark_restart_hctx
> 	blk-mq: wait on correct sbitmap_queue in blk_mq_mark_tag_wait
> 	blk-mq: Fix potential io hung for shared sbitmap per tagset
> 	blk-mq: correct stale comment of .get_budget
> 	block: sync mixed merged request's failfast with 1st bio's
> 	block: Fix io statistics for cgroup in throttle path
> 	block: bio-integrity: Copy flags when bio_integrity_payload is cloned
> 	block: use proper return value from bio_failfast()
> 	blk-iocost: fix divide by 0 error in calc_lcoefs()
> 	blk-cgroup: dropping parent refcount after pd_free_fn() is done
> 	blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()
> 	block: don't allow multiple bios for IOCB_NOWAIT issue
> 	block: clear bio->bi_bdev when putting a bio back in the cache
> 	block: be a bit more careful in checking for NULL bdev while polling
> 
> Without having any in-depth knowledge here, I think "blk-cgroup: synchronize
> pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()" looks the
> most suspicious here...  I see that AUTOSEL selected it from a 3-patch series
> without backporting patch 2, maybe that could be it?  Anyway, just a hunch.

Was just looking at this too, the primary suspects would indeed be those
two blk-cgroup changes. And yes, they ended up in stable due to auto
selection, and very odd how it picked 2 and not the 3rd?!

But I would revert:

bfe46d2efe46c5c952f982e2ca94fe2ec5e58e2a
57a425badc05c2e87e9f25713e5c3c0298e4202c

in that order from 6.2.3 and see if that helps. Adding Yu.

-- 
Jens Axboe


