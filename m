Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C442C4134
	for <lists+linux-block@lfdr.de>; Wed, 25 Nov 2020 14:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgKYNfY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 25 Nov 2020 08:35:24 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:38668 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729399AbgKYNfY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 08:35:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UGW7mH6_1606311317;
Received: from 30.0.173.120(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UGW7mH6_1606311317)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Nov 2020 21:35:18 +0800
Subject: Re: [PATCH 3/7] blk-iocost: Just open code the q_name()
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1606186717.git.baolin.wang@linux.alibaba.com>
 <3bdc9526ac839a6952db8cd50cf0e75280614b1d.1606186717.git.baolin.wang@linux.alibaba.com>
 <X75BGjo8B1fgKwui@mtj.duckdns.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <2bc32abe-1328-1d01-cbd3-68286808ab21@linux.alibaba.com>
Date:   Wed, 25 Nov 2020 21:35:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X75BGjo8B1fgKwui@mtj.duckdns.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Tue, Nov 24, 2020 at 11:33:32AM +0800, Baolin Wang wrote:
>> The simple q_name() function is only called from ioc_name(),
>> just open code it to make code more readable.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> I'm not sure this is an improvement. Either way seems fine to me. So, why
> change?

Yes, this may be not called an 'improvement'. Just from my taste of 
reading code, there is no need to factor out a separate function only 
including 4 lines code and called by only one place. Anyway I can drop
this patch if you think this is unnecessary. Thanks.
