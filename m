Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2604F34C3E7
	for <lists+linux-block@lfdr.de>; Mon, 29 Mar 2021 08:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhC2Geu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 29 Mar 2021 02:34:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:35900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230305AbhC2Gen (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Mar 2021 02:34:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D36EAB13D;
        Mon, 29 Mar 2021 06:34:41 +0000 (UTC)
Subject: Re: [PATCH 7/8] block: refactor the bounce buffering code
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Khalid Aziz <khalid@gonehiking.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Ondrej Zary <linux@rainbow-software.org>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20210326055822.1437471-1-hch@lst.de>
 <20210326055822.1437471-8-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <5bf65977-046f-41b3-de54-f72d235b753d@suse.de>
Date:   Mon, 29 Mar 2021 08:34:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210326055822.1437471-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/26/21 6:58 AM, Christoph Hellwig wrote:
> Get rid of all the PFN arithmetics and just use an enum for the two
> remaining options, and use PageHighMem for the actual bounce decision.
> 
> Add a fast path to entirely avoid the call for the common case of a queue
> not using the legacy bouncing code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c       |  6 ++----
>  block/blk-settings.c   | 42 ++++++++----------------------------------
>  block/blk.h            | 16 ++++++++++++----
>  block/bounce.c         | 35 +++++------------------------------
>  include/linux/blkdev.h | 29 +++++++++++------------------
>  5 files changed, 38 insertions(+), 90 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
