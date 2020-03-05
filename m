Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9720717A5B1
	for <lists+linux-block@lfdr.de>; Thu,  5 Mar 2020 13:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgCEMwG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 5 Mar 2020 07:52:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:60850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgCEMwG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Mar 2020 07:52:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C1DA3B2AF;
        Thu,  5 Mar 2020 12:52:04 +0000 (UTC)
Subject: Re: [PATCH RFC v6 05/10] blk-mq: Add support in
 hctx_tags_bitmap_show() for a shared sbitmap
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        ming.lei@redhat.com, bvanassche@acm.org, don.brace@microsemi.com,
        sumit.saxena@broadcom.com, hch@infradead.org,
        kashyap.desai@broadcom.com, shivasharan.srikanteshwara@broadcom.com
Cc:     chenxiang66@hisilicon.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, esc.storagedev@microsemi.com
References: <1583409280-158604-1-git-send-email-john.garry@huawei.com>
 <1583409280-158604-6-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <14a0a7ec-3d12-64ab-6c10-241cd117a3c4@suse.de>
Date:   Thu, 5 Mar 2020 13:52:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583409280-158604-6-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/5/20 12:54 PM, John Garry wrote:
> Since a set-wide shared tag sbitmap may be used, it is no longer valid to
> examine the per-hctx tagset for getting the active requests for a hctx
> (when a shared sbitmap is used).
> 
> As such, add support for the shared sbitmap by using an intermediate
> sbitmap per hctx, iterating all active tags for the specific hctx in the
> shared sbitmap.
> 
> Originally-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   block/blk-mq-debugfs.c | 57 ++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 55 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
