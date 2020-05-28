Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C2B1E5E9F
	for <lists+linux-block@lfdr.de>; Thu, 28 May 2020 13:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388452AbgE1Lpz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 28 May 2020 07:45:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:58728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388444AbgE1Lpz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 07:45:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2940FAB5C;
        Thu, 28 May 2020 11:45:53 +0000 (UTC)
Date:   Thu, 28 May 2020 13:45:52 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH V3 3/6] blk-mq: move getting driver tag and budget into
 one helper
Message-ID: <20200528114552.ek3wqrgqyg2qxjhe@beryllium.lan>
References: <20200528080053.1062653-1-ming.lei@redhat.com>
 <20200528080053.1062653-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528080053.1062653-4-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 28, 2020 at 04:00:50PM +0800, Ming Lei wrote:
> Move code for getting driver tag and budget into one helper, so
> blk_mq_dispatch_rq_list gets a bit simplified, and easier to read.
> 
> Meantime move updating of 'no_tag' and 'no_budget_available' into
> the branch for handling partial dispatch because that is exactly
> consumer of the two local variables.
> 
> Also rename the parameter of 'got_budget' as 'ask_budget'.

Personally, I find it harder to do multiple inversions of boolean. Well, it's
propably just me.
> 
> No functional change.
> 
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Christoph Hellwig <hch@infradead.org>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
