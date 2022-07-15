Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B118C575E2D
	for <lists+linux-block@lfdr.de>; Fri, 15 Jul 2022 11:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbiGOJCn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 15 Jul 2022 05:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiGOJCm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jul 2022 05:02:42 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD0B78DC9;
        Fri, 15 Jul 2022 02:02:41 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657875760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aGK5SB/6T9qrJYhGg5fGhFJpq52XN8nE6d4BW8QyEaM=;
        b=scBpDYfDicEzB9o+wlsEmz7N42cAJvOFfDm75JYC4mzGfZWB0Zw3G1ukXbKVCnf7NG1dLh
        /UGSppJt4WiDav1uYz5fRrykZ2Jvzkdz1/g4bZ6/RPsN3RQRWPK6N3tv/ZcLLX2b8Lgs2G
        AEDfqzw0Ah4W4yypmFaeN5AQbdp1Azg=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH 6/9] md: stop using for_each_mddev in md_notify_reboot
To:     Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20220713113125.2232975-1-hch@lst.de>
 <20220713113125.2232975-7-hch@lst.de>
Message-ID: <6fa6e045-eb3e-9c72-723d-6e0fe571c728@linux.dev>
Date:   Fri, 15 Jul 2022 17:02:35 +0800
MIME-Version: 1.0
In-Reply-To: <20220713113125.2232975-7-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 7/13/22 7:31 PM, Christoph Hellwig wrote:
> Just do a simple list_for_each_entry_safe on all_mddevs, and only grab a
> reference when we drop the lock.
>
> Reviewed-by: Christoph Hellwig<hch@lst.de>

I suppose it actually means SoB 😉

Thanks,
Guoqing
