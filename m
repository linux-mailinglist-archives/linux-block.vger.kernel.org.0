Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF54A201B3
	for <lists+linux-block@lfdr.de>; Thu, 16 May 2019 10:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfEPIuQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 May 2019 04:50:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:33368 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726383AbfEPIuQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 04:50:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6EB8FAEDB;
        Thu, 16 May 2019 08:50:15 +0000 (UTC)
Subject: Re: [PATCH 4/4] block: remove the bi_seg_{front,back}_size fields in
 struct bio
To:     Christoph Hellwig <hch@lst.de>, axboe@fb.com
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org
References: <20190516084058.20678-1-hch@lst.de>
 <20190516084058.20678-5-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <62f7fd1b-0174-ff87-19aa-46f12bb6f554@suse.de>
Date:   Thu, 16 May 2019 10:50:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516084058.20678-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/16/19 10:40 AM, Christoph Hellwig wrote:
> At this point these fields aren't used for anything, so we can remove
> them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-merge.c         | 94 +++++----------------------------------
>   include/linux/blk_types.h |  7 ---
>   2 files changed, 12 insertions(+), 89 deletions(-)
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
