Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E5635DCE8
	for <lists+linux-block@lfdr.de>; Tue, 13 Apr 2021 12:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhDMKz7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 13 Apr 2021 06:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhDMKzu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 06:55:50 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24DEC061574
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 03:55:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z1so18852361edb.8
        for <linux-block@vger.kernel.org>; Tue, 13 Apr 2021 03:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=va658DcvB9VpnT6zlnFssN11/Tnxxz2cyGv/gA71ftU=;
        b=PiMHislXz8pJmhPvsAadDi9Af9yqHMe9WvfMofA7+gE1OX1pmd8JjyMOKWHD0Joxrg
         PjvCVV/3Wuhu3p/0wtwZwnNwMrvQL/m/4y3yC1sc6huJOjz9IyScytwhU3oNAZ3pxDqZ
         7aNdc6stSrFBgIgGQLraCV9y0fQM6laXBDRCSdDDXABOL4oB9MPJjtLrZgTAhQijRM6J
         elvfq0oYphGCsW9of6JatFhrbdfPLyiNrShfY52tNXE8nizFdivXNOUKskKPJooolXRS
         PiT174veyORmFaD5QrpQyoZaoF/A5aq2PHj0liQvQMh64XIyp8Qrt9bLrYkp2/XvffHy
         GGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=va658DcvB9VpnT6zlnFssN11/Tnxxz2cyGv/gA71ftU=;
        b=AfUBK2h/IPA5mCZjPkon/6aSpy1IL6qXf4Qze2yZY7suHqFQpN7rPCZ+R8WtwxT0gY
         5uK29coasXMX6Us+6rfbnHMxpG4zG3UC2Gwl5JhGrVXehd+T7SkTekpmeFANKXMB0UzM
         Y6BTKJ+fMfFurBow4JrAwdbWEE7wqIEE6/hlfvqmCDQcrRLy1OF72BPcOfRtYYi9S4Sl
         fi4ZdQ6LhquCpPLg0XQEj37b5iCA7177aDV/RnwjwpUmZ+x8nkXQzZn6NXtJ5AO4wdmj
         jg1jGtwyni112SAlo4vnR/qvorGaOvoZcfybXsMg7ovPUIFu4+V9wQA1cfTWyKzSoe6w
         OBiA==
X-Gm-Message-State: AOAM530y5PHhOWZ6qJkhY8AJRi0S2XFrc8mucmKmQsP0RI1gi8gJftGL
        s9x6aSkvVH2kSNllXtpzM9AbJQ==
X-Google-Smtp-Source: ABdhPJxWfmjVMmbjEfL5HaZ4mDwT3aOXbcswowPXw2Y8I4NhukX8Jh/zNINPeg2SYyvtfVwfjBNGfA==
X-Received: by 2002:a50:fb8c:: with SMTP id e12mr35068851edq.295.1618311329613;
        Tue, 13 Apr 2021 03:55:29 -0700 (PDT)
Received: from [10.0.0.62] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id t1sm9087230eds.53.2021.04.13.03.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 03:55:29 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: remove duplicate include in lightnvm.h
To:     menglong8.dong@gmail.com
Cc:     linux-block@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>
References: <20210313112241.366786-1-zhang.yunkai@zte.com.cn>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <e2bd4734-959c-4505-7e1c-ccc04185e4d3@lightnvm.io>
Date:   Tue, 13 Apr 2021 12:55:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210313112241.366786-1-zhang.yunkai@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 13/03/2021 12.22, menglong8.dong@gmail.com wrote:
> From: Zhang Yunkai <zhang.yunkai@zte.com.cn>
>
> 'linux/ioctl.h' included in 'lightnvm.h' is duplicated.
> It is also included in the 33th line.
>
> Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
> ---
>   include/uapi/linux/lightnvm.h | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/include/uapi/linux/lightnvm.h b/include/uapi/linux/lightnvm.h
> index ead2e72e5c88..2745afd9b8fa 100644
> --- a/include/uapi/linux/lightnvm.h
> +++ b/include/uapi/linux/lightnvm.h
> @@ -22,7 +22,6 @@
>   
>   #ifdef __KERNEL__
>   #include <linux/const.h>
> -#include <linux/ioctl.h>
>   #else /* __KERNEL__ */
>   #include <stdio.h>
>   #include <sys/ioctl.h>
Thanks, Yunkai. I've pulled it. Note that I've merged your two patches 
into one.
