Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7EE222A5C
	for <lists+linux-block@lfdr.de>; Thu, 16 Jul 2020 19:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgGPRsC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 Jul 2020 13:48:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:44330 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgGPRsC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 13:48:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8A82ADD6;
        Thu, 16 Jul 2020 17:48:04 +0000 (UTC)
Subject: Re: [PATCH 4/4] block: integrate bd_start_claiming into __blkdev_get
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org
References: <20200716143310.473136-1-hch@lst.de>
 <20200716143310.473136-5-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <0f54d0a5-3315-6735-dca6-cc7aaf06626a@suse.de>
Date:   Thu, 16 Jul 2020 19:47:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200716143310.473136-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/16/20 4:33 PM, Christoph Hellwig wrote:
> bd_start_claiming duplicates a lot of the work done in __blkdev_get.
> Integrate the two functions to avoid the duplicate work, and to do the
> right thing for the md -ERESTARTSYS corner case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/block_dev.c | 177 +++++++++++++++----------------------------------
>   1 file changed, 55 insertions(+), 122 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
