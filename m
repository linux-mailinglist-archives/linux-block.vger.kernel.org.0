Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AE354BDCA
	for <lists+linux-block@lfdr.de>; Wed, 15 Jun 2022 00:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352978AbiFNWj3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 14 Jun 2022 18:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbiFNWj2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 18:39:28 -0400
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB0250E1B
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 15:39:28 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id q140so9778530pgq.6
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 15:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=hHKfj9QBc7Jx/PD9diTRFtCvatZOAoCmnIXkfYZ6O6A=;
        b=jUWtaX9sAvrULuI0WpeJevIz4thPFk4LS07/l0oD4M513mOveNoPJLWWwwgfnynbdB
         bSQEhu9ok2IoHnCFKSC0EuyDIiV7ZQ2PZBBiv/vN6wIvI8faqBn9SiuVNI89+uh5DUo9
         6AB5w68zLZTYVayorFaPtexAZu/oN88HyKbAtm9meTP2fx6xOXU2DSZ6SlCe40jgYbsz
         2MVZpFFPmvgMOsU2QZ+xllp81CFpoKwpvfzg0sfoEKXGWS5lADnAypJdNOC7QISudY9f
         9wjQCEx3UiRSI/2qfPxZDqEd7bodjHKMTfre9p1cbCpoIGH7c9wFZfvWMHzVJEBzSYx2
         JEMw==
X-Gm-Message-State: AOAM531aAVwO2WFJlBuR53n+X86rpOV3k+nzI6gMg+fV2hTG028saSgw
        EJ5sg/mlEW4FgwkygvuIP7Y=
X-Google-Smtp-Source: ABdhPJxWSbeOKO9mH5SomYOpUgq1oFAI/87EAyQgHBfkjo720NWvz6dm/mt5mEMofDNZoPHl0ESkUA==
X-Received: by 2002:a05:6a00:2349:b0:51c:29c0:82f6 with SMTP id j9-20020a056a00234900b0051c29c082f6mr6909587pfj.32.1655246367380;
        Tue, 14 Jun 2022 15:39:27 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ab60:e1ea:e2eb:c1b6? ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
        by smtp.gmail.com with ESMTPSA id e6-20020a63ae46000000b003f65560a1a7sm8327182pgp.53.2022.06.14.15.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 15:39:26 -0700 (PDT)
Message-ID: <186833db-bb36-e3c3-5670-ac8ff0b2906b@acm.org>
Date:   Tue, 14 Jun 2022 15:39:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 2/5] scsi: Retry unaligned zoned writes
To:     Khazhy Kumykov <khazhy@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220614174943.611369-1-bvanassche@acm.org>
 <20220614174943.611369-3-bvanassche@acm.org>
 <CACGdZYJ7HfykzbgiPpT7Ymd0h39qQE3qfz90QCNeoBjK04-HSw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACGdZYJ7HfykzbgiPpT7Ymd0h39qQE3qfz90QCNeoBjK04-HSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/22 14:47, Khazhy Kumykov wrote:
> On Tue, Jun 14, 2022 at 10:49 AM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>>  From ZBC-2: "The device server terminates with CHECK CONDITION status, with
>> the sense key set to ILLEGAL REQUEST, and the additional sense code set to
>> UNALIGNED WRITE COMMAND a write command, other than an entire medium write
>> same command, that specifies: a) the starting LBA in a sequential write
>> required zone set to a value that is not equal to the write pointer for that
>> sequential write required zone; or b) an ending LBA that is not equal to the
>> last logical block within a physical block (see SBC-5)."
>>
>> I am not aware of any other conditions that may trigger the UNALIGNED
>> WRITE COMMAND response.
>>
>> Retry unaligned writes in preparation of removing zone locking.
> Is /just/ retrying effective here? A series of writes to the same zone
> would all need to be sent in order - in the worst case (requests
> somehow ordered in reverse order) this becomes quadratic as only 1
> request "succeeds" out of the N outstanding requests, with the rest
> all needing to retry. (Imagine a user writes an entire "zone" - which
> could be split into hundreds of requests).
> 
> Block layer / schedulers are free to do this reordering, which I
> understand does happen whenever we need to requeue - and would result
> in a retry of all writes after the first re-ordered request. (side
> note: fwiw "requests somehow in reverse order" can happen - bfq
> inherited cfq's odd behavior of sometimes issuing sequential IO in
> reverse order due to back_seek, e.g.)

Hi Khazhy,

For zoned block devices I propose to only support those I/O schedulers 
that either preserve the LBA order or fix the LBA order if two or more 
out-of-order requests are received by the I/O scheduler.

I agree that in the worst case the number of retries is proportional to 
the square of the number of pending requests. However, for the use case 
that matters most to me, F2FS on top of a UFS device, we haven't seen 
any retries in our tests without I/O scheduler. This is probably because 
of how F2FS submits writes combined with the UFS controller only 
supporting a single hardware queue. I expect to see a small number of 
retries once UFS controllers become available that support multiple 
hardware queues.

Thanks,

Bart.
