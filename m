Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C70D3E263D
	for <lists+linux-block@lfdr.de>; Fri,  6 Aug 2021 10:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbhHFIiV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 6 Aug 2021 04:38:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54278 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbhHFIiV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Aug 2021 04:38:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1C7CD21BD4;
        Fri,  6 Aug 2021 08:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628239085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MZBqNnNscfHiOGe+k+ov3sat4e7XsHhtjE9C+58y2uc=;
        b=A3hycox/Fm/0aNPL6yk1NYiLoqZxIjc9SkSOOSbAy9TCdCh6Ns4lUMN3IqknGBxy0cnAR3
        ueBCYYiHx1j4Xr6sxJns1hUEkFL8d4JuVejFWbIJZ952doVHW6WoMb4VX+ojNf0M8/jbA/
        Zy2BgBlT6YmnyX+kw/7/NpZR9OLs7zw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628239085;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MZBqNnNscfHiOGe+k+ov3sat4e7XsHhtjE9C+58y2uc=;
        b=aNOCG0J7PpmgPwbQc/65LlLCJj2f93M6tu/nosPkuvOzylpDGIGLjNbX4E2bfIgNcv36ME
        9mupo7VMREFy4xAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01AE313A6A;
        Fri,  6 Aug 2021 08:38:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id d0UqOuz0DGEkYwAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 06 Aug 2021 08:38:04 +0000
Subject: Re: [PATCH v2 2/4] block: fix ioprio interface
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
References: <20210806051140.301127-1-damien.lemoal@wdc.com>
 <20210806051140.301127-3-damien.lemoal@wdc.com>
 <6fdc9b02-d03f-a63f-cefb-1d00ac42b885@suse.de>
 <DM6PR04MB70818B00518B40E671481E76E7F39@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <5b2642eb-2817-3814-3469-71027d6b629d@suse.de>
Date:   Fri, 6 Aug 2021 10:38:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB70818B00518B40E671481E76E7F39@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/6/21 8:57 AM, Damien Le Moal wrote:
> On 2021/08/06 15:35, Hannes Reinecke wrote:
>> On 8/6/21 7:11 AM, Damien Le Moal wrote:
>>> An iocb aio_reqprio field is 16-bits (u16) but often handled as an int
>>> in the block layer. E.g. ioprio_check_cap() takes an int as argument.
>>> With such implicit int casting function calls, the upper 16-bits of the
>>> int argument may be left uninitialized by the compiler, resulting in
>>> invalid values for the IOPRIO_PRIO_CLASS() macro (garbage upper bits)
>>> and in an error return for functions such as ioprio_check_cap().
>>>
>>> Fix this by masking the result of the shift by IOPRIO_CLASS_SHIFT bits
>>> in the IOPRIO_PRIO_CLASS() macro. The new macro IOPRIO_CLASS_MASK
>>> defines the 3-bits mask for the priority class.
>>>
>>> While at it, cleanup the following:
>>> * Apply the mask IOPRIO_PRIO_MASK to the data argument of the
>>>    IOPRIO_PRIO_VALUE() macro to ignore upper bits of the data value.
>>> * Remove unnecessary parenthesis around fixed values in the macro
>>>    definitions in include/uapi/linux/ioprio.h.
>>> * Update the outdated mention of CFQ in the comment describing priority
>>>    classes and instead mention BFQ and mq-deadline.
>>> * Change the argument name of the IOPRIO_PRIO_CLASS() and
>>>    IOPRIO_PRIO_DATA() macros from "mask" to "ioprio" to reflect the fact
>>>    that an IO priority value should be passed rather than a mask.
>>> * Change the ioprio_valid() macro into an inline function, adding a
>>>    check on the maximum value of the class of a priority value as
>>>    defined by the IOPRIO_CLASS_MAX enum value. Move this function to
>>>    the kernel side in include/linux/ioprio.h.
>>> * Remove the unnecessary "else" after the return statements in
>>>    task_nice_ioclass().
>>>
>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
>>> ---
>>>   include/linux/ioprio.h      | 15 ++++++++++++---
>>>   include/uapi/linux/ioprio.h | 19 +++++++++++--------
>>>   2 files changed, 23 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
>>> index ef9ad4fb245f..9b3a6d8172b4 100644
>>> --- a/include/linux/ioprio.h
>>> +++ b/include/linux/ioprio.h
>>> @@ -8,6 +8,16 @@
>>>   
>>>   #include <uapi/linux/ioprio.h>
>>>   
>>> +/*
>>> + * Check that a priority value has a valid class.
>>> + */
>>> +static inline bool ioprio_valid(unsigned short ioprio)
>>
>> Wouldn't it be better to use 'u16' here as type, as we're relying on the 
>> number of bits?
> 
> Other functions in block/ioprio.c and in include/linux/ioprio.h use "unsigned
> short", so I followed. But many functions, if not most, use "int". This is all a
> bit of a mess. I think we need a "typedef ioprio_t u16;" to clean things up. But
> there are a lot of places to fix. I can add such patch... Worth it ?
> 
Possibly not.
Consider my comment retracted :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
