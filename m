Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3E13BA2F7
	for <lists+linux-block@lfdr.de>; Fri,  2 Jul 2021 17:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhGBP6V (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 2 Jul 2021 11:58:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22878 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231757AbhGBP6V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Jul 2021 11:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625241348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=508AyhKpE8jUDrBFR0nb6Agup3ldPNqzk6KlIwcdo6g=;
        b=LpvTfE/Xx+XxBOBEfTmUYI/QfsjpiHQc0Gu+BHHdR3yz83mUE4ooCVhgda5bWfcA1zOBTW
        xytcClIOyvL59dXXPT824g80VpkdOa4Jesx3/C9QvjSknNLBabkhiZnNXeUNvEjRA+6v1r
        dj9+KQW/eQiIvFkwdJ6vEK9nSAZeJMc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-JomhaFF6NAmtyieHslVtnA-1; Fri, 02 Jul 2021 11:55:47 -0400
X-MC-Unique: JomhaFF6NAmtyieHslVtnA-1
Received: by mail-wm1-f72.google.com with SMTP id k16-20020a7bc3100000b02901d849b41038so6401822wmj.7
        for <linux-block@vger.kernel.org>; Fri, 02 Jul 2021 08:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=508AyhKpE8jUDrBFR0nb6Agup3ldPNqzk6KlIwcdo6g=;
        b=mGBPHerdmQYiwm8J9nJWki6dyGKYK6mO80xVmaQi8QnRzznWRTqaOKP38mRND9+pxe
         LknqCK4mL9BkS6rnAk2RvibWLj9ouP0uUgPK9tnmBOUSfTITx4jUc+lNt0HzwUmP1/dk
         uxOo7mY1wCzyuqRESI3TQdH5W/0Ek8WZpDVhXq4NUtI2dJh0v7vD8sfsBXjg+NERMOdd
         NjPxXu4E80xy9GG3oUtENhk70m7v2G99t33s53UnmAW03XhegUglL2lDIUShEpXvikaU
         MSLxLHXovSJhOD210wCW1wJO4bc/nJUy7jEf/FGPXvFAE0vlp4HLgcYxFJol88dZj86q
         YEuw==
X-Gm-Message-State: AOAM533MadYxSSGM8smSTzRtv9LjLc23WqXPigxLPIyq7PGhyxjdg502
        +jyg16AQfy8W7IXr/rzJbq+HRC7WZfQ/FEOZXpTa/qhgAyfsZsDyAWrg6u2whEkvcZocg8yfjbq
        Y7SRUDuwDcVIwtPE0rSb31ng=
X-Received: by 2002:a1c:1dd1:: with SMTP id d200mr205140wmd.82.1625241346471;
        Fri, 02 Jul 2021 08:55:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5g/VM21EKC5p1b+bedRgUGipGzZg9oN5IehHhOj+/WVKmexFW92+hQHKujHlDSVZapekDzw==
X-Received: by 2002:a1c:1dd1:: with SMTP id d200mr205117wmd.82.1625241346342;
        Fri, 02 Jul 2021 08:55:46 -0700 (PDT)
Received: from redhat.com ([2.55.4.39])
        by smtp.gmail.com with ESMTPSA id n12sm4180006wmq.5.2021.07.02.08.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 08:55:45 -0700 (PDT)
Date:   Fri, 2 Jul 2021 11:55:40 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH V2 5/6] virtio: add one field into virtio_device for
 recording if device uses managed irq
Message-ID: <20210702115430-mutt-send-email-mst@kernel.org>
References: <20210702150555.2401722-1-ming.lei@redhat.com>
 <20210702150555.2401722-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702150555.2401722-6-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 02, 2021 at 11:05:54PM +0800, Ming Lei wrote:
> blk-mq needs to know if the device uses managed irq, so add one field
> to virtio_device for recording if device uses managed irq.
> 
> If the driver use managed irq, this flag has to be set so it can be
> passed to blk-mq.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>


The API seems somewhat confusing. virtio does not request
a managed irq as such, does it? I think it's a decision taken
by the irq core.

Any way to query the irq to find out if it's managed?


> ---
>  drivers/block/virtio_blk.c         | 2 ++
>  drivers/scsi/virtio_scsi.c         | 1 +
>  drivers/virtio/virtio_pci_common.c | 1 +
>  include/linux/virtio.h             | 1 +
>  4 files changed, 5 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index e4bd3b1fc3c2..33b9c80ac475 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -764,6 +764,8 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	vblk->tag_set.queue_depth = queue_depth;
>  	vblk->tag_set.numa_node = NUMA_NO_NODE;
>  	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
> +	if (vdev->use_managed_irq)
> +		vblk->tag_set.flags |= BLK_MQ_F_MANAGED_IRQ;
>  	vblk->tag_set.cmd_size =
>  		sizeof(struct virtblk_req) +
>  		sizeof(struct scatterlist) * sg_elems;
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index b9c86a7e3b97..f301917abc84 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -891,6 +891,7 @@ static int virtscsi_probe(struct virtio_device *vdev)
>  	shost->max_channel = 0;
>  	shost->max_cmd_len = VIRTIO_SCSI_CDB_SIZE;
>  	shost->nr_hw_queues = num_queues;
> +	shost->use_managed_irq = vdev->use_managed_irq;
>  
>  #ifdef CONFIG_BLK_DEV_INTEGRITY
>  	if (virtio_has_feature(vdev, VIRTIO_SCSI_F_T10_PI)) {
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 222d630c41fc..f2ac48fb477b 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -128,6 +128,7 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
>  	if (desc) {
>  		flags |= PCI_IRQ_AFFINITY;
>  		desc->pre_vectors++; /* virtio config vector */
> +		vdev->use_managed_irq = true;
>  	}
>  
>  	err = pci_alloc_irq_vectors_affinity(vp_dev->pci_dev, nvectors,
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index b1894e0323fa..85cc773b2dc7 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -109,6 +109,7 @@ struct virtio_device {
>  	bool failed;
>  	bool config_enabled;
>  	bool config_change_pending;
> +	bool use_managed_irq;
>  	spinlock_t config_lock;
>  	struct device dev;
>  	struct virtio_device_id id;
> -- 
> 2.31.1

