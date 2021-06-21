Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F083AED60
	for <lists+linux-block@lfdr.de>; Mon, 21 Jun 2021 18:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhFUQTm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 21 Jun 2021 12:19:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59376 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhFUQT1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 12:19:27 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5EA431FD4F;
        Mon, 21 Jun 2021 16:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624292231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcnedLC7fM3geHMNrXaVlo8lcxoxZ+rk18RDuHpobq4=;
        b=wdRF0v+kcz24oaSUCo1seaP7c8x8qsTjsy4protts29r92o0k2dhaAkfA3fNXDanm+Csa2
        9iMwgl9h4EGzPN0nLad9rrBYDbx6/Q4hFuihYDGdb4xVNdVuDOrbW+I20XzziDZfMo3Ao3
        k6zKsGZigctKhwbrNSFnARjQglEcgMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624292231;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcnedLC7fM3geHMNrXaVlo8lcxoxZ+rk18RDuHpobq4=;
        b=oL+miu7nn/RfkNu0GMgmIYG45tHcKRutTmZ180kpAYoJjiJBXKJNTh5I1BrII0phBoLDed
        obYOy5+WH3agU5Bg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id DC4E1118DD;
        Mon, 21 Jun 2021 16:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624292231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcnedLC7fM3geHMNrXaVlo8lcxoxZ+rk18RDuHpobq4=;
        b=wdRF0v+kcz24oaSUCo1seaP7c8x8qsTjsy4protts29r92o0k2dhaAkfA3fNXDanm+Csa2
        9iMwgl9h4EGzPN0nLad9rrBYDbx6/Q4hFuihYDGdb4xVNdVuDOrbW+I20XzziDZfMo3Ao3
        k6zKsGZigctKhwbrNSFnARjQglEcgMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624292231;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcnedLC7fM3geHMNrXaVlo8lcxoxZ+rk18RDuHpobq4=;
        b=oL+miu7nn/RfkNu0GMgmIYG45tHcKRutTmZ180kpAYoJjiJBXKJNTh5I1BrII0phBoLDed
        obYOy5+WH3agU5Bg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id bxCVJ4S70GAWKwAALh3uQQ
        (envelope-from <colyli@suse.de>); Mon, 21 Jun 2021 16:17:08 +0000
Subject: Ask help for code review (was Re: [PATCH 03/14] bcache: add initial
 data structures for nvm pages)
To:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, ying.huang@intel.com
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Qiaowei Ren <qiaowei.ren@intel.com>, axboe@kernel.dk
References: <20210615054921.101421-1-colyli@suse.de>
 <20210615054921.101421-4-colyli@suse.de>
From:   Coly Li <colyli@suse.de>
Message-ID: <24ad3795-813c-b50b-e983-56dccef1b0db@suse.de>
Date:   Tue, 22 Jun 2021 00:17:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210615054921.101421-4-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all my dear receivers (Christoph, Dan, Hannes, Jan and Ying),

I do need your help on code review for the following patch. This
series are posted and refined for 2 merge windows already but we
are lack of code review from more experienced kernel developers
like you all.

The following patch defines a set of on-NVDIMM memory objects,
which are used to support NVDIMM for bcache journalling. Currently
the testing hardware is Intel AEP (Apache Pass).

Qiangwei Ren and Jianpeng Ma work with me to compose a mini pages
allocator for NVDIMM pages, then we allocate non-volatiled memory
pages from NVDIMM to store bcache journal set. Then the jouranling
can be very fast and after system reboots, once the NVDIMM mapping
is done, bcache code can directly reference journal set memory
object without loading them via block layer interface.

In order to restore allocated non-volatile memory, we use a set of
list (named owner list) to trace all allocated non-volatile memory
pages identified by UUID. Just like the bcache journal set, the list
stored in NVDIMM and accessed directly as typical in-memory list,
the only difference is they are non-volatiled: we access the lists
directly from NVDIMM, update the list in-place.

This is why you can see pointers are defined in struct
bch_nvm_pgalloc_recs, because such object is reference directly as
memory object, and stored directly onto NVDIMM.

Current patch series works as expected with limited data-set on
both bcache-tools and patched kernel. Because the bcache btree nodes
are not stored onto NVDIMM yet, journaling for leaf node splitting
will be handled in later series.

The whole work of supporting NVDIMM for bcache will involve in,
- Storing bcache journal on NVDIMM
- Store bcache btree nodes on NVDIMM
- Store cached data on NVDIMM.
- On-NVDIMM objects consistency for power failure

In order to make the code review to be more easier, the first step
we submit storing journal on NVDIMM into upstream firstly, following
work will be submitted step by step.

Jens wants more widely review before taking this series into bcache
upstream, and you are all the experts I trust and have my respect.

I do ask for help of code review from you all. Especially for the
following particular data structure definition patch, because I
define pointers in memory structures and reference and store them on
the NVDIMM.

Thanks in advance for your help.

Coly Li




On 6/15/21 1:49 PM, Coly Li wrote:
> This patch initializes the prototype data structures for nvm pages
> allocator,
>
> - struct bch_nvm_pages_sb
> This is the super block allocated on each nvdimm namespace. A nvdimm
> set may have multiple namespaces, bch_nvm_pages_sb->set_uuid is used
> to mark which nvdimm set this name space belongs to. Normally we will
> use the bcache's cache set UUID to initialize this uuid, to connect this
> nvdimm set to a specified bcache cache set.
>
> - struct bch_owner_list_head
> This is a table for all heads of all owner lists. A owner list records
> which page(s) allocated to which owner. After reboot from power failure,
> the ownwer may find all its requested and allocated pages from the owner
> list by a handler which is converted by a UUID.
>
> - struct bch_nvm_pages_owner_head
> This is a head of an owner list. Each owner only has one owner list,
> and a nvm page only belongs to an specific owner. uuid[] will be set to
> owner's uuid, for bcache it is the bcache's cache set uuid. label is not
> mandatory, it is a human-readable string for debug purpose. The pointer
> *recs references to separated nvm page which hold the table of struct
> bch_nvm_pgalloc_rec.
>
> - struct bch_nvm_pgalloc_recs
> This struct occupies a whole page, owner_uuid should match the uuid
> in struct bch_nvm_pages_owner_head. recs[] is the real table contains all
> allocated records.
>
> - struct bch_nvm_pgalloc_rec
> Each structure records a range of allocated nvm pages.
>   - Bits  0 - 51: is pages offset of the allocated pages.
>   - Bits 52 - 57: allocaed size in page_size * order-of-2
>   - Bits 58 - 63: reserved.
> Since each of the allocated nvm pages are power of 2, using 6 bits to
> represent allocated size can have (1<<(1<<64) - 1) * PAGE_SIZE maximum
> value. It can be a 76 bits width range size in byte for 4KB page size,
> which is large enough currently.
>
> Signed-off-by: Coly Li <colyli@suse.de>
> Cc: Jianpeng Ma <jianpeng.ma@intel.com>
> Cc: Qiaowei Ren <qiaowei.ren@intel.com>
> ---
>  include/uapi/linux/bcache-nvm.h | 200 ++++++++++++++++++++++++++++++++
>  1 file changed, 200 insertions(+)
>  create mode 100644 include/uapi/linux/bcache-nvm.h
>
> diff --git a/include/uapi/linux/bcache-nvm.h b/include/uapi/linux/bcache-nvm.h
> new file mode 100644
> index 000000000000..5094a6797679
> --- /dev/null
> +++ b/include/uapi/linux/bcache-nvm.h
> @@ -0,0 +1,200 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +
> +#ifndef _UAPI_BCACHE_NVM_H
> +#define _UAPI_BCACHE_NVM_H
> +
> +#if (__BITS_PER_LONG == 64)
> +/*
> + * Bcache on NVDIMM data structures
> + */
> +
> +/*
> + * - struct bch_nvm_pages_sb
> + *   This is the super block allocated on each nvdimm namespace. A nvdimm
> + * set may have multiple namespaces, bch_nvm_pages_sb->set_uuid is used to mark
> + * which nvdimm set this name space belongs to. Normally we will use the
> + * bcache's cache set UUID to initialize this uuid, to connect this nvdimm
> + * set to a specified bcache cache set.
> + *
> + * - struct bch_owner_list_head
> + *   This is a table for all heads of all owner lists. A owner list records
> + * which page(s) allocated to which owner. After reboot from power failure,
> + * the ownwer may find all its requested and allocated pages from the owner
> + * list by a handler which is converted by a UUID.
> + *
> + * - struct bch_nvm_pages_owner_head
> + *   This is a head of an owner list. Each owner only has one owner list,
> + * and a nvm page only belongs to an specific owner. uuid[] will be set to
> + * owner's uuid, for bcache it is the bcache's cache set uuid. label is not
> + * mandatory, it is a human-readable string for debug purpose. The pointer
> + * recs references to separated nvm page which hold the table of struct
> + * bch_pgalloc_rec.
> + *
> + *- struct bch_nvm_pgalloc_recs
> + *  This structure occupies a whole page, owner_uuid should match the uuid
> + * in struct bch_nvm_pages_owner_head. recs[] is the real table contains all
> + * allocated records.
> + *
> + * - struct bch_pgalloc_rec
> + *   Each structure records a range of allocated nvm pages. pgoff is offset
> + * in unit of page size of this allocated nvm page range. The adjoint page
> + * ranges of same owner can be merged into a larger one, therefore pages_nr
> + * is NOT always power of 2.
> + *
> + *
> + * Memory layout on nvdimm namespace 0
> + *
> + *    0 +---------------------------------+
> + *      |                                 |
> + *  4KB +---------------------------------+
> + *      |         bch_nvm_pages_sb        |
> + *  8KB +---------------------------------+ <--- bch_nvm_pages_sb.bch_owner_list_head
> + *      |       bch_owner_list_head       |
> + *      |                                 |
> + * 16KB +---------------------------------+ <--- bch_owner_list_head.heads[0].recs[0]
> + *      |       bch_nvm_pgalloc_recs      |
> + *      |  (nvm pages internal usage)     |
> + * 24KB +---------------------------------+
> + *      |                                 |
> + *      |                                 |
> + * 16MB  +---------------------------------+
> + *      |      allocable nvm pages        |
> + *      |      for buddy allocator        |
> + * end  +---------------------------------+
> + *
> + *
> + *
> + * Memory layout on nvdimm namespace N
> + * (doesn't have owner list)
> + *
> + *    0 +---------------------------------+
> + *      |                                 |
> + *  4KB +---------------------------------+
> + *      |         bch_nvm_pages_sb        |
> + *  8KB +---------------------------------+
> + *      |                                 |
> + *      |                                 |
> + *      |                                 |
> + *      |                                 |
> + *      |                                 |
> + *      |                                 |
> + * 16MB  +---------------------------------+
> + *      |      allocable nvm pages        |
> + *      |      for buddy allocator        |
> + * end  +---------------------------------+
> + *
> + */
> +
> +#include <linux/types.h>
> +
> +/* In sectors */
> +#define BCH_NVM_PAGES_SB_OFFSET			4096
> +#define BCH_NVM_PAGES_OFFSET			(16 << 20)
> +
> +#define BCH_NVM_PAGES_LABEL_SIZE		32
> +#define BCH_NVM_PAGES_NAMESPACES_MAX		8
> +
> +#define BCH_NVM_PAGES_OWNER_LIST_HEAD_OFFSET	(8<<10)
> +#define BCH_NVM_PAGES_SYS_RECS_HEAD_OFFSET	(16<<10)
> +
> +#define BCH_NVM_PAGES_SB_VERSION		0
> +#define BCH_NVM_PAGES_SB_VERSION_MAX		0
> +
> +static const unsigned char bch_nvm_pages_magic[] = {
> +	0x17, 0xbd, 0x53, 0x7f, 0x1b, 0x23, 0xd6, 0x83,
> +	0x46, 0xa4, 0xf8, 0x28, 0x17, 0xda, 0xec, 0xa9 };
> +static const unsigned char bch_nvm_pages_pgalloc_magic[] = {
> +	0x39, 0x25, 0x3f, 0xf7, 0x27, 0x17, 0xd0, 0xb9,
> +	0x10, 0xe6, 0xd2, 0xda, 0x38, 0x68, 0x26, 0xae };
> +
> +/* takes 64bit width */
> +struct bch_pgalloc_rec {
> +	__u64	pgoff:52;
> +	__u64	order:6;
> +	__u64	reserved:6;
> +};
> +
> +struct bch_nvm_pgalloc_recs {
> +union {
> +	struct {
> +		struct bch_nvm_pages_owner_head	*owner;
> +		struct bch_nvm_pgalloc_recs	*next;
> +		unsigned char			magic[16];
> +		unsigned char			owner_uuid[16];
> +		unsigned int			size;
> +		unsigned int			used;
> +		unsigned long			_pad[4];
> +		struct bch_pgalloc_rec		recs[];
> +	};
> +	unsigned char				pad[8192];
> +};
> +};
> +
> +#define BCH_MAX_RECS					\
> +	((sizeof(struct bch_nvm_pgalloc_recs) -		\
> +	 offsetof(struct bch_nvm_pgalloc_recs, recs)) /	\
> +	 sizeof(struct bch_pgalloc_rec))
> +
> +struct bch_nvm_pages_owner_head {
> +	unsigned char			uuid[16];
> +	unsigned char			label[BCH_NVM_PAGES_LABEL_SIZE];
> +	/* Per-namespace own lists */
> +	struct bch_nvm_pgalloc_recs	*recs[BCH_NVM_PAGES_NAMESPACES_MAX];
> +};
> +
> +/* heads[0] is always for nvm_pages internal usage */
> +struct bch_owner_list_head {
> +union {
> +	struct {
> +		unsigned int			size;
> +		unsigned int			used;
> +		unsigned long			_pad[4];
> +		struct bch_nvm_pages_owner_head	heads[];
> +	};
> +	unsigned char				pad[8192];
> +};
> +};
> +#define BCH_MAX_OWNER_LIST				\
> +	((sizeof(struct bch_owner_list_head) -		\
> +	 offsetof(struct bch_owner_list_head, heads)) /	\
> +	 sizeof(struct bch_nvm_pages_owner_head))
> +
> +/* The on-media bit order is local CPU order */
> +struct bch_nvm_pages_sb {
> +	unsigned long				csum;
> +	unsigned long				ns_start;
> +	unsigned long				sb_offset;
> +	unsigned long				version;
> +	unsigned char				magic[16];
> +	unsigned char				uuid[16];
> +	unsigned int				page_size;
> +	unsigned int				total_namespaces_nr;
> +	unsigned int				this_namespace_nr;
> +	union {
> +		unsigned char			set_uuid[16];
> +		unsigned long			set_magic;
> +	};
> +
> +	unsigned long				flags;
> +	unsigned long				seq;
> +
> +	unsigned long				feature_compat;
> +	unsigned long				feature_incompat;
> +	unsigned long				feature_ro_compat;
> +
> +	/* For allocable nvm pages from buddy systems */
> +	unsigned long				pages_offset;
> +	unsigned long				pages_total;
> +
> +	unsigned long				pad[8];
> +
> +	/* Only on the first name space */
> +	struct bch_owner_list_head		*owner_list_head;
> +
> +	/* Just for csum_set() */
> +	unsigned int				keys;
> +	unsigned long				d[0];
> +};
> +#endif /* __BITS_PER_LONG == 64 */
> +
> +#endif /* _UAPI_BCACHE_NVM_H */

