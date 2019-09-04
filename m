Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 109B4A81D7
	for <lists+linux-block@lfdr.de>; Wed,  4 Sep 2019 14:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfIDMHW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 4 Sep 2019 08:07:22 -0400
Received: from foss.arm.com ([217.140.110.172]:53176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729316AbfIDMHV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Sep 2019 08:07:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E0B8337;
        Wed,  4 Sep 2019 05:07:21 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0EB923F59C;
        Wed,  4 Sep 2019 05:07:19 -0700 (PDT)
Subject: Re: [PATCH] sched: make struct task_struct::state 32-bit
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
        aarcange@redhat.com
References: <20190902210558.GA23013@avx2>
 <d8ad0be1-4ed7-df74-d415-2b1c9a44bac7@arm.com> <20190903181920.GA22358@avx2>
 <92ead22e-0580-c720-1a29-7db79d76f7d7@arm.com>
Message-ID: <a43fe392-bd6a-71f5-8611-c6b764ba56c3@arm.com>
Date:   Wed, 4 Sep 2019 13:07:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <92ead22e-0580-c720-1a29-7db79d76f7d7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/09/2019 22:51, Valentin Schneider wrote:
[...]
> I tried something for function parameters, which seems to be feasible
> according to [1], but couldn't get it to work (yet). Here's what I have
> so far:
> 
[...]

So now I have this:

---
@funcmatch@
identifier func;
identifier p;
identifier state_var;
@@

  func(..., struct task_struct *p, ...
-      , long state_var
+      , int state_var
       ,...)
{
	...
}
---

Which seems to be doing roughly what I want. I probably need another
version to cover functions with reverse parameter order, and also need
to make it match functions that assign state_var to p->state (or pass it
down to another function that might do it).

Baby steps...
