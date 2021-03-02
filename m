Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD5D32AE8D
	for <lists+linux-block@lfdr.de>; Wed,  3 Mar 2021 03:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhCBXpz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Mar 2021 18:45:55 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:53272 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350040AbhCBLtD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Mar 2021 06:49:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UQ5JVjI_1614685688;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UQ5JVjI_1614685688)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Mar 2021 19:48:09 +0800
Subject: Re: [PATCH] block/bfq: update comments and default value in docs for
 fifo_expire
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-doc@vger.kernel.org, Paolo Valente <paolo.valente@linaro.org>
References: <1614045328-87234-1-git-send-email-joseph.qi@linux.alibaba.com>
 <B64607F8-3E03-4EBE-B4AF-63B9F220063D@linaro.org>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <2576c4bd-4917-7838-04f8-f93e799a3845@linux.alibaba.com>
Date:   Tue, 2 Mar 2021 19:48:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <B64607F8-3E03-4EBE-B4AF-63B9F220063D@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2/23/21 4:25 PM, Paolo Valente wrote:
> 
> 
>> Il giorno 23 feb 2021, alle ore 02:55, Joseph Qi <joseph.qi@linux.alibaba.com> ha scritto:
>>
>> Correct the comments since bfq_fifo_expire[0] is for async request,
>> while bfq_fifo_expire[1] is for sync request.
>> Also update docs, according the source code, the default
>> fifo_expire_async is 250ms, and fifo_expire_sync is 125ms.
>>
> 
> Thank you!
> 
> Acked-by: Paolo Valente <paolo.valente@linaro.org>
> 
Jens, could you take this?

Thanks,
Joseph
