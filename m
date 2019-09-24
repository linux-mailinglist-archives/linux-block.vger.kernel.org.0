Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 776F4BC5B4
	for <lists+linux-block@lfdr.de>; Tue, 24 Sep 2019 12:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405020AbfIXKe2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 Sep 2019 06:34:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33215 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409465AbfIXKe1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 06:34:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id i30so1104099pgl.0
        for <linux-block@vger.kernel.org>; Tue, 24 Sep 2019 03:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3y++5MWe+nfLT59J4EFQaaYthSHGH3KQ5ez/42aOPdc=;
        b=QN0xTkk5/nR8L2agLUEjaJWbrf1cK1vvJFl4PJiojL+cuYVlgsVfnXG9d2rVjhlKIX
         kpiy7ClqUnrTSZe1w4XugAmftdG6mzzopfjOs0WmwB1byRgHEIZZ2z2cQmsFxw4zqUG/
         J3xgCKktDwgCvDrh0OQuDt5FNYzZBsuyj2cdEc4ydpJ7I+XLyhnwFiFiGeTcYFrV/2JV
         0EbxhHZDLXxNSSW3jXfooDs3rnoy8DRw7+ieGGTFI2tBg96RkNukUj7vtwh1Nl410joB
         phAtzN6ScbyicCsjP5w3+Tb0hLsmkJZI2TeNjxCMAP6zEYs0w9Ym00sdaT1/cg6BhwBQ
         VUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3y++5MWe+nfLT59J4EFQaaYthSHGH3KQ5ez/42aOPdc=;
        b=ed85eUD3H66GoFXZHxG6QjD2/cNYZBdoHqol7PlfUtMfVtu2sS/a2Qj6a25lVqYEQg
         qkqU6SoukSSRf8ejsT+KTzl45NwxJa4wqsLoAMffVU4qiEohfkE3qFKXeWKPcciD6bSf
         0iQY1J7wv2TmbvWLnUiLLrRyB6Jz3Qa9G74cHsm1sFnfyeLIaxvk0LZvlmPHi1de0qCH
         4qgzoOLYzLzZqOfH0uUrlaobdSAVFY6ogQBMW3CViiIAy4p0q9AbZ6n0f3H9wtNwr0/0
         Dm0OLrCv+FwzJ46VBLh963AWzEKr1AqzuFeJhrvd517dIxn98TeyXkKWCtcjN+T+/6gY
         ah6A==
X-Gm-Message-State: APjAAAVQ3Lx9owEobZ5SRh5CnrWL8Y5Cev//up77+Dpq11UnDI6kZKnX
        w2/N13vfoZ3TlIWs6M+eYyIvaos5AImrWr1E
X-Google-Smtp-Source: APXvYqwM9nLMf57gHat2qR6cvPByEWl6hqrFgd7GudTP9BsEhIq/NHvJGBJVCRtDZNDyLjyEC3o+Pw==
X-Received: by 2002:a63:67c2:: with SMTP id b185mr2384022pgc.436.1569321264430;
        Tue, 24 Sep 2019 03:34:24 -0700 (PDT)
Received: from ?IPv6:2600:380:8419:743e:a9a6:f93b:f300:79e6? ([2600:380:8419:743e:a9a6:f93b:f300:79e6])
        by smtp.gmail.com with ESMTPSA id m2sm2387410pff.154.2019.09.24.03.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 03:34:23 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
From:   Jens Axboe <axboe@kernel.dk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
 <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
 <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
 <b999490f-6138-b685-5472-5cd1843b747d@kernel.dk>
 <ed37058b-ee96-7d44-1dc7-d2c48e2ac23f@kernel.dk>
 <20190924094942.GN2349@hirez.programming.kicks-ass.net>
 <6f935fb9-6ebd-1df1-0cd0-69e34a16fa7e@kernel.dk>
Message-ID: <29e6e06e-351f-c19d-ed7c-51f30c9ca887@kernel.dk>
Date:   Tue, 24 Sep 2019 12:34:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6f935fb9-6ebd-1df1-0cd0-69e34a16fa7e@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/24/19 4:13 AM, Jens Axboe wrote:
> On 9/24/19 3:49 AM, Peter Zijlstra wrote:
>> On Tue, Sep 24, 2019 at 10:36:28AM +0200, Jens Axboe wrote:
>>
>>> +struct io_wait_queue {
>>> +	struct wait_queue_entry wq;
>>> +	struct io_ring_ctx *ctx;
>>> +	struct task_struct *task;
>>
>> wq.private is where the normal waitqueue stores the task pointer.
>>
>> (I'm going to rename that)
> 
> If you do that, then we can just base the io_uring parts on that.

Just took a quick look at it, and ran into block/kyber-iosched.c that
actually uses the private pointer for something that isn't a task
struct...

-- 
Jens Axboe

