Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41FB679C9B
	for <lists+linux-block@lfdr.de>; Tue, 24 Jan 2023 15:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjAXOxu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 Jan 2023 09:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbjAXOxt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2023 09:53:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA874A217
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 06:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674571978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OT9eIYQWRiQnHrGxqukMFcKx66w1c1okWx8bcxXh574=;
        b=W2JpqdELi5OQOfMbSR+ALh1gNEOGkX/RGiS6HzLY4CHJ5CJVU73MDkPN3jY+siruPGGCC1
        /PnRSmZLarm0nF3YmeMNEFppIoCvONshNhCo7QooRJGU8pzDvxPNNbhtEcO4SZtAIHJGHJ
        kQH+WCMTOR+7jRs7xetvV275iyZ+cIg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-670-WTp8VOKgOr-LtA3GEf_ujA-1; Tue, 24 Jan 2023 09:52:57 -0500
X-MC-Unique: WTp8VOKgOr-LtA3GEf_ujA-1
Received: by mail-wr1-f69.google.com with SMTP id v20-20020adfc5d4000000b002bdfcdb4c51so2642625wrg.9
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2023 06:52:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OT9eIYQWRiQnHrGxqukMFcKx66w1c1okWx8bcxXh574=;
        b=ufSe5pqusSmAplhA3nY9vlBsBzP4mhEEHLzCLmQhWN936WQmGiXsP7Q9aVzdaIbiS9
         FJnYCB1f4UNiOfT9LrpdXBsR691Kt/jhSE1FQvWqGkLWYVetqAqYeaNNQI7ngJnFX7o6
         JEwB44sY+I04Oymmxb1GZP0yhG56foL/B3KxZYdv/RcbzaBdnF4CHC+FZ2QEhuEsBHWt
         V4SyM7273jGleVDes6mBIrceIDYrasWB7O692jIS/w7/gvNXOXI1M6axbLAO5RdQx5my
         AWioS7mO9j6Yv4cbEY0f+uxKdbM6Plepw99FFan72Da/K3A1dwmHbOkcJzO/F9lotqHD
         k0BA==
X-Gm-Message-State: AFqh2kobM36OKHq7Sd0He4B11qPOvXYyhckvxnm9htf0zfkgqUMwSx8B
        GUoipP30PO53T7WJ6Y3956FzzE45rey2WneBDqAMsCmPnU+pCGb5z7mFTVMAZxhhciUYRstjrmg
        r9h5fdP4z8pcWk0yMmO3OvLs=
X-Received: by 2002:a05:600c:3582:b0:3d3:5c21:dd94 with SMTP id p2-20020a05600c358200b003d35c21dd94mr25212218wmq.9.1674571974932;
        Tue, 24 Jan 2023 06:52:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXucGPLiYCp7C7Fc6SW9cHKowNEZHdkcktvU7wxAHGZD7hCSY2e+kT11c2bVCSPI3BPgK95t0A==
X-Received: by 2002:a05:600c:3582:b0:3d3:5c21:dd94 with SMTP id p2-20020a05600c358200b003d35c21dd94mr25212195wmq.9.1674571974652;
        Tue, 24 Jan 2023 06:52:54 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id l18-20020a1c7912000000b003db00747fdesm13592874wme.15.2023.01.24.06.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 06:52:53 -0800 (PST)
Message-ID: <a428c70c-1818-a69e-a1e9-5c1a8e87be0a@redhat.com>
Date:   Tue, 24 Jan 2023 15:52:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
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
References: <5bc85aff-e21e-ab83-d47a-e7b7c1081ab0@redhat.com>
 <1b1eb3d8-c6b4-b264-1baa-1b3eb088173d@redhat.com>
 <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-3-dhowells@redhat.com>
 <874093.1674570959@warthog.procyon.org.uk>
 <874737.1674571549@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v8 02/10] iov_iter: Add a function to extract a page list
 from an iterator
In-Reply-To: <874737.1674571549@warthog.procyon.org.uk>
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

On 24.01.23 15:45, David Howells wrote:
> David Hildenbrand <david@redhat.com> wrote:
> 
>> At least reduces the occurrences of FOLL_PIN :)
> 
> I don't see where the problem is in letting people supply FOLL_PIN or
> FOLL_GET.  Why even have pin_user_pages() and get_user_pages() since they end
> up at the same place.  They should be inline wrappers, if separate functions
> at all.

There once was a proposed goal of restricting FOLL_GET to core-mm and 
allowing other drivers etc. to only use FOLL_PIN. Providing 
pin_user_pages() and the corresponding unpin part seemed very clean to me.

To me that makes perfect sense and will prevent any misuse once we 
converted everything relevant to FOLL_PIN.


To be precise, I think we could get away in this patch set by not using 
FOLL_PIN and FOLL_GET and it wouldn't really reduce readability of the 
code ...

-- 
Thanks,

David / dhildenb

