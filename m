Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1D734C3D3
	for <lists+linux-block@lfdr.de>; Mon, 29 Mar 2021 08:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhC2GdK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 29 Mar 2021 02:33:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:35158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229630AbhC2Gcx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Mar 2021 02:32:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 35C1CB32A;
        Mon, 29 Mar 2021 06:32:52 +0000 (UTC)
Subject: Re: [PATCH 6/8] block: remove BLK_BOUNCE_ISA support
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Khalid Aziz <khalid@gonehiking.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Ondrej Zary <linux@rainbow-software.org>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20210326055822.1437471-1-hch@lst.de>
 <20210326055822.1437471-7-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <075e251a-3a50-a9c9-026d-438d2e031ecd@suse.de>
Date:   Mon, 29 Mar 2021 08:32:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210326055822.1437471-7-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/26/21 6:58 AM, Christoph Hellwig wrote:
> Remove the BLK_BOUNCE_ISA support now that all users are gone.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio-integrity.c     |   3 +-
>  block/blk-map.c           |   4 +-
>  block/blk-settings.c      |  11 ----
>  block/blk.h               |   5 --
>  block/bounce.c            | 124 ++++++++------------------------------
>  block/scsi_ioctl.c        |   2 +-
>  drivers/ata/libata-scsi.c |   3 +-
>  include/linux/blkdev.h    |   7 ---
>  mm/Kconfig                |   9 ++-
>  9 files changed, 35 insertions(+), 133 deletions(-)
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
