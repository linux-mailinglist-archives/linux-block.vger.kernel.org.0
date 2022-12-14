Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8854D64CE6E
	for <lists+linux-block@lfdr.de>; Wed, 14 Dec 2022 17:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238798AbiLNQzD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 14 Dec 2022 11:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238980AbiLNQym (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Dec 2022 11:54:42 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCBA2936C
        for <linux-block@vger.kernel.org>; Wed, 14 Dec 2022 08:54:40 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id d14so6806135ilq.11
        for <linux-block@vger.kernel.org>; Wed, 14 Dec 2022 08:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VdMn8MdKqERVq83/l+YeYkH6HVsbE2k4JfbE9pJ1Ypo=;
        b=D+E7a9btXDFAY4h9/TXp95QlTJDLO1Qdr8/uyyoZeUcYY1BfJx680/GCWVnOYNkdrC
         uwS3Ihcc6GS/HH9FobTHT4q6/yO/h+HBfyzj5KqJll1QRfuD/cigJ7qaCfbC/qYDusnQ
         p93GRasXxxai4ma/lZuwCAwp9RWztMdrtx9AesUYzDCJXCmlEp6LHO7VShoahengkD68
         Hf/JvqDQimnkUXDnJN0+2zEWVpAP3EbQTCR7j9G2i942JRgJLzpPlD0zzTUpMUsDn7PK
         JBIA/baZ7ShOWi9jmmY46XJNtwUyQq0zo5jo/71jmEjhytxo9rcE5br8fy/UlWnNStMf
         8xZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VdMn8MdKqERVq83/l+YeYkH6HVsbE2k4JfbE9pJ1Ypo=;
        b=K0AegnYG/+6XunPiYPijMNhL/EJ0OoTZBGazrJKQJdfwYMb3/p8zaNgPXpja3E/iy5
         Y27j8gMJW51Vp8HqHJEou0soVGrGrblilCjZB7gPJpjkNzykNjx/H/dey/0CXCOkUqoN
         Z+2bXtsDVLblLeBV1c5Otv4WJqu6Y9lfWck98S2VqS6GDfksyiHB+YDEsQN7pmOZ/W11
         kazBEK9mfdpqCFMdLnpLHcY6yBjzoijpLXMOQjU/IT/rzQ8lnPYSx3s1R4YmhtppOmjI
         e9g3x1PO6Bu6oA4r03VQVsk5mN1C8Vt0Du4+64wqoOQNuiTo87/C88tWdreD4CQ9Vd5S
         ZZaw==
X-Gm-Message-State: ANoB5pmdj7DZ0DNPCHqzKnAgHQykVEOC2rZzyJGL1pbXTJ8+E168DbRW
        7ddfLhGLyefUevAvnZ8BU5PRx6j64z7MA1XGboY=
X-Google-Smtp-Source: AA0mqf7yTYbzA6kWuOn6T+CbG+tkLnt+dK8fzRI3Qj4rvvrUlMRd1H7Wf+1zoOKPsSDPOqMLe3AHuA==
X-Received: by 2002:a05:6e02:ed0:b0:304:ac4f:a79b with SMTP id i16-20020a056e020ed000b00304ac4fa79bmr1862392ilk.3.1671036879545;
        Wed, 14 Dec 2022 08:54:39 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h9-20020a056e020d4900b00300df8bfcf5sm1913591ilj.14.2022.12.14.08.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 08:54:38 -0800 (PST)
Message-ID: <5fbaea42-14a7-27a8-cea1-3a59161ceba0@kernel.dk>
Date:   Wed, 14 Dec 2022 09:54:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH-block v3 1/2] bdi, blk-cgroup: Fix potential UAF of blkcg
To:     Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Yi Zhang <yi.zhang@redhat.com>
References: <20221213184446.50181-1-longman@redhat.com>
 <20221213184446.50181-2-longman@redhat.com>
 <Y5jSllwwBdmQ1jQz@slm.duckdns.org>
 <34a8c4a7-a58d-63fc-4599-accf1cbb6aae@redhat.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <34a8c4a7-a58d-63fc-4599-accf1cbb6aae@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/13/22 12:53 PM, Waiman Long wrote:
> 
> On 12/13/22 14:29, Tejun Heo wrote:
>> On Tue, Dec 13, 2022 at 01:44:45PM -0500, Waiman Long wrote:
>>> Commit 59b57717fff8 ("blkcg: delay blkg destruction until after
>>> writeback has finished") delayed call to blkcg_destroy_blkgs() to
>>> cgwb_release_workfn(). However, it is done after a css_put() of blkcg
>>> which may be the final put that causes the blkcg to be freed as RCU
>>> read lock isn't held.
>>>
>>> Another place where blkcg_destroy_blkgs() can be called indirectly via
>>> blkcg_unpin_online() is from the offline_css() function called from
>>> css_killed_work_fn(). Over there, the potentially final css_put() call
>>> is issued after offline_css().
>>>
>>> By adding a css_tryget() into blkcg_destroy_blkgs() and warning its
>>> failure, the following stack trace was produced in a test system on
>>> bootup.
>> This doesn't agree with the code anymore. Otherwise
>>
>> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Sorry, I overlooked the commit log in my update. I will update it if I need another version, or Jens can make the following edit:
> 
> css_tryget() -> percpu_ref_is_zero().

Since the other one also needs an edit, would be great if you could
just send out a v4.

-- 
Jens Axboe


