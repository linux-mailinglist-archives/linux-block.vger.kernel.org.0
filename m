Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007CD419006
	for <lists+linux-block@lfdr.de>; Mon, 27 Sep 2021 09:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbhI0Hc3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 27 Sep 2021 03:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbhI0Hc2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 03:32:28 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C453C061570;
        Mon, 27 Sep 2021 00:30:51 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h3so16947385pgb.7;
        Mon, 27 Sep 2021 00:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/SPeBepBiNs0Pq9nGNX9rF+zwWDYRbc/kp0Zx1Di3hg=;
        b=LkqZw+/Q1POlxJavggvhC2v8Ji+KAmW1XmX6+Dj4/EXf5KUDohKuXMaHOon8iUtjJg
         L4WsnVWMPTvGvHFc5+Ih2o1kMBUpZ0c0we77x5WhjvUS+a1j2Tm7Fn++tSOJeFZOBeHO
         ZNDdTg4S2K9wHTiGHm4/CxSgKhMV6sdxKzOkTRg4Wbgq7vNr+t56nV9kzVvasIUVk9VJ
         F6u/5wnF9OHsix6U+095heuCMgZdZbXrrpipQTwLfXqo4ItjJVlH3xgZHfXSZSnQLg80
         COJpbn+IlgleVP9ZMXTY6KglUi+j0LJabTa9c/bL6R5mtnUMnoVO7YkihK96nWyNwqOo
         bR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/SPeBepBiNs0Pq9nGNX9rF+zwWDYRbc/kp0Zx1Di3hg=;
        b=d1G4AjW0unLvGK/R5vSmXGFC6mNFicJhbi2x86ZDYP2nsChX7/v3Kreoetr0XC6zYr
         wfiZ5H0NXcDu3gyox3prUTLZdPAy5mgUTN/pciNSm5JSTYzJa5nURpV/UuyIVjvWEBZc
         +KAoY+xmOcPVCLdAVMu3D3jVNvScRUeGcSr0wSAEikaXyxVTWSfzf+NZNhHaWDEoTNdB
         hOOnZ5SZ6yqyy8UZj/umgOWa0N/uVbRK04PjejhW6xmrdmvMRhNsddzra/zuE06i+5yA
         P7fhw8W1xf3vvE6Q2S3mp/UqVtUcng+Y5dZMiT9lxx1lxkNo8zL7JVz5I2OthHUyL4Xw
         /Iyw==
X-Gm-Message-State: AOAM532RIo4y4x144gIB/b5KUvwOTOJB7PqJmO0xNzM7YO8KRxgmD1au
        VqlltgKdiF1Zw7PO8ZSELRw=
X-Google-Smtp-Source: ABdhPJz10hGMu78eGuW0GVQXMHrDrGv5rkecdT8VpzmJgOuD1akRTR1shBVmyYwyEO9fF1+G3XMgCA==
X-Received: by 2002:a62:51c6:0:b0:43d:e849:c69d with SMTP id f189-20020a6251c6000000b0043de849c69dmr22153855pfb.31.1632727850844;
        Mon, 27 Sep 2021 00:30:50 -0700 (PDT)
Received: from [10.239.207.187] ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id h6sm16108743pfr.121.2021.09.27.00.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 00:30:50 -0700 (PDT)
Message-ID: <8efbe758-74e4-32ea-d41e-639b750b27c0@gmail.com>
Date:   Mon, 27 Sep 2021 15:30:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v3 3/6] badblocks: improvement badblocks_set() for
 multiple ranges handling
Content-Language: en-US
To:     Coly Li <colyli@suse.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        nvdimm@lists.linux.dev
Cc:     antlists@youngman.org.uk, Dan Williams <dan.j.williams@intel.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        NeilBrown <neilb@suse.de>, Richard Fan <richard.fan@suse.com>,
        Vishal L Verma <vishal.l.verma@intel.com>
References: <20210913163643.10233-1-colyli@suse.de>
 <20210913163643.10233-4-colyli@suse.de>
From:   Geliang Tang <geliangtang@gmail.com>
In-Reply-To: <20210913163643.10233-4-colyli@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/14/21 00:36, Coly Li wrote:
> Recently I received a bug report that current badblocks code does not
> properly handle multiple ranges. For example,
> 	badblocks_set(bb, 32, 1, true);
> 	badblocks_set(bb, 34, 1, true);
> 	badblocks_set(bb, 36, 1, true);
> 	badblocks_set(bb, 32, 12, true);
> Then indeed badblocks_show() reports,
> 	32 3
> 	36 1
> But the expected bad blocks table should be,
> 	32 12
> Obviously only the first 2 ranges are merged and badblocks_set() returns
> and ignores the rest setting range.
> 
> This behavior is improper, if the caller of badblocks_set() wants to set
> a range of blocks into bad blocks table, all of the blocks in the range
> should be handled even the previous part encountering failure.
> 
> The desired way to set bad blocks range by badblocks_set() is,
> - Set as many as blocks in the setting range into bad blocks table.
> - Merge the bad blocks ranges and occupy as less as slots in the bad
>    blocks table.
> - Fast.
> 
> Indeed the above proposal is complicated, especially with the following
> restrictions,
> - The setting bad blocks range can be acknowledged or not acknowledged.
> - The bad blocks table size is limited.
> - Memory allocation should be avoided.
> 
> The basic idea of the patch is to categorize all possible bad blocks
> range setting combinationsinto to much less simplified and more less
> special conditions. Inside badblocks_set() there is an implicit loop
> composed by jumping between labels 're_insert' and 'update_sectors'. No
> matter how large the setting bad blocks range is, in every loop just a
> minimized range from the head is handled by a pre-defined behavior from
> one of the categorized conditions. The logic is simple and code flow is
> manageable.
> 
> The different relative layout between the setting range and existing bad
> block range are checked and handled (merge, combine, overwrite, insert)
> by the helpers in previous patch. This patch is to make all the helpers
> work together with the above idea.
> 
> This patch only has the algorithm improvement for badblocks_set(). There
> are following patches contain improvement for badblocks_clear() and
> badblocks_check(). But the algorithm in badblocks_set() is fundamental
> and typical, other improvement in clear and check routines are based on
> all the helpers and ideas in this patch.
> 
> In order to make the change to be more clear for code review, this patch
> does not directly modify existing badblocks_set(), and just add a new
> one named _badblocks_set(). Later patch will remove current existing
> badblocks_set() code and make it as a wrapper of _badblocks_set(). So
> the new added change won't be mixed with deleted code, the code review
> can be easier.
> 
> Signed-off-by: Coly Li <colyli@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Richard Fan <richard.fan@suse.com>
> Cc: Vishal L Verma <vishal.l.verma@intel.com>
> ---
>   block/badblocks.c | 561 ++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 541 insertions(+), 20 deletions(-)
> 
> diff --git a/block/badblocks.c b/block/badblocks.c
> index efe316181e05..39de90af8386 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -16,6 +16,322 @@
>   #include <linux/types.h>
>   #include <linux/slab.h>
>   
> +/*
> + * The purpose of badblocks set/clear is to manage bad blocks ranges which are
> + * identified by LBA addresses.
> + *
> + * When the caller of badblocks_set() wants to set a range of bad blocks, the
> + * setting range can be acked or unacked. And the setting range may merge,
> + * overwrite, skip the overlaypped already set range, depends on who they are
> + * overlapped or adjacent, and the acknowledgment type of the ranges. It can be
> + * more complicated when the setting range covers multiple already set bad block
> + * ranges, with restritctions of maximum length of each bad range and the bad
> + * table space limitation.
> + *
> + * It is difficut and unnecessary to take care of all the possible situations,
> + * for setting a large range of bad blocks, we can handle it by dividing the
> + * large range into smaller ones when encounter overlap, max range length or
> + * bad table full conditions. Every time only a smaller piece of the bad range
> + * is handled with a limited number of conditions how it is interacted with
> + * possible overlapped or adjacent already set bad block ranges. Then the hard
> + * complicated problem can be much simpler to habndle in proper way.
> + *
> + * When setting a range of bad blocks to the bad table, the simplified situations
> + * to be considered are, (The already set bad blocks ranges are naming with
> + *  prefix E, and the setting bad blocks range is naming with prefix S)
> + *
> + * 1) A setting range is not overlapped or adjacent to any other already set bad
> + *    block range.
> + *                         +--------+
> + *                         |    S   |
> + *                         +--------+
> + *        +-------------+               +-------------+
> + *        |      E1     |               |      E2     |
> + *        +-------------+               +-------------+
> + *    For this situation if the bad blocks table is not full, just allocate a
> + *    free slot from the bad blocks table to mark the setting range S. The
> + *    result is,
> + *        +-------------+  +--------+   +-------------+
> + *        |      E1     |  |    S   |   |      E2     |
> + *        +-------------+  +--------+   +-------------+
> + * 2) A setting range starts exactly at a start LBA of an already set bad blocks
> + *    range.
> + * 2.1) The setting range size < already set range size
> + *        +--------+
> + *        |    S   |
> + *        +--------+
> + *        +-------------+
> + *        |      E      |
> + *        +-------------+
> + * 2.1.1) If S and E are both acked or unacked range, the setting range S can
> + *    be merged into existing bad range E. The result is,
> + *        +-------------+
> + *        |      S      |
> + *        +-------------+
> + * 2.1.2) If S is uncked setting and E is acked, the setting will be dinied, and

uncked -> unacked
dinied?

> + *    the result is,
> + *        +-------------+
> + *        |      E      |
> + *        +-------------+
> + * 2.1.3) If S is acked setting and E is unacked, range S can overwirte on E.
> + *    An extra slot from the bad blocks table will be allocated for S, and head
> + *    of E will move to end of the inserted range E. The result is,
> + *        +--------+----+
> + *        |    S   | E  |
> + *        +--------+----+
> + * 2.2) The setting range size == already set range size
> + * 2.2.1) If S and E are both acked or unacked range, the setting range S can
> + *    be merged into existing bad range E. The result is,
> + *        +-------------+
> + *        |      S      |
> + *        +-------------+
> + * 2.2.2) If S is uncked setting and E is acked, the setting will be dinied, and

uncked -> unacked

> + *    the result is,
> + *        +-------------+
> + *        |      E      |
> + *        +-------------+
> + * 2.2.3) If S is acked setting and E is unacked, range S can overwirte all of
> +      bad blocks range E. The result is,
> + *        +-------------+
> + *        |      S      |
> + *        +-------------+
> + * 2.3) The setting range size > already set range size
> + *        +-------------------+
> + *        |          S        |
> + *        +-------------------+
> + *        +-------------+
> + *        |      E      |
> + *        +-------------+
> + *    For such situation, the setting range S can be treated as two parts, the
> + *    first part (S1) is as same size as the already set range E, the second
> + *    part (S2) is the rest of setting range.
> + *        +-------------+-----+        +-------------+       +-----+
> + *        |    S1       | S2  |        |     S1      |       | S2  |
> + *        +-------------+-----+  ===>  +-------------+       +-----+
> + *        +-------------+              +-------------+
> + *        |      E      |              |      E      |
> + *        +-------------+              +-------------+
> + *    Now we only focus on how to handle the setting range S1 and already set
> + *    range E, which are already explained in 1.2), for the rest S2 it will be
> + *    handled later in next loop.
> + * 3) A setting range starts before the start LBA of an already set bad blocks
> + *    range.
> + *        +-------------+
> + *        |      S      |
> + *        +-------------+
> + *             +-------------+
> + *             |      E      |
> + *             +-------------+
> + *    For this situation, the setting range S can be divided into two parts, the
> + *    first (S1) ends at the start LBA of already set range E, the second part
> + *    (S2) starts exactly at a start LBA of the already set range E.
> + *        +----+---------+             +----+      +---------+
> + *        | S1 |    S2   |             | S1 |      |    S2   |
> + *        +----+---------+      ===>   +----+      +---------+
> + *             +-------------+                     +-------------+
> + *             |      E      |                     |      E      |
> + *             +-------------+                     +-------------+
> + *    Now only the first part S1 should be handled in this loop, which is in
> + *    similar condition as 1). The rest part S2 has exact same start LBA address
> + *    of the already set range E, they will be handled in next loop in one of
> + *    situations in 2).
> + * 4) A setting range starts after the start LBA of an already set bad blocks
> + *    range.
> + * 4.1) If the setting range S exactly matches the tail part of already set bad
> + *    blocks range E, like the following chart shows,
> + *            +---------+
> + *            |   S     |
> + *            +---------+
> + *        +-------------+
> + *        |      E      |
> + *        +-------------+
> + * 4.1.1) If range S and E have same ackknowledg value (both acked or unacked),
> + *    they will be merged into one, the result is,
> + *        +-------------+
> + *        |      S      |
> + *        +-------------+
> + * 4.1.2) If range E is acked and the setting range S is unacked, the setting
> + *    request of S will be rejected, the result is,
> + *        +-------------+
> + *        |      E      |
> + *        +-------------+
> + * 4.1.3) If range E is unacked, and the setting range S is acked, then S may
> + *    overwrite the overlapped range of E, the result is,
> + *        +---+---------+
> + *        | E |    S    |
> + *        +---+---------+
> + * 4.2) If the setting range S stays in middle of an already set range E, like
> + *    the following chart shows,
> + *             +----+
> + *             | S  |
> + *             +----+
> + *        +--------------+
> + *        |       E      |
> + *        +--------------+
> + * 4.2.1) If range S and E have same ackknowledg value (both acked or unacked),
> + *    they will be merged into one, the result is,
> + *        +--------------+
> + *        |       S      |
> + *        +--------------+
> + * 4.2.2) If range E is acked and the setting range S is unacked, the setting
> + *    request of S will be rejected, the result is also,
> + *        +--------------+
> + *        |       E      |
> + *        +--------------+
> + * 4.2.3) If range E is unacked, and the setting range S is acked, then S will
> + *    inserted into middle of E and split previous range E into twp parts (E1
> + *    and E2), the result is,
> + *        +----+----+----+
> + *        | E1 |  S | E2 |
> + *        +----+----+----+
> + * 4.3) If the setting bad blocks range S is overlapped with an already set bad
> + *    blocks range E. The range S starts after the start LBA of range E, and
> + *    ends after the end LBA of range E, as the following chart shows,
> + *            +-------------------+
> + *            |          S        |
> + *            +-------------------+
> + *        +-------------+
> + *        |      E      |
> + *        +-------------+
> + *    For this situation the range S can be divided into two parts, the first
> + *    part (S1) ends at end range E, and the second part (S2) has rest range of
> + *    origin S.
> + *            +---------+---------+            +---------+      +---------+
> + *            |    S1   |    S2   |            |    S1   |      |    S2   |
> + *            +---------+---------+  ===>      +---------+      +---------+
> + *        +-------------+                  +-------------+
> + *        |      E      |                  |      E      |
> + *        +-------------+                  +-------------+
> + *     Now in this loop the setting range S1 and already set range E can be
> + *     handled as the situations 4), the rest range S2 will be handled in next
> + *     loop and ignored in this loop.
> + * 5) A setting bad blocks range S is adjacent to one or more already set bad
> + *    blocks range(s), and they are all acked or unacked range.
> + * 5.1) Front merge: If the already set bad blocks range E is before setting
> + *    range S and they are adjacent,
> + *                +------+
> + *                |  S   |
> + *                +------+
> + *        +-------+
> + *        |   E   |
> + *        +-------+
> + * 5.1.1) When total size of range S and E <= BB_MAX_LEN, and their acknowledge
> + *    values are same, the setting range S can front merges into range E. The
> + *    result is,
> + *        +--------------+
> + *        |       S      |
> + *        +--------------+
> + * 5.1.2) Otherwise these two ranges cannot merge, just insert the setting
> + *    range S right after already set range E into the bad blocks table. The
> + *    result is,
> + *        +--------+------+
> + *        |   E    |   S  |
> + *        +--------+------+
> + * 6) Special cases which above conditions cannot handle
> + * 6.1) Multiple already set ranges may merge into less ones in a full bad table
> + *        +-------------------------------------------------------+
> + *        |                           S                           |
> + *        +-------------------------------------------------------+
> + *        |<----- BB_MAX_LEN ----->|
> + *                                 +-----+     +-----+   +-----+
> + *                                 | E1  |     | E2  |   | E3  |
> + *                                 +-----+     +-----+   +-----+
> + *     In the above example, when the bad blocks table is full, inserting the
> + *     first part of setting range S will fail because no more available slot
> + *     can be allocated from bad blocks table. In this situation a proper
> + *     setting method should be go though all the setting bad blocks range and
> + *     look for chance to merge already set ranges into less ones. When there
> + *     is available slot from bad blocks table, re-try again to handle more
> + *     setting bad blocks ranges as many as possible.
> + *        +------------------------+
> + *        |          S3            |
> + *        +------------------------+
> + *        |<----- BB_MAX_LEN ----->|
> + *                                 +-----+-----+-----+---+-----+--+
> + *                                 |       S1        |     S2     |
> + *                                 +-----+-----+-----+---+-----+--+
> + *     The above chart shows although the first part (S3) cannot be inserted due
> + *     to no-space in bad blocks table, but the following E1, E2 and E3 ranges
> + *     can be merged with rest part of S into less range S1 and S2. Now there is
> + *     1 free slot in bad blocks table.
> + *        +------------------------+-----+-----+-----+---+-----+--+
> + *        |           S3           |       S1        |     S2     |
> + *        +------------------------+-----+-----+-----+---+-----+--+
> + *     Since the bad blocks table is not full anymore, re-try again for the
> + *     origin setting range S. Now the setting range S3 can be inserted into the
> + *     bad blocks table with previous freed slot from multiple ranges merge.
> + * 6.2) Front merge after overwrite
> + *    In the following example, in bad blocks table, E1 is an acked bad blocks
> + *    range and E2 is an unacked bad blocks range, therefore they are not able
> + *    to merge into a larger range. The setting bad blocks range S is acked,
> + *    therefore part of E2 can be overwritten by S.
> + *                      +--------+
> + *                      |    S   |                             acknowledged
> + *                      +--------+                         S:       1
> + *              +-------+-------------+                   E1:       1
> + *              |   E1  |    E2       |                   E2:       0
> + *              +-------+-------------+
> + *     With previosu simplified routines, after overwiting part of E2 with S,
> + *     the bad blocks table should be (E3 is remaining part of E2 which is not
> + *     overwritten by S),
> + *                                                             acknowledged
> + *              +-------+--------+----+                    S:       1
> + *              |   E1  |    S   | E3 |                   E1:       1
> + *              +-------+--------+----+                   E3:       0
> + *     The above result is correct but not perfect. Range E1 and S in the bad
> + *     blocks table are all acked, merging them into a larger one range may
> + *     occupy less bad blocks table space and make badblocks_check() faster.
> + *     Therefore in such situation, after overwiting range S, the previous range
> + *     E1 should be checked for possible front combination. Then the ideal
> + *     result can be,
> + *              +----------------+----+                        acknowledged
> + *              |       E1       | E3 |                   E1:       1
> + *              +----------------+----+                   E3:       0
> + * 6.3) Behind merge: If the already set bad blocks range E is behind the setting
> + *    range S and they are adjacent. Normally we don't need to care about this
> + *    because front merge handles this while going though range S from head to
> + *    tail, except for the tail part of range S. When the setting range S are
> + *    fully handled, all the above simplified routine doesn't check whether the
> + *    tail LBA of range S is adjacent to the next already set range and not able
> + *    to them if they are mergeable.
> + *        +------+
> + *        |  S   |
> + *        +------+
> + *               +-------+
> + *               |   E   |
> + *               +-------+
> + *    For the above special stiuation, when the setting range S are all handled
> + *    and the loop ends, an extra check is necessary for whether next already
> + *    set range E is right after S and mergeable.
> + * 6.2.1) When total size of range E and S <= BB_MAX_LEN, and their acknowledge
> + *    values are same, the setting range S can behind merges into range E. The
> + *    result is,
> + *        +--------------+
> + *        |       S      |
> + *        +--------------+
> + * 6.2.2) Otherwise these two ranges cannot merge, just insert the setting range
> + *     S infront of the already set range E in the bad blocks table. The result
> + *     is,
> + *        +------+-------+
> + *        |  S   |   E   |
> + *        +------+-------+
> + *
> + * All the above 5 simplified situations and 3 special cases may cover 99%+ of
> + * the bad block range setting conditions. Maybe there is some rare corner case
> + * is not considered and optimized, it won't hurt if badblocks_set() fails due
> + * to no space, or some ranges are not merged to save bad blocks table space.
> + *
> + * Inside badblocks_set() each loop starts by jumping to re_insert label, every
> + * time for the new loop prev_badblocks() is called to find an already set range
> + * which starts before or at current setting range. Since the setting bad blocks
> + * range is handled from head to tail, most of the cases it is unnecessary to do
> + * the binary search inside prev_badblocks(), it is possible to provide a hint
> + * to prev_badblocks() for a fast path, then the expensive binary search can be
> + * avoided. In my test with the hint to prev_badblocks(), except for the first
> + * loop, all rested calls to prev_badblocks() can go into the fast path and
> + * return correct bad blocks table index immediately.
> + */
> +
>   /*
>    * Find the range starts at-or-before 's' from bad table. The search
>    * starts from index 'hint' and stops at index 'hint_end' from the bad
> @@ -390,6 +706,231 @@ static int insert_at(struct badblocks *bb, int at, struct badblocks_context *bad)
>   	return len;
>   }
>   
> +static void badblocks_update_acked(struct badblocks *bb)
> +{
> +	u64 *p = bb->page;
> +	int i;
> +	bool unacked = false;
> +
> +	if (!bb->unacked_exist)
> +		return;
> +
> +	for (i = 0; i < bb->count ; i++) {
> +		if (!BB_ACK(p[i])) {
> +			unacked = true;
> +			break;
> +		}
> +	}
> +
> +	if (!unacked)
> +		bb->unacked_exist = 0;
> +}
> +
> +/* Do exact work to set bad block range into the bad block table */
> +static int _badblocks_set(struct badblocks *bb, sector_t s, int sectors,
> +			  int acknowledged)
> +{
> +	u64 *p;
> +	struct badblocks_context bad;
> +	int prev = -1, hint = -1;
> +	int len = 0, added = 0;
> +	int retried = 0, space_desired = 0;
> +	int rv = 0;
> +	unsigned long flags;

orig_start and orig_len are used in _badblocks_set() only, we can drop 
them from struct badblocks_context, declare two local variables instead:

         sector_t orig_start;
         int orig_len;

> +
> +	if (bb->shift < 0)
> +		/* badblocks are disabled */
> +		return 1;
> +
> +	if (sectors == 0)
> +		/* Invalid sectors number */
> +		return 1;
> +
> +	if (bb->shift) {
> +		/* round the start down, and the end up */
> +		sector_t next = s + sectors;
> +
> +		rounddown(s, bb->shift);
> +		roundup(next, bb->shift);
> +		sectors = next - s;
> +	}
> +
> +	write_seqlock_irqsave(&bb->lock, flags);
> +
> +	bad.orig_start = s;
> +	bad.orig_len = sectors;

         orig_start = s;
         orig_len = sectors;

> +	bad.ack = acknowledged;
> +	p = bb->page;
> +
> +re_insert:
> +	bad.start = s;
> +	bad.len = sectors;
> +	len = 0;
> +
> +	if (badblocks_empty(bb)) {
> +		len = insert_at(bb, 0, &bad);
> +		bb->count++;
> +		added++;
> +		goto update_sectors;
> +	}
> +
> +	prev = prev_badblocks(bb, &bad, hint);
> +
> +	/* start before all badblocks */
> +	if (prev < 0) {
> +		if (!badblocks_full(bb)) {
> +			/* insert on the first */
> +			if (bad.len > (BB_OFFSET(p[0]) - bad.start))
> +				bad.len = BB_OFFSET(p[0]) - bad.start;
> +			len = insert_at(bb, 0, &bad);
> +			bb->count++;
> +			added++;
> +			hint = 0;
> +			goto update_sectors;
> +		}
> +
> +		/* No sapce, try to merge */
> +		if (overlap_behind(bb, &bad, 0)) {
> +			if (can_merge_behind(bb, &bad, 0)) {
> +				len = behind_merge(bb, &bad, 0);
> +				added++;
> +			} else {
> +				len = min_t(sector_t,
> +					    BB_OFFSET(p[0]) - s, sectors);
> +				space_desired = 1;
> +			}
> +			hint = 0;
> +			goto update_sectors;
> +		}
> +
> +		/* no table space and give up */
> +		goto out;
> +	}
> +
> +	/* in case p[prev-1] can be merged with p[prev] */
> +	if (can_combine_front(bb, prev, &bad)) {
> +		front_combine(bb, prev);
> +		bb->count--;
> +		added++;
> +		hint = prev - 1;
> +		goto update_sectors;
> +	}
> +
> +	if (overlap_front(bb, prev, &bad)) {
> +		if (can_merge_front(bb, prev, &bad)) {
> +			len = front_merge(bb, prev, &bad);
> +			added++;
> +			hint = prev - 1;
> +		} else {
> +			int extra = 0;
> +
> +			if (!can_front_overwrite(bb, prev, &bad, &extra)) {
> +				len = min_t(sector_t,
> +					    BB_END(p[prev]) - s, sectors);
> +				hint = prev;
> +				goto update_sectors;
> +			}
> +
> +			len = front_overwrite(bb, prev, &bad, extra);
> +			added++;
> +			bb->count += extra;
> +			hint = prev;
> +
> +			if (prev > 0 && can_combine_front(bb, prev, &bad)) {
> +				front_combine(bb, prev);
> +				bb->count--;
> +				hint = prev - 1;
> +			}
> +		}
> +		goto update_sectors;
> +	}
> +
> +	if (can_merge_front(bb, prev, &bad)) {
> +		len = front_merge(bb, prev, &bad);
> +		added++;
> +		hint = prev;
> +		goto update_sectors;
> +	}
> +
> +	/* if no space in table, still try to merge in the covered range */
> +	if (badblocks_full(bb)) {
> +		/* skip the cannot-merge range */
> +		if (((prev + 1) < bb->count) &&
> +		    overlap_behind(bb, &bad, prev + 1) &&
> +		    ((s + sectors) >= BB_END(p[prev + 1]))) {
> +			len = BB_END(p[prev + 1]) - s;
> +			hint = prev + 1;
> +			goto update_sectors;
> +		}
> +
> +		/* no retry any more */
> +		len = sectors;
> +		space_desired = 1;
> +		hint = -1;
> +		goto update_sectors;
> +	}
> +
> +	/* cannot merge and there is space in bad table */
> +	if ((prev + 1) < bb->count &&
> +	    overlap_behind(bb, &bad, prev + 1))
> +		bad.len = min_t(sector_t,
> +				bad.len, BB_OFFSET(p[prev + 1]) - bad.start);
> +
> +	len = insert_at(bb, prev + 1, &bad);
> +	bb->count++;
> +	added++;
> +	hint = prev + 1;
> +
> +update_sectors:
> +	s += len;
> +	sectors -= len;
> +
> +	if (sectors > 0)
> +		goto re_insert;
> +
> +	WARN_ON(sectors < 0);
> +
> +	/* Check whether the following already set range can be merged */
> +	if ((prev + 1) < bb->count &&
> +	    BB_END(p[prev]) == BB_OFFSET(p[prev + 1]) &&
> +	    (BB_LEN(p[prev]) + BB_LEN(p[prev + 1])) <= BB_MAX_LEN &&
> +	    BB_ACK(p[prev]) == BB_ACK(p[prev + 1])) {
> +		p[prev] = BB_MAKE(BB_OFFSET(p[prev]),
> +				  BB_LEN(p[prev]) + BB_LEN(p[prev + 1]),
> +				  BB_ACK(p[prev]));
> +
> +		if ((prev + 2) < bb->count)
> +			memmove(p + prev + 1, p + prev + 2,
> +				(bb->count -  (prev + 2)) * 8);
> +		bb->count--;
> +	}
> +
> +	if (space_desired && !badblocks_full(bb)) {
> +		s = bad.orig_start;
> +		sectors = bad.orig_len;

	        s = orig_start;
         	sectors = orig_len;


Thanks,
-Geliang

> +		space_desired = 0;
> +		if (retried++ < 3)
> +			goto re_insert;
> +	}
> +
> +out:
> +	if (added) {
> +		set_changed(bb);
> +
> +		if (!acknowledged)
> +			bb->unacked_exist = 1;
> +		else
> +			badblocks_update_acked(bb);
> +	}
> +
> +	write_sequnlock_irqrestore(&bb->lock, flags);
> +
> +	if (!added)
> +		rv = 1;
> +
> +	return rv;
> +}
> +
>   /**
>    * badblocks_check() - check a given range for bad sectors
>    * @bb:		the badblocks structure that holds all badblock information
> @@ -499,26 +1040,6 @@ int badblocks_check(struct badblocks *bb, sector_t s, int sectors,
>   }
>   EXPORT_SYMBOL_GPL(badblocks_check);
>   
> -static void badblocks_update_acked(struct badblocks *bb)
> -{
> -	u64 *p = bb->page;
> -	int i;
> -	bool unacked = false;
> -
> -	if (!bb->unacked_exist)
> -		return;
> -
> -	for (i = 0; i < bb->count ; i++) {
> -		if (!BB_ACK(p[i])) {
> -			unacked = true;
> -			break;
> -		}
> -	}
> -
> -	if (!unacked)
> -		bb->unacked_exist = 0;
> -}
> -
>   /**
>    * badblocks_set() - Add a range of bad blocks to the table.
>    * @bb:		the badblocks structure that holds all badblock information
> 

