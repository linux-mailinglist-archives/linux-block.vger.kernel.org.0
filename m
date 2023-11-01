Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4A67DE4CD
	for <lists+linux-block@lfdr.de>; Wed,  1 Nov 2023 17:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjKAQp5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 1 Nov 2023 12:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKAQp4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Nov 2023 12:45:56 -0400
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E765110C;
        Wed,  1 Nov 2023 09:45:53 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6b709048f32so51007b3a.0;
        Wed, 01 Nov 2023 09:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698857153; x=1699461953;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HShWGtQKfpCm3R1g2YQJwks+runHVlSK4U2xQP7+rJw=;
        b=CyMgr99UDmCjxc57wsi7Kho1KUL1nMkhtYk/FuNZnNyBAW2txrnJuXuWOmzLt5afIW
         MC/K1am0PDUDPkOJEAGNVr/vbC1RLA6b9bYbSZHidguqRZ/CP0S7Bni3ZMB/PQApUHgQ
         qmNU6JG10D4zu4wBKOMaPC5QRfqQTJDNkdQKYQN+aYeHWr7M8IIbE0ePC1id61a/rNhS
         oNcHPdmFQ7u7WONZSsjiR46u+gsEEtkGTYZmbZn4OmKoqkDPC4HP6r9gtYcZ8EkOXUhv
         1b6PWgJFaHPdW/3APAFQide9YVgnnaU+5t2EzbrsD9yUJLq0HMf4qw9JizWViOCND7xR
         cK+w==
X-Gm-Message-State: AOJu0YyGXxs71QXZxJ4vK1wJL1dfpRxnJBPzJDaup3kWGXFxOkSUWsf0
        uZWXFVmVweyICPkNM+FSXHk=
X-Google-Smtp-Source: AGHT+IEvWUmiw62j9GKtgIQhaMTq2wosTr2Yb141pNyQ3mQMR8cKVHrMgBkkuosP22aFkuyRN3ZYpg==
X-Received: by 2002:a05:6a20:1614:b0:17b:62ae:a8aa with SMTP id l20-20020a056a20161400b0017b62aea8aamr15776276pzj.6.1698857153253;
        Wed, 01 Nov 2023 09:45:53 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:2312:f48f:8e12:6623? ([2620:15c:211:201:2312:f48f:8e12:6623])
        by smtp.gmail.com with ESMTPSA id c9-20020a639609000000b005891f3af36asm108341pge.87.2023.11.01.09.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 09:45:52 -0700 (PDT)
Message-ID: <c06b2624-b05b-48d4-840d-beb208aa33dc@acm.org>
Date:   Wed, 1 Nov 2023 09:45:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (2) [PATCH v3 01/14] fs: Move enum rw_hint into a new header file
Content-Language: en-US
To:     daejun7.park@samsung.com, KANCHAN JOSHI <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Seonghun Kim <seonghun-sui.kim@samsung.com>,
        Jorn Lee <lunar.lee@samsung.com>,
        Sung-Jun Park <sungjun07.park@samsung.com>,
        Hyunji Jeon <hyunji.jeon@samsung.com>,
        Dongwoo Kim <dongwoo7565.kim@samsung.com>,
        Seongcheol Hong <sc01.hong@samsung.com>,
        Jaeheon Lee <jaeheon7.lee@samsung.com>,
        Wonjong Song <wj3.song@samsung.com>,
        JinHwan Park <jh.i.park@samsung.com>,
        Yonggil Song <yonggil.song@samsung.com>,
        Soonyoung Kim <overmars.kim@samsung.com>,
        Shinwoo Park <sw_kr.park@samsung.com>,
        Seokhwan Kim <sukka.kim@samsung.com>
References: <9b0990ec-a3c9-48c0-b312-8c07c727e326@acm.org>
 <20231017204739.3409052-1-bvanassche@acm.org>
 <20231017204739.3409052-2-bvanassche@acm.org>
 <b3058ce6-e297-b4c3-71d4-4b76f76439ba@samsung.com>
 <CGME20231017204823epcas5p2798d17757d381aaf7ad4dd235f3f0da3@epcms2p1>
 <20231101063910epcms2p18f991db15958f246fa1654f2d412e176@epcms2p1>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231101063910epcms2p18f991db15958f246fa1654f2d412e176@epcms2p1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/31/23 23:39, Daejun Park wrote:
>> On 10/30/23 04:11, Kanchan Joshi wrote:
>>> On 10/18/2023 2:17 AM, Bart Van Assche wrote:
>> Thanks for having taken a look at this patch series. Jens asked for data
>> that shows that this patch series improves performance. Is this
>> something Samsung can help with?
> 
> We analyzed the NAND block erase counter with and without stream separation
> through a long-term workload in F2FS.
> The analysis showed that the erase counter is reduced by approximately 40%
> with stream seperation.
> Long-term workload is a scenario where erase and write are repeated by
> stream after performing precondition fill for each temperature of F2FS.

Hi Daejun,

Thank you for having shared this data. This is very helpful. Since I'm
not familiar with the erase counter: does the above data perhaps mean
that write amplification is reduced by 40% in the workload that has been
examined?

Thanks,

Bart.

