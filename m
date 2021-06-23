Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586FB3B1436
	for <lists+linux-block@lfdr.de>; Wed, 23 Jun 2021 08:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhFWG4P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-block@lfdr.de>); Wed, 23 Jun 2021 02:56:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:42725 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhFWG4P (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 02:56:15 -0400
IronPort-SDR: sDwOAiY1EvqF9GAKsK/5gY/694rnXLYlX0szEnglOX815D5DptUfccAKfWDQddGFQYvLJaeaFS
 eEFYLzl04NSg==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="186894531"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="186894531"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 23:53:58 -0700
IronPort-SDR: Qu1NpAdKmc54ivDOZIL3DQLJK++vkcSmMR4weNkyZm0F+zPPiXIsQUlBHis+fyJU23VHUcj8So
 cNjFAnK0Uv5A==
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="452924921"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 23:53:55 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Coly Li <colyli@suse.de>
Cc:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.com>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org, Jianpeng Ma <jianpeng.ma@intel.com>,
        Qiaowei Ren <qiaowei.ren@intel.com>, axboe@kernel.dk
Subject: Re: Ask help for code review (was Re: [PATCH 03/14] bcache: add
 initial data structures for nvm pages)
References: <20210615054921.101421-1-colyli@suse.de>
        <20210615054921.101421-4-colyli@suse.de>
        <24ad3795-813c-b50b-e983-56dccef1b0db@suse.de>
        <875yy6l2a1.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <b1597c54-16ea-c943-8af7-25c8eab342e9@suse.de>
Date:   Wed, 23 Jun 2021 14:53:53 +0800
In-Reply-To: <b1597c54-16ea-c943-8af7-25c8eab342e9@suse.de> (Coly Li's message
        of "Wed, 23 Jun 2021 12:32:04 +0800")
Message-ID: <87czsdhy0u.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Coly Li <colyli@suse.de> writes:

> Hi Ying,
>
> I reply your comment in-place where you commented on.
>
> On 6/22/21 4:41 PM, Huang, Ying wrote:
>> Coly Li <colyli@suse.de> writes:
>>

[snip]

>>>> diff --git a/include/uapi/linux/bcache-nvm.h b/include/uapi/linux/bcache-nvm.h
>>>> new file mode 100644
>>>> index 000000000000..5094a6797679
>>>> --- /dev/null
>>>> +++ b/include/uapi/linux/bcache-nvm.h
>>>> @@ -0,0 +1,200 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>>>> +
>>>> +#ifndef _UAPI_BCACHE_NVM_H
>>>> +#define _UAPI_BCACHE_NVM_H
>>>> +
>>>> +#if (__BITS_PER_LONG == 64)
>>>> +/*
>>>> + * Bcache on NVDIMM data structures
>>>> + */
>>>> +
>>>> +/*
>>>> + * - struct bch_nvm_pages_sb
>>>> + *   This is the super block allocated on each nvdimm namespace. A nvdimm
>>>> + * set may have multiple namespaces, bch_nvm_pages_sb->set_uuid is used to mark
>>>> + * which nvdimm set this name space belongs to. Normally we will use the
>>>> + * bcache's cache set UUID to initialize this uuid, to connect this nvdimm
>>>> + * set to a specified bcache cache set.
>>>> + *
>>>> + * - struct bch_owner_list_head
>>>> + *   This is a table for all heads of all owner lists. A owner list records
>>>> + * which page(s) allocated to which owner. After reboot from power failure,
>>>> + * the ownwer may find all its requested and allocated pages from the owner
>>>> + * list by a handler which is converted by a UUID.
>>>> + *
>>>> + * - struct bch_nvm_pages_owner_head
>>>> + *   This is a head of an owner list. Each owner only has one owner list,
>>>> + * and a nvm page only belongs to an specific owner. uuid[] will be set to
>>>> + * owner's uuid, for bcache it is the bcache's cache set uuid. label is not
>>>> + * mandatory, it is a human-readable string for debug purpose. The pointer
>>>> + * recs references to separated nvm page which hold the table of struct
>>>> + * bch_pgalloc_rec.
>>>> + *
>>>> + *- struct bch_nvm_pgalloc_recs
>>>> + *  This structure occupies a whole page, owner_uuid should match the uuid
>>>> + * in struct bch_nvm_pages_owner_head. recs[] is the real table contains all
>>>> + * allocated records.
>>>> + *
>>>> + * - struct bch_pgalloc_rec
>>>> + *   Each structure records a range of allocated nvm pages. pgoff is offset
>>>> + * in unit of page size of this allocated nvm page range. The adjoint page
>>>> + * ranges of same owner can be merged into a larger one, therefore pages_nr
>>>> + * is NOT always power of 2.
>>>> + *
>>>> + *
>>>> + * Memory layout on nvdimm namespace 0
>>>> + *
>>>> + *    0 +---------------------------------+
>>>> + *      |                                 |
>>>> + *  4KB +---------------------------------+
>>>> + *      |         bch_nvm_pages_sb        |
>>>> + *  8KB +---------------------------------+ <--- bch_nvm_pages_sb.bch_owner_list_head
>>>> + *      |       bch_owner_list_head       |
>>>> + *      |                                 |
>>>> + * 16KB +---------------------------------+ <--- bch_owner_list_head.heads[0].recs[0]
>>>> + *      |       bch_nvm_pgalloc_recs      |
>>>> + *      |  (nvm pages internal usage)     |
>>>> + * 24KB +---------------------------------+
>>>> + *      |                                 |
>>>> + *      |                                 |
>>>> + * 16MB  +---------------------------------+
>>>> + *      |      allocable nvm pages        |
>>>> + *      |      for buddy allocator        |
>>>> + * end  +---------------------------------+
>>>> + *
>>>> + *
>>>> + *
>>>> + * Memory layout on nvdimm namespace N
>>>> + * (doesn't have owner list)
>>>> + *
>>>> + *    0 +---------------------------------+
>>>> + *      |                                 |
>>>> + *  4KB +---------------------------------+
>>>> + *      |         bch_nvm_pages_sb        |
>>>> + *  8KB +---------------------------------+
>>>> + *      |                                 |
>>>> + *      |                                 |
>>>> + *      |                                 |
>>>> + *      |                                 |
>>>> + *      |                                 |
>>>> + *      |                                 |
>>>> + * 16MB  +---------------------------------+
>>>> + *      |      allocable nvm pages        |
>>>> + *      |      for buddy allocator        |
>>>> + * end  +---------------------------------+
>>>> + *
>>>> + */
>>>> +
>>>> +#include <linux/types.h>
>>>> +
>>>> +/* In sectors */
>>>> +#define BCH_NVM_PAGES_SB_OFFSET			4096
>>>> +#define BCH_NVM_PAGES_OFFSET			(16 << 20)
>>>> +
>>>> +#define BCH_NVM_PAGES_LABEL_SIZE		32
>>>> +#define BCH_NVM_PAGES_NAMESPACES_MAX		8
>>>> +
>>>> +#define BCH_NVM_PAGES_OWNER_LIST_HEAD_OFFSET	(8<<10)
>>>> +#define BCH_NVM_PAGES_SYS_RECS_HEAD_OFFSET	(16<<10)
>>>> +
>>>> +#define BCH_NVM_PAGES_SB_VERSION		0
>>>> +#define BCH_NVM_PAGES_SB_VERSION_MAX		0
>>>> +
>>>> +static const unsigned char bch_nvm_pages_magic[] = {
>>>> +	0x17, 0xbd, 0x53, 0x7f, 0x1b, 0x23, 0xd6, 0x83,
>>>> +	0x46, 0xa4, 0xf8, 0x28, 0x17, 0xda, 0xec, 0xa9 };
>>>> +static const unsigned char bch_nvm_pages_pgalloc_magic[] = {
>>>> +	0x39, 0x25, 0x3f, 0xf7, 0x27, 0x17, 0xd0, 0xb9,
>>>> +	0x10, 0xe6, 0xd2, 0xda, 0x38, 0x68, 0x26, 0xae };
>>>> +
>>>> +/* takes 64bit width */
>>>> +struct bch_pgalloc_rec {
>>>> +	__u64	pgoff:52;
>>>> +	__u64	order:6;
>>>> +	__u64	reserved:6;
>>>> +};
>>>> +
>>>> +struct bch_nvm_pgalloc_recs {
>>>> +union {
>>>> +	struct {
>>>> +		struct bch_nvm_pages_owner_head	*owner;
>>>> +		struct bch_nvm_pgalloc_recs	*next;
>> I have concerns about using pointers directly in on-NVDIMM data
>> structure too.  How can you guarantee the NVDIMM devices will be mapped
>> to exact same virtual address across reboot?
>>
>
>
> We use the NVDIMM name space as memory, and from our testing and
> observation, the DAX mapping base address is consistent if the NVDIMM
> address from e820 table does not change.
>
> And from our testing and observation, the NVDIMM address from e820
> table does not change when,
> - NVDIMM and DRAM memory population does not change
> - Install more NVDIMM and/or DRAM based on existing memory population
> - NVDIMM always plugged in same slot location and no movement or swap
> - No CPU remove and change
>
> For 99.9%+ time when the hardware working healthily, the above condition
> can be assumed. Therefore we choose to store whole linear address
> (pointer) here, other than relative offset inside the NVDIMM name space.
>
> For the 0.0?% condition if the NVDIMM address from e820 table changes,
> because the last time DAX map address is stored in ns_start of struct
> bch_nvm_pages_sb, if the new DAX mapping address is different from
> ns_srart value, all pointers in the owner list can be updated by,
>     new_addr = (old_addr - old_ns_start) + new_ns_start
>
> The update can be very fast (and it can be power failure tolerant with
> carefully coding) for. Therefore we decide to store full linear address
> for directly memory access for 99%+ condition, and update the pointers
> for the 0.0?% condition when DAX mapping address of the NVDIMM changes.
>
> Handling DAX mapping address change is not current high priority task,
> our next task after this series merged will be the power failure tolerance
> of the owner list (from Intel developers) and storing bcache btree nodes
> on NVDIMM pages (from me).

Thanks for the detailed explanation.  Given "ns_start", this should work
even when the base address changed.

So the question becomes pointer vs. offset, which one is better.  I
guess that you prefer pointer because it's easier to be used.  How about
making the pointer in the NVDIMM like the per-cpu pointer?  Which is
implemented as an offset with the pointer type.  And it's not too
hard to be used.  With that, you don't need to maintain the code to
update all pointers when the base address is changed.

Best Regards,
Huang, Ying

>>>> +		unsigned char			magic[16];
>>>> +		unsigned char			owner_uuid[16];
>>>> +		unsigned int			size;
>>>> +		unsigned int			used;
>>>> +		unsigned long			_pad[4];
>>>> +		struct bch_pgalloc_rec		recs[];
>>>> +	};
>>>> +	unsigned char				pad[8192];
>>>> +};
>>>> +};
>>>> +
>>>> +#define BCH_MAX_RECS					\
>>>> +	((sizeof(struct bch_nvm_pgalloc_recs) -		\
>>>> +	 offsetof(struct bch_nvm_pgalloc_recs, recs)) /	\
>>>> +	 sizeof(struct bch_pgalloc_rec))
>>>> +
>>>> +struct bch_nvm_pages_owner_head {
>>>> +	unsigned char			uuid[16];
>>>> +	unsigned char			label[BCH_NVM_PAGES_LABEL_SIZE];
>>>> +	/* Per-namespace own lists */
>>>> +	struct bch_nvm_pgalloc_recs	*recs[BCH_NVM_PAGES_NAMESPACES_MAX];
>>>> +};
>>>> +
>>>> +/* heads[0] is always for nvm_pages internal usage */
>>>> +struct bch_owner_list_head {
>>>> +union {
>>>> +	struct {
>>>> +		unsigned int			size;
>>>> +		unsigned int			used;
>>>> +		unsigned long			_pad[4];
>>>> +		struct bch_nvm_pages_owner_head	heads[];
>>>> +	};
>>>> +	unsigned char				pad[8192];
>>>> +};
>>>> +};
>>>> +#define BCH_MAX_OWNER_LIST				\
>>>> +	((sizeof(struct bch_owner_list_head) -		\
>>>> +	 offsetof(struct bch_owner_list_head, heads)) /	\
>>>> +	 sizeof(struct bch_nvm_pages_owner_head))
>>>> +
>>>> +/* The on-media bit order is local CPU order */
>>>> +struct bch_nvm_pages_sb {
>>>> +	unsigned long				csum;
>>>> +	unsigned long				ns_start;
>>>> +	unsigned long				sb_offset;
>>>> +	unsigned long				version;
>>>> +	unsigned char				magic[16];
>>>> +	unsigned char				uuid[16];
>>>> +	unsigned int				page_size;
>>>> +	unsigned int				total_namespaces_nr;
>>>> +	unsigned int				this_namespace_nr;
>>>> +	union {
>>>> +		unsigned char			set_uuid[16];
>>>> +		unsigned long			set_magic;
>>>> +	};
>>>> +
>>>> +	unsigned long				flags;
>>>> +	unsigned long				seq;
>>>> +
>>>> +	unsigned long				feature_compat;
>>>> +	unsigned long				feature_incompat;
>>>> +	unsigned long				feature_ro_compat;
>>>> +
>>>> +	/* For allocable nvm pages from buddy systems */
>>>> +	unsigned long				pages_offset;
>>>> +	unsigned long				pages_total;
>>>> +
>>>> +	unsigned long				pad[8];
>>>> +
>>>> +	/* Only on the first name space */
>>>> +	struct bch_owner_list_head		*owner_list_head;
>>>> +
>>>> +	/* Just for csum_set() */
>>>> +	unsigned int				keys;
>>>> +	unsigned long				d[0];
>>>> +};
>>>> +#endif /* __BITS_PER_LONG == 64 */
>>>> +
>>>> +#endif /* _UAPI_BCACHE_NVM_H */
