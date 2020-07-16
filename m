Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57736221C7D
	for <lists+linux-block@lfdr.de>; Thu, 16 Jul 2020 08:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgGPGRQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 Jul 2020 02:17:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:46628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgGPGRP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 02:17:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2425FAC7C;
        Thu, 16 Jul 2020 06:17:18 +0000 (UTC)
Subject: Re: [PATCH v3 14/16] bcache: add sysfs file to display feature sets
 information of cache set
To:     colyli@suse.de, linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20200715143015.14957-1-colyli@suse.de>
 <20200715143015.14957-15-colyli@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <dd08f8dd-4818-7cb2-6151-f7315cc03755@suse.de>
Date:   Thu, 16 Jul 2020 08:17:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200715143015.14957-15-colyli@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/15/20 4:30 PM, colyli@suse.de wrote:
> From: Coly Li <colyli@suse.de>
> 
> A new sysfs file /sys/fs/bcache/<cache set UUID>/internal/feature_sets
> is added by this patch, to display feature sets information of the cache
> set.
> 
> Now only an incompat feature 'large_bucket' added in bcache, the sysfs
> file content is:
> 	feature_incompat: [large_bucket]
> string large_bucket means the running bcache drive supports incompat
> feature 'large_bucket', the wrapping [] means the 'large_bucket' feature
> is currently enabled on this cache set.
> 
> This patch is ready to display compat and ro_compat features, in future
> once bcache code implements such feature sets, the according feature
> strings will be displayed in this sysfs file too.
> 
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>   drivers/md/bcache/Makefile   |  2 +-
>   drivers/md/bcache/features.c | 48 ++++++++++++++++++++++++++++++++++++
>   drivers/md/bcache/features.h |  3 +++
>   drivers/md/bcache/sysfs.c    |  6 +++++
>   4 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/bcache/Makefile b/drivers/md/bcache/Makefile
> index fd714628da6a..5b87e59676b8 100644
> --- a/drivers/md/bcache/Makefile
> +++ b/drivers/md/bcache/Makefile
> @@ -4,4 +4,4 @@ obj-$(CONFIG_BCACHE)	+= bcache.o
>   
>   bcache-y		:= alloc.o bset.o btree.o closure.o debug.o extents.o\
>   	io.o journal.o movinggc.o request.o stats.o super.o sysfs.o trace.o\
> -	util.o writeback.o
> +	util.o writeback.o features.o
> diff --git a/drivers/md/bcache/features.c b/drivers/md/bcache/features.c
> index ba53944bb390..5c601635e11c 100644
> --- a/drivers/md/bcache/features.c
> +++ b/drivers/md/bcache/features.c
> @@ -8,6 +8,7 @@
>    */
>   #include <linux/bcache.h>
>   #include "bcache.h"
> +#include "features.h"
>   
>   struct feature {
>   	int		compat;
> @@ -20,3 +21,50 @@ static struct feature feature_list[] = {
>   		"large_bucket"},
>   	{0, 0, 0 },
>   };
> +
> +#define compose_feature_string(type, head)				\
> +({									\
> +	struct feature *f;						\
> +	bool first = true;						\
> +									\
> +	for (f = &feature_list[0]; f->compat != 0; f++) {		\
> +		if (f->compat != BCH_FEATURE_ ## type)			\
> +			continue;					\
> +		if (BCH_HAS_ ## type ## _FEATURE(&c->sb, f->mask)) {	\
> +			if (first) {					\
> +				out += snprintf(out, buf + size - out,	\
> +						"%s%s", head, ": [");	\
> +			} else {					\
> +				out += snprintf(out, buf + size - out,	\
> +						" [");			\
> +			}						\
> +		} else {						\
> +			if (first)					\
> +				out += snprintf(out, buf + size - out,	\
> +						"%s%s", head, ": ");	\
> +			else						\
> +				out += snprintf(out, buf + size - out,	\
> +						" ");			\
> +		}							\
> +									\
> +		out += snprintf(out, buf + size - out, "%s", f->string);\
> +									\
> +		if (BCH_HAS_ ## type ## _FEATURE(&c->sb, f->mask))	\
> +			out += snprintf(out, buf + size - out, "]");	\
> +									\
> +		first = false;						\
> +	}								\
> +	if (!first)							\
> +		out += snprintf(out, buf + size - out, "\n");		\
> +})
> +
> +int bch_print_cache_set_feature_set(struct cache_set *c, char *buf, int size)
> +{
> +	char *out = buf;
> +
> +	compose_feature_string(COMPAT, "feature_compat");
> +	compose_feature_string(RO_COMPAT, "feature_ro_compat");
> +	compose_feature_string(INCOMPAT, "feature_incompat");
> +
> +	return out - buf;
> +}
> diff --git a/drivers/md/bcache/features.h b/drivers/md/bcache/features.h
> index dca052cf5203..350a4f413136 100644
> --- a/drivers/md/bcache/features.h
> +++ b/drivers/md/bcache/features.h
> @@ -78,4 +78,7 @@ static inline void bch_clear_feature_##name(struct cache_sb *sb) \
>   }
>   
>   BCH_FEATURE_INCOMPAT_FUNCS(large_bucket, LARGE_BUCKET);
> +
> +int bch_print_cache_set_feature_set(struct cache_set *c, char *buf, int size);
> +
>   #endif
> diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
> index 0dadec5a78f6..e3633f06d43b 100644
> --- a/drivers/md/bcache/sysfs.c
> +++ b/drivers/md/bcache/sysfs.c
> @@ -11,6 +11,7 @@
>   #include "btree.h"
>   #include "request.h"
>   #include "writeback.h"
> +#include "features.h"
>   
>   #include <linux/blkdev.h>
>   #include <linux/sort.h>
> @@ -88,6 +89,7 @@ read_attribute(btree_used_percent);
>   read_attribute(average_key_size);
>   read_attribute(dirty_data);
>   read_attribute(bset_tree_stats);
> +read_attribute(feature_sets);
>   
>   read_attribute(state);
>   read_attribute(cache_read_races);
> @@ -779,6 +781,9 @@ SHOW(__bch_cache_set)
>   	if (attr == &sysfs_bset_tree_stats)
>   		return bch_bset_print_stats(c, buf);
>   
> +	if (attr == &sysfs_feature_sets)
> +		return bch_print_cache_set_feature_set(c, buf, PAGE_SIZE);
> +
>   	return 0;
>   }
>   SHOW_LOCKED(bch_cache_set)
> @@ -987,6 +992,7 @@ static struct attribute *bch_cache_set_internal_files[] = {
>   	&sysfs_io_disable,
>   	&sysfs_cutoff_writeback,
>   	&sysfs_cutoff_writeback_sync,
> +	&sysfs_feature_sets,
>   	NULL
>   };
>   KTYPE(bch_cache_set_internal);
> 
Tsk.

sysfs attributes should be one value only, not some string declaring 
several things at once.
Why not adding two attributes (features_compat and features_incompat), 
listing each feature?
That would even easier to implement.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
