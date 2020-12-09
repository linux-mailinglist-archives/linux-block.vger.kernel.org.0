Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680972D3C64
	for <lists+linux-block@lfdr.de>; Wed,  9 Dec 2020 08:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgLIHfM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 9 Dec 2020 02:35:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:36480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbgLIHfI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Dec 2020 02:35:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7F7CAACC6;
        Wed,  9 Dec 2020 07:34:26 +0000 (UTC)
Subject: Re: [PATCH v5 5/8] scsi_transport_spi: Set RQF_PM for domain
 validation commands
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Woody Suwalski <terraluna977@gmail.com>,
        Can Guo <cang@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Stan Johnson <userm57@yahoo.com>
References: <20201209052951.16136-1-bvanassche@acm.org>
 <20201209052951.16136-6-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <7e4cc6ea-7f49-8fc0-f5d7-848c24419e31@suse.de>
Date:   Wed, 9 Dec 2020 08:34:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201209052951.16136-6-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/9/20 6:29 AM, Bart Van Assche wrote:
> Disable runtime power management during domain validation. Since a later
> patch removes RQF_PREEMPT, set RQF_PM for domain validation commands such
> that these are executed in the quiesced SCSI device state.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Woody Suwalski <terraluna977@gmail.com>
> Cc: Can Guo <cang@codeaurora.org>
> Cc: Stanley Chu <stanley.chu@mediatek.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/scsi/scsi_transport_spi.c | 27 +++++++++++++++++++--------
>   1 file changed, 19 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
