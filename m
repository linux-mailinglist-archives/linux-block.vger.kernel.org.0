Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0627567D9D0
	for <lists+linux-block@lfdr.de>; Fri, 27 Jan 2023 00:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjAZXnT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Jan 2023 18:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjAZXnS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2023 18:43:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9039474DF
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 15:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674776473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hgp2csT/5N2GgfmM2EojwNPbWSvoxY/hrLJRyt5ZyZI=;
        b=ico2nsL1J50vZg8BOQ0Pu7Oim2rJSV445t0zkwm1jVqxicv08SBt7+Tw/4fV8V+jApXWtS
        f2sIy3XoVxwMJ9wvl/zJb8nhtD5KwghYkQzRJpoTawiu0rNjQ9RUnXZq9xCfnqlP96Z/Pa
        ACRcCpR9wpA4ecrvxXAvkQYo2IbSok8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-433-Dn8gPfD2PbaxXAoU42G5-Q-1; Thu, 26 Jan 2023 18:41:11 -0500
X-MC-Unique: Dn8gPfD2PbaxXAoU42G5-Q-1
Received: by mail-wm1-f70.google.com with SMTP id r15-20020a05600c35cf00b003d9a14517b2so3649029wmq.2
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 15:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgp2csT/5N2GgfmM2EojwNPbWSvoxY/hrLJRyt5ZyZI=;
        b=wkgo9zCxEDgK6NCOMO7VX37tCetxClzwIKhXp9k/jWIbKHftzzQtsXYjxhDdmdE3jr
         lBFbSh5tU0n73+ERZREF/sCATwCQWe5SxDZgOxLT9KNsJbV1PNGhcrA/qRgl9IEsFf5J
         a+ihke7juPxqKyVANwTlSWD3prUYuduKGEqqT//iRK3fCm5x859ogZeh50du1/+SoouX
         kK6WzytbbyzWaGeATzjSL9F26AN3VryNE8OAduqDafOdCqK4TKve8nZLmq+K3/Z7qCP+
         pMQ8Dz9ETfCkZDpWk9iGQ3aiyGNQ7EQ8bVDmExt2Hdztehp0dDa7WeNh2gEEAUUMi4/T
         GAZw==
X-Gm-Message-State: AO0yUKUL6n1Wvy6QFVFMB8/V0FZ/b1liKyoya8EsTfeZdFMteOCNLaa/
        WzqDrK/h0um3etyTn0VD8FWzGL8NlOTT7nSpYYaFIse84GDv9TPXNWKUDP8rrOeGNKVTdE0btVO
        V/TU+IKNzURkK0FC/ubDrx9k=
X-Received: by 2002:a05:600c:4691:b0:3dc:24fc:ef6f with SMTP id p17-20020a05600c469100b003dc24fcef6fmr4321092wmo.40.1674776470750;
        Thu, 26 Jan 2023 15:41:10 -0800 (PST)
X-Google-Smtp-Source: AK7set+lzFboGivn/VNW6G+eB5vRq3OTKvz6ptdlIfr3a3nxgdbjnY8Utt36TAGPBJAaiqBnRnN+hg==
X-Received: by 2002:a05:600c:4691:b0:3dc:24fc:ef6f with SMTP id p17-20020a05600c469100b003dc24fcef6fmr4321075wmo.40.1674776470367;
        Thu, 26 Jan 2023 15:41:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:5e00:9e97:86d:5ed5:bb95? (p200300cbc7075e009e97086d5ed5bb95.dip0.t-ipconnect.de. [2003:cb:c707:5e00:9e97:86d:5ed5:bb95])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c429500b003dc1a525f22sm2429845wmc.25.2023.01.26.15.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 15:41:09 -0800 (PST)
Message-ID: <5a1796f3-e49c-80e8-2dd6-9a6e82939271@redhat.com>
Date:   Fri, 27 Jan 2023 00:41:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v7 2/8] iov_iter: Add a function to extract a page list
 from an iterator
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
References: <7bbcccc9-6ebf-ffab-7425-2a12f217ba15@redhat.com>
 <246ba813-698b-8696-7f4d-400034a3380b@redhat.com>
 <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-3-dhowells@redhat.com>
 <3814749.1674474663@warthog.procyon.org.uk>
 <3903251.1674479992@warthog.procyon.org.uk>
 <c742e47b-dcc0-1fef-dc8c-3bf85d26b046@redhat.com> <Y9L7cRFFZh9A7kZY@ZenIV>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y9L7cRFFZh9A7kZY@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26.01.23 23:15, Al Viro wrote:
> On Mon, Jan 23, 2023 at 02:24:13PM +0100, David Hildenbrand wrote:
>> On 23.01.23 14:19, David Howells wrote:
>>> David Hildenbrand <david@redhat.com> wrote:
>>>
>>>> Switching from FOLL_GET to FOLL_PIN was in the works by John H. Not sure what
>>>> the status is. Interestingly, Documentation/core-api/pin_user_pages.rst
>>>> already documents that "CASE 1: Direct IO (DIO)" uses FOLL_PIN ... which does,
>>>> unfortunately, no reflect reality yet.
>>>
>>> Yeah - I just came across that.
>>>
>>> Should iov_iter.c then switch entirely to using pin_user_pages(), rather than
>>> get_user_pages()?  In which case my patches only need keep track of
>>> pinned/not-pinned and never "got".
>>
>> That would be the ideal case: whenever intending to access page content, use
>> FOLL_PIN instead of FOLL_GET.
>>
>> The issue that John was trying to sort out was that there are plenty of
>> callsites that do a simple put_page() instead of calling unpin_user_page().
>> IIRC, handling that correctly in existing code -- what was pinned must be
>> released via unpin_user_page() -- was the biggest workitem.
>>
>> Not sure how that relates to your work here (that's why I was asking): if
>> you could avoid FOLL_GET, that would be great :)
> 
> Take a good look at iter_to_pipe().  It does *not* need to pin anything
> (we have an ITER_SOURCE there); with this approach it will.  And it
> will stuff those pinned references into a pipe, where they can sit
> indefinitely.
> 
> IOW, I don't believe it's a usable approach.
> 

Not sure what makes you believe that FOLL_GET is any better for this 
long-term pinning, I'd like to learn about that.

As raised already somewhere in the whole discussion by me, the right way 
to take such a long-term ping as vmsplice() does is to use 
FOLL_PIN|FOLL_LONGTERM. As also raised, that will fix the last remaining 
vmsplice()+hugetlb COW issue as tested by the cow.c vm selftest and make 
sure to migrate that memory off of MIGRATE_MOVABLE/CMA memory where we 
cannot tolerate to have long-term unmovable memory sitting around.

-- 
Thanks,

David / dhildenb

