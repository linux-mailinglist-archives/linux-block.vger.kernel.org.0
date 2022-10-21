Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075EE607812
	for <lists+linux-block@lfdr.de>; Fri, 21 Oct 2022 15:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiJUNPW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 21 Oct 2022 09:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiJUNOb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 09:14:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D034E9F
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 06:14:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A776168B05; Fri, 21 Oct 2022 15:13:47 +0200 (CEST)
Date:   Fri, 21 Oct 2022 15:13:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/8] block: set the disk capacity to 0 in
 blk_mark_disk_dead
Message-ID: <20221021131347.GB21741@lst.de>
References: <20221020105608.1581940-1-hch@lst.de> <20221020105608.1581940-2-hch@lst.de> <3aebc5d7-874d-ddeb-7383-79826e98fd9d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aebc5d7-874d-ddeb-7383-79826e98fd9d@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 21, 2022 at 08:49:30AM +0200, Hannes Reinecke wrote:
> I'm ever so slightly concerned about not sending the uevent anymore; MD for 
> one relies on that event to figure out if a device is down.

Hmm, where?  I actually just had customer reports about md not noticing
nvme devices going down properly and thus looking into in-kernel
delivery of notifications..

> And I'm also relatively sure that testing with MD on Xen had been 
> relatively few.
> What do we lose by using the 'notify' version instead?

Mostly that we get incorrect resize events to userspace,  but maybe
because nvme is more common that might still be better overall.
