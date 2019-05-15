Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9FA1E8C2
	for <lists+linux-block@lfdr.de>; Wed, 15 May 2019 09:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbfEOHIK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 May 2019 03:08:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:50772 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbfEOHIK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 May 2019 03:08:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC52DAE1B;
        Wed, 15 May 2019 07:08:08 +0000 (UTC)
Subject: Re: [PATCH] block: Don't revalidate bdev of hidden gendisk
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20190515065740.12397-1-jack@suse.cz>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <1874efef-5b45-8fab-8d65-da3825433071@suse.de>
Date:   Wed, 15 May 2019 09:08:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515065740.12397-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/15/19 8:57 AM, Jan Kara wrote:
> When hidden gendisk is revalidated, there's no point in revalidating
> associated block device as there's none. We would thus just create new
> bdev inode, report "detected capacity change from 0 to XXX" message and
> evict the bdev inode again. Avoid this pointless dance and confusing
> message in the kernel log.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>   fs/block_dev.c | 25 ++++++++++++++++---------
>   1 file changed, 16 insertions(+), 9 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
