Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D934D6BD080
	for <lists+linux-block@lfdr.de>; Thu, 16 Mar 2023 14:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjCPNO7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 Mar 2023 09:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCPNO6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Mar 2023 09:14:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C42D136
        for <linux-block@vger.kernel.org>; Thu, 16 Mar 2023 06:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678972456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cij1DgoI5i6Ff0Me0upgsjOT5aDaEMgTlpSwTjH71C4=;
        b=dBjZAXIqiLkW9HrMIdIHRq6ZEwadd4YqX5tBlIdDS/t6/Gv9ahqKH1TdTiwkNDrRiwyx/G
        4HbBXIWQ7pP8gOaem2fL0E8ut/ukfB6f3tEbP9KTk8DM20f5KQ6JrjBzvAPe5d97btUfUM
        T9o1RDn4UcvmJmkgYVMDrj7J4C9qfLQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-6Lx8C2OcPXygESZP40ZHAQ-1; Thu, 16 Mar 2023 09:14:15 -0400
X-MC-Unique: 6Lx8C2OcPXygESZP40ZHAQ-1
Received: by mail-wm1-f69.google.com with SMTP id k18-20020a05600c1c9200b003ed2a3f101fso2602074wms.9
        for <linux-block@vger.kernel.org>; Thu, 16 Mar 2023 06:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678972454;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cij1DgoI5i6Ff0Me0upgsjOT5aDaEMgTlpSwTjH71C4=;
        b=WhYEsvlcWTr5gzaK3i3/x/RmvFFw+yLjwd4PFXw/f5sBpbk63bnuvXcs+belrPJ9rG
         6COX95oCZ9UIx41SH3JPYrgXGNqKHvoyuqxFz1J4MLfZhfH80mqXXj85we1zDlwtzQ1K
         IEgiJ/1PO47KX+J+SPh9fVV7l64nZnWzY5tN0tgYTukQok5x41gEhbN4GPE7ZQcHXl7w
         c+nExmazGJNPrrjCZ5CG4JlN779ndvuzP5+eUTDzxS+8V8Ze5egpNpRKoYlz7XLAUUEw
         p8gBMqsV8OqYMfp35RcmS1PKDcf+KisOnS/zT6zH+G3Q43l25Q7apRlgnM2K96BryDjH
         bYAQ==
X-Gm-Message-State: AO0yUKXCVmQtBmyG3pKHcoXs5j88sxBuDv67iBlIzb3bbmaYwmpV+ocU
        8oBfD1BrxZNIheDeiTA49ps/Yb00i6Ou7UEWR0rcXcJjFwNEBYUrQX+/A1pdMLGSfA66O5qpWIC
        lRHe6aqep8u1Yb/94/vRJKUc=
X-Received: by 2002:a7b:c394:0:b0:3ed:6693:1388 with SMTP id s20-20020a7bc394000000b003ed66931388mr1025915wmj.18.1678972453933;
        Thu, 16 Mar 2023 06:14:13 -0700 (PDT)
X-Google-Smtp-Source: AK7set8ZjMO0Y6+7kxovZnLoqzSDbEfVY0ZYumsiTW725vRLK5qi93k9OiMeyFdN6OokIatcXWlIng==
X-Received: by 2002:a7b:c394:0:b0:3ed:6693:1388 with SMTP id s20-20020a7bc394000000b003ed66931388mr1025892wmj.18.1678972453636;
        Thu, 16 Mar 2023 06:14:13 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id k18-20020a056000005200b002c71dd1109fsm7318197wrx.47.2023.03.16.06.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 06:14:13 -0700 (PDT)
Message-ID: <f312327e-c11e-60f4-1367-af4e480b2609@redhat.com>
Date:   Thu, 16 Mar 2023 14:14:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v19 04/15] overlayfs: Implement splice-read
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
References: <20230315163549.295454-1-dhowells@redhat.com>
 <20230315163549.295454-5-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230315163549.295454-5-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 15.03.23 17:35, David Howells wrote:
> Implement splice-read for overlayfs by passing the request down a layer
> rather than going through generic_file_splice_read() which is going to be
> changed to assume that ->read_folio() is present on buffered files.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: John Hubbard <jhubbard@nvidia.com>
> cc: David Hildenbrand <david@redhat.com>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Miklos Szeredi <miklos@szeredi.hu>
> cc: linux-unionfs@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

