Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E41A1E5E27
	for <lists+linux-block@lfdr.de>; Thu, 28 May 2020 13:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388202AbgE1LXz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 28 May 2020 07:23:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:50770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388198AbgE1LXy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 07:23:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C3834AEA4;
        Thu, 28 May 2020 11:23:52 +0000 (UTC)
Date:   Thu, 28 May 2020 13:23:52 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH V3 2/6] blk-mq: pass hctx to blk_mq_dispatch_rq_list
Message-ID: <20200528112352.i7fjsa2qfspyal4x@beryllium.lan>
References: <20200528080053.1062653-1-ming.lei@redhat.com>
 <20200528080053.1062653-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528080053.1062653-3-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 28, 2020 at 04:00:49PM +0800, Ming Lei wrote:
> All requests in the 'list' of blk_mq_dispatch_rq_list belong to same
> hctx, so it is better to pass hctx instead of request queue, because
> blk-mq's dispatch target is hctx instead of request queue.
> 
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
