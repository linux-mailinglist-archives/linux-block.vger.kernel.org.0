Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34785562888
	for <lists+linux-block@lfdr.de>; Fri,  1 Jul 2022 03:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiGABrH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 30 Jun 2022 21:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiGABrG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 21:47:06 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CE45C953
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 18:47:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VHvnoJW_1656640021;
Received: from 30.225.24.50(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VHvnoJW_1656640021)
          by smtp.aliyun-inc.com;
          Fri, 01 Jul 2022 09:47:01 +0800
Message-ID: <087a250f-01fd-a38e-78a8-4449175b6d4a@linux.alibaba.com>
Date:   Fri, 1 Jul 2022 09:47:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2 60/63] fs/ocfs2: Use the enum req_op and blk_opf_t
 types
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
 <20220629233145.2779494-61-bvanassche@acm.org>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20220629233145.2779494-61-bvanassche@acm.org>
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



On 6/30/22 7:31 AM, Bart Van Assche wrote:
> Improve static type checking by using the enum req_op type for variables
> that represent a request operation and the new blk_opf_t type for
> variables that represent request flags. Combine the last two
> o2hb_setup_one_bio() arguments into a single argument.
> 
> Cc: Mark Fasheh <mark@fasheh.com>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  fs/ocfs2/cluster/heartbeat.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
> index ea0e70c0fce0..5d7e303b0293 100644
> --- a/fs/ocfs2/cluster/heartbeat.c
> +++ b/fs/ocfs2/cluster/heartbeat.c
> @@ -503,8 +503,7 @@ static void o2hb_bio_end_io(struct bio *bio)
>  static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
>  				      struct o2hb_bio_wait_ctxt *wc,
>  				      unsigned int *current_slot,
> -				      unsigned int max_slots, int op,
> -				      int op_flags)
> +				      unsigned int max_slots, blk_opf_t opf)
>  {
>  	int len, current_page;
>  	unsigned int vec_len, vec_start;
> @@ -518,7 +517,7 @@ static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
>  	 * GFP_KERNEL that the local node can get fenced. It would be
>  	 * nicest if we could pre-allocate these bios and avoid this
>  	 * all together. */
> -	bio = bio_alloc(reg->hr_bdev, 16, op | op_flags, GFP_ATOMIC);
> +	bio = bio_alloc(reg->hr_bdev, 16, opf, GFP_ATOMIC);
>  	if (!bio) {
>  		mlog(ML_ERROR, "Could not alloc slots BIO!\n");
>  		bio = ERR_PTR(-ENOMEM);
> @@ -566,7 +565,7 @@ static int o2hb_read_slots(struct o2hb_region *reg,
>  
>  	while(current_slot < max_slots) {
>  		bio = o2hb_setup_one_bio(reg, &wc, &current_slot, max_slots,
> -					 REQ_OP_READ, 0);
> +					 REQ_OP_READ);
>  		if (IS_ERR(bio)) {
>  			status = PTR_ERR(bio);
>  			mlog_errno(status);
> @@ -598,7 +597,7 @@ static int o2hb_issue_node_write(struct o2hb_region *reg,
>  
>  	slot = o2nm_this_node();
>  
> -	bio = o2hb_setup_one_bio(reg, write_wc, &slot, slot+1, REQ_OP_WRITE,
> +	bio = o2hb_setup_one_bio(reg, write_wc, &slot, slot+1, REQ_OP_WRITE |
>  				 REQ_SYNC);

Better to let 'REQ_OP_WRITE | REQ_SYNC' at the same line.
Other looks fine.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

>  	if (IS_ERR(bio)) {
>  		status = PTR_ERR(bio);
