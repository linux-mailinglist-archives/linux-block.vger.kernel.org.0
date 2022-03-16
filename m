Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32954DAD0F
	for <lists+linux-block@lfdr.de>; Wed, 16 Mar 2022 09:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354712AbiCPI6r (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Mar 2022 04:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354732AbiCPI6o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 04:58:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A4F60ABD
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 01:57:30 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h23so1313048wrb.8
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 01:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=i86emO6SxCXEn74tqHI96z0+O6c+YZlbNu3rB2ToUEI=;
        b=a/tw3FBFsdZukvSdSN301t7KfTaYisCIfurH5Uhaw96NSkOyfgg0LKxt4f3/ZXoC6V
         72ERoQ2o/a9HPmv5cEGW8cg3x16fsrFlUxaABO6N7qZuQ/MRhq2taydq701KzgKFMIi1
         w4JBmijEe4lcGXSg3FzVujfgbnokPsTyrgHyupwwhVaRaEfQG4qmA2uMvHlDnlxNTsQX
         5fQPA21jKO8DbYv1SfxTVy/YYb9igDdu22fpD6PLFXV25zUSAAR4m269Mn00SDJ37OOD
         9oH8VV5vuglLpNCbSPjeh7p2cIkg2nfyBfnkz3XnFa6UqTSC7ZY6V4RSe7MPOBYDcAIK
         jxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=i86emO6SxCXEn74tqHI96z0+O6c+YZlbNu3rB2ToUEI=;
        b=mt4TZtbhYqXhpHzoV0Chu91YvqXXwvf/+qJOrAn1xwQcfpqnsTxWDU3/JRM0A8xzhr
         7Ixx1+2WKbLN7by4XIbQJEE+ujtIwvspsbznN/XUF9ddYk8MOtfVNb14/zXfxEAQJ46f
         kIOZ9ub7c1b1H63tSH9R3smNOG7OJkb+pEfMEpP4OCdJTr5CnCQqVfiyvw/9DVuwVcY7
         71imaJSwHicAWLLxYkA5DbZ/oF5ZIhDqBbud3cvuejod1ty/+89QITD+tjIzlEDvs5u4
         nnB9t3xv9klZH5+pFQ0F4aqJ/Sn285qXoPOvVtWk2yBfUasV1aTqz+HgWRY+LgWW9Uqd
         nR1A==
X-Gm-Message-State: AOAM532xb4hvrdgagfDUnneEpWfCeZXnidNxDR1YE3D16vwQXlxb43bb
        Q9vGlW75DISux/zAXVG1TYs5xGZBICJs/YNY9lQ=
X-Google-Smtp-Source: ABdhPJx90qZ7EpEClVHZrlshAOA+7FVfgI6AqQpZ6pWT5yc11UMV8Alj6MKs0MnkVLlOg/mKrcFJ0w==
X-Received: by 2002:adf:d84e:0:b0:203:d515:6e0b with SMTP id k14-20020adfd84e000000b00203d5156e0bmr5310714wrl.443.1647421049487;
        Wed, 16 Mar 2022 01:57:29 -0700 (PDT)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d564f000000b0020371faf04fsm1085829wrw.67.2022.03.16.01.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 01:57:29 -0700 (PDT)
Date:   Wed, 16 Mar 2022 09:57:28 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Matias =?utf-8?B?QmrDuHJsaW5n?= <Matias.Bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220316085717.vypsv55u3be6figk@ArmHalley.localdomain>
References: <YivMBj7+j/EZcMVV@bombadil.infradead.org>
 <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
 <20220314073537.GA4204@lst.de>
 <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
 <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <fcb4f608-970c-56d3-fe3d-b344fab8baf7@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fcb4f608-970c-56d3-fe3d-b344fab8baf7@opensource.wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 16.03.2022 09:00, Damien Le Moal wrote:
>On 3/15/22 22:05, Javier González wrote:
>>>> The main constraint for (1) PO2 is removed in the block layer, we
>>>> have (2) Linux hosts stating that unmapped LBAs are a problem,
>>>> and we have (3) HW supporting size=capacity.
>>>>
>>>> I would be happy to hear what else you would like to see for this
>>>> to be of use to the kernel community.
>>>
>>> (Added numbers to your paragraph above)
>>>
>>> 1. The sysfs chunksize attribute was "misused" to also represent
>>> zone size. What has changed is that RAID controllers now can use a
>>> NPO2 chunk size. This wasn't meant to naturally extend to zones,
>>> which as shown in the current posted patchset, is a lot more work.
>>
>> True. But this was the main constraint for PO2.
>
>And as I said, users asked for it.

Now users are asking for arbitrary zone sizes.

[...]

>>> 3. I'm happy to hear that. However, I'll like to reiterate the
>>> point that the PO2 requirement have been known for years. That
>>> there's a drive doing NPO2 zones is great, but a decision was made
>>> by the SSD implementors to not support the Linux kernel given its
>>> current implementation.
>>
>> Zone devices has been supported for years in SMR, and I this is a
>> strong argument. However, ZNS is still very new and customers have
>> several requirements. I do not believe that a HDD stack should have
>> such an impact in NVMe.
>>
>> Also, we will see new interfaces adding support for zoned devices in
>> the future.
>>
>> We should think about the future and not the past.
>
>Backward compatibility ? We must not break userspace...

This is not a user API change. If making changes to applications to
adopt new features and technologies is breaking user-space, then the
zoned block device already broke that when we introduced zone capacity.
Any existing zoned application working on ZNS _will have to_ make
changes to support ZNS.
