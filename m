Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0D6558D18
	for <lists+linux-block@lfdr.de>; Fri, 24 Jun 2022 04:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiFXCEe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 23 Jun 2022 22:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiFXCEd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 22:04:33 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33EE4D608
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 19:04:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VHEZgh1_1656036266;
Received: from 30.225.24.95(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VHEZgh1_1656036266)
          by smtp.aliyun-inc.com;
          Fri, 24 Jun 2022 10:04:27 +0800
Message-ID: <ad19853e-6778-f73c-c1d5-e3e157fc1e2c@linux.alibaba.com>
Date:   Fri, 24 Jun 2022 10:04:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH 48/51] fs/ocfs2: Use the enum req_op and blk_opf_t types
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
 <20220623180528.3595304-49-bvanassche@acm.org>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20220623180528.3595304-49-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 6/24/22 2:05 AM, Bart Van Assche wrote:
> Improve static type checking by using the enum req_op type for variables
> that represent a request operation and the new blk_opf_t type for
> variables that represent request flags.
> 
> Cc: Mark Fasheh <mark@fasheh.com>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Looks fine to me.
Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/cluster/heartbeat.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
> index ea0e70c0fce0..e955aca87936 100644
> --- a/fs/ocfs2/cluster/heartbeat.c
> +++ b/fs/ocfs2/cluster/heartbeat.c
> @@ -503,8 +503,8 @@ static void o2hb_bio_end_io(struct bio *bio)
>  static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
>  				      struct o2hb_bio_wait_ctxt *wc,
>  				      unsigned int *current_slot,
> -				      unsigned int max_slots, int op,
> -				      int op_flags)
> +				      unsigned int max_slots, enum req_op op,
> +				      blk_opf_t op_flags)
>  {
>  	int len, current_page;
>  	unsigned int vec_len, vec_start;
