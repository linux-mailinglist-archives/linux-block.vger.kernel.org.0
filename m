Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E94E38FC86
	for <lists+linux-block@lfdr.de>; Tue, 25 May 2021 10:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhEYIT4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 25 May 2021 04:19:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:59476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbhEYIT4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 May 2021 04:19:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1621930705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dx8Mp3xhIbC9s7UG8etfxN0DUmZKH5uLGFLLxpPpF5k=;
        b=IymtYxBd/wEomXEep83nc/rgBdMCvkjFvi0Pb3VwB43kQA3t6IEPjQXylOT5wYQ/UNRmmL
        43ny40FmOF/eLaRtZsXREkQ4fFxp5EDBtL/egvxW8mUvtyrQOlA1uW6WINlcAAj+wQugx/
        EfqaPh03/0yuSlZkpygKJMJyIGAJ3Ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1621930705;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dx8Mp3xhIbC9s7UG8etfxN0DUmZKH5uLGFLLxpPpF5k=;
        b=FaJrILtbZNsCTNOxN7pTJBozXaRRhC58JWUc7EKPEGNbX7MjJbFQWaVI8ACjsRBXR7lCpI
        y9GvtmRLf0yd7tAg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 75937AE1F;
        Tue, 25 May 2021 08:18:25 +0000 (UTC)
Subject: Re: [PATCH 4/8] block: move adjusting bd_part_count out of
 __blkdev_get
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20210525061301.2242282-1-hch@lst.de>
 <20210525061301.2242282-5-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e0927e9e-9bfc-45a7-5924-c0a0988d6fbe@suse.de>
Date:   Tue, 25 May 2021 10:18:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210525061301.2242282-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/25/21 8:12 AM, Christoph Hellwig wrote:
> Keep in the callers and thus remove the for_part argument.  This mirrors
> what is done on the blkdev_get side and slightly simplifies
> blkdev_get_part as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/block_dev.c | 16 +++++++---------
>   1 file changed, 7 insertions(+), 9 deletions(-)
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
