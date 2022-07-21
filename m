Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED2157C558
	for <lists+linux-block@lfdr.de>; Thu, 21 Jul 2022 09:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiGUHdk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 21 Jul 2022 03:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGUHdj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 03:33:39 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0287B7BE1E
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 00:33:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VK-q-lh_1658388813;
Received: from 30.97.56.180(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VK-q-lh_1658388813)
          by smtp.aliyun-inc.com;
          Thu, 21 Jul 2022 15:33:34 +0800
Message-ID: <66309be3-99f4-b3a5-11fd-f0ed283bcd3a@linux.alibaba.com>
Date:   Thu, 21 Jul 2022 15:33:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 6/8] ublk: fold __ublk_create_dev into ublk_ctrl_add_dev
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20220721051632.1676890-1-hch@lst.de>
 <20220721051632.1676890-7-hch@lst.de>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20220721051632.1676890-7-hch@lst.de>
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

On 2022/7/21 13:16, Christoph Hellwig wrote:
> Fold __ublk_create_dev into its only caller to avoid the packing and
> unpacking of the return value into an ERR_PTR.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
