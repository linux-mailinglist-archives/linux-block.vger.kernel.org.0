Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73DA3B01A9
	for <lists+linux-block@lfdr.de>; Tue, 22 Jun 2021 12:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhFVKrR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Jun 2021 06:47:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45992 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhFVKrR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 06:47:17 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ECEE721966;
        Tue, 22 Jun 2021 10:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624358701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fgx0a56LQ8zDFxW0oGAluqETRSqHSvG6Pv9/WQPIZOc=;
        b=C0Jz/KjcxG83S7zbJ6xduErSgsCdAhN3qMYB3dNz8E7EHf41h0wBsCTCC8pbja5pN8BDx3
        4LmLZV9sHH/BPr1vuCkH5xscpX+FoQK/N83B4MWkq7i31i0EjAAYPAjwqpCE1cduBYaZVH
        unF5eyAG6cpe+szXuFcavXJfI6ZWPrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624358701;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fgx0a56LQ8zDFxW0oGAluqETRSqHSvG6Pv9/WQPIZOc=;
        b=y6eLZ3W6WKzNG1az+uqFoYDY3k1c26BLJYQXm+Xhm7yZOHpPZwwXVSlrrKWBRsgF/3/h05
        QbkckU9L311qxUDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id D28ED118DD;
        Tue, 22 Jun 2021 10:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624358700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fgx0a56LQ8zDFxW0oGAluqETRSqHSvG6Pv9/WQPIZOc=;
        b=xO20gLXru4XLae4Z8Z/10yMWkYT/JbtEzpXphYcxo2n8yQJLAjZSJD97DAQnD5/jO2jv+w
        s+dqOdR9StxUH1231w2Ao2zQwjxgGnFD7QAuRwB67vok8siHwh4uP/aZvmULyieXlzhS6W
        zF64ppiXPVZEe53/9fDYNk1cbrIPiHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624358700;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fgx0a56LQ8zDFxW0oGAluqETRSqHSvG6Pv9/WQPIZOc=;
        b=6SNTPbtumd5RTVMPKS8/7bWbfPFpat6hkSW9ppld6I0UH3TejIY7xqB9JBuFsjSElrIxyI
        3+ALjqkrkc4fJRCg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id O7UnMyy/0WAWVgAALh3uQQ
        (envelope-from <hare@suse.de>); Tue, 22 Jun 2021 10:45:00 +0000
To:     Coly Li <colyli@suse.de>, axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Qiaowei Ren <qiaowei.ren@intel.com>
References: <20210615054921.101421-1-colyli@suse.de>
 <20210615054921.101421-6-colyli@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 05/14] bcache: initialization of the buddy
Message-ID: <bfa10634-b144-e180-c66a-5bf839c5ce71@suse.de>
Date:   Tue, 22 Jun 2021 12:45:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210615054921.101421-6-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/15/21 7:49 AM, Coly Li wrote:
> From: Jianpeng Ma <jianpeng.ma@intel.com>
> 
> This nvm pages allocator will implement the simple buddy to manage the
> nvm address space. This patch initializes this buddy for new namespace.
> 
Please use 'buddy allocator' instead of just 'buddy'.

> the unit of alloc/free of the buddy is page. DAX device has their
> struct page(in dram or PMEM).
> 
>         struct {        /* ZONE_DEVICE pages */
>                 /** @pgmap: Points to the hosting device page map. */
>                 struct dev_pagemap *pgmap;
>                 void *zone_device_data;
>                 /*
>                  * ZONE_DEVICE private pages are counted as being
>                  * mapped so the next 3 words hold the mapping, index,
>                  * and private fields from the source anonymous or
>                  * page cache page while the page is migrated to device
>                  * private memory.
>                  * ZONE_DEVICE MEMORY_DEVICE_FS_DAX pages also
>                  * use the mapping, index, and private fields when
>                  * pmem backed DAX files are mapped.
>                  */
>         };
> 
> ZONE_DEVICE pages only use pgmap. Other 4 words[16/32 bytes] don't use.
> So the second/third word will be used as 'struct list_head ' which list
> in buddy. The fourth word(that is normal struct page::index) store pgoff
> which the page-offset in the dax device. And the fifth word (that is
> normal struct page::private) store order of buddy. page_type will be used
> to store buddy flags.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
> Co-developed-by: Qiaowei Ren <qiaowei.ren@intel.com>
> Signed-off-by: Qiaowei Ren <qiaowei.ren@intel.com>
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>  drivers/md/bcache/nvm-pages.c   | 156 +++++++++++++++++++++++++++++++-
>  drivers/md/bcache/nvm-pages.h   |   6 ++
>  include/uapi/linux/bcache-nvm.h |  10 +-
>  3 files changed, 165 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/md/bcache/nvm-pages.c b/drivers/md/bcache/nvm-pages.c
> index 18fdadbc502f..804ee66e97be 100644
> --- a/drivers/md/bcache/nvm-pages.c
> +++ b/drivers/md/bcache/nvm-pages.c
> @@ -34,6 +34,10 @@ static void release_nvm_namespaces(struct bch_nvm_set *nvm_set)
>  	for (i = 0; i < nvm_set->total_namespaces_nr; i++) {
>  		ns = nvm_set->nss[i];
>  		if (ns) {
> +			kvfree(ns->pages_bitmap);
> +			if (ns->pgalloc_recs_bitmap)
> +				bitmap_free(ns->pgalloc_recs_bitmap);
> +
>  			blkdev_put(ns->bdev, FMODE_READ|FMODE_WRITE|FMODE_EXEC);
>  			kfree(ns);
>  		}
> @@ -48,17 +52,130 @@ static void release_nvm_set(struct bch_nvm_set *nvm_set)
>  	kfree(nvm_set);
>  }
>  
> +static struct page *nvm_vaddr_to_page(struct bch_nvm_namespace *ns, void *addr)
> +{
> +	return virt_to_page(addr);
> +}
> +
> +static void *nvm_pgoff_to_vaddr(struct bch_nvm_namespace *ns, pgoff_t pgoff)
> +{
> +	return ns->kaddr + (pgoff << PAGE_SHIFT);
> +}
> +
> +static inline void remove_owner_space(struct bch_nvm_namespace *ns,
> +					pgoff_t pgoff, u64 nr)
> +{
> +	while (nr > 0) {
> +		unsigned int num = nr > UINT_MAX ? UINT_MAX : nr;
> +
> +		bitmap_set(ns->pages_bitmap, pgoff, num);
> +		nr -= num;
> +		pgoff += num;
> +	}
> +}
> +
> +#define BCH_PGOFF_TO_KVADDR(pgoff) ((void *)((unsigned long)pgoff << PAGE_SHIFT))
> +
>  static int init_owner_info(struct bch_nvm_namespace *ns)
>  {
>  	struct bch_owner_list_head *owner_list_head = ns->sb->owner_list_head;
> +	struct bch_nvm_pgalloc_recs *sys_recs;
> +	int i, j, k, rc = 0;
>  
>  	mutex_lock(&only_set->lock);
>  	only_set->owner_list_head = owner_list_head;
>  	only_set->owner_list_size = owner_list_head->size;
>  	only_set->owner_list_used = owner_list_head->used;
> +
> +	/* remove used space */
> +	remove_owner_space(ns, 0, div_u64(ns->pages_offset, ns->page_size));
> +
> +	sys_recs = ns->kaddr + BCH_NVM_PAGES_SYS_RECS_HEAD_OFFSET;
> +	/* suppose no hole in array */
> +	for (i = 0; i < owner_list_head->used; i++) {
> +		struct bch_nvm_pages_owner_head *head = &owner_list_head->heads[i];
> +
> +		for (j = 0; j < BCH_NVM_PAGES_NAMESPACES_MAX; j++) {
> +			struct bch_nvm_pgalloc_recs *pgalloc_recs = head->recs[j];
> +			unsigned long offset = (unsigned long)ns->kaddr >> PAGE_SHIFT;
> +			struct page *page;
> +
> +			while (pgalloc_recs) {
> +				u32 pgalloc_recs_pos = (unsigned int)(pgalloc_recs - sys_recs);
> +
> +				if (memcmp(pgalloc_recs->magic, bch_nvm_pages_pgalloc_magic, 16)) {
> +					pr_info("invalid bch_nvm_pages_pgalloc_magic\n");
> +					rc = -EINVAL;
> +					goto unlock;
> +				}
> +				if (memcmp(pgalloc_recs->owner_uuid, head->uuid, 16)) {
> +					pr_info("invalid owner_uuid in bch_nvm_pgalloc_recs\n");
> +					rc = -EINVAL;
> +					goto unlock;
> +				}
> +				if (pgalloc_recs->owner != head) {
> +					pr_info("invalid owner in bch_nvm_pgalloc_recs\n");
> +					rc = -EINVAL;
> +					goto unlock;
> +				}
> +
> +				/* recs array can has hole */

can have holes ?

> +				for (k = 0; k < pgalloc_recs->size; k++) {
> +					struct bch_pgalloc_rec *rec = &pgalloc_recs->recs[k];
> +
> +					if (rec->pgoff) {
> +						BUG_ON(rec->pgoff <= offset);
> +
> +						/* init struct page: index/private */
> +						page = nvm_vaddr_to_page(ns,
> +							BCH_PGOFF_TO_KVADDR(rec->pgoff));
> +
> +						set_page_private(page, rec->order);
> +						page->index = rec->pgoff - offset;
> +
> +						remove_owner_space(ns,
> +							rec->pgoff - offset,
> +							1L << rec->order);
> +					}
> +				}
> +				bitmap_set(ns->pgalloc_recs_bitmap, pgalloc_recs_pos, 1);
> +				pgalloc_recs = pgalloc_recs->next;
> +			}
> +		}
> +	}
> +unlock:
>  	mutex_unlock(&only_set->lock);
>  
> -	return 0;
> +	return rc;
> +}
> +
> +static void init_nvm_free_space(struct bch_nvm_namespace *ns)
> +{
> +	unsigned int start, end, pages;
> +	int i;
> +	struct page *page;
> +	pgoff_t pgoff_start;
> +
> +	bitmap_for_each_clear_region(ns->pages_bitmap, start, end, 0, ns->pages_total) {
> +		pgoff_start = start;
> +		pages = end - start;
> +
> +		while (pages) {
> +			for (i = BCH_MAX_ORDER - 1; i >= 0 ; i--) {
> +				if ((pgoff_start % (1L << i) == 0) && (pages >= (1L << i)))
> +					break;
> +			}
> +
> +			page = nvm_vaddr_to_page(ns, nvm_pgoff_to_vaddr(ns, pgoff_start));
> +			page->index = pgoff_start;
> +			set_page_private(page, i);
> +			__SetPageBuddy(page);
> +			list_add((struct list_head *)&page->zone_device_data, &ns->free_area[i]);
> +
> +			pgoff_start += 1L << i;
> +			pages -= 1L << i;
> +		}
> +	}
>  }
>  
>  static int attach_nvm_set(struct bch_nvm_namespace *ns)
> @@ -165,7 +282,7 @@ static int read_nvdimm_meta_super(struct block_device *bdev,
>  struct bch_nvm_namespace *bch_register_namespace(const char *dev_path)
>  {
>  	struct bch_nvm_namespace *ns;
> -	int err;
> +	int i, err;
>  	pgoff_t pgoff;
>  	char buf[BDEVNAME_SIZE];
>  	struct block_device *bdev;
> @@ -249,18 +366,49 @@ struct bch_nvm_namespace *bch_register_namespace(const char *dev_path)
>  	ns->nvm_set = only_set;
>  	mutex_init(&ns->lock);
>  
> +	/*
> +	 * parameters of bitmap_set/clear are unsigned int.
> +	 * Given currently size of nvm is far from exceeding this limit,
> +	 * so only add a WARN_ON message.
> +	 */
> +	WARN_ON(BITS_TO_LONGS(ns->pages_total) > UINT_MAX);
> +	ns->pages_bitmap = kvcalloc(BITS_TO_LONGS(ns->pages_total),
> +					sizeof(unsigned long), GFP_KERNEL);
> +	if (!ns->pages_bitmap) {
> +		err = -ENOMEM;
> +		goto clear_ns_nr;
> +	}
> +
> +	if (ns->sb->this_namespace_nr == 0) {
> +		ns->pgalloc_recs_bitmap = bitmap_zalloc(BCH_MAX_PGALLOC_RECS, GFP_KERNEL);
> +		if (ns->pgalloc_recs_bitmap == NULL) {
> +			err = -ENOMEM;
> +			goto free_pages_bitmap;
> +		}
> +	}
> +
> +	for (i = 0; i < BCH_MAX_ORDER; i++)
> +		INIT_LIST_HEAD(&ns->free_area[i]);
> +
>  	if (ns->sb->this_namespace_nr == 0) {
>  		pr_info("only first namespace contain owner info\n");
>  		err = init_owner_info(ns);
>  		if (err < 0) {
>  			pr_info("init_owner_info met error %d\n", err);
> -			only_set->nss[ns->sb->this_namespace_nr] = NULL;
> -			goto free_ns;
> +			goto free_recs_bitmap;
>  		}
> +		/* init buddy allocator */
> +		init_nvm_free_space(ns);
>  	}
>  
>  	kfree(path);
>  	return ns;
> +free_recs_bitmap:
> +	bitmap_free(ns->pgalloc_recs_bitmap);
> +free_pages_bitmap:
> +	kvfree(ns->pages_bitmap);
> +clear_ns_nr:
> +	only_set->nss[ns->sb->this_namespace_nr] = NULL;
>  free_ns:
>  	kfree(ns);
>  bdput:
> diff --git a/drivers/md/bcache/nvm-pages.h b/drivers/md/bcache/nvm-pages.h
> index 3e24c4dee7fd..71beb244b9be 100644
> --- a/drivers/md/bcache/nvm-pages.h
> +++ b/drivers/md/bcache/nvm-pages.h
> @@ -16,6 +16,7 @@
>   * to which owner. After reboot from power failure, they will be initialized
>   * based on nvm pages superblock in NVDIMM device.
>   */
> +#define BCH_MAX_ORDER 20
>  struct bch_nvm_namespace {
>  	struct bch_nvm_pages_sb *sb;
>  	void *kaddr;
> @@ -27,6 +28,11 @@ struct bch_nvm_namespace {
>  	u64 pages_total;
>  	pfn_t start_pfn;
>  
> +	unsigned long *pages_bitmap;
> +	struct list_head free_area[BCH_MAX_ORDER];
> +
> +	unsigned long *pgalloc_recs_bitmap;
> >  	struct dax_device *dax_dev;
>  	struct block_device *bdev;
>  	struct bch_nvm_set *nvm_set;
> diff --git a/include/uapi/linux/bcache-nvm.h b/include/uapi/linux/bcache-nvm.h
> index 5094a6797679..1fdb3eaabf7e 100644
> --- a/include/uapi/linux/bcache-nvm.h
> +++ b/include/uapi/linux/bcache-nvm.h
> @@ -130,11 +130,15 @@ union {
>  };
>  };
>  
> -#define BCH_MAX_RECS					\
> -	((sizeof(struct bch_nvm_pgalloc_recs) -		\
> -	 offsetof(struct bch_nvm_pgalloc_recs, recs)) /	\
> +#define BCH_MAX_RECS							\
> +	((sizeof(struct bch_nvm_pgalloc_recs) -				\
> +	 offsetof(struct bch_nvm_pgalloc_recs, recs)) /			\
>  	 sizeof(struct bch_pgalloc_rec))
>  
> +#define BCH_MAX_PGALLOC_RECS						\
> +	((BCH_NVM_PAGES_OFFSET - BCH_NVM_PAGES_SYS_RECS_HEAD_OFFSET) /	\
> +	 sizeof(struct bch_nvm_pgalloc_recs))
> +
>  struct bch_nvm_pages_owner_head {
>  	unsigned char			uuid[16];
>  	unsigned char			label[BCH_NVM_PAGES_LABEL_SIZE];
> 
Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
