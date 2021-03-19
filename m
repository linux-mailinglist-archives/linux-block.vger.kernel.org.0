Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6013426AE
	for <lists+linux-block@lfdr.de>; Fri, 19 Mar 2021 21:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhCSUIs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 19 Mar 2021 16:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhCSUIl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 16:08:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DFFC06175F;
        Fri, 19 Mar 2021 13:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rGRzrwVTpnyRBED0N4I/y0vzVWMQ7Nn4oxmzxiU470A=; b=0j4GyJ61WeMO+Kn6dI/Vo6OXQi
        aaMv3a28fFrSfkAVJS8QvrxiqWuC2OA65TL48mBim8g7f8r22yF2QifudXLmgAPv7GBmkRSkxwNyJ
        HQezgK6UWJ1Urciv0hoLfqHrKweeN66NdurcgsFhTj0GcxYKyEXrDv1m9ZW9cSxyz7M0vcE0fvzZS
        OOkYBTCJV/9YHng3nNsHPOeBqPo0LtUGBnfeftXu+L6fQN8H2Unup978jVJM58H9IrO4qCb4W40E6
        LkqkBlkDnwxkerv/0d2P8K260pCwaN9tfdXf2aHBEJ21eRdb3eXB5S0O0fLDzXmpPOnw5XyNo9Ana
        Xe0lVWbQ==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNLQC-001VY9-I1; Fri, 19 Mar 2021 20:08:37 +0000
Date:   Fri, 19 Mar 2021 13:08:36 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Tom Saeger <tom.saeger@oracle.com>
cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] Trivial typo fix and sentence construction for better
 readability
In-Reply-To: <20210319200706.2dlq33ii33gyakyf@brm-x62-17.us.oracle.com>
Message-ID: <cbda62a9-16bc-6ea7-6070-95918b9154c7@bombadil.infradead.org>
References: <20210319195451.32456-1-unixbhaskar@gmail.com> <5ac591a4-2ed-311a-fcc2-3cc8443d71ef@bombadil.infradead.org> <20210319200706.2dlq33ii33gyakyf@brm-x62-17.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_130836_615162_F12974D4 
X-CRM114-Status: GOOD (  12.66  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Fri, 19 Mar 2021, Tom Saeger wrote: > On Fri, Mar 19, 2021
    at 01:03:02PM -0700, Randy Dunlap wrote: >> >> Hm, needs some spacing fixes
    IMO. See below. >> >> >> On Sat, 20 Mar 2021, Bhaskar Chowdhury wrote: >>
    >>> >>> s/funtion/functions [...] 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Fri, 19 Mar 2021, Tom Saeger wrote:

> On Fri, Mar 19, 2021 at 01:03:02PM -0700, Randy Dunlap wrote:
>>
>> Hm, needs some spacing fixes IMO. See below.
>>
>>
>> On Sat, 20 Mar 2021, Bhaskar Chowdhury wrote:
>>
>>>
>>> s/funtion/functions/
>>>
>>> Plus the sentence reconstructed for better readability.
>>>
>>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>>> ---
>>> Changes from V1:
>>>  Randy's suggestions incorporated.
>>>
>>> block/blk-mq-tag.c | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>>> index 9c92053e704d..c2bef283db63 100644
>>> --- a/block/blk-mq-tag.c
>>> +++ b/block/blk-mq-tag.c
>>> @@ -373,8 +373,8 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
>>> }
>>>
>>> /**
>>> - * blk_mq_tagset_wait_completed_request - wait until all completed req's
>>> - * complete funtion is run
>
> completion function
>
> That's my read of it.

Sounds good. Thanks.

Bhaskar, please use this wording.


> --Tom
>
>>> + * blk_mq_tagset_wait_completed_request - wait until all the  req's
>>
>>                                                             the req's
>>
>>> + *  functions completed their run
>>
>> and more indentation + wording on that line above:
>>  *        functions have completed their run
>>
>>>  * @tagset:	Tag set to drain completed request
>>>  *
>>>  * Note: This function has to be run after all IO queues are shutdown
>>> --
>>
>> Thanks.
>
