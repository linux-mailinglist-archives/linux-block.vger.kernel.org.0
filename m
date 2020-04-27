Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172381B9729
	for <lists+linux-block@lfdr.de>; Mon, 27 Apr 2020 08:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgD0GRL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 27 Apr 2020 02:17:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:42660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbgD0GRL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 02:17:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 08024AC79;
        Mon, 27 Apr 2020 06:17:08 +0000 (UTC)
Subject: Re: [PATCH 3/7] cdrom: factor out a cdrom_read_tocentry helper
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20200425075706.721917-1-hch@lst.de>
 <20200425075706.721917-4-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <33e9ab6e-b444-0d54-cb4e-4b57595e5bf0@suse.de>
Date:   Mon, 27 Apr 2020 08:17:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200425075706.721917-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/25/20 9:57 AM, Christoph Hellwig wrote:
> Factor out a version of the CDROMREADTOCENTRY ioctl handler that can
> be called directly from kernel space.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   drivers/cdrom/cdrom.c | 39 ++++++++++++++++++++++-----------------
>   include/linux/cdrom.h |  3 +++
>   2 files changed, 25 insertions(+), 17 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
