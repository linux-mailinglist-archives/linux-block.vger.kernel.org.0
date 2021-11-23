Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6409C459915
	for <lists+linux-block@lfdr.de>; Tue, 23 Nov 2021 01:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhKWAUs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 22 Nov 2021 19:20:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36389 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231550AbhKWAUr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Nov 2021 19:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637626660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RjMwCURZYhH7uxbsg2k5Wuq2Rys5JGTRvwbIfrl7OJk=;
        b=ODmbdUt50MwVKX0pGGphkerPacu29P7X/7C8nJDK3h/5dqs5DztAric8nMSQ1MvUTg1IXS
        YwuNMilC/E7VIg7/2tl/ZcU2N6bTyeD/kxEISoIt7wzFmbPD7KgcN1EpT9zXEfNVjNMgLW
        MC5jjA4MZgIJi4Fdxs6UGzaJYd912Is=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-6l01jUTYMtefSNGTxcWa8A-1; Mon, 22 Nov 2021 19:17:36 -0500
X-MC-Unique: 6l01jUTYMtefSNGTxcWa8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 230E8423BA;
        Tue, 23 Nov 2021 00:17:35 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 565905FC25;
        Tue, 23 Nov 2021 00:17:24 +0000 (UTC)
Date:   Tue, 23 Nov 2021 08:17:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/5] blk-mq: add helper of blk_mq_global_quiesce_wait()
Message-ID: <YZwzEBtFug6JEmMZ@T590>
References: <20211119021849.2259254-1-ming.lei@redhat.com>
 <20211119021849.2259254-4-ming.lei@redhat.com>
 <8f6b6452-9abb-fd89-0262-9fb9d00d42a5@grimberg.me>
 <YZuagPbZJ6CjiUNi@T590>
 <38b9661e-c5b8-ae18-f2ab-b30f9d3e7115@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38b9661e-c5b8-ae18-f2ab-b30f9d3e7115@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 22, 2021 at 03:55:36PM +0200, Sagi Grimberg wrote:
> 
> > > > Add helper of blk_mq_global_quiesce_wait() for supporting to quiesce
> > > > queues in parallel, then we can just wait once if global quiesce wait
> > > > is allowed.
> > > 
> > > blk_mq_global_quiesce_wait() is a poor name... global is scope-less and
> > > obviously it has a scope.
> > 
> > How about blk_mq_shared_quiesce_wait()? or any suggestion?
> 
> Shared between what?

All request queues in one host-wide, both scsi and nvme has such
requirement.

> 
> Maybe if the queue has a non-blocking tagset, it can have a "quiesced"
> flag that is cleared in unquiesce? then the callers can just continue
> to iterate but will only wait the rcu grace period once.

Yeah, that is what these patches try to implement.


Thanks
Ming

