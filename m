Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA7B54F0FE
	for <lists+linux-block@lfdr.de>; Fri, 17 Jun 2022 08:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiFQGWl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 17 Jun 2022 02:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379986AbiFQGWk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 02:22:40 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA47DAD
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 23:22:37 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0798967373; Fri, 17 Jun 2022 08:22:34 +0200 (CEST)
Date:   Fri, 17 Jun 2022 08:22:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/6] block: factor out a chunk_size_left helper
Message-ID: <20220617062233.GA5079@lst.de>
References: <20220614090934.570632-1-hch@lst.de> <20220614090934.570632-2-hch@lst.de> <Yqu3TKf5MUwcnUty@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqu3TKf5MUwcnUty@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 16, 2022 at 07:05:48PM -0400, Mike Snitzer wrote:
> > +	return min(q->limits.max_sectors,
> > +			blk_chunk_sectors_left(offset, chunk_sectors));
> >  }
> 
> While you're at it, any reason not to use queue_max_sectors() here?

I'm not sure if it is a good reason, but this code sniplet goes
away later in the series, and all replacemens do use queue_max_sectors.
