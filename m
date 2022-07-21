Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D9F57C524
	for <lists+linux-block@lfdr.de>; Thu, 21 Jul 2022 09:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiGUHTK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 21 Jul 2022 03:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiGUHTK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 03:19:10 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8FC7B7AD
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 00:19:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VK-R-og_1658387943;
Received: from 30.97.56.180(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VK-R-og_1658387943)
          by smtp.aliyun-inc.com;
          Thu, 21 Jul 2022 15:19:04 +0800
Message-ID: <f4094148-1585-ee06-a4db-fd787a73f6c8@linux.alibaba.com>
Date:   Thu, 21 Jul 2022 15:19:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 5/8] ublk: cleanup ublk_ctrl_uring_cmd
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20220721051632.1676890-1-hch@lst.de>
 <20220721051632.1676890-6-hch@lst.de>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20220721051632.1676890-6-hch@lst.de>
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

On 2022/7/21 13:16, Christoph Hellwig wrote:
> Move all per-command work into the per-command ublk_ctrl_* helpers
> instead of being split over those, ublk_ctrl_cmd_validate, and the main
> ublk_ctrl_uring_cmd handler.  To facilitate that, the old
> ublk_ctrl_stop_dev function that just contained two function calls is
> folded into both callers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
