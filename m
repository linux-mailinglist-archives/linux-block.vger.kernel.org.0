Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E21D60784B
	for <lists+linux-block@lfdr.de>; Fri, 21 Oct 2022 15:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJUNXX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 21 Oct 2022 09:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJUNXW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 09:23:22 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2A1261419
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 06:23:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 191AD68B05; Fri, 21 Oct 2022 15:23:19 +0200 (CEST)
Date:   Fri, 21 Oct 2022 15:23:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/8] blk-mq: pass a tagset to blk_mq_wait_quiesce_done
Message-ID: <20221021132318.GD22327@lst.de>
References: <20221020105608.1581940-1-hch@lst.de> <20221020105608.1581940-5-hch@lst.de> <Y1H5+Z5HotPo7yWV@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1H5+Z5HotPo7yWV@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 21, 2022 at 09:46:33AM +0800, Ming Lei wrote:
> The change is fine, but the interface could confuse people, it
> looks like it is waiting for whole tagset quiesced, but it needs
> to mark all request queues as quiesced first, otherwise it is just
> wait for one specific queue's quiesce.
> 
> So suggest to document such thing.

Yes, that's probably a good idea.  Still better would be to make
this API purely internal, as the pure wait callers in NVMe and SCSI
are a bit sketchy.
