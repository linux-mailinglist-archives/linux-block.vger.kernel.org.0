Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC46607837
	for <lists+linux-block@lfdr.de>; Fri, 21 Oct 2022 15:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiJUNTo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 21 Oct 2022 09:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiJUNTm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 09:19:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6404D2558E
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 06:19:38 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2B4CD68B05; Fri, 21 Oct 2022 15:19:33 +0200 (CEST)
Date:   Fri, 21 Oct 2022 15:19:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/8] blk-mq: skip non-mq queues in blk_mq_quiesce_queue
Message-ID: <20221021131932.GA22327@lst.de>
References: <20221020105608.1581940-1-hch@lst.de> <20221020105608.1581940-3-hch@lst.de> <Y1HyOS9A72GZIQWT@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1HyOS9A72GZIQWT@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 21, 2022 at 09:13:29AM +0800, Ming Lei wrote:
> > -	blk_mq_wait_quiesce_done(q);
> > +	/* nothing to wait for non-mq queues */
> > +	if (queue_is_mq(q))
> > +		blk_mq_wait_quiesce_done(q);
> 
> This interface can't work as expected for bio drivers, the only user
> should be del_gendisk(), but anyway the patch is fine:

Another one is the wb_lat_usec sysfs attribute.  But maybe it is better
do just do this in the callers and WARN?

