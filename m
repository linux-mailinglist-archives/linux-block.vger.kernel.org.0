Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3182E408365
	for <lists+linux-block@lfdr.de>; Mon, 13 Sep 2021 06:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhIME0M (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 13 Sep 2021 00:26:12 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44796 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhIME0M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Sep 2021 00:26:12 -0400
Received: from [192.168.1.87] (unknown [223.184.74.135])
        by linux.microsoft.com (Postfix) with ESMTPSA id EFE5D20B713A;
        Sun, 12 Sep 2021 21:24:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EFE5D20B713A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1631507097;
        bh=cP8pHTWjVPluEKCR0eJNXHRO0i01z6NRteeW3cTiSGg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KoqeiBUdseZ6ngVstpdIBlbqTXnenQKSsIyw/6gESd+h25uDCAL/41FesxI6dtMvO
         Ziv2htZg/tCwEJ3yl2SRzl/7EkH692FRMIPv1DVdqxBQ/0Shawv3nHhLnQ2Aw7yuM8
         lFXcTmT2wdYs+Wr8qHSyeIEgdZbQxY5ro3Be7KTw=
Subject: Re: [PATCH] blk-mq: export blk_mq_submit_bio symbol
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>
References: <20210909053653.144360-1-kumarpraveen@linux.microsoft.com>
 <7e80b65b-51a4-3ca1-da43-e87612b8ca5f@nvidia.com>
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
Message-ID: <f7add831-ecf0-6599-158b-cd2f15543da5@linux.microsoft.com>
Date:   Mon, 13 Sep 2021 09:54:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <7e80b65b-51a4-3ca1-da43-e87612b8ca5f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09-09-2021 21:46, Chaitanya Kulkarni wrote:
> 
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 65d3a63aecc6..40a9b085f029 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -2283,6 +2283,7 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
>>          blk_queue_exit(q);
>>          return BLK_QC_T_NONE;
>>   }
>> +EXPORT_SYMBOL_GPL(blk_mq_submit_bio);
>>
> 
> Where is the code that used this API ?
> 

Thanks Chaitanya for your response. Please check my response to Christoph.
That should give overall understanding of the use-case.

Regards,

~Praveen.

