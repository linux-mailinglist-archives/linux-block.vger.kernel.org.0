Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9CA682676
	for <lists+linux-block@lfdr.de>; Tue, 31 Jan 2023 09:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjAaId1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 31 Jan 2023 03:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjAaIdV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 03:33:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3199D21A1B
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 00:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675153953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mXC2zcAxG9G8Isnah+UEIve545QvqxOVfqOZABcZwZc=;
        b=F0ttl8FdvWhpB9P5pKDkGj/92OFBNZU2BR45PmtXqqU0mpk0BZCrwyI5Go7e3VRK5nOwFu
        FSz/vGX/6Lqpn9l22R4qf/xYqXuC4+tWFk+irqYrefyCwFs7aTTi0bzcRMd0TOrOr33vHK
        6TrUejiHOlSjhjtmHWaLRhApo1wZqeI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-346-rOck86xNPeSWVW-2EVnUPg-1; Tue, 31 Jan 2023 03:32:31 -0500
X-MC-Unique: rOck86xNPeSWVW-2EVnUPg-1
Received: by mail-wr1-f69.google.com with SMTP id y18-20020adffa52000000b002bfbd64ae48so2319686wrr.15
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 00:32:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXC2zcAxG9G8Isnah+UEIve545QvqxOVfqOZABcZwZc=;
        b=uU4PeCcPcEiK+mL7c8TQE9c2NKAM3HEGGDSD237QSNkmnw+dYOGTTSJ+MNwtGay1xv
         8P1VgM5mRBo5NFuUVAjHBgxwNdC1sDLimoR5Z3bh0ViBpRigDU710ETgl9BbichSUv6I
         IOJMUhyVa4ZDzU2Kos/v0FbhNZJRxGjhmmXSrZgzi66iJSvGHI+KC/7wVkCgu/JH8uXz
         c5D6rI+YiLDVy0aqDxAFmvSqiEmcwVxD4AJcRUvMd82XTkVK8f9vQN0rNryj3ufEqegm
         VcwYoCcZYF6/y/uMyG6pT75B4RuScUoQd7/ws1f3hHjVPuKLxc8SL/xBpEWGJsSCZ78T
         NkDA==
X-Gm-Message-State: AO0yUKUnEbLyiQ4ShIHI05ypbTF2VdAfRHibh2D+tzNKXPejSFXkVCZK
        awwxc+xUNh2kY7qWksYYTL2CI+xfwqzwgVpXt9EifQWOZN9dMx8i8eUagnozISyUMFTD24UvHEf
        T4lQfehtnR/OquOrK7JZXYaU=
X-Received: by 2002:adf:a491:0:b0:2bf:b394:4f23 with SMTP id g17-20020adfa491000000b002bfb3944f23mr20583262wrb.51.1675153949864;
        Tue, 31 Jan 2023 00:32:29 -0800 (PST)
X-Google-Smtp-Source: AK7set+sWw0CLpzPTQgDsOCrke2BcwF/lz4GziC+6IvgWtlAZZxAVafKyoN+GsZbhWORcN9yHV3v8w==
X-Received: by 2002:adf:a491:0:b0:2bf:b394:4f23 with SMTP id g17-20020adfa491000000b002bfb3944f23mr20583248wrb.51.1675153949544;
        Tue, 31 Jan 2023 00:32:29 -0800 (PST)
Received: from ?IPV6:2003:d8:2f0a:ca00:f74f:2017:1617:3ec3? (p200300d82f0aca00f74f201716173ec3.dip0.t-ipconnect.de. [2003:d8:2f0a:ca00:f74f:2017:1617:3ec3])
        by smtp.gmail.com with ESMTPSA id a13-20020adfeecd000000b002bbedd60a9asm13865885wrp.77.2023.01.31.00.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 00:32:28 -0800 (PST)
Message-ID: <040ed7a7-3f4d-dab7-5a49-1cd9933c5445@redhat.com>
Date:   Tue, 31 Jan 2023 09:32:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jeff Layton <jlayton@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <e68c5cab-c3a6-1872-98fa-9f909f23be79@nvidia.com>
 <3351099.1675077249@warthog.procyon.org.uk>
 <fd0003a0-a133-3daf-891c-ba7deafad768@kernel.dk>
 <f57ee72f-38e9-6afa-182f-2794638eadcb@kernel.dk>
 <e8480b18-08af-d101-a721-50d213893492@kernel.dk>
 <3520518.1675116740@warthog.procyon.org.uk>
 <f392399b-a4c4-2251-e12b-e89fff351c4d@kernel.dk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [GIT PULL] iov_iter: Improve page extraction (pin or just list)
In-Reply-To: <f392399b-a4c4-2251-e12b-e89fff351c4d@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 30.01.23 23:15, Jens Axboe wrote:
> On 1/30/23 3:12 PM, David Howells wrote:
>> John Hubbard <jhubbard@nvidia.com> wrote:
>>
>>> This is something that we say when adding pin_user_pages_fast(),
>>> yes. I doubt that I can quickly find the email thread, but we
>>> measured it and weren't immediately able to come up with a way
>>> to make it faster.
>>
>> percpu counters maybe - add them up at the point of viewing?
> 
> They are percpu, see my last email. But for every 108 changes (on
> my system), they will do two atomic_long_adds(). So not very
> useful for anything but low frequency modifications.
> 

Can we just treat the whole acquired/released accounting as a debug 
mechanism to detect missing releases and do it only for debug kernels?


The pcpu counter is an s8, so we have to flush on a regular basis and 
cannot really defer it any longer ... but I'm curious if it would be of 
any help to only have a single PINNED counter that goes into both 
directions (inc/dec on pin/release), to reduce the flushing.

Of course, once we pin/release more than ~108 pages in one go or we 
switch CPUs frequently it won't be that much of a help ...

-- 
Thanks,

David / dhildenb

