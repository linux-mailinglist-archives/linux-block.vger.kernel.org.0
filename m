Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4337F49CB01
	for <lists+linux-block@lfdr.de>; Wed, 26 Jan 2022 14:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240435AbiAZNii (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 26 Jan 2022 08:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240371AbiAZNig (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 08:38:36 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14CCC06161C
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 05:38:35 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id y84so10957505iof.0
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 05:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KbzpRph0Mirr8SYyjxp9jggX64pxfscjypFnc+VjXUI=;
        b=2h86gEPsZt0ZRZ84D/69gIx+ZrLslbkplVGbsOAbusBnHkfr0lUNoC7Op19I3YhizF
         S467/e+ilOOHR+jtKiozvpymRc9p6hhXvZpCuinpElvwJLplcrKwvhMGzWqvexKMs/xM
         3FbMgA7Byz4TsskTLPdfL/sJesykdpOBUoX//Wyu8XTLVIekd2rtbA/q06qofTbnt01D
         qgR9bocOBcl/HhIFPWGz4OSq+LcgR96HpAYWfgWOylfvfi7lmN9JjrN+LPdOZQFwAjY2
         X6Bz71oxNHWGIwtDxlyBSjgdRo0/oSjVhBOv2KchvGM1GDwxl9eXK+21vkF6OUw+vaHC
         4eSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KbzpRph0Mirr8SYyjxp9jggX64pxfscjypFnc+VjXUI=;
        b=3cFUDadx9AcdeZTY1Zrr6wULbGhZUzHBUHj1J84dr6yJM8kCy2lq7pH0YZJcSUOdrT
         QNC3a+MPrwLTeZwFalsuusiQtLkqPfBNle7z+vJJ7+gRdA4OmL6nrGTuYT4LosxAEJn9
         xtbBHUNK1ZGOaLIflUMH2Te4ntvbtjmro5qkPQTw4uqaKIbxQHwv8OvyYVKQvOKuhoiU
         F08eunDjM0ucGw3eBNbG31kBH9ZPTMq0Uou8xs5HmDpWJTmg22O27qDpK1ceAFcSVh4E
         3MrJyvWdehRDjaKEPnkPwiSNZsPJrCTnDFZUk55HXHsPwQkE4d//PbK2kbU+pHGRLgMT
         rMTg==
X-Gm-Message-State: AOAM533jjTIMZEwJ+i4ERqDX17zwI4FaZSdiDSG3RNnqMlzieWojpEzf
        cv2wctKtVo2h48aOps+YUPF4Fg==
X-Google-Smtp-Source: ABdhPJygyTf213ZJMtCcew39K4MPmynzYhqQ6Sj1LmJZF3M+EudaxH8+lUH1KPDZguuIJpox9Wt7ZA==
X-Received: by 2002:a05:6602:1688:: with SMTP id s8mr13649548iow.206.1643204315186;
        Wed, 26 Jan 2022 05:38:35 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id g10sm836114iov.22.2022.01.26.05.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 05:38:34 -0800 (PST)
Subject: Re: "blk-mq: fix tag_get wait task can't be awakened" causes hangs
To:     QiuLaibin <qiulaibin@huawei.com>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-block@vger.kernel.org
Cc:     john.garry@huawei.com, ming.lei@redhat.com,
        martin.petersen@oracle.com, hare@suse.de,
        akpm@linux-foundation.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org
References: <1643040870.3bwvk3sis4.none.ref@localhost>
 <1643040870.3bwvk3sis4.none@localhost>
 <78cafe94-a787-e006-8851-69906f0c2128@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <723815a5-f716-499a-acce-15028a629f3a@kernel.dk>
Date:   Wed, 26 Jan 2022 06:38:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <78cafe94-a787-e006-8851-69906f0c2128@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/24/22 9:08 PM, QiuLaibin wrote:
> Hi Alex
> 
> 1、Please help to import this structure:
> 
> blk_mq_tags <= request_queue->blk_mq_hw_ctx->blk_mq_tags
> 
> If there is no kernel dump, help to see the value of
> 
> cat /sys/block/sda/mq/0/nr_tags
>                 __ <= Change it to the problem device
> 
> And how many block devices in total by lsblk.
> 
> 2、Please describe in detail how to reproduce the issue,
> 
> And what type of USB device?
> 
> 3、Please help to try the attachment patch and see if it can be reproduced.

Any progress on this? I strongly suspect that any QD=1 setup would
trivially show the issue, based on the reports.

-- 
Jens Axboe

