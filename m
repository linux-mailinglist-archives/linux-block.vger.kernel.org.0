Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79223B0194
	for <lists+linux-block@lfdr.de>; Tue, 22 Jun 2021 12:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhFVKmB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Jun 2021 06:42:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44974 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhFVKl5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 06:41:57 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 82EB82197B;
        Tue, 22 Jun 2021 10:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624358380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lMjLjIyORP3EZGzPZ6rkc2iaBkCJNHMrE0xScCOJZuE=;
        b=erjeY9nBcxyZqoZaI2u8P3lHBBKVh8Y1FnrfW1i9nQUPEyaqXEwNI9M/w+Zblr6V3R34Sv
        dSyB22PWTqiIK8Gahlac2vjPs+pwOIHyNeqHqV/yW5C7GgaRtaUPv/9t3fOntw9XSqLCoW
        PqoT1M5rjYyMbqry3e+jGsHXxJN4pvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624358380;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lMjLjIyORP3EZGzPZ6rkc2iaBkCJNHMrE0xScCOJZuE=;
        b=RGxac33fPNh8jXk9CoicJKLSDkuj1QfGg+KThnfPfIzQGkmFV2hEcYGlm2rsirhJvIyOU7
        tVspQKvPTDQ9/0AA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 6BF31118DD;
        Tue, 22 Jun 2021 10:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624358380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lMjLjIyORP3EZGzPZ6rkc2iaBkCJNHMrE0xScCOJZuE=;
        b=erjeY9nBcxyZqoZaI2u8P3lHBBKVh8Y1FnrfW1i9nQUPEyaqXEwNI9M/w+Zblr6V3R34Sv
        dSyB22PWTqiIK8Gahlac2vjPs+pwOIHyNeqHqV/yW5C7GgaRtaUPv/9t3fOntw9XSqLCoW
        PqoT1M5rjYyMbqry3e+jGsHXxJN4pvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624358380;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lMjLjIyORP3EZGzPZ6rkc2iaBkCJNHMrE0xScCOJZuE=;
        b=RGxac33fPNh8jXk9CoicJKLSDkuj1QfGg+KThnfPfIzQGkmFV2hEcYGlm2rsirhJvIyOU7
        tVspQKvPTDQ9/0AA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id KS76GOy90WDcUgAALh3uQQ
        (envelope-from <hare@suse.de>); Tue, 22 Jun 2021 10:39:40 +0000
To:     Coly Li <colyli@suse.de>, axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Qiaowei Ren <qiaowei.ren@intel.com>
References: <20210615054921.101421-1-colyli@suse.de>
 <20210615054921.101421-5-colyli@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 04/14] bcache: initialize the nvm pages allocator
Message-ID: <39c118e3-ddc9-f417-a929-fc21e761a4ac@suse.de>
Date:   Tue, 22 Jun 2021 12:39:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210615054921.101421-5-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/15/21 7:49 AM, Coly Li wrote:
> From: Jianpeng Ma <jianpeng.ma@intel.com>
> 
> This patch define the prototype data structures in memory and
> initializes the nvm pages allocator.
> 
> The nvm address space which is managed by this allocator can consist of
> many nvm namespaces, and some namespaces can compose into one nvm set,
> like cache set. For this initial implementation, only one set can be
> supported.
> 
> The users of this nvm pages allocator need to call register_namespace()
> to register the nvdimm device (like /dev/pmemX) into this allocator as
> the instance of struct nvm_namespace.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
> Co-developed-by: Qiaowei Ren <qiaowei.ren@intel.com>
> Signed-off-by: Qiaowei Ren <qiaowei.ren@intel.com>
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>  drivers/md/bcache/Kconfig     |  10 ++
>  drivers/md/bcache/Makefile    |   1 +
>  drivers/md/bcache/nvm-pages.c | 295 ++++++++++++++++++++++++++++++++++
>  drivers/md/bcache/nvm-pages.h |  74 +++++++++
>  drivers/md/bcache/super.c     |   3 +
>  5 files changed, 383 insertions(+)
>  create mode 100644 drivers/md/bcache/nvm-pages.c
>  create mode 100644 drivers/md/bcache/nvm-pages.h
> 
> diff --git a/drivers/md/bcache/Kconfig b/drivers/md/bcache/Kconfig
> index d1ca4d059c20..a69f6c0e0507 100644
> --- a/drivers/md/bcache/Kconfig
> +++ b/drivers/md/bcache/Kconfig
> @@ -35,3 +35,13 @@ config BCACHE_ASYNC_REGISTRATION
>  	device path into this file will returns immediately and the real
>  	registration work is handled in kernel work queue in asynchronous
>  	way.
> +
> +config BCACHE_NVM_PAGES
> +	bool "NVDIMM support for bcache (EXPERIMENTAL)"
> +	depends on BCACHE
> +	depends on 64BIT
> +	depends on LIBNVDIMM
> +	depends on DAX
> +	help
> +	  Allocate/release NV-memory pages for bcache and provide allocated pages
> +	  for each requestor after system reboot.
> diff --git a/drivers/md/bcache/Makefile b/drivers/md/bcache/Makefile
> index 5b87e59676b8..2397bb7c7ffd 100644
> --- a/drivers/md/bcache/Makefile
> +++ b/drivers/md/bcache/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_BCACHE)	+= bcache.o
>  bcache-y		:= alloc.o bset.o btree.o closure.o debug.o extents.o\
>  	io.o journal.o movinggc.o request.o stats.o super.o sysfs.o trace.o\
>  	util.o writeback.o features.o
> +bcache-$(CONFIG_BCACHE_NVM_PAGES) += nvm-pages.o
> diff --git a/drivers/md/bcache/nvm-pages.c b/drivers/md/bcache/nvm-pages.c
> new file mode 100644
> index 000000000000..18fdadbc502f
> --- /dev/null
> +++ b/drivers/md/bcache/nvm-pages.c
> @@ -0,0 +1,295 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Nvdimm page-buddy allocator
> + *
> + * Copyright (c) 2021, Intel Corporation.
> + * Copyright (c) 2021, Qiaowei Ren <qiaowei.ren@intel.com>.
> + * Copyright (c) 2021, Jianpeng Ma <jianpeng.ma@intel.com>.
> + */
> +
> +#if defined(CONFIG_BCACHE_NVM_PAGES)
> +

No need for this 'if' statement as it'll be excluded by the Makefile
anyway if the config option isn't set.

> +#include "bcache.h"
> +#include "nvm-pages.h"
> +
> +#include <linux/slab.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/dax.h>
> +#include <linux/pfn_t.h>
> +#include <linux/libnvdimm.h>
> +#include <linux/mm_types.h>
> +#include <linux/err.h>
> +#include <linux/pagemap.h>
> +#include <linux/bitmap.h>
> +#include <linux/blkdev.h>
> +
> +struct bch_nvm_set *only_set;
> +
> +static void release_nvm_namespaces(struct bch_nvm_set *nvm_set)
> +{
> +	int i;
> +	struct bch_nvm_namespace *ns;
> +
> +	for (i = 0; i < nvm_set->total_namespaces_nr; i++) {
> +		ns = nvm_set->nss[i];
> +		if (ns) {
> +			blkdev_put(ns->bdev, FMODE_READ|FMODE_WRITE|FMODE_EXEC);
> +			kfree(ns);
> +		}
> +	}
> +
> +	kfree(nvm_set->nss);
> +}
> +
> +static void release_nvm_set(struct bch_nvm_set *nvm_set)
> +{
> +	release_nvm_namespaces(nvm_set);
> +	kfree(nvm_set);
> +}
> +
> +static int init_owner_info(struct bch_nvm_namespace *ns)
> +{
> +	struct bch_owner_list_head *owner_list_head = ns->sb->owner_list_head;
> +
> +	mutex_lock(&only_set->lock);
> +	only_set->owner_list_head = owner_list_head;
> +	only_set->owner_list_size = owner_list_head->size;
> +	only_set->owner_list_used = owner_list_head->used;
> +	mutex_unlock(&only_set->lock);
> +
> +	return 0;
> +}
> +
> +static int attach_nvm_set(struct bch_nvm_namespace *ns)
> +{
> +	int rc = 0;
> +
> +	mutex_lock(&only_set->lock);
> +	if (only_set->nss) {
> +		if (memcmp(ns->sb->set_uuid, only_set->set_uuid, 16)) {
> +			pr_info("namespace id doesn't match nvm set\n");
> +			rc = -EINVAL;
> +			goto unlock;
> +		}
> +
> +		if (only_set->nss[ns->sb->this_namespace_nr]) {

Doesn't this need to be checked against 'total_namespaces_nr' to avoid
overflow?

> +			pr_info("already has the same position(%d) nvm\n",
> +					ns->sb->this_namespace_nr);
> +			rc = -EEXIST;
> +			goto unlock;
> +		}
> +	} else {
> +		memcpy(only_set->set_uuid, ns->sb->set_uuid, 16);
> +		only_set->total_namespaces_nr = ns->sb->total_namespaces_nr;
> +		only_set->nss = kcalloc(only_set->total_namespaces_nr,
> +				sizeof(struct bch_nvm_namespace *), GFP_KERNEL);
> +		if (!only_set->nss) {

When you enter here, 'set_uuid' and 'total_namespace_nr' is being
modified, which might cause errors later on.
Please move these two lines _after_ the kcalloc() to avoid this.

> +			rc = -ENOMEM;
> +			goto unlock;
> +		}
> +	}
> +
> +	only_set->nss[ns->sb->this_namespace_nr] = ns;
> +
> +	/* Firstly attach */

Initial attach?

> +	if ((unsigned long)ns->sb->owner_list_head == BCH_NVM_PAGES_OWNER_LIST_HEAD_OFFSET) {
> +		struct bch_nvm_pages_owner_head *sys_owner_head;
> +		struct bch_nvm_pgalloc_recs *sys_pgalloc_recs;
> +
> +		ns->sb->owner_list_head = ns->kaddr + BCH_NVM_PAGES_OWNER_LIST_HEAD_OFFSET;
> +		sys_pgalloc_recs = ns->kaddr + BCH_NVM_PAGES_SYS_RECS_HEAD_OFFSET;
> +
> +		sys_owner_head = &(ns->sb->owner_list_head->heads[0]);
> +		sys_owner_head->recs[0] = sys_pgalloc_recs;
> +		ns->sb->csum = csum_set(ns->sb);
> +
Hmm. You are trying to pick up the 'list_head' structure from NVM, right?

In doing so, don't you need to validate the structure (eg by checking
the checksum) before doing so to ensure that the contents are valid?

> +		sys_pgalloc_recs->owner = sys_owner_head;
> +	} else
> +		BUG_ON(ns->sb->owner_list_head !=
> +			(ns->kaddr + BCH_NVM_PAGES_OWNER_LIST_HEAD_OFFSET));
> +
> +unlock:
> +	mutex_unlock(&only_set->lock);
> +	return rc;
> +}
> +
> +static int read_nvdimm_meta_super(struct block_device *bdev,
> +			      struct bch_nvm_namespace *ns)
> +{
> +	struct page *page;
> +	struct bch_nvm_pages_sb *sb;
> +	int r = 0;
> +	uint64_t expected_csum = 0;
> +
> +	page = read_cache_page_gfp(bdev->bd_inode->i_mapping,
> +			BCH_NVM_PAGES_SB_OFFSET >> PAGE_SHIFT, GFP_KERNEL);
> +
> +	if (IS_ERR(page))
> +		return -EIO;
> +
> +	sb = (struct bch_nvm_pages_sb *)(page_address(page) +
> +					offset_in_page(BCH_NVM_PAGES_SB_OFFSET));
> +	r = -EINVAL;
> +	expected_csum = csum_set(sb);
> +	if (expected_csum != sb->csum) {
> +		pr_info("csum is not match with expected one\n");
> +		goto put_page;
> +	}
> +
> +	if (memcmp(sb->magic, bch_nvm_pages_magic, 16)) {
> +		pr_info("invalid bch_nvm_pages_magic\n");
> +		goto put_page;
> +	}
> +
> +	if (sb->total_namespaces_nr != 1) {
> +		pr_info("currently only support one nvm device\n");
> +		goto put_page;
> +	}
> +
> +	if (sb->sb_offset != BCH_NVM_PAGES_SB_OFFSET) {
> +		pr_info("invalid superblock offset\n");
> +		goto put_page;
> +	}
> +
> +	r = 0;
> +	/* temporary use for DAX API */
> +	ns->page_size = sb->page_size;
> +	ns->pages_total = sb->pages_total;
> +
> +put_page:
> +	put_page(page);
> +	return r;
> +}
> +
> +struct bch_nvm_namespace *bch_register_namespace(const char *dev_path)
> +{
> +	struct bch_nvm_namespace *ns;
> +	int err;
> +	pgoff_t pgoff;
> +	char buf[BDEVNAME_SIZE];
> +	struct block_device *bdev;
> +	int id;
> +	char *path = NULL;
> +
> +	path = kstrndup(dev_path, 512, GFP_KERNEL);
> +	if (!path) {
> +		pr_err("kstrndup failed\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	bdev = blkdev_get_by_path(strim(path),
> +				  FMODE_READ|FMODE_WRITE|FMODE_EXEC,
> +				  only_set);
> +	if (IS_ERR(bdev)) {
> +		pr_info("get %s error: %ld\n", dev_path, PTR_ERR(bdev));
> +		kfree(path);
> +		return ERR_PTR(PTR_ERR(bdev));
> +	}
> +
> +	err = -ENOMEM;
> +	ns = kzalloc(sizeof(struct bch_nvm_namespace), GFP_KERNEL);
> +	if (!ns)
> +		goto bdput;
> +
> +	err = -EIO;
> +	if (read_nvdimm_meta_super(bdev, ns)) {
> +		pr_info("%s read nvdimm meta super block failed.\n",
> +			bdevname(bdev, buf));
> +		goto free_ns;
> +	}
> +
> +	err = -EOPNOTSUPP;
> +	if (!bdev_dax_supported(bdev, ns->page_size)) {
> +		pr_info("%s don't support DAX\n", bdevname(bdev, buf));
> +		goto free_ns;
> +	}
> +
> +	err = -EINVAL;
> +	if (bdev_dax_pgoff(bdev, 0, ns->page_size, &pgoff)) {
> +		pr_info("invalid offset of %s\n", bdevname(bdev, buf));
> +		goto free_ns;
> +	}
> +
> +	err = -ENOMEM;
> +	ns->dax_dev = fs_dax_get_by_bdev(bdev);
> +	if (!ns->dax_dev) {
> +		pr_info("can't by dax device by %s\n", bdevname(bdev, buf));
> +		goto free_ns;
> +	}
> +
> +	err = -EINVAL;
> +	id = dax_read_lock();
> +	if (dax_direct_access(ns->dax_dev, pgoff, ns->pages_total,
> +			      &ns->kaddr, &ns->start_pfn) <= 0) {
> +		pr_info("dax_direct_access error\n");
> +		dax_read_unlock(id);
> +		goto free_ns;
> +	}
> +	dax_read_unlock(id);
> +
> +	ns->sb = ns->kaddr + BCH_NVM_PAGES_SB_OFFSET;
> +

You already read the superblock in read_nvdimm_meta_super(), right?
Wouldn't it be better to first do the 'dax_direct_access()' call, and
then check the superblock?
That way you'll ensure that dax_direct_access()' did the right thing;
with the current code you are using two different methods of accessing
the superblock, which theoretically can result in one method succeeding,
the other not ...

> +	err = -EINVAL;
> +	/* Check magic again to make sure DAX mapping is correct */
> +	if (memcmp(ns->sb->magic, bch_nvm_pages_magic, 16)) {
> +		pr_info("invalid bch_nvm_pages_magic after DAX mapping\n");
> +		goto free_ns;
> +	}
> +
> +	err = attach_nvm_set(ns);
> +	if (err < 0)
> +		goto free_ns;
> +
> +	ns->page_size = ns->sb->page_size;
> +	ns->pages_offset = ns->sb->pages_offset;
> +	ns->pages_total = ns->sb->pages_total;
> +	ns->free = 0;
> +	ns->bdev = bdev;
> +	ns->nvm_set = only_set;
> +	mutex_init(&ns->lock);
> +
> +	if (ns->sb->this_namespace_nr == 0) {
> +		pr_info("only first namespace contain owner info\n");
> +		err = init_owner_info(ns);
> +		if (err < 0) {
> +			pr_info("init_owner_info met error %d\n", err);
> +			only_set->nss[ns->sb->this_namespace_nr] = NULL;
> +			goto free_ns;
> +		}
> +	}
> +
> +	kfree(path);
> +	return ns;
> +free_ns:
> +	kfree(ns);
> +bdput:
> +	blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXEC);
> +	kfree(path);
> +	return ERR_PTR(err);
> +}
> +EXPORT_SYMBOL_GPL(bch_register_namespace);
> +
> +int __init bch_nvm_init(void)
> +{
> +	only_set = kzalloc(sizeof(*only_set), GFP_KERNEL);
> +	if (!only_set)
> +		return -ENOMEM;
> +
> +	only_set->total_namespaces_nr = 0;
> +	only_set->owner_list_head = NULL;
> +	only_set->nss = NULL;
> +
> +	mutex_init(&only_set->lock);
> +
> +	pr_info("bcache nvm init\n");
> +	return 0;
> +}
> +
> +void bch_nvm_exit(void)
> +{
> +	release_nvm_set(only_set);
> +	pr_info("bcache nvm exit\n");
> +}
> +
> +#endif /* CONFIG_BCACHE_NVM_PAGES */
> diff --git a/drivers/md/bcache/nvm-pages.h b/drivers/md/bcache/nvm-pages.h
> new file mode 100644
> index 000000000000..3e24c4dee7fd
> --- /dev/null
> +++ b/drivers/md/bcache/nvm-pages.h
> @@ -0,0 +1,74 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _BCACHE_NVM_PAGES_H
> +#define _BCACHE_NVM_PAGES_H
> +
> +#if defined(CONFIG_BCACHE_NVM_PAGES)
> +#include <linux/bcache-nvm.h>
> +#endif /* CONFIG_BCACHE_NVM_PAGES */
> +

Hmm? What is that doing here?
Please move it into the source file.

> +/*
> + * Bcache NVDIMM in memory data structures
> + */
> +
> +/*
> + * The following three structures in memory records which page(s) allocated
> + * to which owner. After reboot from power failure, they will be initialized
> + * based on nvm pages superblock in NVDIMM device.
> + */
> +struct bch_nvm_namespace {
> +	struct bch_nvm_pages_sb *sb;
> +	void *kaddr;
> +
> +	u8 uuid[16];
> +	u64 free;
> +	u32 page_size;
> +	u64 pages_offset;
> +	u64 pages_total;
> +	pfn_t start_pfn;
> +
> +	struct dax_device *dax_dev;
> +	struct block_device *bdev;
> +	struct bch_nvm_set *nvm_set;
> +
> +	struct mutex lock;
> +};
> +
> +/*
> + * A set of namespaces. Currently only one set can be supported.
> + */
> +struct bch_nvm_set {
> +	u8 set_uuid[16];
> +	u32 total_namespaces_nr;
> +
> +	u32 owner_list_size;
> +	u32 owner_list_used;
> +	struct bch_owner_list_head *owner_list_head;
> +
> +	struct bch_nvm_namespace **nss;
> +
> +	struct mutex lock;
> +};
> +extern struct bch_nvm_set *only_set;
> +
> +#if defined(CONFIG_BCACHE_NVM_PAGES)
> +
> +struct bch_nvm_namespace *bch_register_namespace(const char *dev_path);
> +int bch_nvm_init(void);
> +void bch_nvm_exit(void);
> +
> +#else
> +
> +static inline struct bch_nvm_namespace *bch_register_namespace(const char *dev_path)
> +{
> +	return NULL;
> +}
> +static inline int bch_nvm_init(void)
> +{
> +	return 0;
> +}
> +static inline void bch_nvm_exit(void) { }
> +
> +#endif /* CONFIG_BCACHE_NVM_PAGES */
> +
> +#endif /* _BCACHE_NVM_PAGES_H */
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 2f1ee4fbf4d5..ce22aefb1352 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -14,6 +14,7 @@
>  #include "request.h"
>  #include "writeback.h"
>  #include "features.h"
> +#include "nvm-pages.h"
>  
>  #include <linux/blkdev.h>
>  #include <linux/pagemap.h>
> @@ -2823,6 +2824,7 @@ static void bcache_exit(void)
>  {
>  	bch_debug_exit();
>  	bch_request_exit();
> +	bch_nvm_exit();
>  	if (bcache_kobj)
>  		kobject_put(bcache_kobj);
>  	if (bcache_wq)
> @@ -2921,6 +2923,7 @@ static int __init bcache_init(void)
>  
>  	bch_debug_init();
>  	closure_debug_init();
> +	bch_nvm_init();
>  
>  	bcache_is_reboot = false;
>  
> 
Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
