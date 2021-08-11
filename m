Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105F13E966D
	for <lists+linux-block@lfdr.de>; Wed, 11 Aug 2021 19:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhHKRDv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 11 Aug 2021 13:03:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48268 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhHKRDu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 13:03:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D62B522210;
        Wed, 11 Aug 2021 17:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628701405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yw2Lnquz8mhvPAZ2zFhRmvTOY9GchEY3dKk/xW+CMHY=;
        b=j/kCwcXsQo2nFVQpMr/P7rW0iQKdxintNq8ljjA/843U90PM0eNXXQ0RzW8E3lZNsAX4tM
        DlMuYaxirRX8pZA+2gO/S7ncxyJ9RbslQ4kAeseuKWrBgYSWSiO/zg7a9DFB7R5nVmovCl
        eXT/fdX0R7QWEL/PxHFKt02BaQEeV10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628701405;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yw2Lnquz8mhvPAZ2zFhRmvTOY9GchEY3dKk/xW+CMHY=;
        b=KXe7GnQpgh+AlZ27agE5fiDWwXWk9qhJeRMug9lzaWWLqjJdTJn2VRaPCmQK/zYoI1GCvL
        qLE+4VepZoRjznCg==
Received: from localhost.localdomain (colyli.tcp.ovpn1.nue.suse.de [10.163.16.22])
        by relay2.suse.de (Postfix) with ESMTP id F3F5EA3D58;
        Wed, 11 Aug 2021 17:03:19 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-nvdimm@lists.linux.dev,
        axboe@kernel.dk, hare@suse.com, jack@suse.cz,
        dan.j.williams@intel.com, hch@lst.de, ying.huang@intel.com,
        Coly Li <colyli@suse.de>, Hannes Reinecke <hare@suse.de>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Qiaowei Ren <qiaowei.ren@intel.com>
Subject: [PATCH v12 01/12] bcache: add initial data structures for nvm pages
Date:   Thu, 12 Aug 2021 01:02:13 +0800
Message-Id: <20210811170224.42837-2-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210811170224.42837-1-colyli@suse.de>
References: <20210811170224.42837-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch initializes the prototype data structures for nvm pages
allocator,

- struct bch_nvmpg_sb
  This is the super block allocated on each nvdimm namespace for the nvm
pages allocator. A nvdimm pages allocator set may have multiple name-
spaces, bch_nvmpg_sb->set_uuid is used to mark which nvdimm set this
namespace belongs to.

- struct bch_nvmpg_header
  This is a table for all heads of all allocation record lists. An allo-
cation record list traces all page(s) allocated from nvdimm namespace(s)
to a specific requester (identified by uuid). After system reboot, a
requester can retrieve all previously allocated nvdimm pages from its
record list by a pre-defined uuid.

- struct bch_nvmpg_head
  This is a head of an allocation record list. Each nvdimm pages
requester (typically it's a driver) has and only has one allocation
record list, and an allocated nvdimm page only belongs to a specific
allocation record list. Member uuid[] will be set as the requester's
uuid, e.g. for bcache it is the cache set uuid. Member label is not
mandatory, it is a human-readable string for debug purpose. The nvm
offset format pointers recs_offset[] point to the location of actual
allocator record lists on each namespace of the nvdimm pages allocator
set. Each per namespace record list is represented by the following
struct bch_nvmpg_recs.

- struct bch_nvmpg_recs
  This structure represents a requester's allocation record list. Member
uuid is same value as the uuid of its corresponding struct
bch_nvmpg_head. Member recs[] is a table of struct bch_pgalloc_rec
objects to trace all allocated nvmdimm pages. If the table recs[] is
full, the nvmpg format offset is a pointer points to the next struct
bch_nvmpg_recs object, nvm pages allocator will look for available free
allocation record there. All the linked struct bch_nvmpg_recs objects
compose a requester's alloction record list which is headed by the above
struct bch_nvmpg_head.

- struct bch_nvmpg_recs
  This structure records a range of allocated nvdimm pages. Member pgoff
is offset in unit of page size of this allocation range. Member order
indicates size of the allocation range by (1 << order) in unit of page
size. Because the nvdimm pages allocator set may have multiple nvdimm
namespaces, member ns_id is used to identify which namespace the pgoff
belongs to.
  - Bits  0 - 51: pgoff - is pages offset of the allocated pages.
  - Bits 52 - 57: order - allocaed size in page_size * order-of-2
  - Bits 58 - 60: ns_id - identify which namespace the pages stays on
  - Bits 61 - 63: reserved.
Since each of the allocated nvm pages are power of 2, using 6 bits to
represent allocated size can have (1<<(1<<64) - 1) * PAGE_SIZE maximum
value. It can be a 76 bits width range size in byte for 4KB page size,
which is large enough currently.

All the structure members having _offset suffix are in a special fomat.
E.g. bch_nvmpg_sb.{sb_offset, pages_offset, set_header_offset},
bch_nvmpg_head.recs_offset, bch_nvmpg_recs.{head_offset, next_offset},
the offset value is 64bit, the most significant 3 bits are used to
identify which namespace this offset belongs to, and the rested 61 bits
are actual offset inside the namespace. Following patches will have
helper routines to do the conversion between memory pointer and offset.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jianpeng Ma <jianpeng.ma@intel.com>
Cc: Qiaowei Ren <qiaowei.ren@intel.com>
Cc: Ying Huang <ying.huang@intel.com>
---
 include/uapi/linux/bcache-nvm.h | 253 ++++++++++++++++++++++++++++++++
 1 file changed, 253 insertions(+)
 create mode 100644 include/uapi/linux/bcache-nvm.h

diff --git a/include/uapi/linux/bcache-nvm.h b/include/uapi/linux/bcache-nvm.h
new file mode 100644
index 000000000000..0e1082bb88ee
--- /dev/null
+++ b/include/uapi/linux/bcache-nvm.h
@@ -0,0 +1,253 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef _UAPI_BCACHE_NVM_H
+#define _UAPI_BCACHE_NVM_H
+
+/*
+ * Bcache on NVDIMM data structures
+ */
+
+/*
+ * - struct bch_nvmpg_sb
+ *   This is the super block allocated on each nvdimm namespace for the nvm
+ * pages allocator. A nvdimm pages allocator set may have multiple namespaces,
+ * bch_nvmpg_sb->set_uuid is used to mark which nvdimm set this name space
+ * belongs to.
+ *
+ * - struct bch_nvmpg_header
+ *   This is a table for all heads of all allocation record lists. An allo-
+ * cation record list traces all page(s) allocated from nvdimm namespace(s) to
+ * a specific requester (identified by uuid). After system reboot, a requester
+ * can retrieve all previously allocated nvdimm pages from its record list by a
+ * pre-defined uuid.
+ *
+ * - struct bch_nvmpg_head
+ *   This is a head of an allocation record list. Each nvdimm pages requester
+ * (typically it's a driver) has and only has one allocation record list, and
+ * an allocated nvdimm page only bedlones to a specific allocation record list.
+ * Member uuid[] will be set as the requester's uuid, e.g. for bcache it is the
+ * cache set uuid. Member label is not mandatory, it is a human-readable string
+ * for debug purpose. The nvm offset format pointers recs_offset[] point to the
+ * location of actual allocator record lists on each name space of the nvdimm
+ * pages allocator set. Each per name space record list is represented by the
+ * following struct bch_nvmpg_recs.
+ *
+ * - struct bch_nvmpg_recs
+ *   This structure represents a requester's allocation record list. Member uuid
+ * is same value as the uuid of its corresponding struct bch_nvmpg_head. Member
+ * recs[] is a table of struct bch_pgalloc_rec objects to trace all allocated
+ * nvmdimm pages. If the table recs[] is full, the nvmpg format offset is a
+ * pointer points to the next struct bch_nvmpg_recs object, nvm pages allocator
+ * will look for available free allocation record there. All the linked
+ * struct bch_nvmpg_recs objects compose a requester's alloction record list
+ * which is headed by the above struct bch_nvmpg_head.
+ *
+ * - struct bch_nvmpg_rec
+ *   This structure records a range of allocated nvdimm pages. Member pgoff is
+ * offset in unit of page size of this allocation range. Member order indicates
+ * size of the allocation range by (1 << order) in unit of page size. Because
+ * the nvdimm pages allocator set may have multiple nvdimm name spaces, member
+ * ns_id is used to identify which name space the pgoff belongs to.
+ *
+ * All allocation record lists are stored on the first initialized nvdimm name-
+ * space (ns_id 0). The meta data default layout of nvm pages allocator on
+ * namespace 0 is,
+ *
+ *    0 +---------------------------------+
+ *      |                                 |
+ *  4KB +---------------------------------+ <-- BCH_NVMPG_SB_OFFSET
+ *      |          bch_nvmpg_sb           |
+ *  8KB +---------------------------------+ <-- BCH_NVMPG_RECLIST_HEAD_OFFSET
+ *      |        bch_nvmpg_header         |
+ *      |                                 |
+ * 16KB +---------------------------------+ <-- BCH_NVMPG_SYSRECS_OFFSET
+ *      |         bch_nvmpg_recs          |
+ *      |  (nvm pages internal usage)     |
+ * 24KB +---------------------------------+
+ *      |                                 |
+ *      |                                 |
+ * 16MB +---------------------------------+ <-- BCH_NVMPG_START
+ *      |      allocable nvm pages        |
+ *      |      for buddy allocator        |
+ * end  +---------------------------------+
+ *
+ *
+ *
+ * Meta data default layout on rested nvdimm namespaces,
+ *
+ *    0 +---------------------------------+
+ *      |                                 |
+ *  4KB +---------------------------------+ <-- BCH_NVMPG_SB_OFFSET
+ *      |          bch_nvmpg_sb           |
+ *  8KB +---------------------------------+
+ *      |                                 |
+ *      |                                 |
+ *      |                                 |
+ *      |                                 |
+ *      |                                 |
+ *      |                                 |
+ * 16MB +---------------------------------+ <-- BCH_NVMPG_START
+ *      |      allocable nvm pages        |
+ *      |      for buddy allocator        |
+ * end  +---------------------------------+
+ *
+ *
+ * - The nvmpg offset format pointer
+ *   All member names ending with _offset in this header are nvmpg offset
+ * format pointer. The offset format is,
+ *       [highest 3 bits: ns_id]
+ *       [rested 61 bits: offset in No. ns_id namespace]
+ *
+ * The above offset is byte unit, the procedure to reference a nvmpg offset
+ * format pointer is,
+ * 1) Identify the namespace related in-memory structure by ns_id from the
+ *    highest 3 bits of offset value.
+ * 2) Get the DAX mapping base address from the in-memory structure.
+ * 3) Calculate the actual memory address on nvdimm by plusing the DAX base
+ *    address with offset value in rested low 61 bits.
+ * All related in-memory structure and conversion routines don't belong to
+ * user space api, they are defined by nvm-pages allocator code in
+ * drivers/md/bcache/nvm-pages.{c,h}
+ *
+ */
+
+#include <linux/types.h>
+
+/* In sectors */
+#define BCH_NVMPG_SB_OFFSET		4096
+#define BCH_NVMPG_START			(16 << 20)
+
+#define BCH_NVMPG_LBL_SIZE		32
+#define BCH_NVMPG_NS_MAX		8
+
+#define BCH_NVMPG_RECLIST_HEAD_OFFSET	(8<<10)
+#define BCH_NVMPG_SYSRECS_OFFSET	(16<<10)
+
+#define BCH_NVMPG_SB_VERSION		0
+#define BCH_NVMPG_SB_VERSION_MAX	0
+
+static const __u8 bch_nvmpg_magic[] = {
+	0x17, 0xbd, 0x53, 0x7f, 0x1b, 0x23, 0xd6, 0x83,
+	0x46, 0xa4, 0xf8, 0x28, 0x17, 0xda, 0xec, 0xa9 };
+static const __u8 bch_nvmpg_recs_magic[] = {
+	0x39, 0x25, 0x3f, 0xf7, 0x27, 0x17, 0xd0, 0xb9,
+	0x10, 0xe6, 0xd2, 0xda, 0x38, 0x68, 0x26, 0xae };
+
+/* takes 64bit width */
+struct bch_nvmpg_rec {
+	union {
+		struct {
+			__u64	pgoff:52;
+			__u64	order:6;
+			__u64	ns_id:3;
+			__u64	reserved:3;
+		};
+		__u64	_v;
+	};
+};
+
+struct bch_nvmpg_recs {
+	union {
+		struct {
+			/*
+			 * A nvmpg offset format pointer to
+			 * struct bch_nvmpg_head
+			 */
+			__u64			head_offset;
+			/*
+			 * A nvmpg offset format pointer to
+			 * struct bch_nvm_pgalloc_recs which contains
+			 * the next recs[] array.
+			 */
+			__u64			next_offset;
+			__u8			magic[16];
+			__u8			uuid[16];
+			__u32			size;
+			__u32			used;
+			__u64			_pad[4];
+			struct bch_nvmpg_rec	recs[];
+		};
+		__u8				pad[8192];
+	};
+};
+
+#define BCH_NVMPG_MAX_RECS				\
+	((sizeof(struct bch_nvmpg_recs) -		\
+	  offsetof(struct bch_nvmpg_recs, recs)) /	\
+	 sizeof(struct bch_nvmpg_rec))
+
+#define BCH_NVMPG_HD_STAT_FREE		0x0
+#define BCH_NVMPG_HD_STAT_ALLOC		0x1
+struct bch_nvmpg_head {
+	__u8		uuid[16];
+	__u8		label[BCH_NVMPG_LBL_SIZE];
+	__u32		state;
+	__u32		flags;
+	/*
+	 * Array of offset values from the nvmpg offset format
+	 * pointers, each of the pointer points to a per-namespace
+	 * struct bch_nvmpg_recs.
+	 */
+	__u64		recs_offset[BCH_NVMPG_NS_MAX];
+};
+
+/* heads[0] is always for nvm_pages internal usage */
+struct bch_nvmpg_set_header {
+	union {
+		struct {
+			__u32			size;
+			__u32			used;
+			__u64			_pad[4];
+			struct bch_nvmpg_head	heads[];
+		};
+		__u8				pad[8192];
+	};
+};
+
+#define BCH_NVMPG_MAX_HEADS					\
+	((sizeof(struct bch_nvmpg_set_header) -			\
+	  offsetof(struct bch_nvmpg_set_header, heads)) /	\
+	 sizeof(struct bch_nvmpg_head))
+
+/* The on-media bit order is local CPU order */
+struct bch_nvmpg_sb {
+	__u64			csum;
+	__u64			sb_offset;
+	__u64			ns_start;
+	__u64			version;
+	__u8			magic[16];
+	__u8			uuid[16];
+	__u32			page_size;
+	__u32			total_ns;
+	__u32			this_ns;
+	union {
+		__u8		set_uuid[16];
+		__u64		set_magic;
+	};
+
+	__u64			flags;
+	__u64			seq;
+
+	__u64			feature_compat;
+	__u64			feature_incompat;
+	__u64			feature_ro_compat;
+
+	/* For allocable nvm pages from buddy systems */
+	__u64			pages_offset;
+	__u64			pages_total;
+
+	__u64			pad[8];
+
+	/*
+	 * A nvmpg offset format pointer, it points
+	 * to struct bch_nvmpg_set_header which is
+	 * stored only on the first name space.
+	 */
+	__u64			set_header_offset;
+
+	/* Just for csum_set() */
+	__u32			keys;
+	__u64			d[0];
+};
+
+#endif /* _UAPI_BCACHE_NVM_H */
-- 
2.26.2

