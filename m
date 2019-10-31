Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA621EBA55
	for <lists+linux-block@lfdr.de>; Fri,  1 Nov 2019 00:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfJaXZt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 31 Oct 2019 19:25:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:50824 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfJaXZt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Oct 2019 19:25:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 16:25:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,253,1569308400"; 
   d="scan'208";a="199676391"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga007.fm.intel.com with ESMTP; 31 Oct 2019 16:25:48 -0700
Date:   Thu, 31 Oct 2019 16:25:48 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alex Williamson <alex.williamson@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Chinner <david@fromorbit.com>,
        David Airlie <airlied@linux.ie>,
        "David S . Miller" <davem@davemloft.net>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, bpf@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kvm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rdma@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/19] infiniband: set FOLL_PIN, FOLL_LONGTERM via
 pin_longterm_pages*()
Message-ID: <20191031232546.GG14771@iweiny-DESK2.sc.intel.com>
References: <20191030224930.3990755-1-jhubbard@nvidia.com>
 <20191030224930.3990755-8-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030224930.3990755-8-jhubbard@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 30, 2019 at 03:49:18PM -0700, John Hubbard wrote:
> Convert infiniband to use the new wrapper calls, and stop
> explicitly setting FOLL_LONGTERM at the call sites.
> 
> The new pin_longterm_*() calls replace get_user_pages*()
> calls, and set both FOLL_LONGTERM and a new FOLL_PIN
> flag. The FOLL_PIN flag requires that the caller must
> return the pages via put_user_page*() calls, but
> infiniband was already doing that as part of an earlier
> commit.
> 

NOTE: I'm not 100% convinced that mixing the flags and new calls like this is
good.  I think we are going to need a lot more documentation on which flags are
"user" accessible vs not...

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/infiniband/core/umem.c              |  5 ++---
>  drivers/infiniband/core/umem_odp.c          | 10 +++++-----
>  drivers/infiniband/hw/hfi1/user_pages.c     |  4 ++--
>  drivers/infiniband/hw/mthca/mthca_memfree.c |  3 +--
>  drivers/infiniband/hw/qib/qib_user_pages.c  |  8 ++++----
>  drivers/infiniband/hw/qib/qib_user_sdma.c   |  2 +-
>  drivers/infiniband/hw/usnic/usnic_uiom.c    |  9 ++++-----
>  drivers/infiniband/sw/siw/siw_mem.c         |  5 ++---
>  8 files changed, 21 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index 24244a2f68cc..c5a78d3e674b 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -272,11 +272,10 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
>  
>  	while (npages) {
>  		down_read(&mm->mmap_sem);
> -		ret = get_user_pages(cur_base,
> +		ret = pin_longterm_pages(cur_base,
>  				     min_t(unsigned long, npages,
>  					   PAGE_SIZE / sizeof (struct page *)),
> -				     gup_flags | FOLL_LONGTERM,
> -				     page_list, NULL);
> +				     gup_flags, page_list, NULL);
>  		if (ret < 0) {
>  			up_read(&mm->mmap_sem);
>  			goto umem_release;
> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
> index 163ff7ba92b7..a38b67b83db5 100644
> --- a/drivers/infiniband/core/umem_odp.c
> +++ b/drivers/infiniband/core/umem_odp.c
> @@ -534,7 +534,7 @@ static int ib_umem_odp_map_dma_single_page(
>  	} else if (umem_odp->page_list[page_index] == page) {
>  		umem_odp->dma_list[page_index] |= access_mask;
>  	} else {
> -		pr_err("error: got different pages in IB device and from get_user_pages. IB device page: %p, gup page: %p\n",
> +		pr_err("error: got different pages in IB device and from pin_longterm_pages. IB device page: %p, gup page: %p\n",
>  		       umem_odp->page_list[page_index], page);
>  		/* Better remove the mapping now, to prevent any further
>  		 * damage. */
> @@ -639,11 +639,11 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
>  		/*
>  		 * Note: this might result in redundent page getting. We can
>  		 * avoid this by checking dma_list to be 0 before calling
> -		 * get_user_pages. However, this make the code much more
> -		 * complex (and doesn't gain us much performance in most use
> -		 * cases).
> +		 * pin_longterm_pages. However, this makes the code much
> +		 * more complex (and doesn't gain us much performance in most
> +		 * use cases).
>  		 */
> -		npages = get_user_pages_remote(owning_process, owning_mm,
> +		npages = pin_longterm_pages_remote(owning_process, owning_mm,
>  				user_virt, gup_num_pages,
>  				flags, local_page_list, NULL, NULL);
>  		up_read(&owning_mm->mmap_sem);
> diff --git a/drivers/infiniband/hw/hfi1/user_pages.c b/drivers/infiniband/hw/hfi1/user_pages.c
> index 469acb961fbd..9b55b0a73e29 100644
> --- a/drivers/infiniband/hw/hfi1/user_pages.c
> +++ b/drivers/infiniband/hw/hfi1/user_pages.c
> @@ -104,9 +104,9 @@ int hfi1_acquire_user_pages(struct mm_struct *mm, unsigned long vaddr, size_t np
>  			    bool writable, struct page **pages)
>  {
>  	int ret;
> -	unsigned int gup_flags = FOLL_LONGTERM | (writable ? FOLL_WRITE : 0);
> +	unsigned int gup_flags = (writable ? FOLL_WRITE : 0);
>  
> -	ret = get_user_pages_fast(vaddr, npages, gup_flags, pages);
> +	ret = pin_longterm_pages_fast(vaddr, npages, gup_flags, pages);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/drivers/infiniband/hw/mthca/mthca_memfree.c b/drivers/infiniband/hw/mthca/mthca_memfree.c
> index edccfd6e178f..beec7e4b8a96 100644
> --- a/drivers/infiniband/hw/mthca/mthca_memfree.c
> +++ b/drivers/infiniband/hw/mthca/mthca_memfree.c
> @@ -472,8 +472,7 @@ int mthca_map_user_db(struct mthca_dev *dev, struct mthca_uar *uar,
>  		goto out;
>  	}
>  
> -	ret = get_user_pages_fast(uaddr & PAGE_MASK, 1,
> -				  FOLL_WRITE | FOLL_LONGTERM, pages);
> +	ret = pin_longterm_pages_fast(uaddr & PAGE_MASK, 1, FOLL_WRITE, pages);
>  	if (ret < 0)
>  		goto out;
>  
> diff --git a/drivers/infiniband/hw/qib/qib_user_pages.c b/drivers/infiniband/hw/qib/qib_user_pages.c
> index 6bf764e41891..684a14e14d9b 100644
> --- a/drivers/infiniband/hw/qib/qib_user_pages.c
> +++ b/drivers/infiniband/hw/qib/qib_user_pages.c
> @@ -108,10 +108,10 @@ int qib_get_user_pages(unsigned long start_page, size_t num_pages,
>  
>  	down_read(&current->mm->mmap_sem);
>  	for (got = 0; got < num_pages; got += ret) {
> -		ret = get_user_pages(start_page + got * PAGE_SIZE,
> -				     num_pages - got,
> -				     FOLL_LONGTERM | FOLL_WRITE | FOLL_FORCE,
> -				     p + got, NULL);
> +		ret = pin_longterm_pages(start_page + got * PAGE_SIZE,
> +					 num_pages - got,
> +					 FOLL_WRITE | FOLL_FORCE,
> +					 p + got, NULL);
>  		if (ret < 0) {
>  			up_read(&current->mm->mmap_sem);
>  			goto bail_release;
> diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c b/drivers/infiniband/hw/qib/qib_user_sdma.c
> index 05190edc2611..fd86a9d19370 100644
> --- a/drivers/infiniband/hw/qib/qib_user_sdma.c
> +++ b/drivers/infiniband/hw/qib/qib_user_sdma.c
> @@ -670,7 +670,7 @@ static int qib_user_sdma_pin_pages(const struct qib_devdata *dd,
>  		else
>  			j = npages;
>  
> -		ret = get_user_pages_fast(addr, j, FOLL_LONGTERM, pages);
> +		ret = pin_longterm_pages_fast(addr, j, 0, pages);
>  		if (ret != j) {
>  			i = 0;
>  			j = ret;
> diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
> index 62e6ffa9ad78..6b90ca1c3771 100644
> --- a/drivers/infiniband/hw/usnic/usnic_uiom.c
> +++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
> @@ -141,11 +141,10 @@ static int usnic_uiom_get_pages(unsigned long addr, size_t size, int writable,
>  	ret = 0;
>  
>  	while (npages) {
> -		ret = get_user_pages(cur_base,
> -				     min_t(unsigned long, npages,
> -				     PAGE_SIZE / sizeof(struct page *)),
> -				     gup_flags | FOLL_LONGTERM,
> -				     page_list, NULL);
> +		ret = pin_longterm_pages(cur_base,
> +					 min_t(unsigned long, npages,
> +					     PAGE_SIZE / sizeof(struct page *)),
> +					 gup_flags, page_list, NULL);
>  
>  		if (ret < 0)
>  			goto out;
> diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
> index e99983f07663..20e663d7ada8 100644
> --- a/drivers/infiniband/sw/siw/siw_mem.c
> +++ b/drivers/infiniband/sw/siw/siw_mem.c
> @@ -426,9 +426,8 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
>  		while (nents) {
>  			struct page **plist = &umem->page_chunk[i].plist[got];
>  
> -			rv = get_user_pages(first_page_va, nents,
> -					    foll_flags | FOLL_LONGTERM,
> -					    plist, NULL);
> +			rv = pin_longterm_pages(first_page_va, nents,
> +						foll_flags, plist, NULL);
>  			if (rv < 0)
>  				goto out_sem_up;
>  
> -- 
> 2.23.0
> 
