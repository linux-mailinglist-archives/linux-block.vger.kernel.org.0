Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA39E72E3F9
	for <lists+linux-block@lfdr.de>; Tue, 13 Jun 2023 15:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242309AbjFMNVf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 13 Jun 2023 09:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbjFMNVe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 09:21:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BF2196
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2023 06:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686662452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4h5WtWuafa3HQI+R1L+tq078+xSXnWdHqUJjJ8pE/wc=;
        b=OAs7xmOydm7QRuOx0isG/bx4YxI8UbvOl98odkJQ4Ipu/oTo1XUEiKI4KgLW2kP9BtHjso
        nl4eSwVJ1JwG0lWrFEhMl0UXTvTaLNqqAJMdWUdstQ+RrK/U63imyIj1AFaH5963KCZGtT
        mSDuFw5pwtzR/KKEJ3Dcz1jFHs56Too=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-CUvZC2KsNK2eQSqSgLGyOg-1; Tue, 13 Jun 2023 09:20:49 -0400
X-MC-Unique: CUvZC2KsNK2eQSqSgLGyOg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94BCF1C0515D;
        Tue, 13 Jun 2023 13:20:48 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E4DF492C1B;
        Tue, 13 Jun 2023 13:20:44 +0000 (UTC)
Date:   Tue, 13 Jun 2023 21:20:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH 2/2] nvme: don't freeze/unfreeze queues from different
 contexts
Message-ID: <ZIhtJ3PjJYMWXS04@ovpn-8-16.pek2.redhat.com>
References: <20230613005847.1762378-1-ming.lei@redhat.com>
 <20230613005847.1762378-3-ming.lei@redhat.com>
 <c850f479-36b9-3478-6400-95faea095467@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c850f479-36b9-3478-6400-95faea095467@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 13, 2023 at 04:13:42PM +0300, Sagi Grimberg wrote:
> 
> > For block layer freeze/unfreeze APIs, the caller is required to call the
> > two in strict pair, so most of users simply call them from same context,
> > and everything works just fine.
> > 
> > For NVMe, the two are done from different contexts, this way has caused
> > all kinds of IO hang issue, such as:
> > 
> > 1) When io queue connect fails, this controller is deleted without being
> > marked as DEAD. Upper layer may wait forever in __bio_queue_enter(), because
> > in del_gendisk(), disk won't be marked as DEAD unless bdev sync & invalidate
> > returns. If any writeback IO waits in __bio_queue_enter(), IO deadlock is
> > caused. Reported from Yi Zhang.
> > 
> > 2) error recovering vs. namespace deletiong, if any IO originated from
> > scan work is waited in __bio_queue_enter(), flushing scan work hangs for
> > ever in nvme_remove_namespaces() because controller is left as frozen
> > when error recovery is interrupted by controller removal. Reported from
> > Chunguang.
> > 
> > Fix the issue by calling the two in same context just when reset is done
> > and not starting freeze from beginning of error recovery. Not only IO hang
> > is solved, correctness of freeze & unfreeze is respected.
> > 
> > And this way is correct because quiesce is enough for driver to handle
> > error recovery. The only difference is where to wait during error recovery.
> > With this way, IO is just queued in block layer queue instead of
> > __bio_queue_enter(), finally waiting for completion is done in upper
> > layer. Either way, IO can't move on during error recovery.
> > 
> > Reported-by: Chunguang Xu <brookxu.cn@gmail.com>
> > Closes: https://lore.kernel.org/linux-nvme/cover.1685350577.git.chunguang.xu@shopee.com/
> > Reported-by: Yi Zhang <yi.zhang@redhat.com>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >   drivers/nvme/host/core.c | 4 +---
> >   drivers/nvme/host/pci.c  | 8 +++++---
> >   drivers/nvme/host/rdma.c | 3 ++-
> >   drivers/nvme/host/tcp.c  | 3 ++-
> >   4 files changed, 10 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 4ef5eaecaa75..d5d9b6f6ec74 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -4707,10 +4707,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
> >   	 * removing the namespaces' disks; fail all the queues now to avoid
> >   	 * potentially having to clean up the failed sync later.
> >   	 */
> > -	if (ctrl->state == NVME_CTRL_DEAD) {
> > +	if (ctrl->state == NVME_CTRL_DEAD)
> >   		nvme_mark_namespaces_dead(ctrl);
> > -		nvme_unquiesce_io_queues(ctrl);
> > -	}
> 
> Shouldn't this be in the next patch? Not sure what
> this helps in this patch? It is not clearly documented
> in the commit msg.

oops, good catch, will fix it in V2.

> 
> >   	/* this is a no-op when called from the controller reset handler */
> >   	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 492f319ebdf3..5d775b76baca 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2578,14 +2578,15 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
> >   	dead = nvme_pci_ctrl_is_dead(dev);
> >   	if (dev->ctrl.state == NVME_CTRL_LIVE ||
> >   	    dev->ctrl.state == NVME_CTRL_RESETTING) {
> > -		if (pci_is_enabled(pdev))
> > -			nvme_start_freeze(&dev->ctrl);
> >   		/*
> >   		 * Give the controller a chance to complete all entered requests
> >   		 * if doing a safe shutdown.
> >   		 */
> > -		if (!dead && shutdown)
> > +		if (!dead && shutdown & pci_is_enabled(pdev)) {
> > +			nvme_start_freeze(&dev->ctrl);
> >   			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
> > +			nvme_unfreeze(&dev->ctrl);
> > +		}
> 
> I'd split out the pci portion, it is not related to the reported issue,

Yes.

> and it is structured differently than the fabrics transports (as for now
> at least).

The above change needs to be done in this patch given the same pattern
needs to remove the above 'if (pci_is_enabled(pdev)) nvme_start_freeze()'.

> 
> >   	}
> >   	nvme_quiesce_io_queues(&dev->ctrl);
> > @@ -2740,6 +2741,7 @@ static void nvme_reset_work(struct work_struct *work)
> >   	 * controller around but remove all namespaces.
> >   	 */
> >   	if (dev->online_queues > 1) {
> > +		nvme_start_freeze(&dev->ctrl);
> >   		nvme_unquiesce_io_queues(&dev->ctrl);
> >   		nvme_wait_freeze(&dev->ctrl);
> >   		nvme_pci_update_nr_queues(dev);
> > diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> > index 0eb79696fb73..354cce8853c1 100644
> > --- a/drivers/nvme/host/rdma.c
> > +++ b/drivers/nvme/host/rdma.c
> > @@ -918,6 +918,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
> >   		goto out_cleanup_tagset;
> >   	if (!new) {
> > +		nvme_start_freeze(&ctrl->ctrl);
> >   		nvme_unquiesce_io_queues(&ctrl->ctrl);
> >   		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
> >   			/*
> > @@ -926,6 +927,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
> >   			 * to be safe.
> >   			 */
> >   			ret = -ENODEV;
> > +			nvme_unfreeze(&ctrl->ctrl);
> 
> What does this unfreeze designed to do?

It is for undoing the previous nvme_start_freeze.


Thanks,
Ming

