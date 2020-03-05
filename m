Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2D317A57D
	for <lists+linux-block@lfdr.de>; Thu,  5 Mar 2020 13:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgCEMnF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 5 Mar 2020 07:43:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:55900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgCEMnF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Mar 2020 07:43:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D9B7AB29D;
        Thu,  5 Mar 2020 12:43:00 +0000 (UTC)
Subject: Re: [PATCH RFC v6 03/10] blk-mq: Use pointers for blk_mq_tags bitmap
 tags
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        ming.lei@redhat.com, bvanassche@acm.org, don.brace@microsemi.com,
        sumit.saxena@broadcom.com, hch@infradead.org,
        kashyap.desai@broadcom.com, shivasharan.srikanteshwara@broadcom.com
Cc:     chenxiang66@hisilicon.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, esc.storagedev@microsemi.com
References: <1583409280-158604-1-git-send-email-john.garry@huawei.com>
 <1583409280-158604-4-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <8afbcdb5-6f22-931e-f11d-a1fcaec46130@suse.de>
Date:   Thu, 5 Mar 2020 13:42:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583409280-158604-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/5/20 12:54 PM, John Garry wrote:
> Introduce pointers for the blk_mq_tags regular and reserved bitmap tags,
> with the goal of later being able to use a common shared tag bitmap across
> all HW contexts in a set.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   block/bfq-iosched.c    |  4 ++--
>   block/blk-mq-debugfs.c |  8 ++++----
>   block/blk-mq-tag.c     | 41 ++++++++++++++++++++++-------------------
>   block/blk-mq-tag.h     |  7 +++++--
>   block/blk-mq.c         |  4 ++--
>   block/kyber-iosched.c  |  4 ++--
>   6 files changed, 37 insertions(+), 31 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
