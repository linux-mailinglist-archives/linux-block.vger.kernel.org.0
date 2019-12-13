Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0786811E13C
	for <lists+linux-block@lfdr.de>; Fri, 13 Dec 2019 10:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfLMJzi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 13 Dec 2019 04:55:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:50212 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725799AbfLMJzi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 04:55:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 671E6B291;
        Fri, 13 Dec 2019 09:55:36 +0000 (UTC)
Subject: Re: [PATCH] virtio-blk: remove VIRTIO_BLK_F_SCSI support
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, mst@redhat.com,
        jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com
Cc:     linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20191212163719.28432-1-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <f6b110d8-2f13-94e9-0b11-92e2c103f7d6@suse.de>
Date:   Fri, 13 Dec 2019 10:55:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191212163719.28432-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/12/19 5:37 PM, Christoph Hellwig wrote:
> Since the need for a special flag to support SCSI passthrough on a
> block device was added in May 2017 the SCSI passthrough support in
> virtio-blk has been disabled.  It has always been a bad idea
> (just ask the original author..) and we have virtio-scsi for proper
> passthrough.  The feature also never made it into the virtio 1.0
> or later specifications.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/powerpc/configs/guest.config |   1 -
>   drivers/block/Kconfig             |  10 ---
>   drivers/block/virtio_blk.c        | 115 +-----------------------------
>   3 files changed, 1 insertion(+), 125 deletions(-)
> 
I'm all for it.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
