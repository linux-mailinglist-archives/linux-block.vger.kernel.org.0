Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B704B6BF3
	for <lists+linux-block@lfdr.de>; Tue, 15 Feb 2022 13:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbiBOMXp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 15 Feb 2022 07:23:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236233AbiBOMXo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 07:23:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF5BD107AA9
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 04:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644927814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lg31yHPYbAhd6AH4hbJAztA0zTyxpTO1xXri7qThXF8=;
        b=ivsLcoM2BuEvOlQXTuDv1Hok/4UzSmQsCBcFHaPuy9DNdkMKDkaOS5RzgRDEn1l3r8DjNI
        gZnYObhABMY4e290qA5K1RLhmhV5wfdiyU3zGSETYSrWKLiIQW+iMXkdsueiHyqub0MFIk
        et/LW1wdieYSML0FZizxLhql1QEZ+fA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-2jYxIjFwPXuWO7eg4wnywQ-1; Tue, 15 Feb 2022 07:23:32 -0500
X-MC-Unique: 2jYxIjFwPXuWO7eg4wnywQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACE9018460E5;
        Tue, 15 Feb 2022 12:23:31 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C6076128B;
        Tue, 15 Feb 2022 12:22:48 +0000 (UTC)
Date:   Tue, 15 Feb 2022 20:22:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] blk-mq: Remove get_cpu() in
 __blk_mq_delay_run_hw_queue().
Message-ID: <YgubE76UZr5S7SY7@T590>
References: <YgtuX9dDpXe8Xbs+@linutronix.de>
 <YgtxIZdDXie01OJJ@T590>
 <YgtzBdwYxA7ryJh3@linutronix.de>
 <YguVS3cfbJ6w4Thi@T590>
 <YguYbC0540CecccG@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YguYbC0540CecccG@linutronix.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 15, 2022 at 01:11:24PM +0100, Sebastian Andrzej Siewior wrote:
> On 2022-02-15 19:58:03 [+0800], Ming Lei wrote:
> > On Tue, Feb 15, 2022 at 10:31:49AM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2022-02-15 17:23:45 [+0800], Ming Lei wrote:
> > > > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > > > index 1adfe4824ef5e..90217f1b09add 100644
> > > > > --- a/block/blk-mq.c
> > > > > +++ b/block/blk-mq.c
> > > > > @@ -2040,14 +2040,10 @@ static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
> > > > >  		return;
> > > > >  
> > > > >  	if (!async && !(hctx->flags & BLK_MQ_F_BLOCKING)) {
> > > > > -		int cpu = get_cpu();
> > > > 
> > > > Did you observe the warning triggered?  might_sleep_if(true) in
> > > > __blk_mq_run_dispatch_ops() is only supposed to be run in case of
> > > > (hctx->flags & BLK_MQ_F_BLOCKING).
> > > 
> > > I haven't seen it triggering but if that call chain is possible then it
> > > will triggert due to get_cpu().
> > 
> > As I mentioned, the call chain isn't possible.
> 
> Why not? Is BLK_MQ_F_BLOCKING and blk_queue_has_srcu() exclusive?

blk_queue_has_srcu() returns true iff BLK_MQ_F_BLOCKING is set.

thanks,
Ming

