Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB4F275260
	for <lists+linux-block@lfdr.de>; Wed, 23 Sep 2020 09:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIWHli (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 23 Sep 2020 03:41:38 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2912 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726617AbgIWHli (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 03:41:38 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 88EF53A7164AE11C43F0;
        Wed, 23 Sep 2020 08:41:36 +0100 (IST)
Received: from [127.0.0.1] (10.47.2.162) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 23 Sep
 2020 08:41:35 +0100
Subject: Re: [PATCH V3 for 5.11 11/12] scsi: make sure sdev->queue_depth is <=
 shost->can_queue
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     Omar Sandoval <osandov@fb.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>
References: <20200923013339.1621784-1-ming.lei@redhat.com>
 <20200923013339.1621784-12-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5b229af8-520d-d3cf-caa0-5d3b11fa1083@huawei.com>
Date:   Wed, 23 Sep 2020 08:38:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200923013339.1621784-12-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.2.162]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 23/09/2020 02:33, Ming Lei wrote:
> Obviously scsi device's queue depth can't be > host's can_queue,
> so make it explicitely in scsi_change_queue_depth().

ha, why not can_queue * nr_hw_queues?

> 
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
> Cc: Ewan D. Milne <emilne@redhat.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/scsi/scsi.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index 24619c3bebd5..cc6ff1ae8c16 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -223,6 +223,8 @@ void scsi_finish_command(struct scsi_cmnd *cmd)
>    */
>   int scsi_change_queue_depth(struct scsi_device *sdev, int depth)
>   {
> +	depth = min_t(int, depth, sdev->host->can_queue);
> +
>   	if (depth > 0) {
>   		sdev->queue_depth = depth;
>   		wmb();
> 

