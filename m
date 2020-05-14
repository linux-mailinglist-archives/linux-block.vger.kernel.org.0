Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1672D1D24A2
	for <lists+linux-block@lfdr.de>; Thu, 14 May 2020 03:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgENBZU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 May 2020 21:25:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58011 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgENBZT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 21:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589419518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z1+9U2mo7XrXKtxmMxvz9GZSgLghOpZ0z2oPFpap8Wc=;
        b=ZcYGI2IKj8kHNYD20qbFaQI8nQ9RZ0Wh7L6ZQqsakK+xsl9UPG1y1ahJN7J+CV0UhBk/Qx
        SGqPUatqyokAbmJGVGUPDdT/O8sC9ICdh66nHN5JwQ5cUD65FdGtjtDWgi9Qu+L7WYr2LP
        ftRB8M5YlglPEV0/dTLk12yaiUqRh/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-sMqWyK4XPhmGN2Rx2k8x8Q-1; Wed, 13 May 2020 21:25:16 -0400
X-MC-Unique: sMqWyK4XPhmGN2Rx2k8x8Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 619018014C0;
        Thu, 14 May 2020 01:25:15 +0000 (UTC)
Received: from T590 (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A04D6A977;
        Thu, 14 May 2020 01:25:09 +0000 (UTC)
Date:   Thu, 14 May 2020 09:25:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [PATCH 6/9] blk-mq: move code for handling partial dispatch into
 one helper
Message-ID: <20200514012505.GG2073570@T590>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
 <20200513095443.2038859-7-ming.lei@redhat.com>
 <20200513125656.GF23958@infradead.org>
 <20200513130100.GH23958@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513130100.GH23958@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 13, 2020 at 06:01:00AM -0700, Christoph Hellwig wrote:
> Btw, with the many arguments an more beeing added later I'm not sure

blk_mq_handle_partial_dispatch() is always inlined, and each parameter
has precise meaning, so IMO more parameters shouldn't be an issue.

> anymore if this is really worth a separate function or just if goto
> label at the end of blk_mq_dispatch_rq_list that can be jumped to,
> and which has the same amount of indentation is the better idea.
> 

There are more benefits in this way:

1) blk_mq_dispatch_rq_list() becomes more readable

2) name of blk_mq_handle_partial_dispatch() has document benefit.

3) it is easier to add new code into both blk_mq_dispatch_rq_list()
and blk_mq_handle_partial_dispatch(), same with changes on both two
functions.

4) easier to verify/review two small function

So IMO it is worth a separate function, especially blk_mq_dispatch_rq_list()
is becoming a big monster function.


Thanks,
Ming

