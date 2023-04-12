Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66866DEAD9
	for <lists+linux-block@lfdr.de>; Wed, 12 Apr 2023 07:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjDLFCv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 12 Apr 2023 01:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDLFCu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 01:02:50 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086212D66
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 22:02:50 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 78AC168BFE; Wed, 12 Apr 2023 07:02:47 +0200 (CEST)
Date:   Wed, 12 Apr 2023 07:02:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 14/16] blk-mq: pass a flags argument to
 blk_mq_insert_request
Message-ID: <20230412050247.GB17948@lst.de>
References: <20230411133329.554624-1-hch@lst.de> <20230411133329.554624-15-hch@lst.de> <17f6f705-fb78-f6e3-3427-eae801fc06af@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17f6f705-fb78-f6e3-3427-eae801fc06af@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 11, 2023 at 11:11:51AM -0700, Bart Van Assche wrote:
>> +#define BLK_MQ_INSERT_AT_HEAD		(1U << 0)
>
> Has it been considered to introduce a new bitwise type for this flag? That 
> would allow sparse to detect accidental conversions from bool into flag and 
> vice versa.

I did think about it, but decided not to bother.  But now that there's
a request for it I'll add it.
