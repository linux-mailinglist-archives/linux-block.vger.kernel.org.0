Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EF1245C68
	for <lists+linux-block@lfdr.de>; Mon, 17 Aug 2020 08:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgHQGX3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 17 Aug 2020 02:23:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:45940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgHQGX2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 02:23:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8920AAD7D;
        Mon, 17 Aug 2020 06:23:51 +0000 (UTC)
Subject: Re: [PATCH 10/14] bcache: don't check seq numbers in
 register_cache_set()
To:     Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20200815041043.45116-1-colyli@suse.de>
 <20200815041043.45116-11-colyli@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <2b340343-6354-af11-6fdb-3c730efc4524@suse.de>
Date:   Mon, 17 Aug 2020 08:23:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200815041043.45116-11-colyli@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/15/20 6:10 AM, Coly Li wrote:
> In order to update the partial super block of cache set, the seq numbers
> of cache and cache set are checked in register_cache_set(). If cache's
> seq number is larger than cache set's seq number, cache set must update
> its partial super block from cache's super block. It is unncessary when
> the embedded struct cache_sb is removed from struct cache set.
> 
> This patch removed the seq numbers checking from register_cache_set(),
> because later there will be no such partial super block in struct cache
> set, the cache set will directly reference in-memory super block from
> struct cache. This is a preparation patch for removing embedded struct
> cache_sb from struct cache_set.
> 
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>   drivers/md/bcache/super.c | 15 ---------------
>   1 file changed, 15 deletions(-)
> 
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 05c5a7e867bb..4ba713d0d9b0 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -2160,21 +2160,6 @@ static const char *register_cache_set(struct cache *ca)
>   	    sysfs_create_link(&c->kobj, &ca->kobj, buf))
>   		goto err;
>   
> -	/*
> -	 * A special case is both ca->sb.seq and c->sb.seq are 0,
> -	 * such condition happens on a new created cache device whose
> -	 * super block is never flushed yet. In this case c->sb.version
> -	 * and other members should be updated too, otherwise we will
> -	 * have a mistaken super block version in cache set.
> -	 */
> -	if (ca->sb.seq > c->sb.seq || c->sb.seq == 0) {
> -		c->sb.version		= ca->sb.version;
> -		memcpy(c->set_uuid, ca->sb.set_uuid, 16);
> -		c->sb.flags             = ca->sb.flags;
> -		c->sb.seq		= ca->sb.seq;
> -		pr_debug("set version = %llu\n", c->sb.version);
> -	}
> -
>   	kobject_get(&ca->kobj);
>   	ca->set = c;
>   	ca->set->cache = ca;
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
