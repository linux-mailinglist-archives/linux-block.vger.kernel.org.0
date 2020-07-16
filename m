Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F6B222A30
	for <lists+linux-block@lfdr.de>; Thu, 16 Jul 2020 19:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgGPRnb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 Jul 2020 13:43:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:43046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728402AbgGPRna (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 13:43:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 97045AFBC;
        Thu, 16 Jul 2020 17:43:33 +0000 (UTC)
Subject: Re: [PATCH 3/4] block: use bd_prepare_to_claim directly in the loop
 driver
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org
References: <20200716143310.473136-1-hch@lst.de>
 <20200716143310.473136-4-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <c4cf5b9d-8776-fa9f-3844-f6025c14be32@suse.de>
Date:   Thu, 16 Jul 2020 19:43:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200716143310.473136-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/16/20 4:33 PM, Christoph Hellwig wrote:
> The arcane magic in bd_start_claiming is only needed to be able to claim
> a block_device that hasn't been fully set up.  Switch the loop driver
> that claims from the ioctl path with a fully set up struct block_device
> to just use the much simpler bd_prepare_to_claim directly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/loop.c   | 7 +++----
>   fs/block_dev.c         | 9 +++++----
>   include/linux/blkdev.h | 3 ++-
>   3 files changed, 10 insertions(+), 9 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
