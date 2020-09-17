Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DC626D7AF
	for <lists+linux-block@lfdr.de>; Thu, 17 Sep 2020 11:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgIQJb5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 17 Sep 2020 05:31:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:43398 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgIQJb4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Sep 2020 05:31:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 815BCAFED;
        Thu, 17 Sep 2020 09:32:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6E2261E12E1; Thu, 17 Sep 2020 11:31:52 +0200 (CEST)
Date:   Thu, 17 Sep 2020 11:31:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 12/12] bdi: replace BDI_CAP_NO_{WRITEBACK,ACCT_DIRTY}
 with a single flag
Message-ID: <20200917093152.GE7347@quack2.suse.cz>
References: <20200910144833.742260-1-hch@lst.de>
 <20200910144833.742260-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910144833.742260-13-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 10-09-20 16:48:32, Christoph Hellwig wrote:
> Replace the two negative flags that are always used together with a
> single positive flag that indicates the writeback capability instead
> of two related non-capabilities.  Also remove the pointless wrappers
> to just check the flag.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/9p/vfs_file.c            |  2 +-
>  fs/fs-writeback.c           |  7 +++---
>  include/linux/backing-dev.h | 48 ++++++++-----------------------------
>  mm/backing-dev.c            |  6 ++---
>  mm/filemap.c                |  4 ++--
>  mm/memcontrol.c             |  2 +-
>  mm/memory-failure.c         |  2 +-
>  mm/migrate.c                |  2 +-
>  mm/mmap.c                   |  2 +-
>  mm/page-writeback.c         | 12 +++++-----
>  10 files changed, 29 insertions(+), 58 deletions(-)
> 
> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index 3576123d82990e..6ecf863bfa2f4b 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -625,7 +625,7 @@ static void v9fs_mmap_vm_close(struct vm_area_struct *vma)
>  
>  	inode = file_inode(vma->vm_file);
>  
> -	if (!mapping_cap_writeback_dirty(inode->i_mapping))
> +	if (!mapping_can_writeback(inode->i_mapping))
>  		wbc.nr_to_write = 0;
>  
>  	might_sleep();
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 149227160ff0b0..d4f84a2fe0878e 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2321,7 +2321,7 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  
>  			wb = locked_inode_to_wb_and_lock_list(inode);
>  
> -			WARN(bdi_cap_writeback_dirty(wb->bdi) &&
> +			WARN((wb->bdi->capabilities & BDI_CAP_WRITEBACK) &&
>  			     !test_bit(WB_registered, &wb->state),
>  			     "bdi-%s not registered\n", bdi_dev_name(wb->bdi));
>  
> @@ -2346,7 +2346,8 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  			 * to make sure background write-back happens
>  			 * later.
>  			 */
> -			if (bdi_cap_writeback_dirty(wb->bdi) && wakeup_bdi)
> +			if (wakeup_bdi &&
> +			    (wb->bdi->capabilities & BDI_CAP_WRITEBACK))
>  				wb_wakeup_delayed(wb);
>  			return;
>  		}
> @@ -2581,7 +2582,7 @@ int write_inode_now(struct inode *inode, int sync)
>  		.range_end = LLONG_MAX,
>  	};
>  
> -	if (!mapping_cap_writeback_dirty(inode->i_mapping))
> +	if (!mapping_can_writeback(inode->i_mapping))
>  		wbc.nr_to_write = 0;
>  
>  	might_sleep();
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index b217344a2c63be..44df4fcef65c1e 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -110,27 +110,14 @@ int bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_ratio);
>  /*
>   * Flags in backing_dev_info::capability
>   *
> - * The first three flags control whether dirty pages will contribute to the
> - * VM's accounting and whether writepages() should be called for dirty pages
> - * (something that would not, for example, be appropriate for ramfs)
> - *
> - * WARNING: these flags are closely related and should not normally be
> - * used separately.  The BDI_CAP_NO_ACCT_AND_WRITEBACK combines these
> - * three flags into a single convenience macro.
> - *
> - * BDI_CAP_NO_ACCT_DIRTY:  Dirty pages shouldn't contribute to accounting
> - * BDI_CAP_NO_WRITEBACK:   Don't write pages back
> - * BDI_CAP_WRITEBACK_ACCT: Automatically account writeback pages
> - * BDI_CAP_STRICTLIMIT:    Keep number of dirty pages below bdi threshold.
> + * BDI_CAP_WRITEBACK:		Supports dirty page writeback, and dirty pages
> + *				should contribute to accounting
> + * BDI_CAP_WRITEBACK_ACCT:	Automatically account writeback pages
> + * BDI_CAP_STRICTLIMIT:		Keep number of dirty pages below bdi threshold
>   */
> -#define BDI_CAP_NO_ACCT_DIRTY	0x00000001
> -#define BDI_CAP_NO_WRITEBACK	0x00000002
> -#define BDI_CAP_WRITEBACK_ACCT	0x00000004
> -#define BDI_CAP_STRICTLIMIT	0x00000010
> -#define BDI_CAP_CGROUP_WRITEBACK 0x00000020
> -
> -#define BDI_CAP_NO_ACCT_AND_WRITEBACK \
> -	(BDI_CAP_NO_WRITEBACK | BDI_CAP_NO_ACCT_DIRTY)
> +#define BDI_CAP_WRITEBACK		(1 << 0)
> +#define BDI_CAP_WRITEBACK_ACCT		(1 << 1)
> +#define BDI_CAP_STRICTLIMIT		(1 << 2)
>  
>  extern struct backing_dev_info noop_backing_dev_info;
>  
> @@ -169,24 +156,9 @@ static inline int wb_congested(struct bdi_writeback *wb, int cong_bits)
>  long congestion_wait(int sync, long timeout);
>  long wait_iff_congested(int sync, long timeout);
>  
> -static inline bool bdi_cap_writeback_dirty(struct backing_dev_info *bdi)
> -{
> -	return !(bdi->capabilities & BDI_CAP_NO_WRITEBACK);
> -}
> -
> -static inline bool bdi_cap_account_dirty(struct backing_dev_info *bdi)
> -{
> -	return !(bdi->capabilities & BDI_CAP_NO_ACCT_DIRTY);
> -}
> -
> -static inline bool mapping_cap_writeback_dirty(struct address_space *mapping)
> -{
> -	return bdi_cap_writeback_dirty(inode_to_bdi(mapping->host));
> -}
> -
> -static inline bool mapping_cap_account_dirty(struct address_space *mapping)
> +static inline bool mapping_can_writeback(struct address_space *mapping)
>  {
> -	return bdi_cap_account_dirty(inode_to_bdi(mapping->host));
> +	return inode_to_bdi(mapping->host)->capabilities & BDI_CAP_WRITEBACK;
>  }
>  
>  static inline int bdi_sched_wait(void *word)
> @@ -223,7 +195,7 @@ static inline bool inode_cgwb_enabled(struct inode *inode)
>  
>  	return cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
>  		cgroup_subsys_on_dfl(io_cgrp_subsys) &&
> -		bdi_cap_account_dirty(bdi) &&
> +		(bdi->capabilities & BDI_CAP_WRITEBACK) &&
>  		(inode->i_sb->s_iflags & SB_I_CGROUPWB);
>  }
>  
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index ab0415dde5c66c..5d0991e75ca337 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -14,9 +14,7 @@
>  #include <linux/device.h>
>  #include <trace/events/writeback.h>
>  
> -struct backing_dev_info noop_backing_dev_info = {
> -	.capabilities	= BDI_CAP_NO_ACCT_AND_WRITEBACK,
> -};
> +struct backing_dev_info noop_backing_dev_info;
>  EXPORT_SYMBOL_GPL(noop_backing_dev_info);
>  
>  static struct class *bdi_class;
> @@ -744,7 +742,7 @@ struct backing_dev_info *bdi_alloc(int node_id)
>  		kfree(bdi);
>  		return NULL;
>  	}
> -	bdi->capabilities = BDI_CAP_WRITEBACK_ACCT;
> +	bdi->capabilities = BDI_CAP_WRITEBACK | BDI_CAP_WRITEBACK_ACCT;
>  	bdi->ra_pages = VM_READAHEAD_PAGES;
>  	bdi->io_pages = VM_READAHEAD_PAGES;
>  	return bdi;
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 1aaea26556cc7e..6c2a0139e22fa3 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -414,7 +414,7 @@ int __filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
>  		.range_end = end,
>  	};
>  
> -	if (!mapping_cap_writeback_dirty(mapping) ||
> +	if (!mapping_can_writeback(mapping) ||
>  	    !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
>  		return 0;
>  
> @@ -1702,7 +1702,7 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
>  no_page:
>  	if (!page && (fgp_flags & FGP_CREAT)) {
>  		int err;
> -		if ((fgp_flags & FGP_WRITE) && mapping_cap_account_dirty(mapping))
> +		if ((fgp_flags & FGP_WRITE) && mapping_can_writeback(mapping))
>  			gfp_mask |= __GFP_WRITE;
>  		if (fgp_flags & FGP_NOFS)
>  			gfp_mask &= ~__GFP_FS;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b807952b4d431b..d2352f76d6519f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5643,7 +5643,7 @@ static int mem_cgroup_move_account(struct page *page,
>  		if (PageDirty(page)) {
>  			struct address_space *mapping = page_mapping(page);
>  
> -			if (mapping_cap_account_dirty(mapping)) {
> +			if (mapping_can_writeback(mapping)) {
>  				__mod_lruvec_state(from_vec, NR_FILE_DIRTY,
>  						   -nr_pages);
>  				__mod_lruvec_state(to_vec, NR_FILE_DIRTY,
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index f1aa6433f40416..a1e73943445e77 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1006,7 +1006,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
>  	 */
>  	mapping = page_mapping(hpage);
>  	if (!(flags & MF_MUST_KILL) && !PageDirty(hpage) && mapping &&
> -	    mapping_cap_writeback_dirty(mapping)) {
> +	    mapping_can_writeback(mapping)) {
>  		if (page_mkclean(hpage)) {
>  			SetPageDirty(hpage);
>  		} else {
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 34a842a8eb6a7b..9d2f42a3a16294 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -503,7 +503,7 @@ int migrate_page_move_mapping(struct address_space *mapping,
>  			__dec_lruvec_state(old_lruvec, NR_SHMEM);
>  			__inc_lruvec_state(new_lruvec, NR_SHMEM);
>  		}
> -		if (dirty && mapping_cap_account_dirty(mapping)) {
> +		if (dirty && mapping_can_writeback(mapping)) {
>  			__dec_node_state(oldzone->zone_pgdat, NR_FILE_DIRTY);
>  			__dec_zone_state(oldzone, NR_ZONE_WRITE_PENDING);
>  			__inc_node_state(newzone->zone_pgdat, NR_FILE_DIRTY);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 40248d84ad5fbd..1fc0e92be4ba9b 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1666,7 +1666,7 @@ int vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
>  
>  	/* Can the mapping track the dirty pages? */
>  	return vma->vm_file && vma->vm_file->f_mapping &&
> -		mapping_cap_account_dirty(vma->vm_file->f_mapping);
> +		mapping_can_writeback(vma->vm_file->f_mapping);
>  }
>  
>  /*
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 0139f9622a92da..358d6f28c627b7 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -1882,7 +1882,7 @@ void balance_dirty_pages_ratelimited(struct address_space *mapping)
>  	int ratelimit;
>  	int *p;
>  
> -	if (!bdi_cap_account_dirty(bdi))
> +	if (!(bdi->capabilities & BDI_CAP_WRITEBACK))
>  		return;
>  
>  	if (inode_cgwb_enabled(inode))
> @@ -2423,7 +2423,7 @@ void account_page_dirtied(struct page *page, struct address_space *mapping)
>  
>  	trace_writeback_dirty_page(page, mapping);
>  
> -	if (mapping_cap_account_dirty(mapping)) {
> +	if (mapping_can_writeback(mapping)) {
>  		struct bdi_writeback *wb;
>  
>  		inode_attach_wb(inode, page);
> @@ -2450,7 +2450,7 @@ void account_page_dirtied(struct page *page, struct address_space *mapping)
>  void account_page_cleaned(struct page *page, struct address_space *mapping,
>  			  struct bdi_writeback *wb)
>  {
> -	if (mapping_cap_account_dirty(mapping)) {
> +	if (mapping_can_writeback(mapping)) {
>  		dec_lruvec_page_state(page, NR_FILE_DIRTY);
>  		dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
>  		dec_wb_stat(wb, WB_RECLAIMABLE);
> @@ -2513,7 +2513,7 @@ void account_page_redirty(struct page *page)
>  {
>  	struct address_space *mapping = page->mapping;
>  
> -	if (mapping && mapping_cap_account_dirty(mapping)) {
> +	if (mapping && mapping_can_writeback(mapping)) {
>  		struct inode *inode = mapping->host;
>  		struct bdi_writeback *wb;
>  		struct wb_lock_cookie cookie = {};
> @@ -2625,7 +2625,7 @@ void __cancel_dirty_page(struct page *page)
>  {
>  	struct address_space *mapping = page_mapping(page);
>  
> -	if (mapping_cap_account_dirty(mapping)) {
> +	if (mapping_can_writeback(mapping)) {
>  		struct inode *inode = mapping->host;
>  		struct bdi_writeback *wb;
>  		struct wb_lock_cookie cookie = {};
> @@ -2665,7 +2665,7 @@ int clear_page_dirty_for_io(struct page *page)
>  
>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
>  
> -	if (mapping && mapping_cap_account_dirty(mapping)) {
> +	if (mapping && mapping_can_writeback(mapping)) {
>  		struct inode *inode = mapping->host;
>  		struct bdi_writeback *wb;
>  		struct wb_lock_cookie cookie = {};
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
