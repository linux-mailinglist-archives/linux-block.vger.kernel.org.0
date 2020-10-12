Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D9A28BDB3
	for <lists+linux-block@lfdr.de>; Mon, 12 Oct 2020 18:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403842AbgJLQ2Q (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 12 Oct 2020 12:28:16 -0400
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com ([40.107.243.41]:58465
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403809AbgJLQ2N (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Oct 2020 12:28:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFpE0cv9VUJClI6EjBT13zzPKCelzk9d0q6trQrmuN+pm9QgUxSfh4yF5HKaDQyRfBwmGPfMbatvAM5xCRNCJS64r2nk0OTb6nKdr3UDOnOK0c/eDhJSofMd9gr17Kb+hTI5d7Bj+TKQF9rLd7soi6uRxfVzYIMT6IuL0dYw15Hbd+pjqYxIuDLl4U+a2Fa5aMYmqs5NRSXuHVubT4dAJmmGVaF3IVz1LOwcQA8zELf+hQ/ptKgbnE+S4OeISfRXsxJZ/xb92SlwPggiONp3XFlulkePniPhNjXE2YGr5qdBe+vRBsiijmOI4KkwMcsHvxhf+qNCthNndgkMMgJy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUslZuWHgaMMCjTRndro6LXHrMR+8pxbpxWqvKPKqmQ=;
 b=mqjylcrHud17r7nrLE+VYI3GElr1tYm4mvTURJcFl0ZRVuXKPZAn+mAXz2UtHwpT61kcduBKk5H42vqX/NCWd6+1iBVWYwuWqU/2LOKE8P6+rCduldV8GU5UqeOrOXXpEztjZTUTVkTjFf0ZG6wW4yIWD8fm8sydgM+7hZOVXEjzq+Ig5PrAYZQIYaVNEQtHQ/20TITxEtgENF+kbEqboXv/CMlwgXWngoYJco/NrTBbDoLjmzU0m9/oCkL5/aCCLXLq4VIDdpy23QkoDWvg4JiUR7uEAK82O8YZ19PER5LgOx4t17A36dTa3XDyuHrNvAFvxB1qiHUPJJw8oOZLMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=kvack.org smtp.mailfrom=micron.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUslZuWHgaMMCjTRndro6LXHrMR+8pxbpxWqvKPKqmQ=;
 b=Dk19TubV0xiyEXIAiUCk0+Yv6HR1yPSGqsycGDH2QKZnAYN4VM3SyoNnWTFL8xJuyP6COyLKs7mVmcLnkDDPiUiW6SjJXoqtXNDtLzoyCTtN22hBWMJOpX3xSuFVQ0Nm5WsrfUMHg7FC/NPS1pM3bdoZIDKUEw5+zvm/aGWJMdA=
Received: from SN4PR0201CA0060.namprd02.prod.outlook.com
 (2603:10b6:803:20::22) by SN4PR0801MB3805.namprd08.prod.outlook.com
 (2603:10b6:803:49::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.29; Mon, 12 Oct
 2020 16:28:09 +0000
Received: from SN1NAM01FT015.eop-nam01.prod.protection.outlook.com
 (2603:10b6:803:20:cafe::1f) by SN4PR0201CA0060.outlook.office365.com
 (2603:10b6:803:20::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend
 Transport; Mon, 12 Oct 2020 16:28:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com;
Received: from mail.micron.com (137.201.242.130) by
 SN1NAM01FT015.mail.protection.outlook.com (10.152.65.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3455.23 via Frontend Transport; Mon, 12 Oct 2020 16:28:08 +0000
Received: from micron.com (10.114.5.55) by bowex17c.micron.com
 (137.201.21.211) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Oct
 2020 10:28:02 -0600
From:   Nabeel M Mohamed <nmeeramohide@micron.com>
To:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux-nvdimm@lists.01.org>
CC:     <smoyer@micron.com>, <gbecker@micron.com>, <plabat@micron.com>,
        <jgroves@micron.com>, Nabeel M Mohamed <nmeeramohide@micron.com>
Subject: [PATCH v2 09/22] mpool: add mblock lifecycle management and IO routines
Date:   Mon, 12 Oct 2020 11:27:23 -0500
Message-ID: <20201012162736.65241-10-nmeeramohide@micron.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20201012162736.65241-1-nmeeramohide@micron.com>
References: <20201012162736.65241-1-nmeeramohide@micron.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bowex17a.micron.com (137.201.21.209) To bowex17c.micron.com
 (137.201.21.211)
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24646.005
X-TM-AS-Result: No--14.586700-0.000000-31
X-TM-AS-MatchedID: 702732-703812-705244-701073-702751-703115-704949-704585-7
        01844-704318-701656-703966-704499-704397-700335-705161-113230-701480-701809
        -703017-703140-702395-188019-703213-121336-701105-704673-703967-703027-7024
        15-701275-703815-702754-704895-702688-701964-780039-701880-105250-705018-70
        1744-703534-704002-704477-703694-700714-851458-700958-704401-700717-702779-
        702960-702874-701919-704749-701847-847575-703080-703215-704714-700286-70281
        2-702719-703286-703953-701723-825159-703357-702914-703958-705247-121270-704
        264-703816-703954-700863-704418-701698-703904-704001-702525-700698-704718-7
        03117-702558-701032-701724-148004-148036-42000-42003
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be77ac95-f52c-44b1-f65d-08d86ecbce1c
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3805:
X-Microsoft-Antispam-PRVS: <SN4PR0801MB3805BFFF1C3F020F8323A15EB3070@SN4PR0801MB3805.namprd08.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Oob-TLC-OOBClassifiers: OLM:104;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1RnQalBCmqJesLQUVfOOnZHOy2DszZxW6uMVPsw+Gj9Iekz4b+rjLAVGB497ECW3J3xamOiPFFlyYf28fDlZcl2F1jVR/HHJIhSwgtJnYRwViVrVt/nSMRMnFzrVUFU4/kXBkIyIWpf+ANrXACNNRbQIdJ65lxEpHsv5kDE0/1F6bRsPDKuhAYIRXcwAxR5w65U5O1mds/pK+ebgmNMh6uLiCYb1wKecMz7pHG9Qv5aLCs2hC/dJ5fjH7HdZBEG1OXbZoRjcyU4moOoSh+qJcptZ97TbYwG9kwHzVosehcZEN+A0tM8hQgo/LdrnS3VGFgKUtmcx39nxpPrFBqJrzA4SRb5UT+Uz4bNFCmulieHdInkBZjw7gHai3fBO5tSiT1RaAIhM0FcROyc01mPVdk3tw8BuFGC7dQnzs+IiGBoKfMX7HbWIW7sMdA18fNCL+8xzzRGO5z88VpsmQYALKg==
X-Forefront-Antispam-Report: CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(46966005)(55016002)(356005)(2906002)(186003)(8676002)(110136005)(47076004)(82740400003)(478600001)(86362001)(33310700002)(7636003)(54906003)(6666004)(316002)(30864003)(6286002)(82310400003)(8936002)(4326008)(5660300002)(7696005)(336012)(70586007)(70206006)(2616005)(83380400001)(107886003)(1076003)(26005)(36756003)(426003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 16:28:08.6757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be77ac95-f52c-44b1-f65d-08d86ecbce1c
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM01FT015.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0801MB3805
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Implements the mblock lifecycle management functions: allocate,
commit, abort, read, write, destroy etc.

Mblocks are containers comprising a linear sequence of bytes that
can be written exactly once, are immutable after writing, and can
be read in whole or in part as needed until deleted.

Mpool currently supports only fixed size mblocks whose size is the
same as the zone size and is established at mpool create.

Mblock API uses the metadata manager interface to reserve storage
space at allocation time, store metadata for the mblock in its
associated MDC-K when committing it, record end-of-life for the
mblock in its associated MDC-K when deleting it and read/write
mblock data.

Co-developed-by: Greg Becker <gbecker@micron.com>
Signed-off-by: Greg Becker <gbecker@micron.com>
Co-developed-by: Pierre Labat <plabat@micron.com>
Signed-off-by: Pierre Labat <plabat@micron.com>
Co-developed-by: John Groves <jgroves@micron.com>
Signed-off-by: John Groves <jgroves@micron.com>
Signed-off-by: Nabeel M Mohamed <nmeeramohide@micron.com>
---
 drivers/mpool/mblock.c | 432 +++++++++++++++++++++++++++++++++++++++++
 drivers/mpool/mblock.h | 161 +++++++++++++++
 2 files changed, 593 insertions(+)
 create mode 100644 drivers/mpool/mblock.c
 create mode 100644 drivers/mpool/mblock.h

diff --git a/drivers/mpool/mblock.c b/drivers/mpool/mblock.c
new file mode 100644
index 000000000000..10c47ec74ff6
--- /dev/null
+++ b/drivers/mpool/mblock.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+/*
+ * DOC: Module info.
+ *
+ * Mblock module.
+ *
+ * Defines functions for writing, reading, and managing the lifecycle
+ * of mblocks.
+ *
+ */
+
+#include <linux/vmalloc.h>
+#include <linux/blk_types.h>
+#include <linux/mm.h>
+
+#include "mpool_printk.h"
+#include "assert.h"
+
+#include "pd.h"
+#include "pmd_obj.h"
+#include "mpcore.h"
+#include "mblock.h"
+
+/**
+ * mblock2layout() - convert opaque mblock handle to pmd_layout
+ *
+ * This function converts the opaque handle (mblock_descriptor) used by
+ * clients to the internal representation (pmd_layout).  The
+ * conversion is a simple cast, followed by a sanity check to verify the
+ * layout object is an mblock object.  If the validation fails, a NULL
+ * pointer is returned.
+ */
+static struct pmd_layout *mblock2layout(struct mblock_descriptor *mbh)
+{
+	struct pmd_layout *layout = (void *)mbh;
+
+	if (!layout)
+		return NULL;
+
+	ASSERT(layout->eld_objid > 0);
+	ASSERT(kref_read(&layout->eld_ref) >= 2);
+
+	return mblock_objid(layout->eld_objid) ? layout : NULL;
+}
+
+static u32 mblock_optimal_iosz_get(struct mpool_descriptor *mp, struct pmd_layout *layout)
+{
+	struct mpool_dev_info *pd = pmd_layout_pd_get(mp, layout);
+
+	return pd->pdi_optiosz;
+}
+
+/**
+ * layout2mblock() - convert pmd_layout to opaque mblock_descriptor
+ *
+ * This function converts the internally used pmd_layout to
+ * the externally used opaque mblock_descriptor.
+ */
+static struct mblock_descriptor *layout2mblock(struct pmd_layout *layout)
+{
+	return (struct mblock_descriptor *)layout;
+}
+
+static void mblock_getprops_cmn(struct mpool_descriptor *mp, struct pmd_layout *layout,
+				struct mblock_props *prop)
+{
+	struct mpool_dev_info *pd;
+
+	pd = pmd_layout_pd_get(mp, layout);
+
+	prop->mpr_objid = layout->eld_objid;
+	prop->mpr_alloc_cap = pmd_layout_cap_get(mp, layout);
+	prop->mpr_write_len = layout->eld_mblen;
+	prop->mpr_optimal_wrsz = mblock_optimal_iosz_get(mp, layout);
+	prop->mpr_mclassp = pd->pdi_mclass;
+	prop->mpr_iscommitted = layout->eld_state & PMD_LYT_COMMITTED;
+}
+
+static int mblock_alloc_cmn(struct mpool_descriptor *mp, u64 objid,
+			    enum mp_media_classp mclassp, bool spare,
+			    struct mblock_props *prop, struct mblock_descriptor **mbh)
+{
+	struct pmd_obj_capacity ocap = { .moc_spare = spare };
+	struct pmd_layout *layout = NULL;
+	int rc;
+
+	if (!mp)
+		return -EINVAL;
+
+	*mbh = NULL;
+
+	if (!objid) {
+		rc = pmd_obj_alloc(mp, OMF_OBJ_MBLOCK, &ocap, mclassp, &layout);
+		if (rc)
+			return rc;
+	} else {
+		rc = pmd_obj_realloc(mp, objid, &ocap, mclassp, &layout);
+		if (rc) {
+			if (rc != -ENOENT)
+				mp_pr_err("mpool %s, re-allocating mblock 0x%lx failed",
+					  rc, mp->pds_name, (ulong)objid);
+			return rc;
+		}
+	}
+
+	if (!layout)
+		return -ENOTRECOVERABLE;
+
+	if (prop) {
+		pmd_obj_rdlock(layout);
+		mblock_getprops_cmn(mp, layout, prop);
+		pmd_obj_rdunlock(layout);
+	}
+
+	*mbh = layout2mblock(layout);
+
+	return 0;
+}
+
+int mblock_alloc(struct mpool_descriptor *mp, enum mp_media_classp mclassp, bool spare,
+		 struct mblock_descriptor **mbh, struct mblock_props *prop)
+{
+	return mblock_alloc_cmn(mp, 0, mclassp, spare, prop, mbh);
+}
+
+int mblock_find_get(struct mpool_descriptor *mp, u64 objid, int which,
+		    struct mblock_props *prop, struct mblock_descriptor **mbh)
+{
+	struct pmd_layout *layout;
+
+	*mbh = NULL;
+
+	if (!mblock_objid(objid))
+		return -EINVAL;
+
+	layout = pmd_obj_find_get(mp, objid, which);
+	if (!layout)
+		return -ENOENT;
+
+	if (prop) {
+		pmd_obj_rdlock(layout);
+		mblock_getprops_cmn(mp, layout, prop);
+		pmd_obj_rdunlock(layout);
+	}
+
+	*mbh = layout2mblock(layout);
+
+	return 0;
+}
+
+void mblock_put(struct mblock_descriptor *mbh)
+{
+	struct pmd_layout *layout;
+
+	layout = mblock2layout(mbh);
+	if (layout)
+		pmd_obj_put(layout);
+}
+
+/*
+ * Helper function to log a message that many functions need to log:
+ */
+#define mp_pr_layout_not_found(_mp, _mbh)				\
+do {									\
+	static unsigned long state;					\
+	uint dly = msecs_to_jiffies(1000);				\
+									\
+	if (printk_timed_ratelimit(&state, dly)) {			\
+		mp_pr_warn("mpool %s, layout not found: mbh %p",	\
+			   (_mp)->pds_name, (_mbh));			\
+		dump_stack();						\
+	}								\
+} while (0)
+
+int mblock_commit(struct mpool_descriptor *mp, struct mblock_descriptor *mbh)
+{
+	struct mpool_dev_info *pd;
+	struct pmd_layout *layout;
+	int rc;
+
+	layout = mblock2layout(mbh);
+	if (!layout) {
+		mp_pr_layout_not_found(mp, mbh);
+		return -EINVAL;
+	}
+
+	pd = pmd_layout_pd_get(mp, layout);
+	if (!pd->pdi_fua) {
+		rc = pd_dev_flush(&pd->pdi_parm);
+		if (rc)
+			return rc;
+	}
+
+	/* Commit will fail with EBUSY if aborting flag set. */
+	rc = pmd_obj_commit(mp, layout);
+	if (rc) {
+		mp_pr_rl("mpool %s, committing mblock 0x%lx failed",
+			 rc, mp->pds_name, (ulong)layout->eld_objid);
+		return rc;
+	}
+
+	return 0;
+}
+
+int mblock_abort(struct mpool_descriptor *mp, struct mblock_descriptor *mbh)
+{
+	struct pmd_layout *layout;
+	int rc;
+
+	layout = mblock2layout(mbh);
+	if (!layout) {
+		mp_pr_layout_not_found(mp, mbh);
+		return -EINVAL;
+	}
+
+	rc = pmd_obj_abort(mp, layout);
+	if (rc) {
+		mp_pr_err("mpool %s, aborting mblock 0x%lx failed",
+			  rc, mp->pds_name, (ulong)layout->eld_objid);
+		return rc;
+	}
+
+	return 0;
+}
+
+int mblock_delete(struct mpool_descriptor *mp, struct mblock_descriptor *mbh)
+{
+	struct pmd_layout *layout;
+
+	layout = mblock2layout(mbh);
+	if (!layout) {
+		mp_pr_layout_not_found(mp, mbh);
+		return -EINVAL;
+	}
+
+	return pmd_obj_delete(mp, layout);
+}
+
+/**
+ * mblock_rw_argcheck() - Validate mblock_write() and mblock_read().
+ * @mp:      Mpool descriptor
+ * @layout:  Layout of the mblock
+ * @iov:     iovec array
+ * @iovcnt:  iovec count
+ * @boff:    Byte offset into the layout.  Must be equal to layout->eld_mblen for write
+ * @rw:      MPOOL_OP_READ or MPOOL_OP_WRITE
+ * @len:     number of bytes in iov list
+ *
+ * Returns: 0 if successful, -errno otherwise
+ *
+ * Note: be aware that there are checks in this function that prevent illegal
+ * arguments in lower level functions (lower level functions should assert the
+ * requirements but not otherwise check them)
+ */
+static int mblock_rw_argcheck(struct mpool_descriptor *mp, struct pmd_layout *layout,
+			      loff_t boff, int rw, size_t len)
+{
+	u64 opt_iosz;
+	u32 mblock_cap;
+	int rc;
+
+	mblock_cap = pmd_layout_cap_get(mp, layout);
+	opt_iosz = mblock_optimal_iosz_get(mp, layout);
+
+	if (rw == MPOOL_OP_READ) {
+		/* boff must be a multiple of the OS page size */
+		if (!PAGE_ALIGNED(boff)) {
+			rc = -EINVAL;
+			mp_pr_err("mpool %s, read offset 0x%lx is not multiple of OS page size",
+				  rc, mp->pds_name, (ulong) boff);
+			return rc;
+		}
+
+		/* Check that boff is not past end of mblock capacity. */
+		if (mblock_cap <= boff) {
+			rc = -EINVAL;
+			mp_pr_err("mpool %s, read offset 0x%lx >= mblock capacity 0x%x",
+				  rc, mp->pds_name, (ulong)boff, mblock_cap);
+			return rc;
+		}
+
+		/*
+		 * Check that the request does not extend past the data
+		 * written.  Don't record an error if this appears to
+		 * be an mcache readahead request.
+		 *
+		 * TODO: Use (len != MCACHE_RA_PAGES_MAX)
+		 */
+		if (boff + len > layout->eld_mblen)
+			return -EINVAL;
+	} else {
+		/* Write boff required to match eld_mblen */
+		if (boff != layout->eld_mblen) {
+			rc = -EINVAL;
+			mp_pr_err("mpool %s write boff (%ld) != eld_mblen (%d)",
+				  rc, mp->pds_name, (ulong)boff, layout->eld_mblen);
+			return rc;
+		}
+
+		/* Writes must be optimal iosz aligned */
+		if (boff % opt_iosz) {
+			rc = -EINVAL;
+			mp_pr_err("mpool %s, write not optimal iosz aligned, offset 0x%lx",
+				  rc, mp->pds_name, (ulong)boff);
+			return rc;
+		}
+
+		/* Check for write past end of allocated space (!) */
+		if ((len + boff) > mblock_cap) {
+			rc = -EINVAL;
+			mp_pr_err("(write): len %lu + boff %lu > mblock_cap %lu",
+				  rc, (ulong)len, (ulong)boff, (ulong)mblock_cap);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
+int mblock_write(struct mpool_descriptor *mp, struct mblock_descriptor *mbh,
+		 const struct kvec *iov, int iovcnt, size_t len)
+{
+	struct pmd_layout *layout;
+	loff_t boff;
+	u8 state;
+	int rc;
+
+	layout = mblock2layout(mbh);
+	if (!layout) {
+		mp_pr_layout_not_found(mp, mbh);
+		return -EINVAL;
+	}
+
+	rc = mblock_rw_argcheck(mp, layout, layout->eld_mblen, MPOOL_OP_WRITE, len);
+	if (rc) {
+		mp_pr_debug("mblock write argcheck failed ", rc);
+		return rc;
+	}
+
+	if (len == 0)
+		return 0;
+
+	boff = layout->eld_mblen;
+
+	ASSERT(PAGE_ALIGNED(len));
+	ASSERT(PAGE_ALIGNED(boff));
+	ASSERT(iovcnt == (len >> PAGE_SHIFT));
+
+	pmd_obj_wrlock(layout);
+	state = layout->eld_state;
+	if (!(state & PMD_LYT_COMMITTED)) {
+		struct mpool_dev_info *pd = pmd_layout_pd_get(mp, layout);
+		int flags = 0;
+
+		if (pd->pdi_fua)
+			flags = REQ_FUA;
+
+		rc = pmd_layout_rw(mp, layout, iov, iovcnt, boff, flags, MPOOL_OP_WRITE);
+		if (!rc)
+			layout->eld_mblen += len;
+	}
+	pmd_obj_wrunlock(layout);
+
+	return !(state & PMD_LYT_COMMITTED) ? rc : -EALREADY;
+}
+
+int mblock_read(struct mpool_descriptor *mp, struct mblock_descriptor *mbh,
+		const struct kvec *iov, int iovcnt, loff_t boff, size_t len)
+{
+	struct pmd_layout *layout;
+	u8 state;
+	int rc;
+
+	layout = mblock2layout(mbh);
+	if (!layout) {
+		mp_pr_layout_not_found(mp, mbh);
+		return -EINVAL;
+	}
+
+	rc = mblock_rw_argcheck(mp, layout, boff, MPOOL_OP_READ, len);
+	if (rc) {
+		mp_pr_debug("mblock read argcheck failed ", rc);
+		return rc;
+	}
+
+	if (len == 0)
+		return 0;
+
+	ASSERT(PAGE_ALIGNED(len));
+	ASSERT(PAGE_ALIGNED(boff));
+	ASSERT(iovcnt == (len >> PAGE_SHIFT));
+
+	/*
+	 * Read lock the mblock layout; mblock reads can proceed concurrently;
+	 * Mblock writes are serialized but concurrent with reads
+	 */
+	pmd_obj_rdlock(layout);
+	state = layout->eld_state;
+	if (state & PMD_LYT_COMMITTED)
+		rc = pmd_layout_rw(mp, layout, iov, iovcnt, boff, 0, MPOOL_OP_READ);
+	pmd_obj_rdunlock(layout);
+
+	return (state & PMD_LYT_COMMITTED) ? rc : -EAGAIN;
+}
+
+int mblock_get_props_ex(struct mpool_descriptor *mp, struct mblock_descriptor *mbh,
+			struct mblock_props_ex *prop)
+{
+	struct pmd_layout *layout;
+
+	layout = mblock2layout(mbh);
+	if (!layout) {
+		mp_pr_layout_not_found(mp, mbh);
+		return -EINVAL;
+	}
+
+	pmd_obj_rdlock(layout);
+	prop->mbx_zonecnt = layout->eld_ld.ol_zcnt;
+	mblock_getprops_cmn(mp, layout, &prop->mbx_props);
+	pmd_obj_rdunlock(layout);
+
+	return 0;
+}
+
+bool mblock_objid(u64 objid)
+{
+	return objid && (pmd_objid_type(objid) == OMF_OBJ_MBLOCK);
+}
diff --git a/drivers/mpool/mblock.h b/drivers/mpool/mblock.h
new file mode 100644
index 000000000000..2a5435875a92
--- /dev/null
+++ b/drivers/mpool/mblock.h
@@ -0,0 +1,161 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+/*
+ * DOC: Module info.
+ *
+ * Defines functions for writing, reading, and managing the lifecycle of mlogs.
+ *
+ */
+
+#ifndef MPOOL_MBLOCK_H
+#define MPOOL_MBLOCK_H
+
+#include <linux/uio.h>
+
+#include "mpool_ioctl.h"
+/*
+ * Opaque handles for clients
+ */
+struct mpool_descriptor;
+struct mblock_descriptor;
+struct mpool_obj_layout;
+
+/*
+ * mblock API functions
+ */
+
+/**
+ * mblock_alloc() - Allocate an mblock.
+ * @mp:         mpool descriptor
+ * @capreq:     mblock capacity requested
+ * @mclassp:    media class
+ * @mbh:        mblock handle returned
+ * @prop:       mblock properties returned
+ *
+ * Allocate mblock with erasure code and capacity params as specified in
+ * ecparm and capreq on drives in a media class mclassp;
+ * if successful mbh is a handle for the mblock and prop contains its
+ * properties.
+ * Note: mblock is not persistent until committed; allocation can be aborted.
+ *
+ * Return: %0 if successful, -errno otherwise...
+ */
+int mblock_alloc(struct mpool_descriptor *mp, enum mp_media_classp mclassp, bool spare,
+		 struct mblock_descriptor **mbh, struct mblock_props *prop);
+
+/**
+ * mblock_find_get() - Get handle and properties for existing mblock with specified objid.
+ * @mp:
+ * @objid:
+ * @which:
+ * @prop:
+ * @mbh:
+ *
+ * If successful, the caller holds a ref on the mblock (which must be put eventually).
+ *
+ * Return: %0 if successful, -errno otherwise...
+ */
+int mblock_find_get(struct mpool_descriptor *mp, u64 objid, int which,
+		    struct mblock_props *prop, struct mblock_descriptor **mbh);
+
+/**
+ * mblock_put() - Put (release) a ref on an mblock
+ * @mbh:
+ *
+ * Put a ref on a known mblock.
+ *
+ * Return: %0 if successful, -errno otherwise...
+ */
+void mblock_put(struct mblock_descriptor *mbh);
+
+/**
+ * mblock_commit() - Make allocated mblock persistent
+ * @mp:
+ * @mbh:
+ *
+ * if fails mblock still exists in an
+ * uncommitted state so can retry commit or abort except as noted.
+ *
+ * Return: %0 if successful, -errno otherwise...
+ * EBUSY if must abort
+ */
+int mblock_commit(struct mpool_descriptor *mp, struct mblock_descriptor *mbh);
+
+/**
+ * mblock_abort() - Discard uncommitted mblock
+ * @mp:
+ * @mbh:
+ *
+ * If successful mbh is invalid after call.
+ *
+ * Return: %0 if successful, -errno otherwise...
+ *
+ */
+int mblock_abort(struct mpool_descriptor *mp, struct mblock_descriptor *mbh);
+
+/**
+ * mblock_delete() - Delete committed mblock
+ * @mp:
+ * @mbh:
+ *
+ * If successful mbh is invalid after call.
+ *
+ * Return: %0 if successful, -errno otherwise...
+ */
+int mblock_delete(struct mpool_descriptor *mp, struct mblock_descriptor *mbh);
+
+/**
+ * mblock_write() - Write iov to mblock
+ * @mp:
+ * @mbh:
+ * @iov:
+ * @iovcnt:
+ * @len:
+ *
+ * Mblocks can be written until they are committed, or
+ * until they are full.  If a caller needs to issue more than one write call
+ * to the same mblock, all but the last write call must be optimal write size aligned.
+ * The mpr_optimal_wrsz field in struct mblock_props gives the optimal write size.
+ *
+ * Return: %0 if success, -errno otherwise...
+ */
+int mblock_write(struct mpool_descriptor *mp, struct mblock_descriptor *mbh,
+		 const struct kvec *iov, int iovcnt, size_t len);
+
+/**
+ * mblock_read() - Read data from mblock mbnum in committed mblock into iov
+ * @mp:
+ * @mbh:
+ * @iov:
+ * @iovcnt:
+ * @boff:
+ * @len:
+ *
+ * Read data from mblock mbnum in committed mblock into iov starting at
+ * byte offset boff; boff and iov buffers must be a multiple of OS page
+ * size for the mblock.
+ *
+ * If fails can call mblock_get_props() to confirm mblock was written.
+ *
+ * Return: 0 if successful, -errno otherwise...
+ */
+int mblock_read(struct mpool_descriptor *mp, struct mblock_descriptor *mbh,
+		const struct kvec *iov, int iovcnt, loff_t boff, size_t len);
+
+/**
+ * mblock_get_props_ex() - Return extended mblock properties in prop
+ * @mp:
+ * @mbh:
+ * @prop:
+ *
+ * Return: %0 if successful, -errno otherwise...
+ */
+int mblock_get_props_ex(struct mpool_descriptor *mp, struct mblock_descriptor *mbh,
+			struct mblock_props_ex *prop);
+
+bool mblock_objid(u64 objid);
+
+#endif /* MPOOL_MBLOCK_H */
-- 
2.17.2

