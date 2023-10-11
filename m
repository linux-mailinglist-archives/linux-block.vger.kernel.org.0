Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E167C5EBB
	for <lists+linux-block@lfdr.de>; Wed, 11 Oct 2023 22:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjJKUxV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 11 Oct 2023 16:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbjJKUxU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Oct 2023 16:53:20 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA049E
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 13:53:18 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7a2874d2820so4654639f.1
        for <linux-block@vger.kernel.org>; Wed, 11 Oct 2023 13:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697057597; x=1697662397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B0r2pRN9W+gPfTIBA/X521fXInr9pJ0L2hQFd34BVM0=;
        b=uQi6cEgVyfSQ8FLM5/ryAty1H3LcAqtZIcluHCYa4OcOU9motrMZRQQ8UKETzgfABn
         YPPXtJd60f/KPQ/9AlfVAuIQ0uyw8D2JMyawDEQBL3enuImc5ymEvgyOocmHlICOFlTR
         30QZ8u/7kBTSe4TUAS8F1LA0kpblbkZBfBWkJNE1r2t8WsJ0/rKLjtFA3PpK17hk1wrN
         ClAru1ZRYFls+4PQq3xTx4QMAzDHAJXGSln9ycAAq3LUGg5Iw4n8IRGk83xI5gl7w5Wv
         LzdZc7XlzDGQSvU2cQdfhHN5j82DH2LlW7pvhmB6dq7a6fLM5O7FvARea2NRRns4Y+1Z
         2YIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697057597; x=1697662397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0r2pRN9W+gPfTIBA/X521fXInr9pJ0L2hQFd34BVM0=;
        b=gyXQCsI3A9QkwCiXH2yspvPrt7YtiKK0XO66ymlFfYKhllTUb59HNN9xWwoAi/RTSU
         J8Nw0nZoeKSK3Q3/0qmIZ4Y5VYATjFztWwtXozIFlpT98awsWlfylNbYsHkaeJrZb7OZ
         qOvjBqKBJTy9QWsmgvJri8JP7s2HqKF0hcUF40U9lBftRkzoB6gOjXgBC19ihhio4H8I
         G9a1IrteWpIw8hlb//IveRi9Ux0TEtS+cDdymzExYbPLNvzFwidsBnlIm2aX+RMd2uvr
         H6XX1Xl9V7UNJf6/5WiUTLA/9gWBNH5Cz2k5/cHu0e217hA+D/EkS8+o2uj6QgIkDGYj
         x3qg==
X-Gm-Message-State: AOJu0YyIeoXKiSiHhutdqJn+pYrlsi5f/BhVHhR05lhNZwOnTuVh24PQ
        ClgufAd14qANwqs3dEUj2vu+0w==
X-Google-Smtp-Source: AGHT+IGoTKFpU2Egc4uvEK/uN+eOQeP5IWTqsfI4byvncIVMVKfEdFp7mzGoAuzS4v8G1B3/mbB/mg==
X-Received: by 2002:a05:6602:3a11:b0:79f:922b:3809 with SMTP id by17-20020a0566023a1100b0079f922b3809mr23714875iob.1.1697057597568;
        Wed, 11 Oct 2023 13:53:17 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 28-20020a0566380a5c00b0043a11ec6517sm3458846jap.171.2023.10.11.13.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 13:53:16 -0700 (PDT)
Message-ID: <d5e95ca1-aa20-43da-92f8-3860e744337e@kernel.dk>
Date:   Wed, 11 Oct 2023 14:53:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: block: Don't invalidate pagecache for invalid falloc modes
Content-Language: en-US
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        stable@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20231011201230.750105-1-sarthakkukreti@chromium.org>
 <b068c2ef-5de3-44fb-a55d-2cbe5a7f1158@kernel.dk>
 <ZScKlejOlxIXYmWI@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZScKlejOlxIXYmWI@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/11/23 2:50 PM, Mike Snitzer wrote:
> On Wed, Oct 11 2023 at  4:20P -0400,
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> On 10/11/23 2:12 PM, Sarthak Kukreti wrote:
>>> Only call truncate_bdev_range() if the fallocate mode is
>>> supported. This fixes a bug where data in the pagecache
>>> could be invalidated if the fallocate() was called on the
>>> block device with an invalid mode.
>>
>> Fix looks fine, but would be nicer if we didn't have to duplicate the
>> truncate_bdev_range() in each switch clause. Can we check this upfront
>> instead?
> 
> No, if you look at the function (rather than just the patch in
> isolation) we need to make the call for each case rather than collapse
> to a single call at the front (that's the reason for this fix, because
> otherwise the default: error case will invalidate the page cache too).

Yes that part is clear, but it might look cleaner to check a valid mask
first rather than have 3 duplicate calls.

> Just so you're aware, I also had this feedback that shaped the patch a
> bit back in April:
> https://listman.redhat.com/archives/dm-devel/2023-April/053986.html
> 
>> Also, please wrap commit messages at 72-74 chars.
> 
> Not seeing where the header should be wrapped.  You referring to the
> Fixes: line?  I've never seen those wrapped.

I'm referring to the commit message itself.

-- 
Jens Axboe

