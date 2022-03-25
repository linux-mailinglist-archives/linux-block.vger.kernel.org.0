Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1093F4E78D3
	for <lists+linux-block@lfdr.de>; Fri, 25 Mar 2022 17:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359069AbiCYQZM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 25 Mar 2022 12:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356998AbiCYQZM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Mar 2022 12:25:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3C231925
        for <linux-block@vger.kernel.org>; Fri, 25 Mar 2022 09:23:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D4FC868B05; Fri, 25 Mar 2022 17:23:31 +0100 (CET)
Date:   Fri, 25 Mar 2022 17:23:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: Re: [PATCH 12/13] loop: remove lo_refcount and avoid lo_mutex in
 ->open / ->release
Message-ID: <20220325162331.GA16355@lst.de>
References: <20220324075119.1556334-1-hch@lst.de> <20220324075119.1556334-13-hch@lst.de> <20220324141321.pqesnshaswwk3svk@quack3.lan> <96a4e2e7-e16e-7e89-255d-8aa29ffca68b@I-love.SAKURA.ne.jp> <20220324172335.GA28299@lst.de> <0b47dbee-ce17-7502-6bf3-fad939f89bb7@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b47dbee-ce17-7502-6bf3-fad939f89bb7@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 25, 2022 at 07:54:15PM +0900, Tetsuo Handa wrote:
> > But for now I'd really prefer to stop moving the goalpost further and
> > further.
> 
> Then, why not kill this code?

I think we should eventually do that, and I've indeed tested a patch
that is only cosmetically different.  I wasn't really convinced we
should do it in this series, but if there is consensus that we should
do it now I can respin the series with a patch like this included.
