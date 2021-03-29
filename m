Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7608C34C3BE
	for <lists+linux-block@lfdr.de>; Mon, 29 Mar 2021 08:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhC2GWX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 29 Mar 2021 02:22:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:59824 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhC2GWC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Mar 2021 02:22:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 199CDB32A;
        Mon, 29 Mar 2021 06:22:01 +0000 (UTC)
Subject: Re: [PATCH 1/8] aha1542: use a local bounce buffer
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Khalid Aziz <khalid@gonehiking.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Ondrej Zary <linux@rainbow-software.org>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20210326055822.1437471-1-hch@lst.de>
 <20210326055822.1437471-2-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <658eb950-d675-77c6-c3b6-fb9c23aff716@suse.de>
Date:   Mon, 29 Mar 2021 08:22:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210326055822.1437471-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/26/21 6:58 AM, Christoph Hellwig wrote:
> To remove the last user of the unchecked_isa_dma flag and thus the block
> layer ISA bounce buffering switch this driver to use its own local bounce
> buffer.  This has the effect of not needing the chain indirection and
> supporting and unlimited number of segments.  It does however limit the
> transfer size for each command to something that can be reasonable
> allocated by dma_alloc_coherent like 8K.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/scsi/aha1542.c | 105 ++++++++++++++++++++++-------------------
>  1 file changed, 57 insertions(+), 48 deletions(-)
> 
I doubt anyone will notice the reduced transfer size; these things are
slow anyway :-)

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
