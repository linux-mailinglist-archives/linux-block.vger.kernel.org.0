Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3033159ABEA
	for <lists+linux-block@lfdr.de>; Sat, 20 Aug 2022 09:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343663AbiHTHA7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 20 Aug 2022 03:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243758AbiHTHA6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Aug 2022 03:00:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122C7C274A
        for <linux-block@vger.kernel.org>; Sat, 20 Aug 2022 00:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660978856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KPdKF7NqQbYWJNAZGbU7fSXV546gMmrYZuRP+B0Ko2s=;
        b=AapS/aEZaOlG9syRMo2oLuMXu3kdeT5/EUPtZSUTWpCylPMpn1SjW+tWcPXCBTvMQ9YTOs
        JQXUDPvSB1sQGp/xqvHyTQdDa2enaUUpR21QGLKRjEaS+KDHVEzN+3p0+4hDygn/x/bU4c
        g3WsoDeD1lO246mjRfJ5uWpFqWlTiwg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-2n2OG7CWME6p8qoOGZJWWg-1; Sat, 20 Aug 2022 03:00:52 -0400
X-MC-Unique: 2n2OG7CWME6p8qoOGZJWWg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D61BD85A581;
        Sat, 20 Aug 2022 07:00:51 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B6334492CA4;
        Sat, 20 Aug 2022 07:00:44 +0000 (UTC)
Date:   Sat, 20 Aug 2022 15:00:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>,
        Paolo Valente <paolo.valente@linaro.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
Message-ID: <YwCGlyDMhWubqKoL@T590>
References: <Yv0KmT8UYos2/4SX@T590>
 <35f0d608-7448-4276-8922-19a23d8f9049@www.fastmail.com>
 <Yv2P0zyoVvz35w/m@T590>
 <568465de-5c3b-4d94-a74b-5b83ce2f942f@www.fastmail.com>
 <Yv2w+Tuhw1RAoXI5@T590>
 <9f2f608a-cd5f-4736-9e6d-07ccc2eca12c@www.fastmail.com>
 <a817431f-276f-4aab-9ff8-c3e397494339@www.fastmail.com>
 <5426d0f9-6539-477d-8feb-2b49136b960f@www.fastmail.com>
 <Yv3NIQlDL0T3lstU@T590>
 <0f731b0a-fbd5-4e7b-a3df-0ed63360c1e0@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f731b0a-fbd5-4e7b-a3df-0ed63360c1e0@www.fastmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 19, 2022 at 03:20:25PM -0400, Chris Murphy wrote:
> 
> 
> On Thu, Aug 18, 2022, at 1:24 AM, Ming Lei wrote:
> > On Thu, Aug 18, 2022 at 12:27:04AM -0400, Chris Murphy wrote:
> >> 
> >> 
> >> On Thu, Aug 18, 2022, at 12:18 AM, Chris Murphy wrote:
> >> > On Thu, Aug 18, 2022, at 12:12 AM, Chris Murphy wrote:
> >> >> On Wed, Aug 17, 2022, at 11:41 PM, Ming Lei wrote:
> >> >>
> >> >>> OK, can you post the blk-mq debugfs log after you trigger it on v5.17?
> >> 
> >> Same boot, 3rd log. But the load is above 300 so I kinda need to sysrq+b soon.
> >> 
> >> https://drive.google.com/file/d/1375H558kqPTdng439rvG6LuXXWPXLToo/view?usp=sharing
> >> 
> >
> > Also please test the following one too:
> >
> >
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 5ee62b95f3e5..d01c64be08e2 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -1991,7 +1991,8 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx 
> > *hctx, struct list_head *list,
> >  		if (!needs_restart ||
> >  		    (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
> >  			blk_mq_run_hw_queue(hctx, true);
> > -		else if (needs_restart && needs_resource)
> > +		else if (needs_restart && (needs_resource ||
> > +					blk_mq_is_shared_tags(hctx->flags)))
> >  			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
> > 
> >  		blk_mq_update_dispatch_busy(hctx, true);
> >
> 
> 
> With just this patch on top of 5.17.0, it still hangs. I've captured block debugfs log:
> https://drive.google.com/file/d/1ic4YHxoL9RrCdy_5FNdGfh_q_J3d_Ft0/view?usp=sharing

The log is similar with before, and the only difference is RESTART not
set.

Also follows another patch merged to v5.18 and it fixes io stall too, feel free to test it:

8f5fea65b06d blk-mq: avoid extending delays of active hctx from blk_mq_delay_run_hw_queues



Thanks, 
Ming

