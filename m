Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25901258C63
	for <lists+linux-block@lfdr.de>; Tue,  1 Sep 2020 12:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgIAKJW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 1 Sep 2020 06:09:22 -0400
Received: from verein.lst.de ([213.95.11.211]:52810 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgIAKJI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Sep 2020 06:09:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8047868B05; Tue,  1 Sep 2020 12:09:04 +0200 (CEST)
Date:   Tue, 1 Sep 2020 12:09:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ilya Dryomov <idryomov@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V2] block: release disk reference in hd_struct_free_work
Message-ID: <20200901100904.GA9278@lst.de>
References: <20200901100738.317061-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901100738.317061-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 01, 2020 at 06:07:38PM +0800, Ming Lei wrote:
> Commit e8c7d14ac6c3 ("block: revert back to synchronous request_queue removal")
> stops to release request queue from wq context because that commit
> supposed all blk_put_queue() is called in context which is allowed
> to sleep. However, this assumption isn't true because we release disk's
> reference in partition's percpu_ref's ->release() which doesn't allow
> to sleep, because the ->release() is run via call_rcu().
> 
> Fixes this issue by moving put disk reference into hd_struct_free_work()
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Fixes: e8c7d14ac6c3 ("block: revert back to synchronous request_queue removal")
> Reported-by: Ilya Dryomov <idryomov@gmail.com>
> Tested-by: Ilya Dryomov <idryomov@gmail.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Bart Van Assche <bvanassche@acm.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
