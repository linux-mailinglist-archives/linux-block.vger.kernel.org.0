Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44111FEDB0
	for <lists+linux-block@lfdr.de>; Thu, 18 Jun 2020 10:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgFRIcL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 Jun 2020 04:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbgFRIcC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 04:32:02 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0953C0613EF
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 01:32:01 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e1so5098804wrt.5
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 01:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mBaOTic59RjsjLgo2G8JEZ2HjlmP5tRj9DOckjIFG3U=;
        b=VeZchB1Zk+81qlHhjvzg9LHD2TBm3ByGBy0IW8ORikdh0NwKJNt9P+kqDslvMSk8SW
         nw6/o4F3Qx8D4bVOI2IfZ8m1HhI57HG0Hg2hsWb4vVk65rZ6pzUgW4hpY/6HTTXzKFdC
         NMqgGuUBaGfuv0iTTGMcyXJYvYBSsw79YzG0M47LU23y2Akz4LEVPk1bFN9SVP9Ah+Qq
         xv5s2DSDOEC1vdjyoTIdHq3HLLEG6tnDZdPLqGpNCtH1KfYSZsnsmu65lt61g5qsxtk9
         tNk90RsdiXSIUxAFNTAEUhx/jhs/r0f5LxK0bU6VAb6V8yPKshxlErMCndviPPQOs6c+
         LH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mBaOTic59RjsjLgo2G8JEZ2HjlmP5tRj9DOckjIFG3U=;
        b=LyrIiO/yyConmx035hHPHpWBfohtiqzX2oDfn/NlupU6MhQ3o59a3PzK0AeVS14NGH
         Nmi6oGCgmPPR3edDJ+MMHuEAjQ9ovZzJ61DPRtdrwC24qNZfZE9MDB2ikl5LQxUH/1hc
         b9uCThnQ8g0LBRWU2m3wSSQsfDGGHPiCRhNHex399W85jobQvvTW+MHQebD2ckcIqk49
         k8mDikbmlA54OIVNZqg8lgkkg9O4u7G6WHfO2RXJBV9kjN40IuNH+XwIcn8grq9MyYKz
         al3yXyB5oTlcZd2OV5Uey+mqF1/EdHRZi41Sggh7dVvb3KKtGdoTodV2ZctqQxpkexDA
         fqjw==
X-Gm-Message-State: AOAM530xpO/6bKNzPaqYYAN2zsvQtqDpOy21qmE9uwrGN9NhTOmZDu16
        xZvkJ55Xat2Ukj8YUytWIpcaWw==
X-Google-Smtp-Source: ABdhPJxf+HN7+JKdkPYOEHori7/i1a/eK+R6a+pu586zPO/RkLdukssOlIov8whQrf/rt2dWqJEzYw==
X-Received: by 2002:adf:a306:: with SMTP id c6mr3397910wrb.122.1592469120621;
        Thu, 18 Jun 2020 01:32:00 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id t14sm2653507wrb.94.2020.06.18.01.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 01:32:00 -0700 (PDT)
Subject: Re: [PATCH 0/3] zone-append support in aio and io-uring
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, bcrl@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, selvakuma.s1@samsung.com,
        nj.shetty@samsung.com, Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <keith.busch@wdc.com>,
        Christoph Hellwig <hch@lst.de>
References: <CGME20200617172653epcas5p488de50090415eb802e62acc0e23d8812@epcas5p4.samsung.com>
 <1592414619-5646-1-git-send-email-joshi.k@samsung.com>
 <f503c488-fa00-4fe2-1ceb-7093ea429e45@lightnvm.io>
 <20200618082740.i4sfoi54aed6sxnk@mpHalley.local>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <f9b820af-2b23-7bb4-f651-e6e1b3002ebf@lightnvm.io>
Date:   Thu, 18 Jun 2020 10:32:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200618082740.i4sfoi54aed6sxnk@mpHalley.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18/06/2020 10.27, Javier González wrote:
> On 18.06.2020 10:04, Matias Bjørling wrote:
>> On 17/06/2020 19.23, Kanchan Joshi wrote:
>>> This patchset enables issuing zone-append using aio and io-uring 
>>> direct-io interface.
>>>
>>> For aio, this introduces opcode IOCB_CMD_ZONE_APPEND. Application 
>>> uses start LBA
>>> of the zone to issue append. On completion 'res2' field is used to 
>>> return
>>> zone-relative offset.
>>>
>>> For io-uring, this introduces three opcodes: 
>>> IORING_OP_ZONE_APPEND/APPENDV/APPENDV_FIXED.
>>> Since io_uring does not have aio-like res2, cqe->flags are 
>>> repurposed to return zone-relative offset
>>
>> Please provide a pointers to applications that are updated and ready 
>> to take advantage of zone append.
>
> Good point. We are posting a RFC with fio support for append. We wanted
> to start the conversation here before.
>
> We can post a fork for improve the reviews in V2.

Christoph's response points that it is not exactly clear how this 
matches with the POSIX API.

fio support is great - but I was thinking along the lines of 
applications that not only benchmark performance. fio should be part of 
the supported applications, but should not be the sole reason the API is 
added.


