Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA11C27B27A
	for <lists+linux-block@lfdr.de>; Mon, 28 Sep 2020 18:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgI1QsZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 28 Sep 2020 12:48:25 -0400
Received: from mail-bn8nam12on2077.outbound.protection.outlook.com ([40.107.237.77]:23232
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726792AbgI1Qrx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Sep 2020 12:47:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPtN9/t2favF70LjC6mo2Iydcnt5+1ebwcru1n9Xr4xEOzjKJZSY//2At+vmvc1G4oIBkJp+DmrYgQcG8B8LjG1L2z46HAB7jF046oPNjgF3NBzY0AXSTA5vgzFTPpmuXMuCg7w3bgvk+R8eH8323iQtk9vvy5nkiaDf1mEeFyqaw61BoySFlhJVENV/hGvtcLaoZJGz9sLHRXEu+2eXxwXLsATFBSzoQHfxHFkbzDWFAJ2EBlXaBuhRWitkFs+BAgzdge4eTW9wB1dz3dlmbVn9dUYd6FPo/qTfkf0twpZIyl81c4Qub1KFOIB8FMQY+NZlxlrywFgEDA/ZhK7gaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgQ0xDa79+MRrnGI0RBVyxF/YwM38Tk0/e47ppbjWtg=;
 b=frZ1BOA3NZiMGRdFwOswby8SG7YyUDPvOqVSEmY0HhrM8b3OmXjqys4KS4Of5NH+LomjL+5jOAP5UCIEidSp0EfBJPY1u5CZMyXIYrqOgmrMr0L0tsVJe/U4R2nMp4ath5NfkVLEnOe857tMV3CvHI8sEnBWCh6fvJIEAH40iJ2yofPtt2b4uF+g0paX2x9tBSVs1U7RUs/5rkd6Bo5tOSQA5NxWtSV8Z1OOpwAQqr7pgRkbG2GzLcBgaMapU3YVPPJFCZTH9Cf6ILupsm7I+lVTd2XhcmGlf+YpLgHsW+QlVHiOznh38zYOjY9JbefMfqBHR4bbkueL3r01+CRSMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=kvack.org smtp.mailfrom=micron.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgQ0xDa79+MRrnGI0RBVyxF/YwM38Tk0/e47ppbjWtg=;
 b=Dbzcy7Y4pSOJbMA91iEHqkBLzjuhZAGH8qn7Cx7D9iP75ZutQA8fnqLQOpdXdP/OPComjHsHj/+Ylyz34i3XHFtkNpPfMRVXRgI+v/5qwFOAoA0gmEojhwzkaqsuwBp+tcmaxRdZVXBNPc4aNdQx5mCIsfbRjlOLK/jOHfeJvDk=
Received: from BN6PR17CA0049.namprd17.prod.outlook.com (2603:10b6:405:75::38)
 by BL0PR08MB4643.namprd08.prod.outlook.com (2603:10b6:208:57::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Mon, 28 Sep
 2020 16:47:15 +0000
Received: from BN3NAM01FT020.eop-nam01.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::22) by BN6PR17CA0049.outlook.office365.com
 (2603:10b6:405:75::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend
 Transport; Mon, 28 Sep 2020 16:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com;
Received: from mail.micron.com (137.201.242.130) by
 BN3NAM01FT020.mail.protection.outlook.com (10.152.67.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3412.21 via Frontend Transport; Mon, 28 Sep 2020 16:47:14 +0000
Received: from micron.com (10.114.5.55) by bowex17c.micron.com
 (137.201.21.211) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 28 Sep
 2020 10:47:11 -0600
From:   <nmeeramohide@micron.com>
To:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux-nvdimm@lists.01.org>
CC:     <smoyer@micron.com>, <gbecker@micron.com>, <plabat@micron.com>,
        <jgroves@micron.com>, Nabeel M Mohamed <nmeeramohide@micron.com>
Subject: [PATCH 14/22] mpool: add pool metadata routines to create persistent mpools
Date:   Mon, 28 Sep 2020 11:45:26 -0500
Message-ID: <20200928164534.48203-15-nmeeramohide@micron.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200928164534.48203-1-nmeeramohide@micron.com>
References: <20200928164534.48203-1-nmeeramohide@micron.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bowex17d.micron.com (137.201.21.212) To bowex17c.micron.com
 (137.201.21.211)
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24646.005
X-TM-AS-Result: No--9.380900-0.000000-31
X-TM-AS-MatchedID: 704500-701073-700071-105700-121367-703712-703959-704135-7
        03215-705161-704397-703851-700010-700836-701410-700028-700717-700863-701077
        -703226-700335-702415-700958-704842-701480-701809-703017-703140-702395-1880
        19-703213-121336-701105-704673-703967-703027-701275-703815-702754-700351-70
        4962-704477-704053-704346-705022-702853-703408-702914-701128-105630-137717-
        702787-704961-702688-703904-704090-702617-702779-701705-704714-702855-70497
        8-700065-702444-704328-106420-701919-700077-702365-701263-703572-702619-704
        727-700786-703080-702699-700737-188199-703115-847575-702316-703853-700876-7
        01333-701750-701667-703635-701744-701108-703920-148004-148036-29997-42000-4
        2003
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f4e166b-81f8-4965-7ed9-08d863ce2775
X-MS-TrafficTypeDiagnostic: BL0PR08MB4643:
X-Microsoft-Antispam-PRVS: <BL0PR08MB4643E2CE59050F722852F910B3350@BL0PR08MB4643.namprd08.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c3uEEAbDA7d8KEJTIMnQooQwmWxOOwtRya5XH8Ozs8LUZDIOkQlpTsOTYcG/1Y4y5PglL9CrPMx+uAXVhlaI0fLp1Z7bOF43cjgX519bTYjIHJ1K20DPI4D5mg95pmRd3O11tiShHu/k0Sdsl5F4uC4O+/34s+l/7QGJxtcjQnHmdsLc6klMGIG/EUUmZE6ZETPoI5mfAYAzSzxeKkRODAXgR8IAMgXGD/C3TrtRJHrKBH+BNbnqlMb21ZZMxe6A4FW97oTLlsvsXCrjmXr5B+UbKgcmk/meD9b0OuS7xg0H8dWZiM0pBIyrpiSZt6iHrdC5n2rRVn4P+HbeYmScEwXiWHDYctviBokyzimRVF3lkzsbygpoEwlmKYxx06SIdEDGEjpG4EDliJP/0jSaPRG3C2ks76lsgHHFfxx6JtSmgbM7Aei9k2Ll5nHUYt6WrBB300swCotFkr6B7XaRY50t6HR21xcL/ArcYvpDNJ0ICnq3v4ooFPdg6m7HPqaY
X-Forefront-Antispam-Report: CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966005)(2876002)(4326008)(2616005)(86362001)(26005)(426003)(186003)(7696005)(336012)(83380400001)(82310400003)(356005)(47076004)(82740400003)(7636003)(33310700002)(478600001)(2906002)(8936002)(1076003)(8676002)(5660300002)(36756003)(6666004)(316002)(6286002)(30864003)(107886003)(110136005)(55016002)(54906003)(70586007)(70206006)(2101003)(579004)(559001);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 16:47:14.7750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4e166b-81f8-4965-7ed9-08d863ce2775
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3NAM01FT020.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR08MB4643
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Nabeel M Mohamed <nmeeramohide@micron.com>

Mpool metadata is stored in metadata containers (MDC). An
mpool can have a maximum of 256 MDCs, MDC-0 through MDC-255.
The following metadata manager functionality is added here
for object persistence:

- Initialize and validate MDC0
- Allocate and initialize MDC 1-N. An mpool is created with
  16 MDCs to provide the requisite concurrency.
- Dynamically scale up the number of MDCs when running low
  on space and the garbage is below a certain threshold
  across all MDCs
- Deserialize metadata records from MDC 0-N at mpool activation
  and setup the corresponding in-memory structures
- Pre-compact MDC-K based on its usage and if the garbage in
  MDC-K is above a certain threshold. A pre-compacting MDC is
  not chosen for object allocation.

MDC0 is a distinguished container that stores both the metadata
for accessing MDC-1 through MDC-255 and all mpool properties.
MDC-1 through MDC-255 store the metadata for accessing client
allocated mblocks and mlogs. Metadata for accessing the mlogs
comprising MDC-0 is in the superblock for the capacity media
class.

In the context of MDC-1/255, compacting MDC-K is simply
serializing the in-memory metadata for accessing the still-live
client objects associated with MDC-K. In the context of MDC-0,
compacting is simply serializing the in-memory mpool properties
and in-memory metadata for accessing MDC-1/255.

An instance of struct pmd_mdc_info is created for each MDC in
an mpool. This struct hosts both the uncommitted and committed
object trees and a lock protecting each of the two trees.
Compacting an MDC requires freezing both the list of committed
objects in that MDC and the metadata for those objects,
which is facilitated by the compact lock in each MDC instance.

Co-developed-by: Greg Becker <gbecker@micron.com>
Signed-off-by: Greg Becker <gbecker@micron.com>
Co-developed-by: Pierre Labat <plabat@micron.com>
Signed-off-by: Pierre Labat <plabat@micron.com>
Co-developed-by: John Groves <jgroves@micron.com>
Signed-off-by: John Groves <jgroves@micron.com>
Signed-off-by: Nabeel M Mohamed <nmeeramohide@micron.com>
---
 drivers/mpool/pmd.c     | 2046 +++++++++++++++++++++++++++++++++++++++
 drivers/mpool/pmd_obj.c |    8 -
 2 files changed, 2046 insertions(+), 8 deletions(-)
 create mode 100644 drivers/mpool/pmd.c

diff --git a/drivers/mpool/pmd.c b/drivers/mpool/pmd.c
new file mode 100644
index 000000000000..07e08b5eed43
--- /dev/null
+++ b/drivers/mpool/pmd.c
@@ -0,0 +1,2046 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2015-2020 Micron Technology, Inc.  All rights reserved.
+ */
+
+/*
+ * DOC: Module info.
+ *
+ * Pool metadata (pmd) module.
+ *
+ * Defines functions for probing, reading, and writing drives in an mpool.
+ *
+ */
+
+#include <linux/workqueue.h>
+#include <linux/atomic.h>
+#include <linux/rwsem.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+
+#include "assert.h"
+#include "mpool_printk.h"
+
+#include "mpool_ioctl.h"
+#include "mdc.h"
+#include "upgrade.h"
+#include "smap.h"
+#include "omf_if.h"
+#include "mpcore.h"
+#include "pmd.h"
+
+static DEFINE_MUTEX(pmd_s_lock);
+
+#define pmd_co_foreach(_cinfo, _node) \
+	for ((_node) = rb_first(&(_cinfo)->mmi_co_root); (_node); (_node) = rb_next((_node)))
+
+static int pmd_mdc0_validate(struct mpool_descriptor *mp, int activation);
+
+static void pmd_mda_init(struct mpool_descriptor *mp)
+{
+	int i;
+
+	spin_lock_init(&mp->pds_mda.mdi_slotvlock);
+	mp->pds_mda.mdi_slotvcnt = 0;
+
+	for (i = 0; i < MDC_SLOTS; ++i) {
+		struct pmd_mdc_info *pmi = mp->pds_mda.mdi_slotv + i;
+
+		mutex_init(&pmi->mmi_compactlock);
+		mutex_init(&pmi->mmi_uc_lock);
+		pmi->mmi_uc_root = RB_ROOT;
+		init_rwsem(&pmi->mmi_co_lock);
+		pmi->mmi_co_root = RB_ROOT;
+		mutex_init(&pmi->mmi_uqlock);
+		pmi->mmi_luniq = 0;
+		pmi->mmi_recbuf = NULL;
+		pmi->mmi_lckpt = objid_make(0, OMF_OBJ_UNDEF, i);
+		memset(&pmi->mmi_stats, 0, sizeof(pmi->mmi_stats));
+
+		/*
+		 * Initial mpool metadata content version.
+		 */
+		pmi->mmi_mdcver.mdcv_major = 1;
+		pmi->mmi_mdcver.mdcv_minor = 0;
+		pmi->mmi_mdcver.mdcv_patch = 0;
+		pmi->mmi_mdcver.mdcv_dev   = 0;
+
+		pmi->mmi_credit.ci_slot = i;
+
+		mutex_init(&pmi->mmi_stats_lock);
+	}
+
+	mp->pds_mda.mdi_slotv[1].mmi_luniq = UROOT_OBJID_MAX;
+	mp->pds_mda.mdi_sel.mds_tbl_idx.counter = 0;
+}
+
+static void pmd_mda_free(struct mpool_descriptor *mp)
+{
+	int sidx;
+
+	/*
+	 * close mdc0 last because closing other mdc logs can result in
+	 * mdc0 updates
+	 */
+	for (sidx = mp->pds_mda.mdi_slotvcnt - 1; sidx > -1; sidx--) {
+		struct pmd_layout      *layout, *tmp;
+		struct pmd_mdc_info    *cinfo;
+
+		cinfo = &mp->pds_mda.mdi_slotv[sidx];
+
+		mp_mdc_close(cinfo->mmi_mdc);
+		kfree(cinfo->mmi_recbuf);
+		cinfo->mmi_recbuf = NULL;
+
+		/* Release committed objects... */
+		rbtree_postorder_for_each_entry_safe(
+			layout, tmp, &cinfo->mmi_co_root, eld_nodemdc) {
+
+			pmd_obj_put(layout);
+		}
+
+		/* Release uncommitted objects... */
+		rbtree_postorder_for_each_entry_safe(
+			layout, tmp, &cinfo->mmi_uc_root, eld_nodemdc) {
+
+			pmd_obj_put(layout);
+		}
+	}
+}
+
+static int pmd_mdc0_init(struct mpool_descriptor *mp, struct pmd_layout *mdc01,
+		     struct pmd_layout *mdc02)
+{
+	struct pmd_mdc_info *cinfo = &mp->pds_mda.mdi_slotv[0];
+	int rc;
+
+	cinfo->mmi_recbuf = kzalloc(OMF_MDCREC_PACKLEN_MAX, GFP_KERNEL);
+	if (!cinfo->mmi_recbuf) {
+		rc = -ENOMEM;
+		mp_pr_err("mpool %s, log rec buffer alloc %zu failed",
+			  rc, mp->pds_name, OMF_MDCREC_PACKLEN_MAX);
+		return rc;
+	}
+
+	/*
+	 * we put the mdc0 mlog layouts in mdc 0 because mdc0 mlog objids have a
+	 * slot # of 0 so the rest of the code expects to find the layout there.
+	 * this allows the majority of the code to treat mdc0 mlog metadata
+	 * exactly the same as for mdcN (and user mlogs), even though mdc0
+	 * metadata is actually stored in superblocks.  however there are a few
+	 * places that need to recognize mdc0 mlogs are special, including
+	 * pmd_mdc_compact() and pmd_obj_erase().
+	 */
+
+	mp->pds_mda.mdi_slotvcnt = 1;
+	pmd_co_insert(cinfo, mdc01);
+	pmd_co_insert(cinfo, mdc02);
+
+	rc = mp_mdc_open(mp, mdc01->eld_objid, mdc02->eld_objid, MDC_OF_SKIP_SER, &cinfo->mmi_mdc);
+	if (rc) {
+		mp_pr_err("mpool %s, MDC0 open failed", rc, mp->pds_name);
+
+		pmd_co_remove(cinfo, mdc01);
+		pmd_co_remove(cinfo, mdc02);
+
+		kfree(cinfo->mmi_recbuf);
+		cinfo->mmi_recbuf = NULL;
+
+		mp->pds_mda.mdi_slotvcnt = 0;
+	}
+
+	return rc;
+}
+
+/**
+ * pmd_mdc0_validate() -
+ * @mp:
+ * @activation:
+ *
+ * Called during mpool activation and mdc alloc because a failed
+ * mdc alloc can result in extraneous mdc mlog objects which if
+ * found we attempt to clean-up here. when called during activation
+ * we may need to adjust mp.mda. this is not so when called from
+ * mdc alloc and in fact decreasing slotvcnt post activation would
+ * violate a key invariant.
+ */
+static int pmd_mdc0_validate(struct mpool_descriptor *mp, int activation)
+{
+	struct pmd_mdc_info *cinfo;
+	struct pmd_layout *layout;
+	struct rb_node *node;
+	int err = 0, err1, err2, i;
+	u64 mdcn, mdcmax = 0;
+	u64 logid1, logid2;
+	u16 slotvcnt;
+	u8 *lcnt;
+
+	/*
+	 * Activation is single-threaded and mdc alloc is serialized
+	 * so the number of active mdc (slotvcnt) will not change.
+	 */
+	spin_lock(&mp->pds_mda.mdi_slotvlock);
+	slotvcnt = mp->pds_mda.mdi_slotvcnt;
+	spin_unlock(&mp->pds_mda.mdi_slotvlock);
+
+	if (!slotvcnt) {
+		/* Must be at least mdc0 */
+		err = -EINVAL;
+		mp_pr_err("mpool %s, no MDC0", err, mp->pds_name);
+		return err;
+	}
+
+	cinfo = &mp->pds_mda.mdi_slotv[0];
+
+	lcnt = kcalloc(MDC_SLOTS, sizeof(*lcnt), GFP_KERNEL);
+	if (!lcnt) {
+		err = -ENOMEM;
+		mp_pr_err("mpool %s, lcnt alloc failed", err, mp->pds_name);
+		return err;
+	}
+
+	pmd_co_rlock(cinfo, 0);
+
+	pmd_co_foreach(cinfo, node) {
+		layout = rb_entry(node, typeof(*layout), eld_nodemdc);
+
+		mdcn = objid_uniq(layout->eld_objid) >> 1;
+		if (mdcn < MDC_SLOTS) {
+			lcnt[mdcn] = lcnt[mdcn] + 1;
+			mdcmax = max(mdcmax, mdcn);
+		}
+		if (mdcn >= MDC_SLOTS || lcnt[mdcn] > 2 ||
+		    objid_type(layout->eld_objid) != OMF_OBJ_MLOG ||
+		    objid_slot(layout->eld_objid)) {
+			err = -EINVAL;
+			mp_pr_err("mpool %s, MDC0 number of MDCs %lu %u or bad otype, objid 0x%lx",
+				  err, mp->pds_name, (ulong)mdcn,
+				  lcnt[mdcn], (ulong)layout->eld_objid);
+			break;
+		}
+	}
+
+	pmd_co_runlock(cinfo);
+
+	if (err)
+		goto exit;
+
+	if (!mdcmax) {
+		/*
+		 * trivial case of mdc0 only; no mdc alloc failure to
+		 * clean-up
+		 */
+		if (lcnt[0] != 2 || slotvcnt != 1) {
+			err = -EINVAL;
+			mp_pr_err("mpool %s, inconsistent number of MDCs or slots %d %d",
+				  err, mp->pds_name, lcnt[0], slotvcnt);
+		}
+
+		goto exit;
+	}
+
+	if ((mdcmax != (slotvcnt - 1)) && mdcmax != slotvcnt) {
+		err = -EINVAL;
+
+		/*
+		 * mdcmax is normally slotvcnt-1; can be slotvcnt if
+		 * mdc alloc failed
+		 */
+		mp_pr_err("mpool %s, inconsistent max number of MDCs %lu %u",
+			  err, mp->pds_name, (ulong)mdcmax, slotvcnt);
+		goto exit;
+	}
+
+	/* Both logs must always exist below mdcmax */
+	for (i = 0; i < mdcmax; i++) {
+		if (lcnt[i] != 2) {
+			err = -ENOENT;
+			mp_pr_err("mpool %s, MDC0 missing mlogs %lu %d %u",
+				  err, mp->pds_name, (ulong)mdcmax, i, lcnt[i]);
+			goto exit;
+		}
+	}
+
+	/* Clean-up from failed mdc alloc if needed */
+	if (lcnt[mdcmax] != 2 || mdcmax == slotvcnt) {
+		/* Note: if activation then mdcmax == slotvcnt-1 always */
+		err1 = 0;
+		err2 = 0;
+		logid1 = logid_make(2 * mdcmax, 0);
+		logid2 = logid_make(2 * mdcmax + 1, 0);
+
+		layout = pmd_obj_find_get(mp, logid1, 1);
+		if (layout) {
+			err1 = pmd_obj_delete(mp, layout);
+			if (err1)
+				mp_pr_err("mpool %s, MDC0 %d, can't delete mlog %lu %lu %u %u",
+					  err1, mp->pds_name, activation, (ulong)logid1,
+					  (ulong)mdcmax, lcnt[mdcmax], slotvcnt);
+		}
+
+		layout = pmd_obj_find_get(mp, logid2, 1);
+		if (layout) {
+			err2 = pmd_obj_delete(mp, layout);
+			if (err2)
+				mp_pr_err("mpool %s, MDC0 %d, can't delete mlog %lu %lu %u %u",
+					  err2, mp->pds_name, activation, (ulong)logid2,
+					  (ulong)mdcmax, lcnt[mdcmax], slotvcnt);
+		}
+
+		if (activation) {
+			/*
+			 * Mpool activation can ignore mdc alloc clean-up
+			 * failures; single-threaded; don't need slotvlock
+			 * or uqlock to adjust mda
+			 */
+			cinfo->mmi_luniq = mdcmax - 1;
+			mp->pds_mda.mdi_slotvcnt = mdcmax;
+			mp_pr_warn("mpool %s, MDC0 alloc recovery: uniq %llu slotvcnt %d",
+				   mp->pds_name, (unsigned long long)cinfo->mmi_luniq,
+				   mp->pds_mda.mdi_slotvcnt);
+		} else {
+			/* MDC alloc cannot tolerate clean-up failures */
+			if (err1)
+				err = err1;
+			else if (err2)
+				err = err2;
+
+			if (err)
+				mp_pr_err("mpool %s, MDC0 alloc recovery, cleanup failed %lu %u %u",
+					  err, mp->pds_name, (ulong)mdcmax, lcnt[mdcmax], slotvcnt);
+			else
+				mp_pr_warn("mpool %s, MDC0 alloc recovery", mp->pds_name);
+
+		}
+	}
+
+exit:
+	kfree(lcnt);
+
+	return err;
+}
+
+int pmd_mdc_alloc(struct mpool_descriptor *mp, u64 mincap, u32 iter)
+{
+	struct pmd_obj_capacity ocap;
+	enum mp_media_classp mclassp;
+	struct pmd_mdc_info *cinfo, *cinew;
+	struct pmd_layout *layout1, *layout2;
+	const char *msg = "(no detail)";
+	u64 mdcslot, logid1, logid2;
+	bool reverse = false;
+	u32 pdcnt;
+	int err;
+
+	/*
+	 * serialize to prevent gap in mdc slot space in event of failure
+	 */
+	mutex_lock(&pmd_s_lock);
+
+	/*
+	 * recover previously failed mdc alloc if needed; cannot continue
+	 * if fails
+	 * note: there is an unlikely corner case where we logically delete an
+	 * mlog from a previously failed mdc alloc but a background op is
+	 * preventing its full removal; this will show up later in this
+	 * fn as a failed alloc.
+	 */
+	err = pmd_mdc0_validate(mp, 0);
+	if (err) {
+		mutex_unlock(&pmd_s_lock);
+
+		mp_pr_err("mpool %s, allocating an MDC, inconsistent MDC0", err, mp->pds_name);
+		return err;
+	}
+
+	/* MDC0 exists by definition; created as part of mpool creation */
+	cinfo = &mp->pds_mda.mdi_slotv[0];
+
+	pmd_mdc_lock(&cinfo->mmi_uqlock, 0);
+	mdcslot = cinfo->mmi_luniq;
+	pmd_mdc_unlock(&cinfo->mmi_uqlock);
+
+	if (mdcslot >= MDC_SLOTS - 1) {
+		mutex_unlock(&pmd_s_lock);
+
+		err = -ENOSPC;
+		mp_pr_err("mpool %s, allocating an MDC, too many %lu",
+			  err, mp->pds_name, (ulong)mdcslot);
+		return err;
+	}
+	mdcslot = mdcslot + 1;
+
+	/*
+	 * Alloc rec buf for new mdc slot; not visible so don't need to
+	 * lock fields.
+	 */
+	cinew = &mp->pds_mda.mdi_slotv[mdcslot];
+	cinew->mmi_recbuf = kzalloc(OMF_MDCREC_PACKLEN_MAX, GFP_KERNEL);
+	if (!cinew->mmi_recbuf) {
+		mutex_unlock(&pmd_s_lock);
+
+		mp_pr_warn("mpool %s, MDC%lu pack/unpack buf alloc failed %lu",
+			   mp->pds_name, (ulong)mdcslot, (ulong)OMF_MDCREC_PACKLEN_MAX);
+		return -ENOMEM;
+	}
+	cinew->mmi_credit.ci_slot = mdcslot;
+
+	mclassp = MP_MED_CAPACITY;
+	pdcnt = 1;
+
+	/*
+	 * Create new mdcs with same parameters and on same media class
+	 * as mdc0.
+	 */
+	ocap.moc_captgt = mincap;
+	ocap.moc_spare  = false;
+
+	logid1 = logid_make(2 * mdcslot, 0);
+	logid2 = logid_make(2 * mdcslot + 1, 0);
+
+	if (!(pdcnt & 0x1) && ((iter * 2 / pdcnt) & 0x1)) {
+		/*
+		 * Reverse the allocation order.
+		 * The goal is to have active mlogs on all the mpool PDs.
+		 * If 2 PDs, no parity, no reserve, the active mlogs
+		 * will be on PDs 0,1,0,1,0,1,0,1 etc
+		 * instead of 0,0,0,0,0 etc without reversing.
+		 * No need to reverse if the number of PDs is odd.
+		 */
+		reverse = true;
+	}
+
+	/*
+	 * Each mlog must meet mincap since only one is active at a
+	 * time.
+	 */
+	layout1 = NULL;
+	err = pmd_obj_alloc_cmn(mp, reverse ? logid2 : logid1, OMF_OBJ_MLOG,
+				&ocap, mclassp, 0, false, &layout1);
+	if (err) {
+		if (err != -ENOENT)
+			msg = "allocation of first mlog failed";
+		goto exit;
+	}
+
+	layout2 = NULL;
+	err = pmd_obj_alloc_cmn(mp, reverse ? logid1 : logid2, OMF_OBJ_MLOG,
+				&ocap, mclassp, 0, false, &layout2);
+	if (err) {
+		pmd_obj_abort(mp, layout1);
+		if (err != -ENOENT)
+			msg = "allocation of second mlog failed";
+		goto exit;
+	}
+
+	/*
+	 * Must erase before commit to guarantee new mdc logs start
+	 * empty; mlogs not committed so pmd_obj_erase()
+	 * not needed to make atomic.
+	 */
+	pmd_obj_wrlock(layout1);
+	err = pmd_layout_erase(mp, layout1);
+	pmd_obj_wrunlock(layout1);
+
+	if (err) {
+		msg = "erase of first mlog failed";
+	} else {
+		pmd_obj_wrlock(layout2);
+		err = pmd_layout_erase(mp, layout2);
+		pmd_obj_wrunlock(layout2);
+
+		if (err)
+			msg = "erase of second mlog failed";
+	}
+	if (err) {
+		pmd_obj_abort(mp, layout1);
+		pmd_obj_abort(mp, layout2);
+		goto exit;
+	}
+
+	/*
+	 * don't need to commit logid1 and logid2 atomically; mdc0
+	 * validation deletes non-paired mdc logs to handle failing part
+	 * way through this process
+	 */
+	err = pmd_obj_commit(mp, layout1);
+	if (err) {
+		pmd_obj_abort(mp, layout1);
+		pmd_obj_abort(mp, layout2);
+		msg = "commit of first mlog failed";
+		goto exit;
+	} else {
+		err = pmd_obj_commit(mp, layout2);
+		if (err) {
+			pmd_obj_delete(mp, layout1);
+			pmd_obj_abort(mp, layout2);
+			msg = "commit of second mlog failed";
+			goto exit;
+		}
+	}
+
+	/*
+	 * Finalize new mdc slot before making visible; don't need to
+	 * lock fields.
+	 */
+	err = mp_mdc_open(mp, logid1, logid2, MDC_OF_SKIP_SER, &cinew->mmi_mdc);
+	if (err) {
+		msg = "mdc open failed";
+
+		/* Failed open so just delete logid1/2; don't
+		 * need to delete atomically since mdc0 validation
+		 * will cleanup any detritus
+		 */
+		pmd_obj_delete(mp, layout1);
+		pmd_obj_delete(mp, layout2);
+		goto exit;
+	}
+
+	/*
+	 * Append the version record.
+	 */
+	if (omfu_mdcver_cmp2(omfu_mdcver_cur(), ">=", 1, 0, 0, 1)) {
+		err = pmd_mdc_addrec_version(mp, mdcslot);
+		if (err) {
+			msg = "error adding the version record";
+			/*
+			 * No version record in a MDC will trigger a MDC
+			 * compaction if a activate is attempted later with this
+			 * empty MDC.
+			 * The compaction will add the version record in that
+			 * empty MDC.
+			 * Same error handling as above.
+			 */
+			pmd_obj_delete(mp, layout1);
+			pmd_obj_delete(mp, layout2);
+			goto exit;
+		}
+	}
+
+	/* Make new mdc visible */
+	pmd_mdc_lock(&cinfo->mmi_uqlock, 0);
+
+	spin_lock(&mp->pds_mda.mdi_slotvlock);
+	cinfo->mmi_luniq = mdcslot;
+	mp->pds_mda.mdi_slotvcnt = mdcslot + 1;
+	spin_unlock(&mp->pds_mda.mdi_slotvlock);
+
+	pmd_mdc_unlock(&cinfo->mmi_uqlock);
+
+exit:
+	if (err) {
+		kfree(cinew->mmi_recbuf);
+		cinew->mmi_recbuf = NULL;
+	}
+
+	mutex_unlock(&pmd_s_lock);
+
+	mp_pr_debug("new mdc logid1 %llu logid2 %llu",
+		    0, (unsigned long long)logid1, (unsigned long long)logid2);
+
+	if (err) {
+		mp_pr_err("mpool %s, MDC%lu: %s", err, mp->pds_name, (ulong)mdcslot, msg);
+
+	} else {
+		mp_pr_debug("mpool %s, delta slotvcnt from %u to %llu", 0, mp->pds_name,
+			    mp->pds_mda.mdi_slotvcnt, (unsigned long long)mdcslot + 1);
+
+	}
+	return err;
+}
+
+/**
+ * pmd_mdc_alloc_set() - allocates a set of MDCs
+ * @mp: mpool descriptor
+ *
+ * Creates MDCs in multiple of MPOOL_MDC_SET_SZ. If allocation had
+ * failed in prior iteration allocate MDCs to make it even multiple
+ * of MPOOL_MDC_SET_SZ.
+ *
+ * Locking: lock should not be held when calling this function.
+ */
+static void pmd_mdc_alloc_set(struct mpool_descriptor *mp)
+{
+	u8 mdc_cnt, sidx;
+	int rc;
+
+	/*
+	 * MDCs are created in multiple of MPOOL_MDC_SET_SZ.
+	 * However, if past allocation had failed there may not be an
+	 * even multiple of MDCs in that case create any remaining
+	 * MDCs to get an even multiple.
+	 */
+	mdc_cnt =  MPOOL_MDC_SET_SZ - ((mp->pds_mda.mdi_slotvcnt - 1) % MPOOL_MDC_SET_SZ);
+
+	mdc_cnt = min(mdc_cnt, (u8)(MDC_SLOTS - (mp->pds_mda.mdi_slotvcnt)));
+
+	for (sidx = 1; sidx <= mdc_cnt; sidx++) {
+		rc = pmd_mdc_alloc(mp, mp->pds_params.mp_mdcncap, 0);
+		if (rc) {
+			mp_pr_err("mpool %s, only %u of %u MDCs created",
+				  rc, mp->pds_name, sidx-1, mdc_cnt);
+
+			/*
+			 * For MDCN creation failure ignore the error.
+			 * Attempt to create any remaining MDC next time
+			 * next time new mdcs are required.
+			 */
+			rc = 0;
+			break;
+		}
+	}
+}
+
+/**
+ * pmd_cmp_drv_mdc0() - compare the drive info read from the MDC0 drive list
+ *	to what is obtained from the drive itself or from the configuration.
+ * @mp:
+ * @pdh:
+ * @omd:
+ *
+ * The drive is in list passed to mpool open or an UNAVAIL mdc0 drive.
+ */
+static int pmd_cmp_drv_mdc0(struct mpool_descriptor *mp, u8 pdh,
+			    struct omf_devparm_descriptor *omd)
+{
+	const char *msg __maybe_unused;
+	struct mc_parms mcp_mdc0list, mcp_pd;
+	struct mpool_dev_info *pd;
+
+	pd = &mp->pds_pdv[pdh];
+
+	mc_pd_prop2mc_parms(&(pd->pdi_parm.dpr_prop), &mcp_pd);
+	mc_omf_devparm2mc_parms(omd, &mcp_mdc0list);
+
+	if (!memcmp(&mcp_pd, &mcp_mdc0list, sizeof(mcp_pd)))
+		return 0;
+
+	if (mpool_pd_status_get(pd) == PD_STAT_UNAVAIL)
+		msg = "UNAVAIL mdc0 drive parms don't match those in drive list record";
+	else
+		msg = "mismatch between MDC0 drive list record and drive parms";
+
+	mp_pr_warn("mpool %s, %s for %s, mclassp %d %d zonepg %u %u sectorsz %u %u devtype %u %u features %lu %lu",
+		   mp->pds_name, msg, pd->pdi_name, mcp_pd.mcp_classp, mcp_mdc0list.mcp_classp,
+		   mcp_pd.mcp_zonepg, mcp_mdc0list.mcp_zonepg, mcp_pd.mcp_sectorsz,
+		   mcp_mdc0list.mcp_sectorsz, mcp_pd.mcp_devtype, mcp_mdc0list.mcp_devtype,
+		   (ulong)mcp_pd.mcp_features, (ulong)mcp_mdc0list.mcp_features);
+
+	return -EINVAL;
+}
+
+static const char *msg_unavail1 __maybe_unused =
+	"defunct and unavailable drive still belong to the mpool";
+
+static const char *msg_unavail2 __maybe_unused =
+	"defunct and available drive still belong to the mpool";
+
+static int pmd_props_load(struct mpool_descriptor *mp)
+{
+	struct omf_devparm_descriptor netdev[MP_MED_NUMBER] = { };
+	struct omf_mdcrec_data *cdr;
+	enum mp_media_classp mclassp;
+	struct pmd_mdc_info *cinfo;
+	struct media_class *mc;
+	bool zombie[MPOOL_DRIVES_MAX];
+	int spzone[MP_MED_NUMBER], i;
+	size_t rlen = 0;
+	u64 pdh, buflen;
+	int err;
+
+	cinfo = &mp->pds_mda.mdi_slotv[0];
+	buflen = OMF_MDCREC_PACKLEN_MAX;
+
+	/*  Note: single threaded here so don't need any locks */
+
+	/* Set mpool properties to defaults; overwritten by property records (if any). */
+	for (mclassp = 0; mclassp < MP_MED_NUMBER; mclassp++)
+		spzone[mclassp] = -1;
+
+	/*
+	 * read mdc0 to capture net of drives, content version & other
+	 * properties; ignore obj records
+	 */
+	err = mp_mdc_rewind(cinfo->mmi_mdc);
+	if (err) {
+		mp_pr_err("mpool %s, MDC0 init for read properties failed", err, mp->pds_name);
+		return err;
+	}
+
+	cdr = kzalloc(sizeof(*cdr), GFP_KERNEL);
+	if (!cdr) {
+		err = -ENOMEM;
+		mp_pr_err("mpool %s, cdr alloc failed", err, mp->pds_name);
+		return err;
+	}
+
+	while (true) {
+		err = mp_mdc_read(cinfo->mmi_mdc, cinfo->mmi_recbuf, buflen, &rlen);
+		if (err) {
+			mp_pr_err("mpool %s, MDC0 read next failed %lu",
+				  err, mp->pds_name, (ulong)rlen);
+			break;
+		}
+		if (rlen == 0)
+			/* Hit end of log */
+			break;
+
+		/*
+		 * skip object-related mdcrec in mdc0; not ready to unpack
+		 * these yet
+		 */
+		if (omf_mdcrec_isobj_le(cinfo->mmi_recbuf))
+			continue;
+
+		err = omf_mdcrec_unpack_letoh(&(cinfo->mmi_mdcver), mp, cdr, cinfo->mmi_recbuf);
+		if (err) {
+			mp_pr_err("mpool %s, MDC0 property unpack failed", err, mp->pds_name);
+			break;
+		}
+
+		if (cdr->omd_rtype == OMF_MDR_MCCONFIG) {
+			struct omf_devparm_descriptor *src;
+
+			src = &cdr->u.dev.omd_parm;
+			ASSERT(src->odp_mclassp < MP_MED_NUMBER);
+
+			memcpy(&netdev[src->odp_mclassp], src, sizeof(*src));
+			continue;
+		}
+
+		if (cdr->omd_rtype == OMF_MDR_MCSPARE) {
+			mclassp = cdr->u.mcs.omd_mclassp;
+			if (mclass_isvalid(mclassp)) {
+				spzone[mclassp] = cdr->u.mcs.omd_spzone;
+			} else {
+				err = -EINVAL;
+
+				/* Should never happen */
+				mp_pr_err("mpool %s, MDC0 mclass spare record, invalid mclassp %u",
+					  err, mp->pds_name, mclassp);
+				break;
+			}
+			continue;
+		}
+
+		if (cdr->omd_rtype == OMF_MDR_VERSION) {
+			cinfo->mmi_mdcver = cdr->u.omd_version;
+			if (omfu_mdcver_cmp(&cinfo->mmi_mdcver, ">", omfu_mdcver_cur())) {
+				char *buf1, *buf2 = NULL;
+
+				buf1 = kmalloc(2 * MAX_MDCVERSTR, GFP_KERNEL);
+				if (buf1) {
+					buf2 = buf1 + MAX_MDCVERSTR;
+					omfu_mdcver_to_str(&cinfo->mmi_mdcver, buf1, sizeof(buf1));
+					omfu_mdcver_to_str(omfu_mdcver_cur(), buf2, sizeof(buf2));
+				}
+
+				err = -EOPNOTSUPP;
+				mp_pr_err("mpool %s, MDC0 version %s, binary version %s",
+					  err, mp->pds_name, buf1, buf2);
+				kfree(buf1);
+				break;
+			}
+			continue;
+		}
+
+		if (cdr->omd_rtype == OMF_MDR_MPCONFIG)
+			mp->pds_cfg = cdr->u.omd_cfg;
+	}
+
+	if (err) {
+		kfree(cdr);
+		return err;
+	}
+
+	/* Reconcile net drive list with those in mpool descriptor */
+	for (i = 0; i < mp->pds_pdvcnt; i++)
+		zombie[i] = true;
+
+	for (i = 0; i < MP_MED_NUMBER; i++) {
+		struct omf_devparm_descriptor *omd;
+		int    j;
+
+		omd = &netdev[i];
+
+		if (mpool_uuid_is_null(&omd->odp_devid))
+			continue;
+
+		j = mp->pds_pdvcnt;
+		while (j--) {
+			if (mpool_uuid_compare(&mp->pds_pdv[j].pdi_devid, &omd->odp_devid) == 0)
+				break;
+		}
+
+		if (j >= 0) {
+			zombie[j] = false;
+			err = pmd_cmp_drv_mdc0(mp, j, omd);
+			if (err)
+				break;
+		} else {
+			err = mpool_desc_unavail_add(mp, omd);
+			if (err)
+				break;
+			zombie[mp->pds_pdvcnt - 1] = false;
+		}
+	}
+
+	/* Check for zombie drives and recompute uacnt[] */
+	if (!err) {
+		for (i = 0; i < MP_MED_NUMBER; i++) {
+			mc = &mp->pds_mc[i];
+			mc->mc_uacnt = 0;
+		}
+
+		for (pdh = 0; pdh < mp->pds_pdvcnt; pdh++) {
+			struct mpool_dev_info  *pd;
+
+			mc = &mp->pds_mc[mp->pds_pdv[pdh].pdi_mclass];
+			pd = &mp->pds_pdv[pdh];
+			if (zombie[pdh]) {
+				char uuid_str[40];
+
+				mpool_unparse_uuid(&pd->pdi_devid, uuid_str);
+				err = -ENXIO;
+
+				if (mpool_pd_status_get(pd) == PD_STAT_UNAVAIL)
+					mp_pr_err("mpool %s, drive %s %s %s", err, mp->pds_name,
+						   uuid_str, pd->pdi_name, msg_unavail1);
+				else
+					mp_pr_err("mpool %s, drive %s %s %s", err, mp->pds_name,
+						  uuid_str, pd->pdi_name, msg_unavail2);
+				break;
+			} else if (mpool_pd_status_get(pd) == PD_STAT_UNAVAIL) {
+				mc->mc_uacnt += 1;
+			}
+		}
+	}
+
+	/*
+	 * Now it is possible to update the percent spare because all
+	 * the media classes of the mpool have been created because all
+	 * the mpool PDs have been added in their classes.
+	 */
+	if (!err) {
+		for (mclassp = 0; mclassp < MP_MED_NUMBER; mclassp++) {
+			if (spzone[mclassp] >= 0) {
+				err = mc_set_spzone(&mp->pds_mc[mclassp], spzone[mclassp]);
+				/*
+				 * Should never happen, it should exist a class
+				 * with perf. level mclassp with a least 1 PD.
+				 */
+				if (err)
+					break;
+			}
+		}
+		if (err)
+			mp_pr_err("mpool %s, can't set spare %u because the class %u has no PD",
+				  err, mp->pds_name, spzone[mclassp], mclassp);
+	}
+
+	kfree(cdr);
+
+	return err;
+}
+
+static int pmd_objs_load(struct mpool_descriptor *mp, u8 cslot)
+{
+	struct omf_mdcrec_data *cdr = NULL;
+	struct pmd_mdc_info *cinfo;
+	struct rb_node *node;
+	u64 argv[2] = { 0 };
+	const char *msg;
+	size_t recbufsz;
+	char *recbuf;
+	u64 mdcmax;
+	int err;
+
+	/* Note: single threaded here so don't need any locks */
+
+	recbufsz = OMF_MDCREC_PACKLEN_MAX;
+	msg = "(no detail)";
+	mdcmax = 0;
+
+	cinfo = &mp->pds_mda.mdi_slotv[cslot];
+
+	/* Initialize mdc if not mdc0. */
+	if (cslot) {
+		u64 logid1 = logid_make(2 * cslot, 0);
+		u64 logid2 = logid_make(2 * cslot + 1, 0);
+
+		/* Freed in pmd_mda_free() */
+		cinfo->mmi_recbuf = kmalloc(recbufsz, GFP_KERNEL);
+		if (!cinfo->mmi_recbuf) {
+			msg = "MDC recbuf alloc failed";
+			err = -ENOMEM;
+			goto errout;
+		}
+
+		err = mp_mdc_open(mp, logid1, logid2, MDC_OF_SKIP_SER, &cinfo->mmi_mdc);
+		if (err) {
+			msg = "mdc open failed";
+			goto errout;
+		}
+	}
+
+	/* Read mdc and capture net result of object data records. */
+	err = mp_mdc_rewind(cinfo->mmi_mdc);
+	if (err) {
+		msg = "mdc rewind failed";
+		goto errout;
+	}
+
+	/* Cache these pointers to simplify the ensuing code. */
+	recbuf = cinfo->mmi_recbuf;
+
+	cdr = kzalloc(sizeof(*cdr), GFP_KERNEL);
+	if (!cdr) {
+		msg = "cdr alloc failed";
+		goto errout;
+	}
+
+	while (true) {
+		struct pmd_layout *layout, *found;
+		size_t rlen = 0;
+		u64 objid;
+
+		err = mp_mdc_read(cinfo->mmi_mdc, recbuf, recbufsz, &rlen);
+		if (err) {
+			msg = "mdc read data failed";
+			break;
+		}
+		if (rlen == 0)
+			break; /* Hit end of log */
+
+		/*
+		 * Version record, if present, must be first.
+		 */
+		if (omf_mdcrec_unpack_type_letoh(recbuf) == OMF_MDR_VERSION) {
+			omf_mdcver_unpack_letoh(cdr, recbuf);
+			cinfo->mmi_mdcver = cdr->u.omd_version;
+
+			if (omfu_mdcver_cmp(&cinfo->mmi_mdcver, ">", omfu_mdcver_cur())) {
+				char *buf1, *buf2 = NULL;
+
+				buf1 = kmalloc(2 * MAX_MDCVERSTR, GFP_KERNEL);
+				if (buf1) {
+					buf2 = buf1 + MAX_MDCVERSTR;
+					omfu_mdcver_to_str(&cinfo->mmi_mdcver, buf1, sizeof(buf1));
+					omfu_mdcver_to_str(omfu_mdcver_cur(), buf2, sizeof(buf2));
+				}
+
+				err = -EOPNOTSUPP;
+				mp_pr_err("mpool %s, MDC%u version %s, binary version %s",
+					  err, mp->pds_name, cslot, buf1, buf2);
+				kfree(buf1);
+				break;
+			}
+			continue;
+		}
+
+		/* Skip non object-related mdcrec in mdc0; i.e., property
+		 * records.
+		 */
+		if (!cslot && !omf_mdcrec_isobj_le(recbuf))
+			continue;
+
+		err = omf_mdcrec_unpack_letoh(&cinfo->mmi_mdcver, mp, cdr, recbuf);
+		if (err) {
+			msg = "mlog record unpack failed";
+			break;
+		}
+
+		objid = cdr->u.obj.omd_objid;
+
+		if (objid_slot(objid) != cslot) {
+			msg = "mlog record wrong slot";
+			err = -EBADSLT;
+			break;
+		}
+
+		if (cdr->omd_rtype == OMF_MDR_OCREATE) {
+			layout = cdr->u.obj.omd_layout;
+			layout->eld_state = PMD_LYT_COMMITTED;
+
+			found = pmd_co_insert(cinfo, layout);
+			if (found) {
+				msg = "OCREATE duplicate object ID";
+				pmd_obj_put(layout);
+				err = -EEXIST;
+				break;
+			}
+
+			atomic_inc(&cinfo->mmi_pco_cnt.pcc_cr);
+			atomic_inc(&cinfo->mmi_pco_cnt.pcc_cobj);
+
+			continue;
+		}
+
+		if (cdr->omd_rtype == OMF_MDR_ODELETE) {
+			found = pmd_co_find(cinfo, objid);
+			if (!found) {
+				msg = "ODELETE object not found";
+				err = -ENOENT;
+				break;
+			}
+
+			pmd_co_remove(cinfo, found);
+			pmd_obj_put(found);
+
+			atomic_inc(&cinfo->mmi_pco_cnt.pcc_del);
+			atomic_dec(&cinfo->mmi_pco_cnt.pcc_cobj);
+
+			continue;
+		}
+
+		if (cdr->omd_rtype == OMF_MDR_OIDCKPT) {
+			/*
+			 * objid == mmi_lckpt == 0 is legit. Such records
+			 * are appended by mpool MDC compaction due to a
+			 * mpool metadata upgrade on an empty mpool.
+			 */
+			if ((objid_uniq(objid) || objid_uniq(cinfo->mmi_lckpt))
+				&& (objid_uniq(objid) <= objid_uniq(cinfo->mmi_lckpt))) {
+				msg = "OIDCKPT cdr ckpt %lu <= cinfo ckpt %lu";
+				argv[0] = objid_uniq(objid);
+				argv[1] = objid_uniq(cinfo->mmi_lckpt);
+				err = -EINVAL;
+				break;
+			}
+
+			cinfo->mmi_lckpt = objid;
+			continue;
+		}
+
+		if (cdr->omd_rtype == OMF_MDR_OERASE) {
+			layout = pmd_co_find(cinfo, objid);
+			if (!layout) {
+				msg = "OERASE object not found";
+				err = -ENOENT;
+				break;
+			}
+
+			/* Note: OERASE gen can equal layout gen after a compaction. */
+			if (cdr->u.obj.omd_gen < layout->eld_gen) {
+				msg = "OERASE cdr gen %lu < layout gen %lu";
+				argv[0] = cdr->u.obj.omd_gen;
+				argv[1] = layout->eld_gen;
+				err = -EINVAL;
+				break;
+			}
+
+			layout->eld_gen = cdr->u.obj.omd_gen;
+
+			atomic_inc(&cinfo->mmi_pco_cnt.pcc_er);
+			continue;
+		}
+
+		if (cdr->omd_rtype == OMF_MDR_OUPDATE) {
+			layout = cdr->u.obj.omd_layout;
+
+			found = pmd_co_find(cinfo, objid);
+			if (!found) {
+				msg = "OUPDATE object not found";
+				pmd_obj_put(layout);
+				err = -ENOENT;
+				break;
+			}
+
+			pmd_co_remove(cinfo, found);
+			pmd_obj_put(found);
+
+			layout->eld_state = PMD_LYT_COMMITTED;
+			pmd_co_insert(cinfo, layout);
+
+			atomic_inc(&cinfo->mmi_pco_cnt.pcc_up);
+
+			continue;
+		}
+	}
+
+	if (err)
+		goto errout;
+
+	/*
+	 * Add all existing objects to space map.
+	 * Also add/update per-mpool space usage stats
+	 */
+	pmd_co_foreach(cinfo, node) {
+		struct pmd_layout *layout;
+
+		layout = rb_entry(node, typeof(*layout), eld_nodemdc);
+
+		/* Remember objid and gen in case of error... */
+		cdr->u.obj.omd_objid = layout->eld_objid;
+		cdr->u.obj.omd_gen = layout->eld_gen;
+
+		if (objid_slot(layout->eld_objid) != cslot) {
+			msg = "layout wrong slot";
+			err = -EBADSLT;
+			break;
+		}
+
+		err = pmd_smap_insert(mp, layout);
+		if (err) {
+			msg = "smap insert failed";
+			break;
+		}
+
+		pmd_update_obj_stats(mp, layout, cinfo, PMD_OBJ_LOAD);
+
+		/* For mdc0 track last logical mdc created. */
+		if (!cslot)
+			mdcmax = max(mdcmax, (objid_uniq(layout->eld_objid) >> 1));
+	}
+
+	if (err)
+		goto errout;
+
+	cdr->u.obj.omd_objid = 0;
+	cdr->u.obj.omd_gen = 0;
+
+	if (!cslot) {
+		/* MDC0: finish initializing mda */
+		cinfo->mmi_luniq = mdcmax;
+		mp->pds_mda.mdi_slotvcnt = mdcmax + 1;
+
+		/* MDC0 only: validate other mdc metadata; may make adjustments to mp.mda. */
+		err = pmd_mdc0_validate(mp, 1);
+		if (err)
+			msg = "MDC0 validation failed";
+	} else {
+		/*
+		 * other mdc: set luniq to guaranteed max value
+		 * previously used and ensure next objid allocation
+		 * will be checkpointed; supports realloc of
+		 * uncommitted objects after a crash
+		 */
+		cinfo->mmi_luniq = objid_uniq(cinfo->mmi_lckpt) + OBJID_UNIQ_DELTA - 1;
+	}
+
+errout:
+	if (err) {
+		char *msgbuf;
+
+		msgbuf = kmalloc(64, GFP_KERNEL);
+		if (msgbuf)
+			snprintf(msgbuf, 64, msg, argv[0], argv[1]);
+
+		mp_pr_err("mpool %s, %s: cslot %u, ckpt %lx, %lx/%lu",
+			  err, mp->pds_name, msgbuf, cslot, (ulong)cinfo->mmi_lckpt,
+			  (ulong)cdr->u.obj.omd_objid, (ulong)cdr->u.obj.omd_gen);
+
+		kfree(msgbuf);
+	}
+
+	kfree(cdr);
+
+	return err;
+}
+
+/**
+ * pmd_objs_load_worker() -
+ * @ws:
+ *
+ * worker thread for loading user MDC 1~N
+ * Each worker instance will do the following (not counting errors):
+ * * grab an MDC number atomically from olw->olw_progress
+ * * If the MDC number is invalid, exit
+ * * load the objects from that MDC
+ *
+ * If an error occurs in this or any other worker, don't load any more MDCs
+ */
+static void pmd_objs_load_worker(struct work_struct *ws)
+{
+	struct pmd_obj_load_work *olw;
+	int sidx, rc;
+
+	olw = container_of(ws, struct pmd_obj_load_work, olw_work);
+
+	while (atomic_read(olw->olw_err) == 0) {
+		sidx = atomic_fetch_add(1, olw->olw_progress);
+		if (sidx >= olw->olw_mp->pds_mda.mdi_slotvcnt)
+			break; /* No more MDCs to load */
+
+		rc = pmd_objs_load(olw->olw_mp, sidx);
+		if (rc)
+			atomic_set(olw->olw_err, rc);
+	}
+}
+
+/**
+ * pmd_objs_load_parallel() - load MDC 1~N in parallel
+ * @mp:
+ *
+ * By loading user MDCs in parallel, we can reduce the mpool activate
+ * time, since the jobs of loading MDC 1~N are independent.
+ * On the other hand, we don't want to start all the jobs at once.
+ * If any one fails, we don't have to start others.
+ */
+static int pmd_objs_load_parallel(struct mpool_descriptor *mp)
+{
+	struct pmd_obj_load_work *olwv;
+	atomic_t err = ATOMIC_INIT(0);
+	atomic_t progress = ATOMIC_INIT(1);
+	uint njobs, inc, cpu, i;
+
+	if (mp->pds_mda.mdi_slotvcnt < 2)
+		return 0; /* No user MDCs allocated */
+
+	njobs = mp->pds_params.mp_objloadjobs;
+	njobs = clamp_t(uint, njobs, 1, mp->pds_mda.mdi_slotvcnt - 1);
+
+	if (mp->pds_mda.mdi_slotvcnt / njobs >= 4 && num_online_cpus() > njobs)
+		njobs *= 2;
+
+	olwv = kcalloc(njobs, sizeof(*olwv), GFP_KERNEL);
+	if (!olwv)
+		return -ENOMEM;
+
+	inc = (num_online_cpus() / njobs) & ~1u;
+	cpu = raw_smp_processor_id();
+
+	/*
+	 * Each of njobs workers will atomically grab MDC numbers from &progress
+	 * and load them, until all valid user MDCs have been loaded.
+	 */
+	for (i = 0; i < njobs; ++i) {
+		INIT_WORK(&olwv[i].olw_work, pmd_objs_load_worker);
+		olwv[i].olw_progress = &progress;
+		olwv[i].olw_err = &err;
+		olwv[i].olw_mp = mp;
+
+		/*
+		 * Try to distribute work across all NUMA nodes.
+		 * queue_work_node() would be preferable, but
+		 * it's not available on older kernels.
+		 */
+		cpu = (cpu + inc) % nr_cpumask_bits;
+		cpu = cpumask_next_wrap(cpu, cpu_online_mask, nr_cpumask_bits, false);
+		queue_work_on(cpu, mp->pds_workq, &olwv[i].olw_work);
+	}
+
+	/* Wait for all worker threads to complete */
+	flush_workqueue(mp->pds_workq);
+
+	kfree(olwv);
+
+	return atomic_read(&err);
+}
+
+static int pmd_mdc_append(struct mpool_descriptor *mp, u8 cslot,
+			  struct omf_mdcrec_data *cdr, int sync)
+{
+	struct pmd_mdc_info *cinfo = &mp->pds_mda.mdi_slotv[cslot];
+	s64 plen;
+
+	plen = omf_mdcrec_pack_htole(mp, cdr, cinfo->mmi_recbuf);
+	if (plen < 0) {
+		mp_pr_warn("mpool %s, MDC%u append failed", mp->pds_name, cslot);
+		return plen;
+	}
+
+	return mp_mdc_append(cinfo->mmi_mdc, cinfo->mmi_recbuf, plen, sync);
+}
+
+/**
+ * pmd_log_all_mdc_cobjs() - write in the new active mlog the object records.
+ * @mp:
+ * @cslot:
+ * @compacted: output
+ * @total: output
+ */
+static int pmd_log_all_mdc_cobjs(struct mpool_descriptor *mp, u8 cslot,
+				 struct omf_mdcrec_data *cdr, u32 *compacted, u32 *total)
+{
+	struct pmd_mdc_info *cinfo;
+	struct pmd_layout *layout;
+	struct rb_node *node;
+	int rc;
+
+	cinfo = &mp->pds_mda.mdi_slotv[cslot];
+	rc = 0;
+
+	pmd_co_foreach(cinfo, node) {
+		layout = rb_entry(node, typeof(*layout), eld_nodemdc);
+
+		if (!objid_mdc0log(layout->eld_objid)) {
+			cdr->omd_rtype = OMF_MDR_OCREATE;
+			cdr->u.obj.omd_layout = layout;
+
+			rc = pmd_mdc_append(mp, cslot, cdr, 0);
+			if (rc) {
+				mp_pr_err("mpool %s, MDC%u log committed obj failed, objid 0x%lx",
+					  rc, mp->pds_name, cslot, (ulong)layout->eld_objid);
+				break;
+			}
+
+			++(*compacted);
+		}
+		++(*total);
+	}
+
+	for (; node; node = rb_next(node))
+		++(*total);
+
+	return rc;
+}
+
+/**
+ * pmd_log_mdc0_cobjs() - write in the new active mlog (of MDC0) the MDC0
+ *	records that are particular to MDC0.
+ * @mp:
+ */
+static int pmd_log_mdc0_cobjs(struct mpool_descriptor *mp)
+{
+	struct mpool_dev_info *pd;
+	int rc = 0, i;
+
+	/*
+	 * Log a drive record (OMF_MDR_MCCONFIG) for every drive in pds_pdv[]
+	 * that is not defunct.
+	 */
+	for (i = 0; i < mp->pds_pdvcnt; i++) {
+		pd = &(mp->pds_pdv[i]);
+		rc = pmd_prop_mcconfig(mp, pd, true);
+		if (rc)
+			return rc;
+	}
+
+	/*
+	 * Log a media class spare record (OMF_MDR_MCSPARE) for every media
+	 * class.
+	 * mc count can't change now. Because the MDC0 compact lock is held
+	 * and that blocks the addition of PDs in the  mpool.
+	 */
+	for (i = 0; i < MP_MED_NUMBER; i++) {
+		struct media_class *mc;
+
+		mc = &mp->pds_mc[i];
+		if (mc->mc_pdmc >= 0) {
+			rc = pmd_prop_mcspare(mp, mc->mc_parms.mcp_classp,
+					       mc->mc_sparms.mcsp_spzone, true);
+			if (rc)
+				return rc;
+		}
+	}
+
+	return pmd_prop_mpconfig(mp, &mp->pds_cfg, true);
+}
+
+/**
+ * pmd_log_non_mdc0_cobjs() - write in the new active mlog (of MDCi i>0) the
+ *	MDCi records that are particular to MDCi (not used by MDC0).
+ * @mp:
+ * @cslot:
+ */
+static int pmd_log_non_mdc0_cobjs(struct mpool_descriptor *mp, u8 cslot,
+				  struct omf_mdcrec_data *cdr)
+{
+	struct pmd_mdc_info *cinfo;
+
+	cinfo = &mp->pds_mda.mdi_slotv[cslot];
+
+	/*
+	 * if not mdc0 log last objid checkpoint to support realloc of
+	 * uncommitted objects after a crash and to guarantee objids are
+	 * never reused.
+	 */
+	cdr->omd_rtype = OMF_MDR_OIDCKPT;
+	cdr->u.obj.omd_objid = cinfo->mmi_lckpt;
+
+	return pmd_mdc_append(mp, cslot, cdr, 0);
+}
+
+/**
+ * pmd_pre_compact_reset() - called on MDCi i>0
+ * @cinfo:
+ * @compacted: object create records appended in the new active mlog.
+ *
+ * Locking:
+ *	MDCi compact lock is held by the caller.
+ */
+static void pmd_pre_compact_reset(struct pmd_mdc_info *cinfo, u32 compacted)
+{
+	struct pre_compact_ctrs *pco_cnt;
+
+	pco_cnt = &cinfo->mmi_pco_cnt;
+	ASSERT(pco_cnt->pcc_cobj.counter == compacted);
+
+	atomic_set(&pco_cnt->pcc_cr, compacted);
+	atomic_set(&pco_cnt->pcc_cobj, compacted);
+	atomic_set(&pco_cnt->pcc_up, 0);
+	atomic_set(&pco_cnt->pcc_del, 0);
+	atomic_set(&pco_cnt->pcc_er, 0);
+}
+
+/**
+ * pmd_mdc_compact() - compact an mpool MDCi with i >= 0.
+ * @mp:
+ * @cslot: the "i" of MDCi
+ *
+ * Locking:
+ * 1) caller must hold MDCi compact lock
+ * 2) MDC compaction freezes the state of all MDCs objects [and for MDC0
+ *    also freezes all mpool properties] by simply holding MDC
+ *    mmi_compactlock mutex. Hence, MDC compaction does not need to
+ *    read-lock individual object layouts or mpool property data
+ *    structures to read them. It is why this function and its callees don't
+ *    take any lock.
+ *
+ * Note: this function or its callees must call pmd_mdc_append() with no sync
+ *	instead of pmd_mdc_addrec() to avoid triggering nested compaction of
+ *	a same MDCi.
+ *	The sync/flush is done by append of cend, no need to sync before that.
+ */
+static int pmd_mdc_compact(struct mpool_descriptor *mp, u8 cslot)
+{
+	struct pmd_mdc_info *cinfo = &mp->pds_mda.mdi_slotv[cslot];
+	u64 logid1 = logid_make(2 * cslot, 0);
+	u64 logid2 = logid_make(2 * cslot + 1, 0);
+	struct omf_mdcrec_data *cdr;
+	int retry = 0, rc = 0;
+
+	cdr = kzalloc(sizeof(*cdr), GFP_KERNEL);
+	if (!cdr) {
+		rc = -ENOMEM;
+		mp_pr_crit("mpool %s, alloc failure during compact", rc, mp->pds_name);
+		return rc;
+	}
+
+	for (retry = 0; retry < MPOOL_MDC_COMPACT_RETRY_DEFAULT; retry++) {
+		u32 compacted = 0;
+		u32 total = 0;
+
+		if (rc) {
+			rc = mp_mdc_open(mp, logid1, logid2, MDC_OF_SKIP_SER, &cinfo->mmi_mdc);
+			if (rc)
+				continue;
+		}
+
+		mp_pr_debug("mpool %s, MDC%u start: mlog1 gen %lu mlog2 gen %lu",
+			    rc, mp->pds_name, cslot,
+			    (ulong)((struct pmd_layout *)cinfo->mmi_mdc->mdc_logh1)->eld_gen,
+			    (ulong)((struct pmd_layout *)cinfo->mmi_mdc->mdc_logh2)->eld_gen);
+
+		rc = mp_mdc_cstart(cinfo->mmi_mdc);
+		if (rc)
+			continue;
+
+		if (omfu_mdcver_cmp2(omfu_mdcver_cur(), ">=", 1, 0, 0, 1)) {
+			rc = pmd_mdc_addrec_version(mp, cslot);
+			if (rc) {
+				mp_mdc_close(cinfo->mmi_mdc);
+				continue;
+			}
+		}
+
+		if (cslot)
+			rc = pmd_log_non_mdc0_cobjs(mp, cslot, cdr);
+		else
+			rc = pmd_log_mdc0_cobjs(mp);
+		if (rc)
+			continue;
+
+		rc = pmd_log_all_mdc_cobjs(mp, cslot, cdr, &compacted, &total);
+
+		mp_pr_debug("mpool %s, MDC%u compacted %u of %u objects: retry=%d",
+			    rc, mp->pds_name, cslot, compacted, total, retry);
+
+		/*
+		 * Append the compaction end record in the new active
+		 * mlog, and flush/sync all the previous records
+		 * appended in the new active log by the compaction
+		 * above.
+		 */
+		if (!rc)
+			rc = mp_mdc_cend(cinfo->mmi_mdc);
+
+		if (!rc) {
+			if (cslot) {
+				/*
+				 * MDCi i>0 compacted successfully
+				 * MDCi compact lock is held.
+				 */
+				pmd_pre_compact_reset(cinfo, compacted);
+			}
+
+			mp_pr_debug("mpool %s, MDC%u end: mlog1 gen %lu mlog2 gen %lu",
+				    rc, mp->pds_name, cslot,
+				    (ulong)((struct pmd_layout *)
+					    cinfo->mmi_mdc->mdc_logh1)->eld_gen,
+				    (ulong)((struct pmd_layout *)
+					    cinfo->mmi_mdc->mdc_logh2)->eld_gen);
+			break;
+		}
+	}
+
+	if (rc)
+		mp_pr_crit("mpool %s, MDC%u compaction failed", rc, mp->pds_name, cslot);
+
+	kfree(cdr);
+
+	return rc;
+}
+
+static int pmd_mdc_addrec(struct mpool_descriptor *mp, u8 cslot, struct omf_mdcrec_data *cdr)
+{
+	int rc;
+
+	rc = pmd_mdc_append(mp, cslot, cdr, 1);
+
+	if (rc == -EFBIG) {
+		rc = pmd_mdc_compact(mp, cslot);
+		if (!rc)
+			rc = pmd_mdc_append(mp, cslot, cdr, 1);
+	}
+
+	if (rc)
+		mp_pr_rl("mpool %s, MDC%u append failed%s", rc, mp->pds_name, cslot,
+			 (rc == -EFBIG) ? " post compaction" : "");
+
+	return rc;
+}
+
+int pmd_mdc_addrec_version(struct mpool_descriptor *mp, u8 cslot)
+{
+	struct omf_mdcrec_data cdr;
+	struct omf_mdcver *ver;
+
+	cdr.omd_rtype = OMF_MDR_VERSION;
+
+	ver = omfu_mdcver_cur();
+	cdr.u.omd_version = *ver;
+
+	return pmd_mdc_addrec(mp, cslot, &cdr);
+}
+
+int pmd_prop_mcconfig(struct mpool_descriptor *mp, struct mpool_dev_info *pd, bool compacting)
+{
+	struct omf_mdcrec_data cdr;
+	struct mc_parms mc_parms;
+
+	cdr.omd_rtype = OMF_MDR_MCCONFIG;
+	mpool_uuid_copy(&cdr.u.dev.omd_parm.odp_devid, &pd->pdi_devid);
+	mc_pd_prop2mc_parms(&pd->pdi_parm.dpr_prop, &mc_parms);
+	mc_parms2omf_devparm(&mc_parms, &cdr.u.dev.omd_parm);
+	cdr.u.dev.omd_parm.odp_zonetot = pd->pdi_parm.dpr_zonetot;
+	cdr.u.dev.omd_parm.odp_devsz = pd->pdi_parm.dpr_devsz;
+
+	/* If compacting no sync needed and don't trigger another compaction. */
+	if (compacting)
+		return pmd_mdc_append(mp, 0, &cdr, 0);
+
+	return pmd_mdc_addrec(mp, 0, &cdr);
+}
+
+int pmd_prop_mcspare(struct mpool_descriptor *mp, enum mp_media_classp mclassp,
+		     u8 spzone, bool compacting)
+{
+	struct omf_mdcrec_data cdr;
+	int rc;
+
+	if (!mclass_isvalid(mclassp) || spzone > 100) {
+		rc = -EINVAL;
+		mp_pr_err("persisting %s spare zone info, invalid arguments %d %u",
+			  rc, mp->pds_name, mclassp, spzone);
+		return rc;
+	}
+
+	cdr.omd_rtype = OMF_MDR_MCSPARE;
+	cdr.u.mcs.omd_mclassp = mclassp;
+	cdr.u.mcs.omd_spzone = spzone;
+
+	/* If compacting no sync needed and don't trigger another compaction. */
+	if (compacting)
+		return pmd_mdc_append(mp, 0, &cdr, 0);
+
+	return pmd_mdc_addrec(mp, 0, &cdr);
+}
+
+int pmd_log_delete(struct mpool_descriptor *mp, u64 objid)
+{
+	struct omf_mdcrec_data cdr;
+
+	cdr.omd_rtype = OMF_MDR_ODELETE;
+	cdr.u.obj.omd_objid = objid;
+
+	return pmd_mdc_addrec(mp, objid_slot(objid), &cdr);
+}
+
+int pmd_log_create(struct mpool_descriptor *mp, struct pmd_layout *layout)
+{
+	struct omf_mdcrec_data cdr;
+
+	cdr.omd_rtype = OMF_MDR_OCREATE;
+	cdr.u.obj.omd_layout = layout;
+
+	return pmd_mdc_addrec(mp, objid_slot(layout->eld_objid), &cdr);
+}
+
+int pmd_log_erase(struct mpool_descriptor *mp, u64 objid, u64 gen)
+{
+	struct omf_mdcrec_data cdr;
+
+	cdr.omd_rtype = OMF_MDR_OERASE;
+	cdr.u.obj.omd_objid = objid;
+	cdr.u.obj.omd_gen = gen;
+
+	return pmd_mdc_addrec(mp, objid_slot(objid), &cdr);
+}
+
+int pmd_log_idckpt(struct mpool_descriptor *mp, u64 objid)
+{
+	struct omf_mdcrec_data cdr;
+
+	cdr.omd_rtype = OMF_MDR_OIDCKPT;
+	cdr.u.obj.omd_objid = objid;
+
+	return pmd_mdc_addrec(mp, objid_slot(objid), &cdr);
+}
+
+int pmd_prop_mpconfig(struct mpool_descriptor *mp, const struct mpool_config *cfg, bool compacting)
+{
+	struct omf_mdcrec_data cdr = { };
+
+	cdr.omd_rtype = OMF_MDR_MPCONFIG;
+	cdr.u.omd_cfg = *cfg;
+
+	if (compacting)
+		return pmd_mdc_append(mp, 0, &cdr, 0);
+
+	return pmd_mdc_addrec(mp, 0, &cdr);
+}
+
+/**
+ * pmd_need_compact() - determine if MDCi corresponding to cslot need compaction of not.
+ * @mp:
+ * @cslot:
+ *
+ * The MDCi needs compaction if the active mlog is above some threshold and
+ * if there is enough garbage (that can be eliminated by the compaction).
+ *
+ * Locking: not lock need to be held when calling this function.
+ *	as a result of not holding lock the result may be off if a compaction
+ *	of MDCi (with i = cslot) is taking place at the same time.
+ */
+static bool pmd_need_compact(struct mpool_descriptor *mp, u8 cslot, char *msgbuf, size_t msgsz)
+{
+	struct pre_compact_ctrs *pco_cnt;
+	struct pmd_mdc_info *cinfo;
+	u64 rec, cobj, len, cap;
+	u32 garbage, pct;
+
+	ASSERT(cslot > 0);
+
+	cinfo = &mp->pds_mda.mdi_slotv[cslot];
+	pco_cnt = &(cinfo->mmi_pco_cnt);
+
+	cap = atomic64_read(&pco_cnt->pcc_cap);
+	if (cap == 0)
+		return false; /* MDC closed for now. */
+
+	len = atomic64_read(&pco_cnt->pcc_len);
+	rec = atomic_read(&pco_cnt->pcc_cr) + atomic_read(&pco_cnt->pcc_up) +
+		atomic_read(&pco_cnt->pcc_del) + atomic_read(&pco_cnt->pcc_er);
+	cobj = atomic_read(&pco_cnt->pcc_cobj);
+
+	pct = (len * 100) / cap;
+	if (pct < mp->pds_params.mp_pcopctfull)
+		return false; /* Active mlog not filled enough */
+
+	if (rec > cobj) {
+		garbage = (rec - cobj) * 100;
+		garbage /= rec;
+	} else {
+
+		/*
+		 * We may arrive here rarely if the caller doesn't
+		 * hold the compact lock. In that case, the update of
+		 * the counters may be seen out of order or a compaction
+		 * may take place at the same time.
+		 */
+		garbage = 0;
+	}
+
+	if (garbage < mp->pds_params.mp_pcopctgarbage)
+		return false;
+
+	if (msgbuf)
+		snprintf(msgbuf, msgsz,
+			 "bytes used %lu, total %lu, pct %u, records %lu, objects %lu, garbage %u",
+			 (ulong)len, (ulong)cap, pct, (ulong)rec, (ulong)cobj, garbage);
+
+	return true;
+}
+
+/**
+ * pmd_mdc_needed() - determines if new MDCns should be created
+ * @mp:  mpool descriptor
+ *
+ * New MDC's are created if total free space across all MDC's
+ * is above a threshold value and the garbage to reclaim space
+ * is below a garbage threshold.
+ *
+ * Locking: no lock needs to be held when calling this function.
+ *
+ * NOTES:
+ * - Skip non-active MDC
+ * - Accumulate total capacity, total garbage and total in-use capacity
+ *   across all active MDCs.
+ * - Return true if total used capacity across all MDCs is threshold and
+ *   garbage is < a threshold that would yield significant free space upon
+ *   compaction.
+ */
+static bool pmd_mdc_needed(struct mpool_descriptor *mp)
+{
+	struct pre_compact_ctrs *pco_cnt;
+	struct pmd_mdc_info *cinfo;
+	u64 cap, tcap, used, garbage, record, rec, cobj;
+	u32 pct, pctg, mdccnt;
+	u16 cslot;
+
+	ASSERT(mp->pds_mda.mdi_slotvcnt <= MDC_SLOTS);
+
+	cap = used = garbage = record = pctg = 0;
+
+	if (mp->pds_mda.mdi_slotvcnt == MDC_SLOTS)
+		return false;
+
+	for (cslot = 1, mdccnt = 0; cslot < mp->pds_mda.mdi_slotvcnt; cslot++) {
+
+		cinfo = &mp->pds_mda.mdi_slotv[cslot];
+		pco_cnt = &(cinfo->mmi_pco_cnt);
+
+		tcap = atomic64_read(&pco_cnt->pcc_cap);
+		if (tcap == 0) {
+			/*
+			 * MDC closed for now and will not be considered
+			 * in making a decision to create new MDC.
+			 */
+			mp_pr_warn("MDC %u not open", cslot);
+			continue;
+		}
+		cap += tcap;
+
+		mdccnt++;
+
+		used += atomic64_read(&pco_cnt->pcc_len);
+		rec = atomic_read(&pco_cnt->pcc_cr) + atomic_read(&pco_cnt->pcc_up) +
+			atomic_read(&pco_cnt->pcc_del) + atomic_read(&pco_cnt->pcc_er);
+
+		cobj = atomic_read(&pco_cnt->pcc_cobj);
+
+		if (rec > cobj)
+			garbage += (rec - cobj);
+
+		record += rec;
+	}
+
+	if (mdccnt == 0) {
+		mp_pr_warn("No mpool MDCs available");
+		return false;
+	}
+
+	/* Percentage capacity used across all MDCs */
+	pct  = (used  * 100) / cap;
+
+	/* Percentage garbage available across all MDCs */
+	if (garbage)
+		pctg = (garbage * 100) / record;
+
+	if (pct > mp->pds_params.mp_crtmdcpctfull && pctg < mp->pds_params.mp_crtmdcpctgrbg) {
+		mp_pr_debug("MDCn %u cap %u used %u rec %u grbg %u pct used %u grbg %u Thres %u-%u",
+			    0, mdccnt, (u32)cap, (u32)used, (u32)record, (u32)garbage, pct, pctg,
+			    (u32)mp->pds_params.mp_crtmdcpctfull,
+			    (u32)mp->pds_params.mp_crtmdcpctgrbg);
+		return true;
+	}
+
+	return false;
+}
+
+
+/**
+ * pmd_precompact() - precompact an mpool MDC
+ * @work:
+ *
+ * The goal of this thread is to minimize the application objects commit time.
+ * This thread pre compacts the MDC1/255. As a consequence MDC1/255 compaction
+ * does not occurs in the context of an application object commit.
+ */
+static void pmd_precompact(struct work_struct *work)
+{
+	struct pre_compact_ctrl *pco;
+	struct mpool_descriptor *mp;
+	struct pmd_mdc_info *cinfo;
+	char msgbuf[128];
+	uint nmtoc, delay;
+	bool compact;
+	u8 cslot;
+
+	pco = container_of(work, typeof(*pco), pco_dwork.work);
+	mp = pco->pco_mp;
+
+	nmtoc = atomic_fetch_add(1, &pco->pco_nmtoc);
+
+	/* Only compact MDC1/255 not MDC0. */
+	cslot = (nmtoc % (mp->pds_mda.mdi_slotvcnt - 1)) + 1;
+
+	/*
+	 * Check if the next mpool mdc to compact needs compaction.
+	 *
+	 * Note that this check is done without taking any lock.
+	 * This is safe because the mpool MDCs don't go away as long as
+	 * the mpool is activated. The mpool can't deactivate before
+	 * this thread exit.
+	 */
+	compact = pmd_need_compact(mp, cslot, NULL, 0);
+	if (compact) {
+		cinfo = &mp->pds_mda.mdi_slotv[cslot];
+
+		/*
+		 * Check a second time while we hold the compact lock
+		 * to avoid doing a useless compaction.
+		 */
+		pmd_mdc_lock(&cinfo->mmi_compactlock, cslot);
+		compact = pmd_need_compact(mp, cslot, msgbuf, sizeof(msgbuf));
+		if (compact)
+			pmd_mdc_compact(mp, cslot);
+		pmd_mdc_unlock(&cinfo->mmi_compactlock);
+
+		if (compact)
+			mp_pr_info("mpool %s, MDC%u %s", mp->pds_name, cslot, msgbuf);
+	}
+
+	/* If running low on MDC space create new MDCs */
+	if (pmd_mdc_needed(mp))
+		pmd_mdc_alloc_set(mp);
+
+	pmd_update_credit(mp);
+
+	delay = clamp_t(uint, mp->pds_params.mp_pcoperiod, 1, 3600);
+
+	queue_delayed_work(mp->pds_workq, &pco->pco_dwork, msecs_to_jiffies(delay * 1000));
+}
+
+void pmd_precompact_start(struct mpool_descriptor *mp)
+{
+	struct pre_compact_ctrl *pco;
+
+	pco = &mp->pds_pco;
+	pco->pco_mp = mp;
+	atomic_set(&pco->pco_nmtoc, 0);
+
+	INIT_DELAYED_WORK(&pco->pco_dwork, pmd_precompact);
+	queue_delayed_work(mp->pds_workq, &pco->pco_dwork, 1);
+}
+
+void pmd_precompact_stop(struct mpool_descriptor *mp)
+{
+	cancel_delayed_work_sync(&mp->pds_pco.pco_dwork);
+}
+
+static int pmd_write_meta_to_latest_version(struct mpool_descriptor *mp, bool permitted)
+{
+	struct pmd_mdc_info *cinfo_converted = NULL, *cinfo;
+	char buf1[MAX_MDCVERSTR] __maybe_unused;
+	char buf2[MAX_MDCVERSTR] __maybe_unused;
+	u32 cslot;
+	int rc;
+
+	/*
+	 * Compact MDC0 first (before MDC1-255 compaction appends in MDC0) to
+	 * avoid having a potential mix of new and old records in MDC0.
+	 */
+	for (cslot = 0; cslot < mp->pds_mda.mdi_slotvcnt; cslot++) {
+		cinfo = &mp->pds_mda.mdi_slotv[cslot];
+
+		/*
+		 * At that point the version on media should be smaller or
+		 * equal to the latest version supported by this binary.
+		 * If it is not the case, the activate fails earlier.
+		 */
+		if (omfu_mdcver_cmp(&cinfo->mmi_mdcver, "==", omfu_mdcver_cur()))
+			continue;
+
+		omfu_mdcver_to_str(&cinfo->mmi_mdcver, buf1, sizeof(buf1));
+		omfu_mdcver_to_str(omfu_mdcver_cur(), buf2, sizeof(buf2));
+
+		if (!permitted) {
+			rc = -EPERM;
+			mp_pr_err("mpool %s, MDC%u upgrade needed from version %s to %s",
+				  rc, mp->pds_name, cslot, buf1, buf2);
+			return rc;
+		}
+
+		mp_pr_info("mpool %s, MDC%u upgraded from version %s to %s",
+			   mp->pds_name, cslot, buf1, buf2);
+
+		cinfo_converted = cinfo;
+
+		pmd_mdc_lock(&cinfo->mmi_compactlock, cslot);
+		rc = pmd_mdc_compact(mp, cslot);
+		pmd_mdc_unlock(&cinfo->mmi_compactlock);
+
+		if (rc) {
+			mp_pr_err("mpool %s, failed to compact MDC %u post upgrade from %s to %s",
+				  rc, mp->pds_name, cslot, buf1, buf2);
+			return rc;
+		}
+	}
+
+	if (cinfo_converted != NULL)
+		mp_pr_info("mpool %s, converted MDC from version %s to %s", mp->pds_name,
+			   omfu_mdcver_to_str(&cinfo_converted->mmi_mdcver, buf1, sizeof(buf1)),
+			   omfu_mdcver_to_str(omfu_mdcver_cur(), buf2, sizeof(buf2)));
+
+	return 0;
+}
+
+void pmd_mdc_cap(struct mpool_descriptor *mp, u64 *mdcmax, u64 *mdccap, u64 *mdc0cap)
+{
+	struct pmd_mdc_info *cinfo = NULL;
+	struct pmd_layout *layout = NULL;
+	struct rb_node *node = NULL;
+	u64 mlogsz;
+	u32 zonepg = 0;
+	u16 mdcn = 0;
+
+	if (!mdcmax || !mdccap || !mdc0cap)
+		return;
+
+	/* Serialize to prevent race with pmd_mdc_alloc() */
+	mutex_lock(&pmd_s_lock);
+
+	/*
+	 * exclude mdc0 from stats because not used for mpool user
+	 * object metadata
+	 */
+	cinfo = &mp->pds_mda.mdi_slotv[0];
+
+	pmd_mdc_lock(&cinfo->mmi_uqlock, 0);
+	*mdcmax = cinfo->mmi_luniq;
+	pmd_mdc_unlock(&cinfo->mmi_uqlock);
+
+	/*  Taking compactlock to freeze all object layout metadata in mdc0 */
+	pmd_mdc_lock(&cinfo->mmi_compactlock, 0);
+	pmd_co_rlock(cinfo, 0);
+
+	pmd_co_foreach(cinfo, node) {
+		layout = rb_entry(node, typeof(*layout), eld_nodemdc);
+
+		mdcn = objid_uniq(layout->eld_objid) >> 1;
+
+		if (mdcn > *mdcmax)
+			/* Ignore detritus from failed pmd_mdc_alloc() */
+			continue;
+
+		zonepg = mp->pds_pdv[layout->eld_ld.ol_pdh].pdi_parm.dpr_zonepg;
+		mlogsz = (layout->eld_ld.ol_zcnt * zonepg) << PAGE_SHIFT;
+
+		if (!mdcn)
+			*mdc0cap = *mdc0cap + mlogsz;
+		else
+			*mdccap = *mdccap + mlogsz;
+	}
+
+	pmd_co_runlock(cinfo);
+	pmd_mdc_unlock(&cinfo->mmi_compactlock);
+	mutex_unlock(&pmd_s_lock);
+
+	/* Only count capacity of one mlog in each mdc mlog pair */
+	*mdccap  = *mdccap >> 1;
+	*mdc0cap = *mdc0cap >> 1;
+}
+
+int pmd_mpool_activate(struct mpool_descriptor *mp, struct pmd_layout *mdc01,
+		       struct pmd_layout *mdc02, int create)
+{
+	int rc;
+
+	mp_pr_debug("mdc01: %lu mdc02: %lu", 0, (ulong)mdc01->eld_objid, (ulong)mdc02->eld_objid);
+
+	/* Activation is intense; serialize it when have multiple mpools */
+	mutex_lock(&pmd_s_lock);
+
+	/* Init metadata array for mpool */
+	pmd_mda_init(mp);
+
+	/* Initialize mdc0 for mpool */
+	rc = pmd_mdc0_init(mp, mdc01, mdc02);
+	if (rc) {
+		/*
+		 * pmd_mda_free() will dealloc mdc01/2 on subsequent
+		 * activation failures
+		 */
+		pmd_obj_put(mdc01);
+		pmd_obj_put(mdc02);
+		goto exit;
+	}
+
+	/* Load mpool properties from mdc0 including drive list and states */
+	if (!create) {
+		rc = pmd_props_load(mp);
+		if (rc)
+			goto exit;
+	}
+
+	/*
+	 * initialize smaps for all drives in mpool (now that list
+	 * is finalized)
+	 */
+	rc = smap_mpool_init(mp);
+	if (rc)
+		goto exit;
+
+	/* Load mdc layouts from mdc0 and finalize mda initialization */
+	rc = pmd_objs_load(mp, 0);
+	if (rc)
+		goto exit;
+
+	/* Load user object layouts from all other mdc */
+	rc = pmd_objs_load_parallel(mp);
+	if (rc) {
+		mp_pr_err("mpool %s, failed to load user MDCs", rc, mp->pds_name);
+		goto exit;
+	}
+
+	/*
+	 * If the format of the mpool metadata read from media during activate
+	 * is not the latest, it is time to write the metadata on media with
+	 * the latest format.
+	 */
+	if (!create) {
+		rc = pmd_write_meta_to_latest_version(mp, true);
+		if (rc) {
+			mp_pr_err("mpool %s, failed to compact MDCs (metadata conversion)",
+				  rc, mp->pds_name);
+			goto exit;
+		}
+	}
+exit:
+	if (rc) {
+		/* Activation failed; cleanup */
+		pmd_mda_free(mp);
+		smap_mpool_free(mp);
+	}
+
+	mutex_unlock(&pmd_s_lock);
+
+	return rc;
+}
+
+void pmd_mpool_deactivate(struct mpool_descriptor *mp)
+{
+	/* Deactivation is intense; serialize it when have multiple mpools */
+	mutex_lock(&pmd_s_lock);
+
+	/* Close all open user (non-mdc) mlogs */
+	mlogutil_closeall(mp);
+
+	pmd_mda_free(mp);
+	smap_mpool_free(mp);
+
+	mutex_unlock(&pmd_s_lock);
+}
diff --git a/drivers/mpool/pmd_obj.c b/drivers/mpool/pmd_obj.c
index 8966fc0abd0e..18157fecccfb 100644
--- a/drivers/mpool/pmd_obj.c
+++ b/drivers/mpool/pmd_obj.c
@@ -507,9 +507,7 @@ int pmd_obj_commit(struct mpool_descriptor *mp, struct pmd_layout *layout)
 
 	pmd_mdc_lock(&cinfo->mmi_compactlock, cslot);
 
-#ifdef OBJ_PERSISTENCE_ENABLED
 	rc = pmd_log_create(mp, layout);
-#endif
 	if (!rc) {
 		pmd_uc_lock(cinfo, cslot);
 		found = pmd_uc_remove(cinfo, layout);
@@ -675,9 +673,7 @@ int pmd_obj_delete(struct mpool_descriptor *mp, struct pmd_layout *layout)
 		return (refcnt > 2) ? -EBUSY : -EINVAL;
 	}
 
-#ifdef OBJ_PERSISTENCE_ENABLED
 	rc = pmd_log_delete(mp, objid);
-#endif
 	if (!rc) {
 		pmd_co_wlock(cinfo, cslot);
 		found = pmd_co_remove(cinfo, layout);
@@ -763,9 +759,7 @@ int pmd_obj_erase(struct mpool_descriptor *mp, struct pmd_layout *layout, u64 ge
 
 		pmd_mdc_lock(&cinfo->mmi_compactlock, cslot);
 
-#ifdef OBJ_PERSISTENCE_ENABLED
 		rc = pmd_log_erase(mp, layout->eld_objid, gen);
-#endif
 		if (!rc) {
 			layout->eld_gen = gen;
 			if (cslot)
@@ -830,9 +824,7 @@ static int pmd_alloc_idgen(struct mpool_descriptor *mp, enum obj_type_omf otype,
 		 * to prevent a race with mdc compaction.
 		 */
 		pmd_mdc_lock(&cinfo->mmi_compactlock, cslot);
-#ifdef OBJ_PERSISTENCE_ENABLED
 		rc = pmd_log_idckpt(mp, *objid);
-#endif
 		if (!rc)
 			cinfo->mmi_lckpt = *objid;
 		pmd_mdc_unlock(&cinfo->mmi_compactlock);
-- 
2.17.2

