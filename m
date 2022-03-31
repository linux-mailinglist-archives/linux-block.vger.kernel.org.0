Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8297D4EE34B
	for <lists+linux-block@lfdr.de>; Thu, 31 Mar 2022 23:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241840AbiCaVYH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 31 Mar 2022 17:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237321AbiCaVYG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Mar 2022 17:24:06 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAA423D748
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 14:22:18 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id o8so765331pgf.9
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 14:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=x3SePf6cYyzJ/sV6xHzMCnP/4ErKQDoUNlfoUc3FU/o=;
        b=pbUrFWcZ2skLn6FAZKUppr3B/0KcKYvs7TVqCpR/V/wpljp0wGqVFJrj7vRAyJlZaG
         N0rqPpfA6Eyg0swWL6TZQ2Ao2/Gs7zjCBpYKtGgeftbX9wZo5RutaAIdeBlBMTpypBzx
         TGel8IyxgFZbX40O+FfItMq6FYmWpwXK95ZvQAB+ZeW7GfasepxJTsDFJwiOIPDzRraq
         2L0hLd+MVFTJd98uB0m2smroBZU8rq8LJ+t/lj+n8QZvP6ZooUOk2UUyhrV3IJrm+6tP
         Zl+ZU+WwG6a53qFjsvhKcgbDV5Sb6n1XbUYHqQhzrdurBPG4yfswzxy4qsxPu50Vppzu
         xLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x3SePf6cYyzJ/sV6xHzMCnP/4ErKQDoUNlfoUc3FU/o=;
        b=GnQ15zoMDEVV68PxchHEYGEh6HNdlDEng4d0xmnUDh6EoOtnnYbzVzUnVp3JIDUBOE
         ne9PQO2DpKfnxR+Bi3IPorca780B/54PuPCWoLQ+kI1nTb6QK2PzmwafTs6KUPUsJ/5Q
         BrrRK5WqEJTK5Nto8MgA6j43HFd4lVjQSAQVE8ttJR+WpbDfFt4szC7uiCmE2OvSTKRH
         zQk8BE3yG+wNKIND9S999OcYoNnkrglHZz+w7Ssmcurd3Gaq5nk2NGAQOrBJhlxsP20z
         5k8aSuMgS6UOl4uZl2DD3gDCuStd2hRRizFDUntOBXOsZ6cMCeGvJFVjHRAzFuWq0SsS
         vGLQ==
X-Gm-Message-State: AOAM533Modwh1BVU4Nf6YhBLdcstMGkyul3hlUIGIH7EB366xX+NvfMj
        e1zjbvP7ncY4SvHnfmDUrsR8gQ==
X-Google-Smtp-Source: ABdhPJwYnU9r41ORdf19G02EFb5yhsyLJV8xzLTtxC7Sx8NiXMpF/1DkwJ2vuON7bztWgA+FZZylpQ==
X-Received: by 2002:a05:6a00:328f:b0:4fa:95b5:e1ff with SMTP id ck15-20020a056a00328f00b004fa95b5e1ffmr7412958pfb.60.1648761737704;
        Thu, 31 Mar 2022 14:22:17 -0700 (PDT)
Received: from ?IPV6:2600:380:772e:9a93:98d9:fd90:ab06:5943? ([2600:380:772e:9a93:98d9:fd90:ab06:5943])
        by smtp.gmail.com with ESMTPSA id j7-20020a056a00130700b004b9f7cd94a4sm410220pfu.56.2022.03.31.14.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 14:22:17 -0700 (PDT)
Message-ID: <1eb268c5-3420-0263-3f0c-7d3982f8f512@kernel.dk>
Date:   Thu, 31 Mar 2022 15:22:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/5] block: turn bio_kmalloc into a simple kmalloc wrapper
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, target-devel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20220308061551.737853-1-hch@lst.de>
 <20220308061551.737853-5-hch@lst.de>
 <CGME20220331211804eucas1p28da21f2dfd57aa490abffb8f87417f42@eucas1p2.samsung.com>
 <6696cc6a-3e3f-035e-5b8c-05ea361383f3@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <6696cc6a-3e3f-035e-5b8c-05ea361383f3@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/31/22 3:18 PM, Marek Szyprowski wrote:
> Hi Christoph,
> 
> On 08.03.2022 07:15, Christoph Hellwig wrote:
>> Remove the magic autofree semantics and require the callers to explicitly
>> call bio_init to initialize the bio.
>>
>> This allows bio_free to catch accidental bio_put calls on bio_init()ed
>> bios as well.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> This patch, which landed in today's next-20220331 as commit 57c47b42f454 
> ("block: turn bio_kmalloc into a simple kmalloc wrapper"), breaks badly 
> all my test systems, which use squashfs initrd:

The series has been reverted on the block side, so next linux-next should
be fine again. We'll try again for 5.19.

-- 
Jens Axboe

