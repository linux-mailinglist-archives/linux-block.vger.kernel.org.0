Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF123AE514
	for <lists+linux-block@lfdr.de>; Mon, 21 Jun 2021 10:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFUIle (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 21 Jun 2021 04:41:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25448 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229937AbhFUIlc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 04:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624264758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=awsNZMMAsK23YLNOqGpugl5EnSbnJjbUBrI+opZ2Ba0=;
        b=ffwQcyyIlFYKcL6quvUngqnyPjyFf8/flpnj+cka6FIt4GbNb7jimnel+fSMZlxsiXmyCZ
        DFc+qYKOSwj2HYlxblKyzGffOWwqKqq9DpU3qBzf9EWxWHML6OZnG8QLj78jsvag611sTY
        8UL4xuABKSTrt7QwT9mmX26GcW0Dagc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-9Ov8so-TNXeyvXUielGzFg-1; Mon, 21 Jun 2021 04:39:16 -0400
X-MC-Unique: 9Ov8so-TNXeyvXUielGzFg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BE561922035;
        Mon, 21 Jun 2021 08:39:15 +0000 (UTC)
Received: from T590 (ovpn-13-237.pek2.redhat.com [10.72.13.237])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 854A35DA2D;
        Mon, 21 Jun 2021 08:38:59 +0000 (UTC)
Date:   Mon, 21 Jun 2021 16:38:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [RFC PATCH V2 1/3] block: add helper of blk_queue_poll
Message-ID: <YNBQHq1hwytjvXyR@T590>
References: <20210617103549.930311-1-ming.lei@redhat.com>
 <20210617103549.930311-2-ming.lei@redhat.com>
 <20210621072036.GB6651@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621072036.GB6651@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 21, 2021 at 09:20:36AM +0200, Christoph Hellwig wrote:
> On Thu, Jun 17, 2021 at 06:35:47PM +0800, Ming Lei wrote:
> > There has been 3 users, and will be more, so add one such helper.
> > 
> > Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> > Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> I still don't like hiding a simple flag test like this, it just adds
> another step to grepping what is going on.

It is actually one pattern in block layer since there is so many such
macros of blk_queue_*. And it makes the check line shorter.


Thanks,
Ming

