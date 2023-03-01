Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF4C6A674A
	for <lists+linux-block@lfdr.de>; Wed,  1 Mar 2023 06:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjCAFT2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 1 Mar 2023 00:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCAFT1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Mar 2023 00:19:27 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7266C113C7;
        Tue, 28 Feb 2023 21:19:25 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vcnk2Ym_1677647960;
Received: from 30.97.48.239(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vcnk2Ym_1677647960)
          by smtp.aliyun-inc.com;
          Wed, 01 Mar 2023 13:19:21 +0800
Message-ID: <565f2ceb-6e6b-8775-4446-5aefcd377e7d@linux.alibaba.com>
Date:   Wed, 1 Mar 2023 13:19:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, lsf-pc@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
References: <Y/7L74P6jSWwOvWt@mit.edu> <Y/7WJMNLjrQ+/+Vs@casper.infradead.org>
 <c6612406-11c7-2158-5186-ebee72c9b698@linux.alibaba.com>
 <Y/7cNU2TRIVl/I85@casper.infradead.org>
 <49b6d3de-e5c7-73fc-fa43-5c068426619b@linux.alibaba.com>
In-Reply-To: <49b6d3de-e5c7-73fc-fa43-5c068426619b@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2023/3/1 13:09, Gao Xiang wrote:
> 
> 
> On 2023/3/1 13:01, Matthew Wilcox wrote:
>> On Wed, Mar 01, 2023 at 12:49:10PM +0800, Gao Xiang wrote:
>>>> The only problem is that the readahead code doesn't tell the filesystem
>>>> whether the request is sync or async.  This should be a simple matter
>>>> of adding a new 'bool async' to the readahead_control and then setting
>>>> REQ_RAHEAD based on that, rather than on whether the request came in
>>>> through readahead() or read_folio() (eg see mpage_readahead()).
>>>
>>> Great!  In addition to that, just (somewhat) off topic, if we have a
>>> "bool async" now, I think it will immediately have some users (such as
>>> EROFS), since we'd like to do post-processing (such as decompression)
>>> immediately in the same context with sync readahead (due to missing
>>> pages) and leave it to another kworker for async readahead (I think
>>> it's almost same for decryption and verification).
>>>
>>> So "bool async" is quite useful on my side if it could be possible
>>> passed to fs side.  I'd like to raise my hands to have it.
>>
>> That's a really interesting use-case; thanks for bringing it up.
>>
>> Ideally, we'd have the waiting task do the
>> decompression/decryption/verification for proper accounting of CPU.
>> Unfortunately, if the folio isn't uptodate, the task doesn't even hold
>> a reference to the folio while it waits, so there's no way to wake the
>> task and let it know that it has work to do.  At least not at the moment
>> ... let me think about that a bit (and if you see a way to do it, feel
>> free to propose it)
> 
> Honestly, I'd like to take the folio lock until all post-processing is
> done and make it uptodate and unlock so that only we need is to pass
> locked-folios requests to kworkers for async way or sync handling in
> the original context.
> 
> If we unlocked these folios in advance without uptodate, which means
> we have to lock it again (which could have more lock contention) and
> need to have a way to trace I/Oed but not post-processed stuff in
> addition to no I/Oed stuff.

I'm not sure which way is better to proper accounting of CPU, but I
think individual fs could know more than mm about post-processing
handling, I think just have some accounting apis to fses for these.

currently I think core-MM just needs to export "async" bool to rac.
and EROFS now just do sync decompression for <= 4 pages in
z_erofs_readahead(), and I think it can be done better, see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/erofs/zdata.c?h=v6.2#n832

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
