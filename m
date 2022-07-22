Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB8C57D9E2
	for <lists+linux-block@lfdr.de>; Fri, 22 Jul 2022 08:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiGVGAO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 22 Jul 2022 02:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGVGAN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 02:00:13 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52281659D
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 23:00:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VK3u-ZS_1658469606;
Received: from 30.97.56.196(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VK3u-ZS_1658469606)
          by smtp.aliyun-inc.com;
          Fri, 22 Jul 2022 14:00:07 +0800
Message-ID: <36f1494a-6d70-5e80-eff6-2dccb673cb98@linux.alibaba.com>
Date:   Fri, 22 Jul 2022 14:00:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH V2 2/2] ublk_drv: make sure that correct flags(features)
 returned to userspace
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20220722050930.611232-1-ming.lei@redhat.com>
 <20220722050930.611232-3-ming.lei@redhat.com>
Content-Language: en-US
In-Reply-To: <20220722050930.611232-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/7/22 13:09, Ming Lei wrote:
> Userspace may support more features or new added flags, but the driver
> side can be old, so make sure correct flags(features) returned to
> userpsace, then userspace can work as expected.
> 
> Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>

