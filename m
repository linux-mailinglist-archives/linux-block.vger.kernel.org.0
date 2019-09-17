Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76283B5848
	for <lists+linux-block@lfdr.de>; Wed, 18 Sep 2019 00:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfIQWyq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Sep 2019 18:54:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbfIQWyq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 18:54:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03CF330820C9;
        Tue, 17 Sep 2019 22:54:46 +0000 (UTC)
Received: from [10.72.12.58] (ovpn-12-58.pek2.redhat.com [10.72.12.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 304885D6A5;
        Tue, 17 Sep 2019 22:54:43 +0000 (UTC)
Subject: Re: [PATCH v3 0/2] blk-mq: Avoid memory reclaim when allocating
To:     Jens Axboe <axboe@kernel.dk>, josef@toxicpanda.com
Cc:     mchristi@redhat.com, hch@infradead.org, linux-block@vger.kernel.org
References: <20190917120910.24842-1-xiubli@redhat.com>
 <426aa779-1011-5a75-bb73-ae573c229806@kernel.dk>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <eaa4fb45-3a62-839e-bdcf-5219fe1c8211@redhat.com>
Date:   Wed, 18 Sep 2019 06:54:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <426aa779-1011-5a75-bb73-ae573c229806@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 17 Sep 2019 22:54:46 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/9/17 22:13, Jens Axboe wrote:
> On 9/17/19 6:09 AM, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> Changed in V2:
>> - Addressed the comment from Ming Lei, thanks.
>>
>> Changed in V3:
>> - Switch to memalloc_noio_save/restore from Christoph's comment, thanks.
> This now seems to be a mix of both approaches, which I don't think makes
> sense at all. I think we should just stick to the gfp_t being passed in,
> and defining the standard mask for init time blk-mq memory allocations.
>
Hmm, I might missed or misunderstand from the last thread. In this 
thread with the save/store, the GFP_KERNEL is using instead. Maybe 
save/store pair is not a exactly correct place or occasion to use here 
as @Bart mentioned.

Thanks.

BRs

