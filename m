Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D18677C2A
	for <lists+linux-block@lfdr.de>; Mon, 23 Jan 2023 14:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjAWNMs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 23 Jan 2023 08:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjAWNMr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2023 08:12:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEFD24132
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2023 05:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674479517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FQv8e3zi0tb0sZVAWv+R67RLgpAS0mltaNdAlpxPgD4=;
        b=OJNrUTM7vLosCPcR+AvoVInAO9JApPOt63Dnt0YQ2K+K7GDvBSLSkeY9E9+ALccEBt6lsY
        oHkUFCNe7lGwClwvarhVkVPp9aSTSU+bvqKx//mqksAOVhkKK4/IJDxAUNqaEfA9J8u0xy
        57ZIVctUk4K/lgRKdPHOxcttcnVU6YQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-115-qFiBPyqcNAeXN4Y8oLNP3Q-1; Mon, 23 Jan 2023 08:11:56 -0500
X-MC-Unique: qFiBPyqcNAeXN4Y8oLNP3Q-1
Received: by mail-wm1-f70.google.com with SMTP id l23-20020a7bc457000000b003db0cb8e543so2844395wmi.3
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2023 05:11:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQv8e3zi0tb0sZVAWv+R67RLgpAS0mltaNdAlpxPgD4=;
        b=OoNyChhtPZ1kmt9L1R/8RxrEgaIQeyHsVAQiGt3ocAfBSBN6KndG338dMi+hPSIJ8R
         KZyq7r1JWrNTnoIf7oSU234aEMWlrz1F1Tc8lBYh0ZTbdoQXMA370tLaHs5zXhconnCp
         yrJy6Dpyiwpa53o2P+Z8Zo8FANoymoODqzoWxBlGXHyyz7eouSjhf7v/XA2j2gJ4s1BL
         8HJ9hd73jVTUm4KacEW8UCjdAy008UQnS0OM6KKFbYhMyEBIQ8AP/ab6lQOmOjdHxtt3
         bOJX0YQvFWcg5Y9Sle2fBhnRWKlqhYH1tuVmTgvK/b5Jz8/TA7BtqUS1OheDIM6s5l74
         OQyw==
X-Gm-Message-State: AFqh2kr/ai1JPxKt7j0LM2QNvFUrrCvRvl911Zps7AcuuBEVHkvEQVBn
        Qmexc2zo0RVr/icMrmZLcn8/w1cz3MRdjs4b2H2qxoUW2shpqitstfeAB2a9PMKoHPt38RJpPoR
        26PGALeBFUyD22mwZHwumV5I=
X-Received: by 2002:a05:600c:4d08:b0:3da:fef0:226b with SMTP id u8-20020a05600c4d0800b003dafef0226bmr23798174wmp.32.1674479515646;
        Mon, 23 Jan 2023 05:11:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsRmwBRBfSgTGOZ07Dfbcl+YnLqnHekKSXbUAgHGKp4HT9xIK23+Golki9zb+CdiaKU8XQ7wg==
X-Received: by 2002:a05:600c:4d08:b0:3da:fef0:226b with SMTP id u8-20020a05600c4d0800b003dafef0226bmr23798149wmp.32.1674479515328;
        Mon, 23 Jan 2023 05:11:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:1100:65a0:c03a:142a:f914? (p200300cbc704110065a0c03a142af914.dip0.t-ipconnect.de. [2003:cb:c704:1100:65a0:c03a:142a:f914])
        by smtp.gmail.com with ESMTPSA id c40-20020a05600c4a2800b003db16770bc5sm10278946wmp.6.2023.01.23.05.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 05:11:54 -0800 (PST)
Message-ID: <7bbcccc9-6ebf-ffab-7425-2a12f217ba15@redhat.com>
Date:   Mon, 23 Jan 2023 14:11:45 +0100
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
References: <246ba813-698b-8696-7f4d-400034a3380b@redhat.com>
 <20230120175556.3556978-1-dhowells@redhat.com>
 <20230120175556.3556978-3-dhowells@redhat.com>
 <3814749.1674474663@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v7 2/8] iov_iter: Add a function to extract a page list
 from an iterator
In-Reply-To: <3814749.1674474663@warthog.procyon.org.uk>
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

On 23.01.23 12:51, David Howells wrote:
> David Hildenbrand <david@redhat.com> wrote:
> 
>> How does this work align with the goal of no longer using FOLL_GET for
>> O_DIRECT? We should get rid of any FOLL_GET usage for accessing page content.
> 
> Would that run the risk of changes being made by the child being visible to
> the a DIO write if the parent changes the buffer first?
> 
> 
> 	PARENT			CHILD
> 	======			=====
> 	start-DIO-write
> 	fork() = pid		fork() = 0
> 	alter-buffer
> 	CoW happens
> 	page copied		original page retained
> 				alter-buffer
> 		<DMA-happens>

FOLL_PIN users are fine in that regard, because we properly detect 
"maybe pinned" during fork() and copy the page. See 
tools/testing/selftests/mm/cow.c (still called 
tools/testing/selftests/vm/cow.c upstream IIRC) for some test cases for 
that handling.

FOLL_GET does not work as expected in that regard: pages can't be 
detected as pinned and we won't be copying them during fork(). We'll end 
up COW-sharing them, which can result in trouble later.

Switching from FOLL_GET to FOLL_PIN was in the works by John H. Not sure 
what the status is. Interestingly, 
Documentation/core-api/pin_user_pages.rst already documents that "CASE 
1: Direct IO (DIO)" uses FOLL_PIN ... which does, unfortunately, no 
reflect reality yet.

-- 
Thanks,

David / dhildenb

