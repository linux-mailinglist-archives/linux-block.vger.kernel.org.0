Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B8A677DD2
	for <lists+linux-block@lfdr.de>; Mon, 23 Jan 2023 15:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjAWOVb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 23 Jan 2023 09:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjAWOVb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2023 09:21:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF68C2004D
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2023 06:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674483647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Qw6OoQIblD+SHFIDSF3ygbKeoxmTzUe8MMuhcikIz8=;
        b=CwcgjHdtBxbVthQJ9Okm8lNn7jgQDWxxZHhSXXCkPZSDRjQOAaXjFcsmbhZwZK01XSaTGG
        ow7VZ0bkK6qOEK6ndTObV8t/OeCi/HXOeEJ4Chfx6ifyITvPl7EjnCd8m4TwWcsSidc0sW
        l5enL2J1rNAqQfEoSTzdP0KfcxygkLo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-80-0bHuQZXEP9W93Hu7VHUx5w-1; Mon, 23 Jan 2023 09:20:46 -0500
X-MC-Unique: 0bHuQZXEP9W93Hu7VHUx5w-1
Received: by mail-wm1-f71.google.com with SMTP id l23-20020a7bc457000000b003db0cb8e543so2925036wmi.3
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2023 06:20:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Qw6OoQIblD+SHFIDSF3ygbKeoxmTzUe8MMuhcikIz8=;
        b=XDlAjc6fKn3OsLnhbBRo+fCJ7eOeHAv2BDm4XE6YdI5wqLt7/EA5FdRRKJcKKE7G4L
         RaptICmY9bdygI3haqtfT2bosGIb0yMSWDjTq78UTK23uaM9Yc2nd3SALGa9AHY2Xbsp
         EsHVH8f1rAYB1iMwfKTCSLSTItc0oK4NE1cZikzNUCVU9uJA5pE9hcai6NDg5vQpituf
         rvfBjTwuwKJvTduQbEDHRNbILpFSEB1S1kpzUV2nrv2VjfXXNJuzz2y/OJR7MoOKZBEh
         XPTopOQ0olVFnGQO/Sj8Wkujo8umf808rYqV41E8uG34DpCFEMP2wj9Jt1IGnWT/HsIn
         jW+Q==
X-Gm-Message-State: AFqh2krDxFB1QPJ3vfePuUbmQfoH5jEHGaJS67biVMh81xrciIW8ur4T
        4oeUiYH9amJwJ7HmyRRsA5xa2bgz0gQtPgphZybz7sihqzSNj8fL1H1/LQNbpyZyfcS/OfBP4dM
        EGzG192FbqY7uHgBoVBZkrAw=
X-Received: by 2002:a05:600c:3083:b0:3da:e4d:e6ba with SMTP id g3-20020a05600c308300b003da0e4de6bamr23672669wmn.14.1674483643852;
        Mon, 23 Jan 2023 06:20:43 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtA0SmMxGfIXBjxWwrkcsAPkrTFymy9qeDOZWk2TkY+Bo+QqROnDkmX5yaFF9e6G40kzNARmg==
X-Received: by 2002:a05:600c:3083:b0:3da:e4d:e6ba with SMTP id g3-20020a05600c308300b003da0e4de6bamr23672641wmn.14.1674483643563;
        Mon, 23 Jan 2023 06:20:43 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:1100:65a0:c03a:142a:f914? (p200300cbc704110065a0c03a142af914.dip0.t-ipconnect.de. [2003:cb:c704:1100:65a0:c03a:142a:f914])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c26d500b003d9b87296a9sm10216753wmv.25.2023.01.23.06.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 06:20:43 -0800 (PST)
Message-ID: <77f3fc56-05d8-def0-e518-0906c729e7df@redhat.com>
Date:   Mon, 23 Jan 2023 15:20:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v7 2/8] iov_iter: Add a function to extract a page list
 from an iterator
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org
References: <c742e47b-dcc0-1fef-dc8c-3bf85d26b046@redhat.com>
 <7bbcccc9-6ebf-ffab-7425-2a12f217ba15@redhat.com>
 <246ba813-698b-8696-7f4d-400034a3380b@redhat.com>
 <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-3-dhowells@redhat.com>
 <3814749.1674474663@warthog.procyon.org.uk>
 <3903251.1674479992@warthog.procyon.org.uk>
 <3911637.1674481111@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3911637.1674481111@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 23.01.23 14:38, David Howells wrote:
> David Hildenbrand <david@redhat.com> wrote:
> 
>> That would be the ideal case: whenever intending to access page content, use
>> FOLL_PIN instead of FOLL_GET.
>>
>> The issue that John was trying to sort out was that there are plenty of
>> callsites that do a simple put_page() instead of calling
>> unpin_user_page(). IIRC, handling that correctly in existing code -- what was
>> pinned must be released via unpin_user_page() -- was the biggest workitem.
>>
>> Not sure how that relates to your work here (that's why I was asking): if you
>> could avoid FOLL_GET, that would be great :)
> 
> Well, it simplifies things a bit.
> 
> I can make the new iov_iter_extract_pages() just do "pin" or "don't pin" and
> do no ref-getting at all.  Things can be converted over to "unpin the pages or
> doing nothing" as they're converted over to using iov_iter_extract_pages()
> from iov_iter_get_pages*().
> 
> The block bio code then only needs a single bit of state: pinned or not
> pinned.

Unfortunately, I'll have to let BIO experts comment on that :) I only 
know the MM side of things here.

> 
> For cifs RDMA, do I need to make it pass in FOLL_LONGTERM?  And does that need
> a special cleanup?

Anything that holds pins "possibly forever" should that. vmsplice() is 
another example that should use it, once properly using FOLL_PIN. 
[FOLL_GET | FOLL_LONGTERM is not really used/defined with semantics]

> 
> sk_buff fragment handling could still be tricky.  I'm thinking that in that
> code I'll need to store FOLL_GET/PIN in the bottom two bits of the frag page
> pointer.  Sometimes it allocates a new page and attaches it (have ref);
> sometimes it does zerocopy to/from a page (have pin) and sometimes it may be
> pointing to a kernel buffer (don't pin or ref).
> 
> David
> 

-- 
Thanks,

David / dhildenb

