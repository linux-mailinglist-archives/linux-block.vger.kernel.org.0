Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C08552CB8
	for <lists+linux-block@lfdr.de>; Tue, 21 Jun 2022 10:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiFUIVk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 21 Jun 2022 04:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiFUIVc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 04:21:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7E624BF5
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 01:21:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1DFDE21E46;
        Tue, 21 Jun 2022 08:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655799689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bDpt3h9r8f/vm9wE+iAKqm571873fnOLxcdkNQVkUGI=;
        b=AzkORPIpCW2jiSXLNw2Wx/lkHdX15Rtel2iCQwSkHkBNczdEp1oFscrjSHPVMt06q6zQWt
        gI69WUxHj8bX9EJhqpNWEHsp8zYxPi+CWwCts6pPrQA2d2ykvTOpS2qGTL94nyX/1Kwtg7
        BWDZ8YYMHvxipujIwrLX/WToZKVFyP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655799689;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bDpt3h9r8f/vm9wE+iAKqm571873fnOLxcdkNQVkUGI=;
        b=tuisVzPWT+JxsSEyUey+uNxOkAzjwDV6lDoTwATAQwgGXVvXccZKIjhLDLkGt1bwoQilAz
        r6MD1oVmWOQe7DCg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AF0AE2C141;
        Tue, 21 Jun 2022 08:21:28 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2E238A062B; Tue, 21 Jun 2022 10:21:28 +0200 (CEST)
Date:   Tue, 21 Jun 2022 10:21:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH 6/8] blk-ioprio: Convert from rqos policy to direct call
Message-ID: <20220621082128.untnv6p4j3z333uz@quack3.lan>
References: <20220620160726.19798-1-jack@suse.cz>
 <20220620161153.11741-6-jack@suse.cz>
 <188bc396-70ce-5423-b42c-9056e34fb46f@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <188bc396-70ce-5423-b42c-9056e34fb46f@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 21-06-22 09:00:57, Damien Le Moal wrote:
> On 6/21/22 01:11, Jan Kara wrote:
> > @@ -2790,6 +2791,11 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
> >  	return rq;
> >  }
> >  
> > +static void bio_set_ioprio(struct bio *bio)
> > +{
> > +	blkcg_set_ioprio(bio);
> > +}
> 
> Nit: Make this inline ?

Similar response as to the other static function you wanted to make inline.
I'm pretty sure it will get inlined regardless of whether I write there
inline or not so I prefer not to clutter the declaration :).

> > +
> >  /**
> >   * blk_mq_submit_bio - Create and send a request to block device.
> >   * @bio: Bio pointer.
> > @@ -2830,6 +2836,8 @@ void blk_mq_submit_bio(struct bio *bio)
> >  
> >  	trace_block_getrq(bio);
> >  
> > +	bio_set_ioprio(bio);
> > +
> >  	rq_qos_track(q, rq, bio);
> >  
> >  	blk_mq_bio_to_request(rq, bio, nr_segs);
> 
> Apart from the nit, looks good to me.
> 
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Thanks for review!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
