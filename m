Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C6270A56C
	for <lists+linux-block@lfdr.de>; Sat, 20 May 2023 06:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjETE4v (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 20 May 2023 00:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjETE4u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 May 2023 00:56:50 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE98BA0
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 21:56:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5F3CB68CFE; Sat, 20 May 2023 06:56:44 +0200 (CEST)
Date:   Sat, 20 May 2023 06:56:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 7/7] blk-mq: don't use the requeue list to queue flush
 commands
Message-ID: <20230520045644.GB32182@lst.de>
References: <20230519044050.107790-1-hch@lst.de> <20230519044050.107790-8-hch@lst.de> <36dbbde0-e7f4-c1bd-8015-6265ac812786@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36dbbde0-e7f4-c1bd-8015-6265ac812786@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 19, 2023 at 12:55:45PM -0700, Bart Van Assche wrote:
>>   	LIST_HEAD(rq_list);
>> -	struct request *rq, *next;
>> +	LIST_HEAD(flush_list);
>> +	struct request *rq;
>>     	spin_lock_irq(&q->requeue_lock);
>>   	list_splice_init(&q->requeue_list, &rq_list);
>> +	list_splice_init(&q->flush_list, &flush_list);
>>   	spin_unlock_irq(&q->requeue_lock);
>
> "rq_list" stands for "request_list". That name is now confusing since this patch
> add a second request list (flush_list).

It is.  But I think you were planning on doing a bigger rework in this
area anyway?
