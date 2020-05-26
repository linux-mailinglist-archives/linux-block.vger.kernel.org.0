Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B013B1DB808
	for <lists+linux-block@lfdr.de>; Wed, 20 May 2020 17:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgETPXE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 20 May 2020 11:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETPXD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 11:23:03 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C507C061A0F
        for <linux-block@vger.kernel.org>; Wed, 20 May 2020 08:23:03 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z26so1698200pfk.12
        for <linux-block@vger.kernel.org>; Wed, 20 May 2020 08:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q/sKPgEYp3g3cebHBn38ukD6oq83OtlMsqDeM2dlT2s=;
        b=S/C8q0u1+H6mmpXkFnd+U1cMWvHcjrZbgtYPv8vmiMr2HBXRFa05Xaukja1+yAc0nj
         Gl9tEsA7MFacod1B+/lF7+tlBsSy/goNENRi9nZuALTFtX8t1hYMg6dVkxsOiOqIJ/xu
         8GuerfD5ZHBRFwTvp5W0/wUUGXkQIouY0qV37HJiWjeY6f2aV2uaDrwfXdPPDL0pD25v
         yk+vS0XmimnbqTY6bf7lgulMI3B4GeDbVJqRY2j9TCeaKQoJ/wRxlSwmf7BXFZ6OeNb6
         wVI1cgBnLy0zG7haievzWmun2dC3jSlduuUWOp397IU8Lq/C1QI56+X8ut6thbGYbIUV
         vwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q/sKPgEYp3g3cebHBn38ukD6oq83OtlMsqDeM2dlT2s=;
        b=X7mmWqUCXV483fsxSCaV/c0NOl04jD3g7XcZIJq3+wADL3WdV2+w2Qs48TERDXa8lM
         aMU32GPzlYvm9/vGg/XUYLu6eTEniCovf369PIX46K4iX6ZQsS/0BQF7SZJjqeflMllT
         XBsWE82kbfGeoBd4wAvJVE6NM+wbH8US6pYlnMNCIFri1lelh62fYJpyod+AGsBpnzds
         XbvFGHDvcNYXCOKQhu5d5jlojWio1RofhFmUgwN3mudjiM2tzoTxJTqrg5yXkbd8EWBb
         VMsMP0L4gWZ6wEN9tVlZCLs7AzHbL8a3L5bbGP3mLyP3/f1eJgdhF0fDdP6abHwWZG+t
         +4Zg==
X-Gm-Message-State: AOAM5317XsRP2YDMF12P7QwsHMntoOxA/XQtaoQaOYOVS7USxNQil5LR
        pBnDGYCu0XPya4MDlz7ysPw09A==
X-Google-Smtp-Source: ABdhPJwli/yOPULvtKHWFg0JjlFST9zIaDeZJYeKHoqoUEmaQIOAwFunV33sHbFGnPJcrs+wZY6JzQ==
X-Received: by 2002:a63:5b1f:: with SMTP id p31mr4691882pgb.335.1589988182905;
        Wed, 20 May 2020 08:23:02 -0700 (PDT)
Received: from [192.168.86.156] (cpe-75-85-219-51.dc.res.rr.com. [75.85.219.51])
        by smtp.gmail.com with ESMTPSA id d18sm2473267pjv.34.2020.05.20.08.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 08:23:02 -0700 (PDT)
Subject: Re: io_uring vs CPU hotplug, was Re: [PATCH 5/9] blk-mq: don't set
 data->ctx and data->hctx in blk_mq_alloc_request_hctx
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>, io-uring@vger.kernel.org
References: <20200518093155.GB35380@T590>
 <87imgty15d.fsf@nanos.tec.linutronix.de> <20200518115454.GA46364@T590>
 <20200518131634.GA645@lst.de> <20200518141107.GA50374@T590>
 <20200518165619.GA17465@lst.de> <20200519015420.GA70957@T590>
 <20200519153000.GB22286@lst.de> <20200520011823.GA415158@T590>
 <20200520030424.GI416136@T590> <20200520080357.GA4197@lst.de>
 <8f893bb8-66a9-d311-ebd8-d5ccd8302a0d@kernel.dk>
Message-ID: <448d3660-0d83-889b-001f-a09ea53fa117@kernel.dk>
Date:   Wed, 20 May 2020 09:20:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8f893bb8-66a9-d311-ebd8-d5ccd8302a0d@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/20 8:45 AM, Jens Axboe wrote:
> On 5/20/20 2:03 AM, Christoph Hellwig wrote:
>> On Wed, May 20, 2020 at 11:04:24AM +0800, Ming Lei wrote:
>>> On Wed, May 20, 2020 at 09:18:23AM +0800, Ming Lei wrote:
>>>> On Tue, May 19, 2020 at 05:30:00PM +0200, Christoph Hellwig wrote:
>>>>> On Tue, May 19, 2020 at 09:54:20AM +0800, Ming Lei wrote:
>>>>>> As Thomas clarified, workqueue hasn't such issue any more, and only other
>>>>>> per CPU kthreads can run until the CPU clears the online bit.
>>>>>>
>>>>>> So the question is if IO can be submitted from such kernel context?
>>>>>
>>>>> What other per-CPU kthreads even exist?
>>>>
>>>> I don't know, so expose to wider audiences.
>>>
>>> One user is io uring with IORING_SETUP_SQPOLL & IORING_SETUP_SQ_AFF, see
>>> io_sq_offload_start(), and it is a IO submission kthread.
>>
>> As far as I can tell that code is buggy, as it still needs to migrate
>> the thread away when the cpu is offlined.  This isn't a per-cpu kthread
>> in the sene of having one for each CPU.
>>
>> Jens?
> 
> It just uses kthread_create_on_cpu(), nothing home grown. Pretty sure
> they just break affinity if that CPU goes offline.

Just checked, and it works fine for me. If I create an SQPOLL ring with
SQ_AFF set and bound to CPU 3, if CPU 3 goes offline, then the kthread
just appears unbound but runs just fine. When CPU 3 comes online again,
the mask appears correct.

So don't think there's anything wrong on that side. The affinity is a
performance optimization, not a correctness issue. Really not much we
can do if the chosen CPU is offlined, apart from continue to chug along.

-- 
Jens Axboe

