Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B09054C1C0
	for <lists+linux-block@lfdr.de>; Wed, 15 Jun 2022 08:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbiFOGWr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Jun 2022 02:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243462AbiFOGWq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 02:22:46 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD8E1839F
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 23:22:45 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0CAB967373; Wed, 15 Jun 2022 08:22:42 +0200 (CEST)
Date:   Wed, 15 Jun 2022 08:22:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 3/3] blk-mq: don't clear flush_rq from tags->rqs[]
Message-ID: <20220615062241.GF22115@lst.de>
References: <20220615023712.750122-1-ming.lei@redhat.com> <20220615023712.750122-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615023712.750122-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 15, 2022 at 10:37:12AM +0800, Ming Lei wrote:
> commit 364b61818f65 ("blk-mq: clearing flush request reference in
> tags->rqs[]") is added to clear the to-be-free flush request from
> tags->rqs[] for avoiding use-after-free on the flush rq.
> 
> Yu Kuai reported that blk_mq_clear_flush_rq_mapping() slows down boot time
> by ~8s because running scsi probe which may create and remove lots of
> unpresent LUNs on megaraid-sas which uses BLK_MQ_F_TAG_HCTX_SHARED and
> each request queue has lots of hw queues.
> 
> Improve the situation by not running blk_mq_clear_flush_rq_mapping if
> disk isn't added when there can't be any flush request issued.

This looks ok.  Another optimization would be to never do this if we
don't have a write cache enabled and thus never ever use the flush_rq.

Reviewed-by: Christoph Hellwig <hch@lst.de>
