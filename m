Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1E9520B98
	for <lists+linux-block@lfdr.de>; Tue, 10 May 2022 04:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbiEJDCO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 9 May 2022 23:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbiEJDCN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 May 2022 23:02:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 601C8285EFD
        for <linux-block@vger.kernel.org>; Mon,  9 May 2022 19:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652151496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VfThjiwVEwPrOow8FSqurh9iv72UgtJ9TH9+GAaixz4=;
        b=ahnyPMsjDrLloTlEE0W036x84UvBiOlYkpNS2roNTdnLKwTfcvZb3H8fpIn4UlN36+1qxx
        GkaNzX6uX2nkEMvsrMN9AoO2nEQqlvK5PSKGxaqEXz7IbaXbESakXpxivUEd6n/UXaC/F8
        HsmwwqYIH+PFUwTxqMykA2NTMJxfdmc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-ANsr0xFJNlum0wru0cPDWQ-1; Mon, 09 May 2022 22:58:13 -0400
X-MC-Unique: ANsr0xFJNlum0wru0cPDWQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0B8129AB41E;
        Tue, 10 May 2022 02:58:12 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C15B940D2829;
        Tue, 10 May 2022 02:58:07 +0000 (UTC)
Date:   Tue, 10 May 2022 10:58:01 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: Re: [RFC PATCH] ubd: add io_uring based userspace block driver
Message-ID: <YnnUuZve2b2LmInc@T590>
References: <20220509092312.254354-1-ming.lei@redhat.com>
 <9c833e12-fd09-fe7d-d4f2-e916c6ce4524@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c833e12-fd09-fe7d-d4f2-e916c6ce4524@kernel.dk>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 09, 2022 at 10:09:10AM -0600, Jens Axboe wrote:
> On 5/9/22 3:23 AM, Ming Lei wrote:
> > This is the driver part of userspace block driver(ubd driver), the other
> > part is userspace daemon part(ubdsrv)[1].
> > 
> > The two parts communicate by io_uring's IORING_OP_URING_CMD with one
> > shared cmd buffer for storing io command, and the buffer is read only for
> > ubdsrv, each io command is indexed by io request tag directly, and
> > is written by ubd driver.
> > 
> > For example, when one READ io request is submitted to ubd block driver, ubd
> > driver stores the io command into cmd buffer first, then completes one
> > IORING_OP_URING_CMD for notifying ubdsrv, and the URING_CMD is issued to
> > ubd driver beforehand by ubdsrv for getting notification of any new io request,
> > and each URING_CMD is associated with one io request by tag.
> > 
> > After ubdsrv gets the io command, it translates and handles the ubd io
> > request, such as, for the ubd-loop target, ubdsrv translates the request
> > into same request on another file or disk, like the kernel loop block
> > driver. In ubdsrv's implementation, the io is still handled by io_uring,
> > and share same ring with IORING_OP_URING_CMD command. When the target io
> > request is done, the same IORING_OP_URING_CMD is issued to ubd driver for
> > both committing io request result and getting future notification of new
> > io request.
> > 
> > Another thing done by ubd driver is to copy data between kernel io
> > request and ubdsrv's io buffer:
> > 
> > 1) before ubsrv handles WRITE request, copy the request's data into
> > ubdsrv's userspace io buffer, so that ubdsrv can handle the write
> > request
> > 
> > 2) after ubsrv handles READ request, copy ubdsrv's userspace io buffer
> > into this READ request, then ubd driver can complete the READ request
> > 
> > Zero copy may be switched if mm is ready to support it.
> > 
> > ubd driver doesn't handle any logic of the specific user space driver,
> > so it should be small/simple enough.
> 
> This is pretty interesting! Just one small thing I noticed, since you
> want to make sure batching is Good Enough:
> 
> > +static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
> > +		const struct blk_mq_queue_data *bd)
> > +{
> > +	struct ubd_queue *ubq = hctx->driver_data;
> > +	struct request *rq = bd->rq;
> > +	struct ubd_io *io = &ubq->ios[rq->tag];
> > +	struct ubd_rq_data *data = blk_mq_rq_to_pdu(rq);
> > +	blk_status_t res;
> > +
> > +	if (ubq->aborted)
> > +		return BLK_STS_IOERR;
> > +
> > +	/* this io cmd slot isn't active, so have to fail this io */
> > +	if (WARN_ON_ONCE(!(io->flags & UBD_IO_FLAG_ACTIVE)))
> > +		return BLK_STS_IOERR;
> > +
> > +	/* fill iod to slot in io cmd buffer */
> > +	res = ubd_setup_iod(ubq, rq);
> > +	if (res != BLK_STS_OK)
> > +		return BLK_STS_IOERR;
> > +
> > +	blk_mq_start_request(bd->rq);
> > +
> > +	/* mark this cmd owned by ubdsrv */
> > +	io->flags |= UBD_IO_FLAG_OWNED_BY_SRV;
> > +
> > +	/*
> > +	 * clear ACTIVE since we are done with this sqe/cmd slot
> > +	 *
> > +	 * We can only accept io cmd in case of being not active.
> > +	 */
> > +	io->flags &= ~UBD_IO_FLAG_ACTIVE;
> > +
> > +	/*
> > +	 * run data copy in task work context for WRITE, and complete io_uring
> > +	 * cmd there too.
> > +	 *
> > +	 * This way should improve batching, meantime pinning pages in current
> > +	 * context is pretty fast.
> > +	 */
> > +	task_work_add(ubq->ubq_daemon, &data->work, TWA_SIGNAL);
> > +
> > +	return BLK_STS_OK;
> > +}
> 
> It'd be better to use bd->last to indicate what kind of signaling you
> need here. TWA_SIGNAL will force an immediate transition if the app is
> running in userspace, which may not be what you want. Also see:
> 
> https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.19/io_uring&id=e788be95a57a9bebe446878ce9bf2750f6fe4974
> 
> But regardless of signaling needed, you don't need it except if bd->last
> is true. Would need a commit_rqs() as well, but that's trivial.

Good point, I think we may add non-last request via task_work_add(TWA_NONE),
and only notify via TWA_SIGNAL_NO_IPI for bd->last.

> 
> More importantly, what prevents ubq->ubq_daemon from going away after
> it's been assigned? I didn't look at the details, but is this relying on
> io_uring being closed to cancel pending requests? That should work, but

I think no way can prevent ubq->ubq_daemon from being killed by 'kill -9',
even though ubdsrv has handled SIGTERM. That is why I suggest to add
one service for removing all ubd devices before shutdown:

https://github.com/ming1/ubdsrv/blob/devel/README

All the commands of UBD_IO_FETCH_REQ or UBD_IO_COMMIT_AND_FETCH_REQ have
been submitted to driver, I understand io_uring can't cancel them,
please correct me if it is wrong.

One solution I thought of is to use one watchdog to check if ubq->ubq_daemon
is dead, then abort whole device if yes. Or any suggestion?

> we need some way to ensure that ->ubq_daemon is always valid here.

Good catch.

get_task_struct() should be used for assigning ubq->ubq_daemon.



thanks,
Ming

