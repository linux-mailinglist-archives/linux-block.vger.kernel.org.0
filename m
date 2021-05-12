Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AB437C28F
	for <lists+linux-block@lfdr.de>; Wed, 12 May 2021 17:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhELPLz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 12 May 2021 11:11:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:36438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233460AbhELPJa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 11:09:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F2158B11D;
        Wed, 12 May 2021 15:08:20 +0000 (UTC)
Subject: Re: [PATCH v1 2/8] block: move disk announce work from
 register_disk() to a helper
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210512064629.13899-1-mcgrof@kernel.org>
 <20210512064629.13899-3-mcgrof@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e6ee9aa9-dda2-12a7-cbfa-9152aa4ca7b7@suse.de>
Date:   Wed, 12 May 2021 17:08:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210512064629.13899-3-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/21 8:46 AM, Luis Chamberlain wrote:
> This moves quite a bit of code which does one thing into a helper.
> We currently do not check for errors but we may decide that might
> be desirable later.
> 
> This also makes the code easier to read.
> 
> This change has no functional changes.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   block/genhd.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
