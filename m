Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33E6310D366
	for <lists+linux-block@lfdr.de>; Fri, 29 Nov 2019 10:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfK2JpK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 29 Nov 2019 04:45:10 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39297 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2JpJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Nov 2019 04:45:09 -0500
Received: by mail-lj1-f195.google.com with SMTP id e10so22102189ljj.6;
        Fri, 29 Nov 2019 01:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=h89gtr4jirvEqw+istiKuMh6C9n8rYoQsr7cxtnxOQE=;
        b=LnYAyqGkTPjTtDnkPptBD1c4uizp/XqM/K+oUqJfRVRvqwY8q/C/9JZO1kF9M8Z0/N
         RgWQXJpX8RkBSnd0oYsTulp32+lThwE1+rbZLZtrNUvmPu+2EZP3pzabBEZerXaahB6M
         /BoEPVa51+oEJyu4iI1LzRnm1t+iroic76VbNEMti7ji8C37RpxO6JcZoPiacMrsD03a
         reL8QPnD9yco+0MPd8GHwS03TtDVxsgsLz4QtJ+xwYTIG2FqnxkAOyrxhtcq54f3Me2Z
         5To/FtbgbjkVmu1DFyZtiqJbu/yU9MFuA8yEuw2iR65JxMoLmkOWdWBnBaiJmgcsYxYU
         fPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h89gtr4jirvEqw+istiKuMh6C9n8rYoQsr7cxtnxOQE=;
        b=a8Kgj7gJVr8Hyebl9ac/wvabT2nymfloZL3M8XDBa39zEenMd/9t05+NMedsLQtC5b
         JkEzNlvPrskgVAwOPsMssMChoynV5TNQCICegx/jD82txTLeC05NFn6JGAIHKNHS5Ajo
         Z/7nIQ5a0G5kk0y6kCQiYG+d8FmhLsF96EdanGcUMpBdKUScDpYuFyBDZODgZlePWRQk
         OeYdxkS3RRRzPQvPoXebTePEQiu3M0oAxhH97qc0ENF9dcDZhLL8fIeeFqIMqFqAC/Ak
         aVXlVSxwxtbmZ9UgqCN7xXnZPBxiyP8Dmg7Rb6rrU53/ZSLSmDCT1M62RCZ0nt5XJonw
         0Jqg==
X-Gm-Message-State: APjAAAXtwrmdjwERMQET6PSeD2MJrWTgVSoMfgT6OMRjKtGg/k/pfMqh
        A+zGBK1rAN4AnHZ6mcX5T8yZsn+nUTw=
X-Google-Smtp-Source: APXvYqymHjqtZ5yLRtHmfHQHjzkdwaZzbuI/7qkmGsPIBQkf4vtO2fa7lH85D+4iKu06z/+F/yXJ/g==
X-Received: by 2002:a2e:3313:: with SMTP id d19mr38009377ljc.240.1575020705682;
        Fri, 29 Nov 2019 01:45:05 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id a24sm547142ljp.97.2019.11.29.01.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Nov 2019 01:45:04 -0800 (PST)
Subject: Re: [PATCH 1/3] blk-mq: optimise rq sort function
To:     Nikolay Borisov <nborisov@suse.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1574974577.git.asml.silence@gmail.com>
 <a21e91fff1abe201ebbc010d596b034f7b5123de.1574974577.git.asml.silence@gmail.com>
 <0124910c-4dcf-2143-0ec6-32dad123067c@suse.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <7b1a16db-287f-bba0-fca0-cc7f85f69ec6@gmail.com>
Date:   Fri, 29 Nov 2019 12:45:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <0124910c-4dcf-2143-0ec6-32dad123067c@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/2019 11:28 AM, Nikolay Borisov wrote:
> On 28.11.19 г. 23:11 ч., Pavel Begunkov wrote:
>> Check "!=" in multi-layer comparisons. The same memory usage, fewer
>> instructions, and 2 from 4 jumps are replaced with SETcc.
>>
>> Note, that list_sort() doesn't differ 0 and <0.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> My first reaction was this is wrong since you no longer return negative
> values. But then I looked into list_sort/merge and this branch
> 'if (cmp(priv, a, b) <= 0) {' clearly shows this is correct.

Yes, that's why there is a note in the patch description. The same is
told by list_sort() description.

> 
> So :
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>

Thanks for taking a look

> 
>> ---
>>  block/blk-mq.c | 12 ++++--------
>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 323c9cb28066..f32a3cfdd34e 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -1668,14 +1668,10 @@ static int plug_rq_cmp(void *priv, struct list_head *a, struct list_head *b)
>>  	struct request *rqa = container_of(a, struct request, queuelist);
>>  	struct request *rqb = container_of(b, struct request, queuelist);
>>  
>> -	if (rqa->mq_ctx < rqb->mq_ctx)
>> -		return -1;
>> -	else if (rqa->mq_ctx > rqb->mq_ctx)
>> -		return 1;
>> -	else if (rqa->mq_hctx < rqb->mq_hctx)
>> -		return -1;
>> -	else if (rqa->mq_hctx > rqb->mq_hctx)
>> -		return 1;
>> +	if (rqa->mq_ctx != rqb->mq_ctx)
>> +		return rqa->mq_ctx > rqb->mq_ctx;
>> +	if (rqa->mq_hctx != rqb->mq_hctx)
>> +		return rqa->mq_hctx > rqb->mq_hctx;
>>  
>>  	return blk_rq_pos(rqa) > blk_rq_pos(rqb);
>>  }
>>

-- 
Pavel Begunkov
