Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313B9536A34
	for <lists+linux-block@lfdr.de>; Sat, 28 May 2022 04:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352550AbiE1CUc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 27 May 2022 22:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352780AbiE1CUb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 May 2022 22:20:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B41EC312;
        Fri, 27 May 2022 19:20:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D74BF21A2E;
        Sat, 28 May 2022 02:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653704426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HqDnviQXPm8yTFMB43HF+MiPh0OFlMaqg8aFqbhkp1Y=;
        b=AtWGp4Lkzhc6zxENgagbrdHwcGRVoLlrs0ckeyUoKJZrJIMgVEVFaYEZAopfloeksQ2hNA
        EIgkpTq4u64s1F1Be7/TeSmdqb2BNjqJkQ51X/DqAt4xMeQn56YZZK7n2sR8wFta3y74LV
        hYORb5x1Ijbz1LVSvkHEVjL+MwjbXNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653704426;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HqDnviQXPm8yTFMB43HF+MiPh0OFlMaqg8aFqbhkp1Y=;
        b=xeWfdqsM6OJIuF4cAlP4QLVa6kzr975UuQl95rZiWquY6wgbwN5vEOxFO6TkEfVzc2zaDU
        aLw8ik4hDWbN+iDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE78313941;
        Sat, 28 May 2022 02:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XaQuMuqGkWJxbgAAMHmgww
        (envelope-from <colyli@suse.de>); Sat, 28 May 2022 02:20:26 +0000
MIME-Version: 1.0
Date:   Sat, 28 May 2022 10:20:26 +0800
From:   colyli <colyli@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] bcache: avoid unnecessary soft lockup in kworker
 update_writeback_rate()
In-Reply-To: <1a3a151e-a8f9-7f53-f9fc-e7eaea42a462@kernel.dk>
References: <20220527152818.27545-1-colyli@suse.de>
 <20220527152818.27545-3-colyli@suse.de>
 <ebf7c9e4-89cb-59e4-8304-d7f8a28966f3@kernel.dk>
 <8251ee2fab43b59ecd5a6140655eeb47@suse.de>
 <1a3a151e-a8f9-7f53-f9fc-e7eaea42a462@kernel.dk>
User-Agent: Roundcube Webmail
Message-ID: <49c0852df72f978241fd14a029c91ea9@suse.de>
X-Sender: colyli@suse.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

在 2022-05-28 08:00，Jens Axboe 写道：
> On 5/27/22 11:05 AM, colyli wrote:
>> ? 2022-05-27 23:49?Jens Axboe ???
>>> On 5/27/22 9:28 AM, Coly Li wrote:
>>>> diff --git a/drivers/md/bcache/writeback.c 
>>>> b/drivers/md/bcache/writeback.c
>>>> index d138a2d73240..c51671abe74e 100644
>>>> --- a/drivers/md/bcache/writeback.c
>>>> +++ b/drivers/md/bcache/writeback.c
>>>> @@ -214,6 +214,7 @@ static void update_writeback_rate(struct 
>>>> work_struct *work)
>>>>                           struct cached_dev,
>>>>                           writeback_rate_update);
>>>>      struct cache_set *c = dc->disk.c;
>>>> +    bool contention = false;
>>>> 
>>>>      /*
>>>>       * should check BCACHE_DEV_RATE_DW_RUNNING before calling
>>>> @@ -243,13 +244,41 @@ static void update_writeback_rate(struct 
>>>> work_struct *work)
>>>>           * in maximum writeback rate number(s).
>>>>           */
>>>>          if (!set_at_max_writeback_rate(c, dc)) {
>>>> -            down_read(&dc->writeback_lock);
>>>> -            __update_writeback_rate(dc);
>>>> -            update_gc_after_writeback(c);
>>>> -            up_read(&dc->writeback_lock);
>>>> +            /*
>>>> +             * When contention happens on dc->writeback_lock with
>>>> +             * the writeback thread, this kwork may be blocked for
>>>> +             * very long time if there are too many dirty data to
>>>> +             * writeback, and kerne message will complain a (bogus)
>>>> +             * software lockup kernel message. To avoid potential
>>>> +             * starving, if down_read_trylock() fails, writeback
>>>> +             * rate updating will be skipped for dc->retry_max 
>>>> times
>>>> +             * at most while delay this worker a bit longer time.
>>>> +             * If dc->retry_max times are tried and the trylock
>>>> +             * still fails, then call down_read() to wait for
>>>> +             * dc->writeback_lock.
>>>> +             */
>>>> +            if (!down_read_trylock((&dc->writeback_lock))) {
>>>> +                contention = true;
>>>> +                dc->retry_nr++;
>>>> +                if (dc->retry_nr > dc->retry_max)
>>>> +                    down_read(&dc->writeback_lock);
>>>> +            }
>>>> +
>>>> +            if (!contention || dc->retry_nr > dc->retry_max) {
>>>> +                __update_writeback_rate(dc);
>>>> +                update_gc_after_writeback(c);
>>>> +                up_read(&dc->writeback_lock);
>>>> +                dc->retry_nr = 0;
>>>> +            }
>>>>          }
>>>>      }
>>> 
>> 
>> Hi Jens,
>> 
>> Thanks for looking into this :-)
>> 
>>> This is really not very pretty. First of all, why bother with storing 
>>> a
>>> max retry value in there? Doesn't seem like it'd ever be different 
>>> per
>> 
>> It is because the probability of the lock contention on
>> dc->writeback_lock depends on the I/O speed backing device. From my
>> observation during the tests, for fast backing device with larger
>> cache device, its writeback thread may work harder to flush more dirty
>> data to backing device, the lock contention happens more and longer,
>> so the writeback rate update kworker has to wait longer time before
>> acquires dc->writeback_lock. So its dc->retry_max should be larger
>> then slow backing device.
>> 
>> Therefore I'd like to have a tunable per-backing-device retry_max. And
>> the syses interface will be added when users/customers want it. The
>> use case is from SAP HANA users, I have report that they observe the
>> soft lockup warning for dc->writeback_lock contention and worry about
>> whether data is corrupted (indeed, of course not).
> 
> The initial patch has 5 as the default, and there are no sysfs knobs. 
> If
> you ever need a sysfs knob, by all means make it a variable and make it
> configurable too. But don't do it upfront where the '5' suitabled named
> would do the job.
> 

Copied.

>>> diff --git a/drivers/md/bcache/writeback.c 
>>> b/drivers/md/bcache/writeback.c
>>> index 9ee0005874cd..cbc01372c7a1 100644
>>> --- a/drivers/md/bcache/writeback.c
>>> +++ b/drivers/md/bcache/writeback.c
>>> @@ -235,19 +235,27 @@ static void update_writeback_rate(struct
>>> work_struct *work)
>>>          return;
>>>      }
>>> 
>>> -    if (atomic_read(&dc->has_dirty) && dc->writeback_percent) {
>>> +    if (atomic_read(&dc->has_dirty) && dc->writeback_percent &&
>>> +        !set_at_max_writeback_rate(c, dc)) {
>>>          /*
>>>           * If the whole cache set is idle, 
>>> set_at_max_writeback_rate()
>>>           * will set writeback rate to a max number. Then it is
>>>           * unncessary to update writeback rate for an idle cache set
>>>           * in maximum writeback rate number(s).
>>>           */
>>> -        if (!set_at_max_writeback_rate(c, dc)) {
>> 
>> The reason I didn't place '!set_at_max_writeback_rate' with other 
>> items in
>> previous if() was for the above code comment. If I moved it to 
>> previous
>> if() without other items, I was not comfortable to place the code 
>> comments
>> neither before or after the if() check. So I used a separated if() 
>> check for
>> '!set_at_max_writeback_rate'.
>> 
>> From your change, it seems placing the code comments behind is fine 
>> (or
>> better), can I understand in this way? I try to learn and follow your 
>> way
>> to handle such code comments situation.
> 
> Just put it higher up if you want, it doesn't really matter, or leave 
> it
> where it is.
> 

Copied.

>>>              __update_writeback_rate(dc);
>>>              update_gc_after_writeback(c);
>>>              up_read(&dc->writeback_lock);
>>> -        }
>>> +        } while (0);
>> 
>> Aha, this is cool! I never though of using do{}while(0) and break in
>> such a genius way! Sure I will use this, thanks for the hint :-)
>> 
>> After you reply my defense of dc->retry_max, and the question of code
>> comments location, I will update and test the patch again, and
>> re-sbumit to you.
>> 
>> Thanks for your constructive suggestion, especially the do{}while(0)
>> part!
> 
> I would do something similar to my change and drop the 'dc' addition 
> for
> the max retries as it, by definition, can only be one value right now.
> For all I know, you'll never need to change it again, and then you're
> just wasting memory and making the code harder to read by putting it in
> dc instead of just having this define.

Copied. I will do the change and repost it again. Thank you for the 
review and comments.

Coly Li
