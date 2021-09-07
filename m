Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743D4402BAB
	for <lists+linux-block@lfdr.de>; Tue,  7 Sep 2021 17:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345019AbhIGPYW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 Sep 2021 11:24:22 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:51531 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344974AbhIGPYW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 11:24:22 -0400
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 187FN6Ve065241;
        Wed, 8 Sep 2021 00:23:07 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Wed, 08 Sep 2021 00:23:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 187FN66E065232
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 8 Sep 2021 00:23:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 1/2] block: make __register_blkdev() return an error
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org
References: <20210904013932.3182778-1-mcgrof@kernel.org>
 <20210904013932.3182778-2-mcgrof@kernel.org>
 <9b9e8bfd-a2a6-4b78-413b-7c6c7eb83e05@I-love.SAKURA.ne.jp>
 <YTUIV0mSJHfgtMov@bombadil.infradead.org>
 <d5c7f0e6-8ded-581c-cb10-00e785a7f7b3@i-love.sakura.ne.jp>
 <YTd98oss0WgCwVzY@bombadil.infradead.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <1c795252-3bc8-1b6c-8a2b-3ef01fd73247@i-love.sakura.ne.jp>
Date:   Wed, 8 Sep 2021 00:23:02 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTd98oss0WgCwVzY@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/07 23:57, Luis Chamberlain wrote:
>> Actually, blk_request_module() failures should be ignored, for
>> subsequent ilookup() will fail if blk_request_module() failed to
>> create the requested block device.
> 
> Then how about this:
> 
> Since we would like to use __must_check for add_disk() we proceed with
> the change to capture the errors and propagate them and we just document on
> fs/block_dev.c's use of blk_request_module() about the above issue and
> how we prefer the errror that ilookup() would return.

Marking add_disk() as __must_check makes it possible to enforce "don't leave
partially initialized devices". That's already an enough improvement.

Probe functions can remain "void", and hence blk_request_module() can remain "void".
That is, I would drop "[PATCH 1/2] block: make __register_blkdev() return an error".
