Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36DD91877E1
	for <lists+linux-block@lfdr.de>; Tue, 17 Mar 2020 03:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgCQCl3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 16 Mar 2020 22:41:29 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:23140 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726343AbgCQCl3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Mar 2020 22:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584412888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=57TLYf096cNbZro5W6SRKhJY1rLLrbuxcJRHBqezJMY=;
        b=iPLVc6J/BwRnJEJRUuyC1vzcBUNiPmMp8AUN1Px8Aw/q4lYsT6NbD4pH3jPTlidRCqrWiC
        wqlq1Glhut3yo2IsqX59KoV/0TA43z5SO6ElZwiT1/CSUem0mkgwig9TbVs0zpdTPfIjz1
        GVnV8ckLpyci6rX7/YS0EbjqmjhEMP4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-K6xeDi6cNh6RAwZKMc5pNg-1; Mon, 16 Mar 2020 22:41:25 -0400
X-MC-Unique: K6xeDi6cNh6RAwZKMc5pNg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DC301804544;
        Tue, 17 Mar 2020 02:41:24 +0000 (UTC)
Received: from ming.t460p (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 44D575D9C9;
        Tue, 17 Mar 2020 02:41:16 +0000 (UTC)
Date:   Tue, 17 Mar 2020 10:41:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Yufen Yu <yuyufen@huawei.com>, josef@toxicpanda.com,
        axboe@kernel.dk, linux-block@vger.kernel.org, nbd@other.debian.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nbd: make starting request more reasonable
Message-ID: <20200317024112.GD28478@ming.t460p>
References: <20200303130843.12065-1-yuyufen@huawei.com>
 <9cdba8b1-f0e5-a079-8d44-0078478dd4d8@huawei.com>
 <20200316153033.GA11016@ming.t460p>
 <20200316160227.GA1069861@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316160227.GA1069861@dhcp-10-100-145-180.wdl.wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 16, 2020 at 09:02:27AM -0700, Keith Busch wrote:
> On Mon, Mar 16, 2020 at 11:30:33PM +0800, Ming Lei wrote:
> > On Mon, Mar 16, 2020 at 08:26:35PM +0800, Yufen Yu wrote:
> > > > +	blk_mq_start_request(req);
> > > > +
> > > >   	if (req->cmd_flags & REQ_FUA)
> > > >   		nbd_cmd_flags |= NBD_CMD_FLAG_FUA;
> > > > @@ -879,7 +881,6 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
> > > >   	if (!refcount_inc_not_zero(&nbd->config_refs)) {
> > > >   		dev_err_ratelimited(disk_to_dev(nbd->disk),
> > > >   				    "Socks array is empty\n");
> > > > -		blk_mq_start_request(req);
> > 
> > I think it is fine to not start request in case of failure, given 
> > __blk_mq_end_request() doesn't check rq's state.
> 
> Not only is it fine to not start it, blk-mq expects the low level
> driver will not tell it to start a request that the lld doesn't
> actually start.

Yeah, in theory, driver should do in this way.

> A started request should be completed through
> blk_mq_complete_request(). Returning an error from your queue_rq()
> doesn't do that, and starting it will have blk-mq track the request as
> an in-flight request.

However, error still can happen when lld is starting to queue the command
to hardware, and there are lots of such usage in drivers. I guess this
way won't be avoided completely.


Thanks,
Ming

