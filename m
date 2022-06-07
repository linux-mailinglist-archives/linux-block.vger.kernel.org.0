Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74016539BA1
	for <lists+linux-block@lfdr.de>; Wed,  1 Jun 2022 05:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349376AbiFAD1p (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 31 May 2022 23:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349399AbiFAD1o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 23:27:44 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AC91C10D
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 20:27:41 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id l13so606956lfp.11
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 20:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uWE/tlnw2tByHU+mXjZ+jRPcFVoufodKiFqk051MZR4=;
        b=FDETkjVNev2bwE0gd7KO4gXYzGXFHsd/brl/7XmqB7hqVP9Qua1X0iYslCPL4xCohU
         5Vz59UKH3SJ3aBaPDso2ALz5rf8dW77CDWbAp98MxvRMiPv7CGm4Mpc3pMsdPsegxYNh
         ivOaFyNmDOMNVGa6xbojIwb/YsonBONeJabAWlx9AD9EOPDLenu0EMMJRwhvCWeWMdnb
         Ff0I7Ep9BtoZh2j0IEOgx9jZ/vJR0SZJUqgaGPEAvcifBmvvtm/05M1R60CivbO2WMW+
         guFFlY1sFKtL1BXEvVtUKwtTjJqIbB/eWH7YWd7WpuLET9ZjV/3F6pAPnolJmUMvrff/
         xT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uWE/tlnw2tByHU+mXjZ+jRPcFVoufodKiFqk051MZR4=;
        b=eoiZP0y/6ITEV0JCIeb1J1QBu4gFMLrbA1HqsNQZPlabso7GCKmPZDrasH7yC+ZsbK
         PXMF/0HyG+mFO350VNmD5ZixfwQT67n0TrkMtFUbIcblKUfbyEbBMhu3jdHWGV0vTPmm
         iq8Rm1flW94+RdO3i88uiL55aC5/05BJubKenh+8cmhFNoJZY6FHPllmX3QfseBbroxY
         RkZtwqOZddSakdGZx9y7NJ7NV1mGEKWcoD5VC2tol4FXTavhAdb9yHKfkA1cy8puneUL
         urxzIUiNH0gzkv9OLzUiLr8mjQbJLwu/ZF+dWRhkv/l9SmphYz3YLoOAEesAJqBEiccn
         sWMA==
X-Gm-Message-State: AOAM5327x2veCajbU7dk1yls0lE3nw8+WZB5tbOO2m503hCRfmjkUIIE
        BHnvoW/JucJdnr7bXHonlI+fbCSiy4gDP6HD
X-Google-Smtp-Source: ABdhPJzatB2O7qy43HFTOdYED0i4F4fVJ+N4n+yDhea/CLDLvvZGS6wSvGM56t/eojTX01SEBIOfJg==
X-Received: by 2002:a5d:6d09:0:b0:20f:bef8:665b with SMTP id e9-20020a5d6d09000000b0020fbef8665bmr45911540wrq.548.1654054048882;
        Tue, 31 May 2022 20:27:28 -0700 (PDT)
Received: from [10.188.163.71] (cust-east-parth2-46-193-73-98.wb.wifirst.net. [46.193.73.98])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c2c4c00b0039750c29cf7sm473034wmg.40.2022.05.31.20.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 20:27:28 -0700 (PDT)
Message-ID: <434b4857-12fd-feb7-7e3e-466831a3f36b@kernel.dk>
Date:   Tue, 31 May 2022 21:27:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: bioset_exit poison from dm_destroy
Content-Language: en-US
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, david@fromorbit.com
References: <YpK7m+14A+pZKs5k@casper.infradead.org>
 <2523e5b0-d89c-552e-40a6-6d414418749d@kernel.dk>
 <YpZlOCMept7wFjOw@redhat.com>
 <6995e822-79a0-ca17-9c32-6089d14b5be5@kernel.dk>
 <YpZxVH7DRUkrbWUa@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YpZxVH7DRUkrbWUa@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/31/22 1:49 PM, Mike Snitzer wrote:
> On Tue, May 31 2022 at  3:00P -0400,
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> On 5/31/22 12:58 PM, Mike Snitzer wrote:
>>> On Sun, May 29 2022 at  8:46P -0400,
>>> Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>>> On 5/28/22 6:17 PM, Matthew Wilcox wrote:
>>>>> Not quite sure whose bug this is.  Current Linus head running xfstests
>>>>> against ext4 (probably not ext4's fault?)
>>>>>
>>>>> 01818 generic/250	run fstests generic/250 at 2022-05-28 23:48:09
>>>>> 01818 EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
>>>>> 01818 EXT4-fs (dm-0): unmounting filesystem.
>>>>> 01818 EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
>>>>> 01818 EXT4-fs (dm-0): unmounting filesystem.
>>>>> 01818 EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
>>>>> 01818 Buffer I/O error on dev dm-0, logical block 3670000, async page read
>>>>> 01818 EXT4-fs (dm-0): unmounting filesystem.
>>>>> 01818 EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
>>>>> 01818 EXT4-fs (dm-0): unmounting filesystem.
>>>>> 01818 general protection fault, probably for non-canonical address 0xdead000000000122: 0000 [#1] PREEMPT SMP NOPTI
>>>>> 01818 CPU: 0 PID: 1579117 Comm: dmsetup Kdump: loaded Not tainted 5.18.0-11049-g1dec3d7fd0c3-dirty #262
>>>>> 01818 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
>>>>> 01818 RIP: 0010:__cpuhp_state_remove_instance+0xf0/0x1b0
>>>>> 01818 Code: a0 f8 d7 81 42 3b 1c 28 7f d9 4c 89 e1 31 d2 89 de 89 7d dc e8 01 fd ff ff 8b 7d dc eb c5 49 8b 04 24 49 8b 54 24 08 48 85 c0 <48> 89 02 74 04 48 89 50 08 48 b8 00 01 00 00 00 00 ad de 48 c7 c7
>>>>> 01818 RSP: 0018:ffff888101fcfc60 EFLAGS: 00010286
>>>>> 01818 RAX: dead000000000100 RBX: 0000000000000017 RCX: 0000000000000000
>>>>> 01818 RDX: dead000000000122 RSI: ffff8881233b0ae8 RDI: ffffffff81e3b080
>>>>> 01818 RBP: ffff888101fcfc88 R08: 0000000000000008 R09: 0000000000000003
>>>>> 01818 R10: 0000000000000000 R11: 00000000002dc6c0 R12: ffff8881233b0ae8
>>>>> 01818 R13: 0000000000000000 R14: ffffffff81e38f58 R15: ffff88817b5a3c00
>>>>> 01818 FS:  00007ff56daec280(0000) GS:ffff888275800000(0000) knlGS:0000000000000000
>>>>> 01818 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> 01818 CR2: 00005591ad94f198 CR3: 000000017b5a0004 CR4: 0000000000770eb0
>>>>> 01818 PKRU: 55555554
>>>>> 01818 Call Trace:
>>>>> 01818  <TASK>
>>>>> 01818  ? kfree+0x66/0x250
>>>>> 01818  bioset_exit+0x32/0x210
>>>>> 01818  cleanup_mapped_device+0x34/0xf0
>>>>> 01818  __dm_destroy+0x149/0x1f0
>>>>> 01818  ? table_clear+0xc0/0xc0
>>>>> 01818  dm_destroy+0xe/0x10
>>>>> 01818  dev_remove+0xd9/0x120
>>>>> 01818  ctl_ioctl+0x1cb/0x420
>>>>> 01818  dm_ctl_ioctl+0x9/0x10
>>>>> 01818  __x64_sys_ioctl+0x89/0xb0
>>>>> 01818  do_syscall_64+0x35/0x80
>>>>> 01818  entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>>>> 01818 RIP: 0033:0x7ff56de3b397
>>>>> 01818 Code: 3c 1c e8 1c ff ff ff 85 c0 79 87 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a9 da 0d 00 f7 d8 64 89 01 48
>>>>> 01818 RSP: 002b:00007ffe55367ef8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
>>>>> 01818 RAX: ffffffffffffffda RBX: 00007ff56df31a8e RCX: 00007ff56de3b397
>>>>> 01818 RDX: 000055daad7cab30 RSI: 00000000c138fd04 RDI: 0000000000000003
>>>>> 01818 RBP: 00007ffe55367fb0 R08: 00007ff56df81558 R09: 00007ffe55367d60
>>>>> 01818 R10: 00007ff56df808a2 R11: 0000000000000206 R12: 00007ff56df808a2
>>>>> 01818 R13: 00007ff56df808a2 R14: 00007ff56df808a2 R15: 00007ff56df808a2
>>>>> 01818  </TASK>
>>>>> 01818 Modules linked in: crct10dif_generic crct10dif_common [last unloaded: crc_t10dif]
>>>>
>>>> I suspect dm is calling bioset_exit() multiple times? Which it probably
>>>> should not.
>>>>
>>>> The reset of bioset_exit() is resilient against this, so might be best
>>>> to include bio_alloc_cache_destroy() in that.
>>>>
>>>>
>>>> diff --git a/block/bio.c b/block/bio.c
>>>> index a3893d80dccc..be3937b84e68 100644
>>>> --- a/block/bio.c
>>>> +++ b/block/bio.c
>>>> @@ -722,6 +722,7 @@ static void bio_alloc_cache_destroy(struct bio_set *bs)
>>>>  		bio_alloc_cache_prune(cache, -1U);
>>>>  	}
>>>>  	free_percpu(bs->cache);
>>>> +	bs->cache = NULL;
>>>>  }
>>>>  
>>>>  /**
>>>
>>> Yes, we need the above to fix the crash.  Does it also make sense to
>>> add this?
>>>
>>> diff --git a/include/linux/bio.h b/include/linux/bio.h
>>> index 49eff01fb829..f410c78e9c0c 100644
>>> --- a/include/linux/bio.h
>>> +++ b/include/linux/bio.h
>>> @@ -681,7 +681,7 @@ struct bio_set {
>>>
>>>  static inline bool bioset_initialized(struct bio_set *bs)
>>>  {
>>> -	return bs->bio_slab != NULL;
>>> +	return (bs->bio_slab != NULL || bs->cache != NULL);
>>>  }
>>
>> Should not be possible to have valid bs->cache without bs->bio_slab?
> 
> Not quite following your question, but I sprinkled this extra check in
> purely because DM core uses bioset_initialized() to verify that the
> bioset is _not_ yet initialized.
> 
> But it really doesn't make sense to consider the bioset _fully_
> initialized if bs->bio_slab is NULL but bs->cache is NOT...

Honestly, I'd be way happier getting rid of bioset_initialized()!

> Anyway, really don't need this change but we do need your earlier
> patch to reset bs->cache to NULL.

Certainly, that patch will be going upstream in a day or two.

-- 
Jens Axboe

