Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E6F222A17
	for <lists+linux-block@lfdr.de>; Thu, 16 Jul 2020 19:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgGPRkk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 Jul 2020 13:40:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:42350 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbgGPRkj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 13:40:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E1D2CB8B4;
        Thu, 16 Jul 2020 17:40:41 +0000 (UTC)
Subject: Re: [PATCH 1/4] block: simplify the restart case in __blkdev_get
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org
References: <20200716143310.473136-1-hch@lst.de>
 <20200716143310.473136-2-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <bdc0b3fa-4f36-e408-e68e-21d6e1aa7b35@suse.de>
Date:   Thu, 16 Jul 2020 19:40:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200716143310.473136-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/16/20 4:33 PM, Christoph Hellwig wrote:
> Insted of duplicating all the cleanup logic jump to the code that cleans
> up anyway, and restart after that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/block_dev.c | 25 ++++++++++---------------
>   1 file changed, 10 insertions(+), 15 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
