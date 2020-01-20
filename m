Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF7A142814
	for <lists+linux-block@lfdr.de>; Mon, 20 Jan 2020 11:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgATKRp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 20 Jan 2020 05:17:45 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2284 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726621AbgATKRp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jan 2020 05:17:45 -0500
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 430547EA414141BA4666;
        Mon, 20 Jan 2020 10:17:43 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml705-cah.china.huawei.com (10.201.108.46) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 20 Jan 2020 10:17:42 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 20 Jan
 2020 10:17:42 +0000
Subject: Re: [PATCH 2/6] scsi: remove .for_blk_mq
To:     Ming Lei <ming.lei@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "Sathya Prakash" <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Jason Yan <yanaijie@huawei.com>
References: <20200119071432.18558-1-ming.lei@redhat.com>
 <20200119071432.18558-3-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <95a902c4-287a-eb23-dc5f-d3a66dff2289@huawei.com>
Date:   Mon, 20 Jan 2020 10:17:41 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200119071432.18558-3-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19/01/2020 07:14, Ming Lei wrote:
> No one use it any more, so remove the flag.
> 
> Cc: Sathya Prakash <sathya.prakash@broadcom.com>
> Cc: Chaitra P B <chaitra.basappa@broadcom.com>
> Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: Sumit Saxena <sumit.saxena@broadcom.com>
> Cc: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> Cc: Ewan D. Milne <emilne@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>,
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

I think that we can also delete drivers/scsi/scsi.c:scsi_use_blk_mq.

IIRC, a patch was already sent for that but never picked up.

Thanks,
John

> ---
>   drivers/scsi/virtio_scsi.c | 1 -
>   include/scsi/scsi_host.h   | 3 ---
>   2 files changed, 4 deletions(-)
> 
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index bfec84aacd90..0e0910c5b942 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -742,7 +742,6 @@ static struct scsi_host_template virtscsi_host_template = {
>   	.dma_boundary = UINT_MAX,
>   	.map_queues = virtscsi_map_queues,
>   	.track_queue_depth = 1,
> -	.force_blk_mq = 1,
>   };
>   
>   #define virtscsi_config_get(vdev, fld) \
> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
> index f577647bf5f2..7a97fb8104cf 100644
> --- a/include/scsi/scsi_host.h
> +++ b/include/scsi/scsi_host.h
> @@ -426,9 +426,6 @@ struct scsi_host_template {
>   	/* True if the controller does not support WRITE SAME */
>   	unsigned no_write_same:1;
>   
> -	/* True if the low-level driver supports blk-mq only */
> -	unsigned force_blk_mq:1;
> -
>   	/*
>   	 * Countdown for host blocking with no commands outstanding.
>   	 */
> 

