Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BCF7CE7C7
	for <lists+linux-block@lfdr.de>; Wed, 18 Oct 2023 21:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjJRTeZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 18 Oct 2023 15:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjJRTeZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Oct 2023 15:34:25 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3DE118;
        Wed, 18 Oct 2023 12:34:23 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1c5c91bec75so49863725ad.3;
        Wed, 18 Oct 2023 12:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697657663; x=1698262463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMeh3qH9TYW3hFExq9XnxFrrSeZ34wjUG6/gWe4RQmM=;
        b=dceXWftmnVUdUdemvFe5+3I5tSHftD+aYP/OjQUDl6p14eX1BXX4OJXWSMyTb4FmUm
         /oMmEDsBGjvVIsFUv7jB32A9dkY05v0yf67EsfHwYMtadLnyhlzwJNNajpvUsVHVNdTo
         jHmdrvjLKe48i13hHRUjNenQKMCpxn7yuIaRfz46Z24L11GXn+wWteqAupBWOXxEiyjM
         t41jzP1xL6hc2dhZvJ3zBO/Ur9lynqpFVPTshdFsZPw4Yf8XWm7gu+K70sUrpB6pUQhd
         N0iewXiZyYGQpNIrwaerzvZL03Ys4UflIzkxUHzSQ7dJcjMSMIH1p5HrR2V5h27jE4j5
         GAiw==
X-Gm-Message-State: AOJu0YzW0fsSpi+sHGbknT8DS42Jmygeovodxaka9VjUmz/pLjteCubf
        bEO8RCsJBnUgu33lKsFJT+w=
X-Google-Smtp-Source: AGHT+IGGvff7t7irqyvDkQrT6elfSKV9+ASYHlHSdgz13fZi//yDG1KxzcD8wrw2qNcuvPKsdRz5tw==
X-Received: by 2002:a17:902:e745:b0:1ca:1c89:9acf with SMTP id p5-20020a170902e74500b001ca1c899acfmr354513plf.53.1697657662867;
        Wed, 18 Oct 2023 12:34:22 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:66c1:dd00:1e1e:add3? ([2620:15c:211:201:66c1:dd00:1e1e:add3])
        by smtp.gmail.com with ESMTPSA id o13-20020a170902d4cd00b001bc676df6a9sm292028plg.132.2023.10.18.12.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 12:34:22 -0700 (PDT)
Message-ID: <e8b49fac-77ce-4b61-ac4d-e4ace58d8319@acm.org>
Date:   Wed, 18 Oct 2023 12:34:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/14] Pass data temperature information to SCSI disk
 devices
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Bean Huo <huobean@gmail.com>,
        Daejun Park <daejun7.park@samsung.com>
References: <20231017204739.3409052-1-bvanassche@acm.org>
 <3f3c2289-3185-4895-92cb-0692e3ca9ebc@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <3f3c2289-3185-4895-92cb-0692e3ca9ebc@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 10/18/23 12:09, Jens Axboe wrote:
> My main hesitation with this is that there's a big gap between what
> makes theoretical sense and practical sense. When we previously tried
> this, turns out devices retained the data temperature on media, as
> expected, but tossed it out when data was GC'ed. That made it more of a
> benchmarking case than anything else. How do we know that things are
> better now? In previous postings I've seen you point at some papers, but
> I'm mostly concerned with practical use cases and devices. Are there any
> results, at all, from that? Or is this a case of vendors asking for
> something to check some marketing boxes or have value add?

Hi Jens,

Multiple UFS vendors made it clear to me that this feature is essential 
for their UFS devices to perform well. I will reach out to some of these
vendors off-list and will ask them to share performance numbers.

A note: persistent stream support is a feature that was only added
recently in the latest SCSI SBC-5 draft. This SCSI specification change
allows SCSI device vendors to interpret the GROUP NUMBER field as a data
lifetime. UFS device vendors interpret the GROUP NUMBER field as a data
lifetime since a long time - long before this was allowed by the SCSI
standards. See also the "ContextID" feature in the UFS specification.
That feature is mentioned in every version of the UFS specification I
have access to. The oldest version of the UFS specification I have
access to is version 2.2, published in 2016.
(https://www.jedec.org/system/files/docs/JESD220C-2_2.pdf). This
document is available free of charge after an account has been created 
on the JEDEC website.

> I'm also really against growing struct bio just for this. Why is patch 2
> not just using the ioprio field at least?

Hmm ... shouldn't the bits in the ioprio field in struct bio have the
same meaning as in the ioprio fields used in interfaces between user
space and the kernel? Damien Le Moal asked me not to use any of the
ioprio bits passing data lifetime information from user space to the kernel.

Is it clear that the size of struct bio has not been changed because the
new bi_lifetime member fills a hole in struct bio?

Thanks,

Bart.


