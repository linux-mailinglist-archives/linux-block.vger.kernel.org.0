Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C227257D9DF
	for <lists+linux-block@lfdr.de>; Fri, 22 Jul 2022 07:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiGVF7B (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 22 Jul 2022 01:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGVF7B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 01:59:01 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A84751A36
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 22:58:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VK3u-5E_1658469536;
Received: from 30.97.56.196(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VK3u-5E_1658469536)
          by smtp.aliyun-inc.com;
          Fri, 22 Jul 2022 13:58:56 +0800
Message-ID: <545d6b3e-3533-a755-3dba-b936d40092c1@linux.alibaba.com>
Date:   Fri, 22 Jul 2022 13:58:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH V2 1/2] ublk_drv: fix error handling of ublk_add_dev
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20220722050930.611232-1-ming.lei@redhat.com>
 <20220722050930.611232-2-ming.lei@redhat.com>
Content-Language: en-US
In-Reply-To: <20220722050930.611232-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/7/22 13:09, Ming Lei wrote:
> __ublk_destroy_dev() is called for handling error in ublk_add_dev(),
> but either tagset isn't allocated or mutex isn't initialized.
> 
> So fix the issue by letting ublk_add_dev cleanup its own allocation,
> and simply call kfree(ub) outside of ublk_add_dev which is named
> as ublk_add_tagset(), meantime ublk_add_chdev() is moved out too.
> 
> Now the error handling in ublk_ctrl_add_dev() becomes more readable.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>

