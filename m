Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0FA1FEDB2
	for <lists+linux-block@lfdr.de>; Thu, 18 Jun 2020 10:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgFRIfg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 Jun 2020 04:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgFRIfd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 04:35:33 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDD1C0613EE
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 01:35:32 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g10so4324127wmh.4
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 01:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XeqeGCk0h227IbaUO31Te14Ep+DTbyrxKQiQv5iAGUM=;
        b=kiq7EiV+NbQ+zkWGdgIxS4diLlNIdZsy2YpyY3fOoiZjFDoM0Aw6xumKAxZS8JZzes
         zO3LwZzOCRwhTJFyYgu8zjkLrrxAagZ4Jghj75zv7UmdYqQRe0UQQ4rp7mQe9gT+3DBQ
         E3KhxmSl9KeqSnzdjpseVAnl6szVQLo7mK4OSBlhrJyeLRX9wxXnNXylUlMZf3cZVOfj
         b8NjNpKi1pG/3ppOO5b6K+Qux02YUgTs1Ps61lEFB4AE7Ah1+gUS6EmumutAEX2+bxqv
         AYPqalk+OtcLwX1ByIUhfHA3xjSQ1z7rf263yTQoxc9nZkTIwpp1FdRddEVbaWxsJ7qt
         9LOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XeqeGCk0h227IbaUO31Te14Ep+DTbyrxKQiQv5iAGUM=;
        b=fOige9mUM5paPHflqvo4dQNi4MG7dh5qirhLy9c2oD+31Wl8neQR9GzJCZMBvcDbT/
         UO4VXj72ttdLOYsNAiWt+VcbTpFG5mi9mbM/wKlEF3L4Mn9Xu43nWMryVJe/nSge5aTx
         WcvT1mFZ5DNinu5xQIpzQSYayJ/MZo50rkpXVt8t7UKuNCUdTKvfK7lAQnUL5uVEW5OB
         arT5tT3T+yTVI1OwuLvRxi3bbG+T5efDG8JvYKNF4bgLWuXbuEzD4J6E2wLTsq1YSOhl
         m7UHZYFfHd2tgnZuYxUj0JbccSPFqrp7IBrohHv/zae/TJctWnuT7dpqyufooi/Q3Wkv
         U4SA==
X-Gm-Message-State: AOAM531ZjMp0lJY7K2wrMmN8qqqBl4efb5Nkmczr7+1AiRJvWe0avNV+
        zH7RcSiW+bLT0hiafawTL7O2aQ==
X-Google-Smtp-Source: ABdhPJzAKFaR/sh/flHYyjmoEWwug3yFpLTufpPxJ16XUVsPQXHOB0qJvJqSG0H/AvgdiFKjJBfaiA==
X-Received: by 2002:a1c:dcc2:: with SMTP id t185mr2957197wmg.91.1592469331180;
        Thu, 18 Jun 2020 01:35:31 -0700 (PDT)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id z7sm1541167wmb.42.2020.06.18.01.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 01:35:30 -0700 (PDT)
From:   "javier.gonz@samsung.com" <javier@javigon.com>
X-Google-Original-From: "javier.gonz@samsung.com" <javier.gonz@samsung.com>
Date:   Thu, 18 Jun 2020 10:35:29 +0200
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Kanchan Joshi <joshi.k@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "bcrl@kvack.org" <bcrl@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "selvakuma.s1@samsung.com" <selvakuma.s1@samsung.com>,
        "nj.shetty@samsung.com" <nj.shetty@samsung.com>
Subject: Re: [PATCH 3/3] io_uring: add support for zone-append
Message-ID: <20200618083529.ciifu4chr4vrv2j5@mpHalley.local>
References: <1592414619-5646-1-git-send-email-joshi.k@samsung.com>
 <CGME20200617172713epcas5p352f2907a12bd4ee3c97be1c7d8e1569e@epcas5p3.samsung.com>
 <1592414619-5646-4-git-send-email-joshi.k@samsung.com>
 <CY4PR04MB37510E916B6F243D189B4EB0E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CY4PR04MB37510E916B6F243D189B4EB0E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18.06.2020 07:39, Damien Le Moal wrote:
>On 2020/06/18 2:27, Kanchan Joshi wrote:
>> From: Selvakumar S <selvakuma.s1@samsung.com>
>>
>> Introduce three new opcodes for zone-append -
>>
>>    IORING_OP_ZONE_APPEND     : non-vectord, similiar to IORING_OP_WRITE
>>    IORING_OP_ZONE_APPENDV    : vectored, similar to IORING_OP_WRITEV
>>    IORING_OP_ZONE_APPEND_FIXED : append using fixed-buffers
>>
>> Repurpose cqe->flags to return zone-relative offset.
>>
>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>> Signed-off-by: Javier Gonzalez <javier.gonz@samsung.com>
>> ---
>>  fs/io_uring.c                 | 72 +++++++++++++++++++++++++++++++++++++++++--
>>  include/uapi/linux/io_uring.h |  8 ++++-
>>  2 files changed, 77 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 155f3d8..c14c873 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -649,6 +649,10 @@ struct io_kiocb {
>>  	unsigned long		fsize;
>>  	u64			user_data;
>>  	u32			result;
>> +#ifdef CONFIG_BLK_DEV_ZONED
>> +	/* zone-relative offset for append, in bytes */
>> +	u32			append_offset;
>
>this can overflow. u64 is needed.

We chose to do it this way to start with because struct io_uring_cqe
only has space for u32 when we reuse the flags.

We can of course create a new cqe structure, but that will come with
larger changes to io_uring for supporting append.

Do you believe this is a better approach?

Javier
