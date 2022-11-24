Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C327637301
	for <lists+linux-block@lfdr.de>; Thu, 24 Nov 2022 08:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiKXHqR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 24 Nov 2022 02:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXHqQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Nov 2022 02:46:16 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DDF13E14
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 23:46:13 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VVa7FcD_1669275970;
Received: from 30.97.56.235(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VVa7FcD_1669275970)
          by smtp.aliyun-inc.com;
          Thu, 24 Nov 2022 15:46:11 +0800
Message-ID: <4c8bf08a-8c56-7147-b717-a65ef1d3badb@linux.alibaba.com>
Date:   Thu, 24 Nov 2022 15:46:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH V2 3/6] ublk_drv: move ublk_get_device_from_id into
 ublk_ctrl_uring_cmd
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Dan Carpenter <error27@gmail.com>
References: <20221124030454.476152-1-ming.lei@redhat.com>
 <20221124030454.476152-4-ming.lei@redhat.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20221124030454.476152-4-ming.lei@redhat.com>
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

On 2022/11/24 11:04, Ming Lei wrote:
> It is annoying for each control command handler to get/put ublk
> device and deal with failure.
> 
> Control command handler is simplified a lot by moving
> ublk_get_device_from_id into ublk_ctrl_uring_cmd().
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
