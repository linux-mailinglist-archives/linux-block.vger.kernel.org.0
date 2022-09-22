Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34AB5E64B3
	for <lists+linux-block@lfdr.de>; Thu, 22 Sep 2022 16:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiIVOIW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 22 Sep 2022 10:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiIVOIV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2022 10:08:21 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D7F54C97
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 07:08:19 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id p3so7752385iof.13
        for <linux-block@vger.kernel.org>; Thu, 22 Sep 2022 07:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date;
        bh=rkVImxlyK2QBDKhgSnYfdEQRSVWW9sMB9j7AsMC1/LE=;
        b=oQJcamULfvQh9FWwuKAKPN5l8tlP8mUoTHHGHGEsNdJfVUZZxr3Jvw2XG6D08iNbGl
         JGkH21lYkHj8GA8FcTZD1PxEB8l2pASE0zRcJTe9/Rkfql8rX4HdkYSuYCIJa9ZOXkA8
         kwuaackEPe0iZ+Bw6pf5xB+x4lzkZsSNwzD35bL30jmg3DAyDaAs6b1Wsqk121DoD/Kw
         mKT+y+FyZXhC257aji5lbhwzkErWCdFiMYzt6M4qPgVp39Waleq0XrDFcYBFr67GVqGg
         Zivn0odNaLDzjv8/fUi1GYghuhQJ6yG9/grWDLBedFQmoy75IUlYLKVl7h5PGrUTXCj3
         gaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rkVImxlyK2QBDKhgSnYfdEQRSVWW9sMB9j7AsMC1/LE=;
        b=vJ2JCDDxvAgT9GtI6aAu1WlbHj/+nIbL6ccn29DV8rJTciuKcbMmjP2K0XwkjaNlgj
         9LVyxzpsMSw2qN3hc9kLKIgGrFvtxgIZqKzQ/tSS7mxF9ZKrJ8JZw2RId6Dy7TH/JE2l
         3RTOGjBR5U/m3m2ZImpcuUYZwEAaz8/trnlnE45ks8R9prKW9pf0InllJx65F4gpfhVS
         IcJmjpJW/rJbu7DFnPBVegtTTX2f/kE2GrmJA/PYZO5HTr1Sxjfit6khhlKUv0emIzK4
         eoouuUCkczo8rPrrkV2/Hx2oWqqz+7QLfG8QRchlSuy3yQWezWzhJHGRpjA1FxKHmYqp
         T3AQ==
X-Gm-Message-State: ACrzQf3FL2PnZ+uVxbcixxZjs9Sm9B1z6QFgST/D0CUW124yce9wVuZw
        YTFFoXr5oCkto7rbi+gMrbrKQQ==
X-Google-Smtp-Source: AMsMyM5FMy8Wj3nL4JYRPeijQ5rrYO7IJ2lH8wCZfN/sOCbqfKAaTbxnPNdUkSLlgqcaDDIXGy1Ltg==
X-Received: by 2002:a05:6638:3791:b0:35a:22c3:4cc9 with SMTP id w17-20020a056638379100b0035a22c34cc9mr2125797jal.114.1663855699117;
        Thu, 22 Sep 2022 07:08:19 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x22-20020a0566380cb600b00349d33a92a2sm2270623jad.140.2022.09.22.07.08.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 07:08:18 -0700 (PDT)
Message-ID: <a208d8c5-f0d8-0334-3eaa-74ed5f181996@kernel.dk>
Date:   Thu, 22 Sep 2022 08:08:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v5 2/3] block: io-uring: add READV_PI/WRITEV_PI operations
To:     "Alexander V. Buev" <a.buev@yadro.com>,
        linux-block@vger.kernel.org, io-uring@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Mikhail Malygin <m.malygin@yadro.com>, linux@yadro.com
References: <20220920144618.1111138-1-a.buev@yadro.com>
 <20220920144618.1111138-3-a.buev@yadro.com>
 <54666720-609b-c639-430d-1dc61e96a6c6@kernel.dk>
 <20220922124846.d4mhaugyd4is7gd5@yadro.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220922124846.d4mhaugyd4is7gd5@yadro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>> But for this patch in particular, not a huge fan of the rote copying of
>> rw.c into a new file. Now we have to patch two different spots whenever
>> a bug is found in there, that's not very maintainable. I do appreciate
>> the fact that this keeps the PI work out of the fast path for
>> read/write, but I do think this warrants a bit of refactoring work first
>> to ensure that there are helpers that can be shared between rw and
>> rw_pi. That definitely needs to be solved before this can be considered
>> for inclusion.
> I think it would be better to move some of the shared code to another file. 
> For example "rw_common.[ch]". What do you think about?
> As an alternative I can leave such code in "rw.[ch]" file as is.

That's basically what I'm suggesting, at least that would be one way to
do it. And the best one imho. So yes, let's go ahead and do that.

-- 
Jens Axboe

