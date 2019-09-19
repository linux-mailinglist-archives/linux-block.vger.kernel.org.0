Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D053B7D42
	for <lists+linux-block@lfdr.de>; Thu, 19 Sep 2019 16:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390294AbfISOwX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 19 Sep 2019 10:52:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34996 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388551AbfISOwX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Sep 2019 10:52:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id v8so3495353eds.2
        for <linux-block@vger.kernel.org>; Thu, 19 Sep 2019 07:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=78lFw348P85UPBgL3HJNM7ArrmsbksumtiCiSWqaTR8=;
        b=CNZa4G4OD6PHbK85JSwKhfnuA2XWsgvhc4wXPVHKgzeWtc4q2VkdhaoKl7xNtbbtzt
         KAtZbFMVU4xeLOJr2KZinrNcPqsu/0d+YQRAWOgAVCsn7FWShNKeHMNpuL+Oh5nkB+rt
         NZe23zFSsUorE3TnmyPYGDvIyokUK+O4DMw+Aih/3oqUdETS0z6jIxCyCBPxFgSUs2/y
         WVdlvCoemycR1qbrjjo3u3vcav0qj9qhZChRq04zrtEQvzJXHl8WNuCT2EQ+n2ben4Hr
         F4ZWPRJiJGSebAKjW6789jvA2+ubwNegkHPnw/6f3860F+5L9PB2U09qo5MDE9+C8eKn
         Jaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=78lFw348P85UPBgL3HJNM7ArrmsbksumtiCiSWqaTR8=;
        b=Xw4Ngo7K8W74qlzV1TvSDRARA72s/JW0iahCgJuAT4o35oztAu/D8g1Beix8lQT0jt
         6Ny0lNbqcN7csaJWYjQfOS0FMP78Qp9lMwvqGJzytI8YIQwaRpzd31TO0/Fy8KvMr714
         103hQhr3KDEAsqq5A8DQK+SapG4IaAe52U3stIoOXWoaJdVkKA4ZjNkgiiQjzWp1n4Jt
         uJZag2Y0fiW9cqqMdL+MgJqxwjXOUrjqibhlxbjBv+hse83xHUMyQ7B9r0tOP6xqdLh8
         jJCvLW2c41jc0JLoRMPM0QJA37l1ozgfLJXNPW39YI/UF3K4wbabLTFcd28xqWltH8OA
         4dGg==
X-Gm-Message-State: APjAAAWVn1+FJxFcEbYw4xEYw1SxS8+XGJUkuDaF+JzKf6ko6aloHhKx
        mShLt4IlL+4t85qiu2bM5X6Pyw==
X-Google-Smtp-Source: APXvYqzSM/CiprUBhOqWB7LRdK9taFV5rRaDvNj1XoDR61PfHV2W/PP9LfEW7kVOxxWOti0tnU8YeQ==
X-Received: by 2002:aa7:d789:: with SMTP id s9mr16659745edq.62.1568904741577;
        Thu, 19 Sep 2019 07:52:21 -0700 (PDT)
Received: from ?IPv6:2a02:247f:ffff:2540:15ef:65f0:201c:bd82? ([2001:1438:4010:2540:15ef:65f0:201c:bd82])
        by smtp.gmail.com with ESMTPSA id ch11sm1044595ejb.48.2019.09.19.07.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 07:52:20 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-mq: fixup request re-insert in
 blk_mq_try_issue_list_directly()
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>
References: <20190919094547.67194-1-hare@suse.de>
 <20190919094547.67194-2-hare@suse.de>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <a277ea45-ef1b-0876-0548-90b67dfc016b@cloud.ionos.com>
Date:   Thu, 19 Sep 2019 16:52:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919094547.67194-2-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 9/19/19 11:45 AM, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.com>
>
> When blk_mq_request_issue_directly() returns BLK_STS_RESOURCE we
> need to requeue the I/O, but adding it to the global request list
> will mess up with the passed-in request list. So re-add the request
> to the original list and leave it to the caller to handle situations
> where the list wasn't completely emptied.
>
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>   block/blk-mq.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b038ec680e84..44ff3c1442a4 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1899,8 +1899,7 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
>   		if (ret != BLK_STS_OK) {
>   			if (ret == BLK_STS_RESOURCE ||
>   					ret == BLK_STS_DEV_RESOURCE) {
> -				blk_mq_request_bypass_insert(rq,
> -							list_empty(list));
> +				list_add(list, &rq->queuelist);

Just curious, maybe the above should be "list_add(&rq->queuelist, list)".

Thanks,
Guoqing
