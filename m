Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F6A70EB07
	for <lists+linux-block@lfdr.de>; Wed, 24 May 2023 03:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjEXBvV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 May 2023 21:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjEXBvU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 21:51:20 -0400
Received: from out-8.mta1.migadu.com (out-8.mta1.migadu.com [95.215.58.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C41185
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 18:51:18 -0700 (PDT)
Message-ID: <5874a6ea-e93b-c9f8-8e06-7ceae182e34f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684893077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eYauzNVLneYqRZlTEpN+2GETbsXYjr9b3Tuw3F3Z+rg=;
        b=l/UcI+yQhsBQd++2UVnMV0OA8BKnq/AmV3zhsaBw6chFd/bo5bDj7GKst2nd+wd+kfA650
        Cgs+j6vQd4j2BoK+iFt7qXzOPlLfH6jCfUZdRFHKJzS+XJ1mH3NVNWkR6weB49WzmkcJNq
        BnInrDn0KmJwoHPQ9TTwGWKAUy6M7YY=
Date:   Wed, 24 May 2023 09:51:14 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 03/10] block/rnbd: introduce rnbd_access_modes
Content-Language: en-US
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
References: <20230523075331.32250-1-guoqing.jiang@linux.dev>
 <20230523075331.32250-4-guoqing.jiang@linux.dev>
 <CAMGffEnCKArKzc0KwAbWa-XnELSYybAKptXE+o7zfOGSwjmU2g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <CAMGffEnCKArKzc0KwAbWa-XnELSYybAKptXE+o7zfOGSwjmU2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 5/23/23 17:23, Jinpu Wang wrote:
>> +       int             mode;
> why not enum rnbd_access_mode?

Will change it in next version, thanks for the review.

Guoqing
