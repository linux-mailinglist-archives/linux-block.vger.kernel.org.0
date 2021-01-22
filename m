Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94330300336
	for <lists+linux-block@lfdr.de>; Fri, 22 Jan 2021 13:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbhAVJY5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 22 Jan 2021 04:24:57 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:36020 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727343AbhAVJOm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jan 2021 04:14:42 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UMW501u_1611306827;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UMW501u_1611306827)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Jan 2021 17:13:47 +0800
Subject: Re: [PATCH RFC] virtio-blk: support per-device queue depth
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>
References: <1610942338-78252-1-git-send-email-joseph.qi@linux.alibaba.com>
 <405493e0-7917-2ee9-7242-5f02c044a0fb@redhat.com>
 <ce313c74-645f-3a55-44ac-4e757497c778@linux.alibaba.com>
 <20210122033412-mutt-send-email-mst@kernel.org>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <4295b785-cb0e-cacf-4b86-c9019e16c617@linux.alibaba.com>
Date:   Fri, 22 Jan 2021 17:13:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210122033412-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 1/22/21 4:34 PM, Michael S. Tsirkin wrote:
> On Fri, Jan 22, 2021 at 09:43:27AM +0800, Joseph Qi wrote:
>> Hi Michael,
>>
>> Any comments on this patch?
>>
>> Thanks,
>> Joseph
> 
> Suggest copying all reviewers, including Paolo Bonzini
> <pbonzini@redhat.com> and Stefan Hajnoczi <stefanha@redhat.com>.
> 

Sure, will send v2 including cc reviewers.

Thanks,
Joseph
