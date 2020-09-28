Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8921227B27D
	for <lists+linux-block@lfdr.de>; Mon, 28 Sep 2020 18:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgI1Qrw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 28 Sep 2020 12:47:52 -0400
Received: from mail-dm6nam10on2088.outbound.protection.outlook.com ([40.107.93.88]:18657
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726826AbgI1Qre (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Sep 2020 12:47:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGzexvr1uhXEoa47Eqqwd9x3XnKiipPz7z5zE5A13B83kADLN7VK/0olF8k3ILWr7Vo+ZZNNrH0yQ2hpjJHDI8dZtcEKJNLM2Fw3ZheYTDK7wb8O/OdhczyD5d38BuWyz1gaj4wQcbp/vMVl/njJiJdyW+dsNxhWBGsWMqNKuISDHL2on8gls7ioiSFrWS7SMfoK3GMwxUTm2c1xdf2PuQpPCAn1L5PFa+JoLxdwmmYD3LfF7ulFcfbBh0EXu+zkbwOVZGn5pPX5LPMttEdEkTEq5WsSoyQVdkMWliPUUD2ZkfZbAQa4uVWIAc79mohe3MYCFmVcMY8/ajcFbsvytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dd3R2hAlAFHGngJ3uVvqBwnK/GU4ZnTpKb43fx9o8LA=;
 b=CR8HTusOuKpfIYLEICC9DoAtPc08C7UwRRHs6EuzJTe+rgtB2f9nBx1Pk69vjYBcOE7xsNnGj6GOvbv9KZ84QxcS4ORlnNGR3vJJVwuuK4ca1OAS3DNAvVes1veN3YesrhsnvloA5V3UTBwyI5i7Xcs222dz7lZzfXCfe29JDO63pltg4P/IthbSkVX6haAk8sgsubD32dJy3trgn0osgXYKGgnE7PLvgNVPGfgVwBjhKnLln7301rwCz7/Es3k75equSFARFRXHKRb7t0AgxeMl3a1lcrELC+53Sz4iWAIdqZbsExJvHYthCqFYYrezmi6HlKvEIGMYqgXYSSoP/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=kvack.org smtp.mailfrom=micron.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dd3R2hAlAFHGngJ3uVvqBwnK/GU4ZnTpKb43fx9o8LA=;
 b=MDAkOkhRxydftbJuHkD3dMeVDiFUuA/yfuaExMX0YVwNHRy/WV+yMPd7+toh2+M3o53X0Dhi82jtbT/mD1phVC+d+x95yLz+NtMRpluRQnqa068zIiJaZVZoX5kpK0EwCSqZOEFQBaJYaDI5e1hXN6j38lHSPfRs1ZwYTcq4uvQ=
Received: from BN6PR17CA0044.namprd17.prod.outlook.com (2603:10b6:405:75::33)
 by BYAPR08MB4245.namprd08.prod.outlook.com (2603:10b6:a03::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.29; Mon, 28 Sep 2020 16:47:17 +0000
Received: from BN3NAM01FT020.eop-nam01.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::38) by BN6PR17CA0044.outlook.office365.com
 (2603:10b6:405:75::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Mon, 28 Sep 2020 16:47:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com;
Received: from mail.micron.com (137.201.242.130) by
 BN3NAM01FT020.mail.protection.outlook.com (10.152.67.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3412.21 via Frontend Transport; Mon, 28 Sep 2020 16:47:16 +0000
Received: from micron.com (10.114.5.55) by bowex17c.micron.com
 (137.201.21.211) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 28 Sep
 2020 10:47:13 -0600
From:   <nmeeramohide@micron.com>
To:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux-nvdimm@lists.01.org>
CC:     <smoyer@micron.com>, <gbecker@micron.com>, <plabat@micron.com>,
        <jgroves@micron.com>, Nabeel M Mohamed <nmeeramohide@micron.com>
Subject: [PATCH 17/22] mpool: add mpool lifecycle management ioctls
Date:   Mon, 28 Sep 2020 11:45:29 -0500
Message-ID: <20200928164534.48203-18-nmeeramohide@micron.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200928164534.48203-1-nmeeramohide@micron.com>
References: <20200928164534.48203-1-nmeeramohide@micron.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bowex17d.micron.com (137.201.21.212) To bowex17c.micron.com
 (137.201.21.211)
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24646.005
X-TM-AS-Result: No--10.732300-0.000000-31
X-TM-AS-MatchedID: 700076-703904-701478-121588-702559-701342-704053-703017-7
        03173-701270-700328-703572-186035-704841-702617-701343-705041-703532-702732
        -704926-704381-702619-703694-703348-700535-703905-700335-705161-704961-7044
        99-703140-701480-702395-188019-704477-703279-702415-703812-702433-300015-70
        4978-704318-703357-702914-704521-851458-700069-188199-703880-702102-703213-
        703991-704401-700714-704402-702525-701750-703534-700863-703215-703864-70191
        9-704239-780048-702907-700458-704929-702908-703385-701443-704002-702590-705
        244-702490-704718-700786-700716-703027-700060-703285-703878-702779-701475-7
        00717-121367-703347-702853-701104-704418-702438-148004-148036-29997-42000-4
        2003
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb94f881-8204-43b0-12bf-08d863ce289d
X-MS-TrafficTypeDiagnostic: BYAPR08MB4245:
X-Microsoft-Antispam-PRVS: <BYAPR08MB424521A77D4B8B055C213EA6B3350@BYAPR08MB4245.namprd08.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Oob-TLC-OOBClassifiers: OLM:69;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FW9fDDI4/q/vhE+k4q2QJcCPnyxyTDWy6EbWNTSsYgGDqD+SeYsnsOz3FbHVyV5gXNJsrIPSSuVROWwHapRrcOATA0RpM6MHbRVnOvXg0QVl/EbGyP5caLZd1V928HDyhKSZzpgtifwWGBoSMOycS8tIQvkpqi5heV3KTjGTA99Bg4kt6CgoAaEffll/lXxtGSY63vgnqAAdLC2iYbVQEFKqYJk8tHPtMmWJJLZ5okJTOIIxKfWlupt4rnURh++btk2uCt4N1PSK3e7FPPcD1ZUY1H/sjhrWo9AL8Y0hPhmUBVPwe2q2ALrs9hNZsmyKqOEGAyX9IMbJFVHvd3KGOMHStp3jUjIvZou8WDP144fxohPC2yVY+jK/y1TDgTHAsfAh7nrRP6R73ec08eHUIHrd5tNN5CUXOdRwQClk+U7QqzZ4nNE5gv0xM9meBMCPHQu0Wwn7dW6YSPxTzQROQlKBKF0b+Y2Kh7c2VqqL6jmmuAXPgICtQsH7tXV3x95o
X-Forefront-Antispam-Report: CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966005)(2616005)(36756003)(7696005)(26005)(6666004)(186003)(8936002)(8676002)(316002)(110136005)(426003)(2906002)(54906003)(336012)(55016002)(2876002)(5660300002)(107886003)(82310400003)(86362001)(6286002)(70206006)(70586007)(1076003)(82740400003)(7636003)(478600001)(356005)(47076004)(83380400001)(4326008)(30864003)(33310700002)(2101003)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 16:47:16.7051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb94f881-8204-43b0-12bf-08d863ce289d
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3NAM01FT020.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4245
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Nabeel M Mohamed <nmeeramohide@micron.com>

This adds the open, release and mpool management ioctls for
the mpool driver.

The create, destroy, activate, deactivate and rename ioctls
are issued to the mpool control device (/dev/mpoolctl),
and the rest are issued to the mpool device
(/dev/mpool/<mpool_name>).

The mpool control device is owned by (root, disk) with
mode 0664. Non-default uid, gid and mode can be assigned to
an mpool device either at create time or post creation using
the params set ioctl.

Both the per-mpool and common parameters are available in
the sysfs device tree path created by the kernel for each mpool
device minor (/sys/devices/virtual/mpool). Mpool parameters
cannot be changed via the sysfs tree at this point.

The mpool management ioctl handlers invoke the mpool lifecycle
management routines to administer mpools. Activating an mpool
creates a unit object which stores some key information like
reference to the device object, reference to the mpc_mpool
instance containing the per-mpool private data, device props,
ownership and mode bits, device open count, flags etc. The
per-mpool parameters are persisted in MDC0 at activation.

Deactivating an mpool tears down the unit object and releases
all its associated resources.

An mpool can be renamed only when it's deactivated.  Renaming
an mpool updates the superblock on all its constituent storage
volumes with the new mpool name.

Co-developed-by: Greg Becker <gbecker@micron.com>
Signed-off-by: Greg Becker <gbecker@micron.com>
Co-developed-by: Pierre Labat <plabat@micron.com>
Signed-off-by: Pierre Labat <plabat@micron.com>
Co-developed-by: John Groves <jgroves@micron.com>
Signed-off-by: John Groves <jgroves@micron.com>
Signed-off-by: Nabeel M Mohamed <nmeeramohide@micron.com>
---
 drivers/mpool/mpctl.c | 1719 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 1667 insertions(+), 52 deletions(-)

diff --git a/drivers/mpool/mpctl.c b/drivers/mpool/mpctl.c
index 4f3600840ff0..002321c8689b 100644
--- a/drivers/mpool/mpctl.c
+++ b/drivers/mpool/mpctl.c
@@ -78,9 +78,14 @@ static const struct file_operations mpc_fops_default;
 
 static struct mpc_softstate mpc_softstate;
 
+static struct backing_dev_info *mpc_bdi;
+
 static unsigned int mpc_ctl_uid __read_mostly;
 static unsigned int mpc_ctl_gid __read_mostly = 6;
 static unsigned int mpc_ctl_mode __read_mostly = 0664;
+static unsigned int mpc_default_uid __read_mostly;
+static unsigned int mpc_default_gid __read_mostly = 6;
+static unsigned int mpc_default_mode __read_mostly = 0660;
 
 static const struct mpc_uinfo mpc_uinfo_ctl = {
 	.ui_typename = "mpoolctl",
@@ -112,6 +117,202 @@ static inline gid_t mpc_current_gid(void)
 	return from_kgid(current_user_ns(), current_gid());
 }
 
+#define MPC_MPOOL_PARAMS_CNT     7
+
+static ssize_t mpc_uid_show(struct device *dev, struct device_attribute *da, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%d\n", dev_to_unit(dev)->un_uid);
+}
+
+static ssize_t mpc_gid_show(struct device *dev, struct device_attribute *da, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%d\n", dev_to_unit(dev)->un_gid);
+}
+
+static ssize_t mpc_mode_show(struct device *dev, struct device_attribute *da, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "0%o\n", dev_to_unit(dev)->un_mode);
+}
+
+static ssize_t mpc_ra_show(struct device *dev, struct device_attribute *da, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%u\n", dev_to_unit(dev)->un_ra_pages_max);
+}
+
+static ssize_t mpc_label_show(struct device *dev, struct device_attribute *da, char *buf)
+{
+	return scnprintf(buf, PAGE_SIZE, "%s\n", dev_to_unit(dev)->un_label);
+}
+
+static ssize_t mpc_type_show(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct mpool_uuid  uuid;
+	char               uuid_str[MPOOL_UUID_STRING_LEN + 1] = { };
+
+	memcpy(uuid.uuid, dev_to_unit(dev)->un_utype.b, MPOOL_UUID_SIZE);
+	mpool_unparse_uuid(&uuid, uuid_str);
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", uuid_str);
+}
+
+static void mpc_mpool_params_add(struct device_attribute *dattr)
+{
+	MPC_ATTR_RO(dattr++, uid);
+	MPC_ATTR_RO(dattr++, gid);
+	MPC_ATTR_RO(dattr++, mode);
+	MPC_ATTR_RO(dattr++, ra);
+	MPC_ATTR_RO(dattr++, label);
+	MPC_ATTR_RO(dattr,   type);
+}
+
+static int mpc_params_register(struct mpc_unit *unit, int cnt)
+{
+	struct device_attribute *dattr;
+	struct mpc_attr *attr;
+	int rc;
+
+	attr = mpc_attr_create(unit->un_device, "parameters", cnt);
+	if (!attr)
+		return -ENOMEM;
+
+	dattr = attr->a_dattr;
+
+	/* Per-mpool parameters */
+	if (mpc_unit_ismpooldev(unit))
+		mpc_mpool_params_add(dattr);
+
+	rc = mpc_attr_group_create(attr);
+	if (rc) {
+		mpc_attr_destroy(attr);
+		return rc;
+	}
+
+	unit->un_attr = attr;
+
+	return 0;
+}
+
+static void mpc_params_unregister(struct mpc_unit *unit)
+{
+	mpc_attr_group_destroy(unit->un_attr);
+	mpc_attr_destroy(unit->un_attr);
+	unit->un_attr = NULL;
+}
+
+/**
+ * mpc_toascii() - convert string to restricted ASCII
+ *
+ * Zeroes out the remainder of str[] and returns the length.
+ */
+static size_t mpc_toascii(char *str, size_t sz)
+{
+	size_t len = 0;
+	int i;
+
+	if (!str || sz < 1)
+		return 0;
+
+	if (str[0] == '-')
+		str[0] = '_';
+
+	for (i = 0; i < (sz - 1) && str[i]; ++i) {
+		if (isalnum(str[i]) || strchr("_.-", str[i]))
+			continue;
+
+		str[i] = '_';
+	}
+
+	len = i;
+
+	while (i < sz)
+		str[i++] = '\000';
+
+	return len;
+}
+
+static void mpool_params_merge_defaults(struct mpool_params *params)
+{
+	if (params->mp_spare_cap == MPOOL_SPARES_INVALID)
+		params->mp_spare_cap = MPOOL_SPARES_DEFAULT;
+
+	if (params->mp_spare_stg == MPOOL_SPARES_INVALID)
+		params->mp_spare_stg = MPOOL_SPARES_DEFAULT;
+
+	if (params->mp_ra_pages_max == U32_MAX)
+		params->mp_ra_pages_max = MPOOL_RA_PAGES_MAX;
+	params->mp_ra_pages_max = clamp_t(u32, params->mp_ra_pages_max, 0, MPOOL_RA_PAGES_MAX);
+
+	if (params->mp_mode != -1)
+		params->mp_mode &= 0777;
+
+	params->mp_rsvd0 = 0;
+	params->mp_rsvd1 = 0;
+	params->mp_rsvd2 = 0;
+	params->mp_rsvd3 = 0;
+	params->mp_rsvd4 = 0;
+
+	if (!strcmp(params->mp_label, MPOOL_LABEL_INVALID))
+		strcpy(params->mp_label, MPOOL_LABEL_DEFAULT);
+
+	mpc_toascii(params->mp_label, sizeof(params->mp_label));
+}
+
+static void mpool_to_mpcore_params(struct mpool_params *params, struct mpcore_params *mpc_params)
+{
+	u64 mdc0cap, mdcncap;
+	u32 mdcnum;
+
+	mpcore_params_defaults(mpc_params);
+
+	mdc0cap = (u64)params->mp_mdc0cap << 20;
+	mdcncap = (u64)params->mp_mdcncap << 20;
+	mdcnum  = params->mp_mdcnum;
+
+	if (mdc0cap != 0)
+		mpc_params->mp_mdc0cap = mdc0cap;
+
+	if (mdcncap != 0)
+		mpc_params->mp_mdcncap = mdcncap;
+
+	if (mdcnum != 0)
+		mpc_params->mp_mdcnum = mdcnum;
+}
+
+static bool mpool_params_merge_config(struct mpool_params *params, struct mpool_config *cfg)
+{
+	uuid_le uuidnull = { };
+	bool changed = false;
+
+	if (params->mp_uid != -1 && params->mp_uid != cfg->mc_uid) {
+		cfg->mc_uid = params->mp_uid;
+		changed = true;
+	}
+
+	if (params->mp_gid != -1 && params->mp_gid != cfg->mc_gid) {
+		cfg->mc_gid = params->mp_gid;
+		changed = true;
+	}
+
+	if (params->mp_mode != -1 && params->mp_mode != cfg->mc_mode) {
+		cfg->mc_mode = params->mp_mode;
+		changed = true;
+	}
+
+	if (memcmp(&uuidnull, &params->mp_utype, sizeof(uuidnull)) &&
+	    memcmp(&params->mp_utype, &cfg->mc_utype, sizeof(params->mp_utype))) {
+		memcpy(&cfg->mc_utype, &params->mp_utype, sizeof(cfg->mc_utype));
+		changed = true;
+	}
+
+	if (strcmp(params->mp_label, MPOOL_LABEL_DEFAULT) &&
+	    strncmp(params->mp_label, cfg->mc_label, sizeof(params->mp_label))) {
+		strlcpy(cfg->mc_label, params->mp_label, sizeof(cfg->mc_label));
+		changed = true;
+	}
+
+	return changed;
+}
+
 /**
  * mpc_mpool_release() - release kref handler for mpc_mpool object
  * @refp:  kref pointer
@@ -216,6 +417,9 @@ static void mpc_unit_release(struct kref *refp)
 	if (unit->un_mpool)
 		mpc_mpool_put(unit->un_mpool);
 
+	if (unit->un_attr)
+		mpc_params_unregister(unit);
+
 	if (unit->un_device)
 		device_destroy(ss->ss_class, unit->un_devno);
 
@@ -228,6 +432,89 @@ static void mpc_unit_put(struct mpc_unit *unit)
 		kref_put(&unit->un_ref, mpc_unit_release);
 }
 
+/**
+ * mpc_unit_lookup() - Look up a unit by minor number.
+ * @minor:  minor number
+ * @unitp:  unit ptr
+ *
+ * Returns a referenced ptr to the unit (via *unitp) if found,
+ * otherwise it sets *unitp to NULL.
+ */
+static void mpc_unit_lookup(int minor, struct mpc_unit **unitp)
+{
+	struct mpc_softstate *ss = &mpc_softstate;
+	struct mpc_unit *unit;
+
+	*unitp = NULL;
+
+	mutex_lock(&ss->ss_lock);
+	unit = idr_find(&ss->ss_unitmap, minor);
+	if (unit) {
+		kref_get(&unit->un_ref);
+		*unitp = unit;
+	}
+	mutex_unlock(&ss->ss_lock);
+}
+
+/**
+ * mpc_unit_lookup_by_name_itercb() - Test to see if unit matches arg.
+ * @item:   unit ptr
+ * @arg:    argument vector base ptr
+ *
+ * This iterator callback is called by mpc_unit_lookup_by_name()
+ * for each unit in the units table.
+ *
+ * Return: If the unit matching the given name is found returns
+ * the referenced unit pointer in argv[2], otherwise NULL.
+ */
+static int mpc_unit_lookup_by_name_itercb(int minor, void *item, void *arg)
+{
+	struct mpc_unit *unit = item;
+	void **argv = arg;
+	struct mpc_unit *parent = argv[0];
+	const char *name = argv[1];
+
+	if (!unit)
+		return ITERCB_NEXT;
+
+	if (mpc_unit_isctldev(parent) && !mpc_unit_ismpooldev(unit))
+		return ITERCB_NEXT;
+
+	if (parent->un_mpool && unit->un_mpool != parent->un_mpool)
+		return ITERCB_NEXT;
+
+	if (strcmp(unit->un_name, name) == 0) {
+		kref_get(&unit->un_ref);
+		argv[2] = unit;
+		return ITERCB_DONE;
+	}
+
+	return ITERCB_NEXT;
+}
+
+/**
+ * mpc_unit_lookup_by_name() - Look up an mpool unit by name.
+ * @parent: parent unit
+ * @name:   unit name. This is not the mpool name.
+ * @unitp:  unit ptr
+ *
+ * If a unit exists in the system which has the given name and parent
+ * then it is referenced and returned via *unitp.  Otherwise, *unitp
+ * is set to NULL.
+ */
+static void mpc_unit_lookup_by_name(struct mpc_unit *parent, const char *name,
+				    struct mpc_unit **unitp)
+{
+	struct mpc_softstate *ss = &mpc_softstate;
+	void *argv[] = { parent, (void *)name, NULL };
+
+	mutex_lock(&ss->ss_lock);
+	idr_for_each(&ss->ss_unitmap, mpc_unit_lookup_by_name_itercb, argv);
+	mutex_unlock(&ss->ss_lock);
+
+	*unitp = argv[2];
+}
+
 /**
  * mpc_unit_setup() - Create a device unit object and special file
  * @uinfo:
@@ -328,6 +615,36 @@ static int mpc_unit_setup(const struct mpc_uinfo *uinfo, const char *name,
 	return rc;
 }
 
+
+static int mpc_cf_journal(struct mpc_unit *unit)
+{
+	struct mpool_config cfg = { };
+	struct mpc_mpool *mpool;
+	int rc;
+
+	mpool = unit->un_mpool;
+	if (!mpool)
+		return -EINVAL;
+
+	down_write(&mpool->mp_lock);
+
+	cfg.mc_uid = unit->un_uid;
+	cfg.mc_gid = unit->un_gid;
+	cfg.mc_mode = unit->un_mode;
+	cfg.mc_oid1 = unit->un_ds_oidv[0];
+	cfg.mc_oid2 = unit->un_ds_oidv[1];
+	cfg.mc_captgt = unit->un_mdc_captgt;
+	cfg.mc_ra_pages_max = unit->un_ra_pages_max;
+	memcpy(&cfg.mc_utype, &unit->un_utype, sizeof(cfg.mc_utype));
+	strlcpy(cfg.mc_label, unit->un_label, sizeof(cfg.mc_label));
+
+	rc = mpool_config_store(mpool->mp_desc, &cfg);
+
+	up_write(&mpool->mp_lock);
+
+	return rc;
+}
+
 /**
  * mpc_uevent() - Hook to intercept and modify uevents before they're posted to udev
  * @dev:    mpc driver device
@@ -348,86 +665,1384 @@ static int mpc_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
-static int mpc_exit_unit(int minor, void *item, void *arg)
+/**
+ * mpc_mp_chown() - Change ownership of an mpool.
+ * @unit: mpool unit ptr
+ * @mps:
+ *
+ * Return:  Returns 0 if successful, -errno otherwise...
+ */
+static int mpc_mp_chown(struct mpc_unit *unit, struct mpool_params *params)
 {
-	mpc_unit_put(item);
+	mode_t mode;
+	uid_t uid;
+	gid_t gid;
+	int rc = 0;
 
-	return ITERCB_NEXT;
+	if (!mpc_unit_ismpooldev(unit))
+		return -EINVAL;
+
+	uid  = params->mp_uid;
+	gid  = params->mp_gid;
+	mode = params->mp_mode;
+
+	if (mode != -1)
+		mode &= 0777;
+
+	if (uid != -1 && uid != unit->un_uid && !capable(CAP_CHOWN))
+		return -EPERM;
+
+	if (gid != -1 && gid != unit->un_gid && !capable(CAP_CHOWN))
+		return -EPERM;
+
+	if (mode != -1 && mode != unit->un_mode && !capable(CAP_FOWNER))
+		return -EPERM;
+
+	if (-1 != uid)
+		unit->un_uid = uid;
+	if (-1 != gid)
+		unit->un_gid = gid;
+	if (-1 != mode)
+		unit->un_mode = mode;
+
+	if (uid != -1 || gid != -1 || mode != -1)
+		rc = kobject_uevent(&unit->un_device->kobj, KOBJ_CHANGE);
+
+	return rc;
 }
 
 /**
- * mpctl_exit() - Tear down and unload the mpool control module.
+ * mpioc_params_get() - get parameters of an activated mpool
+ * @unit:   mpool unit ptr
+ * @get:    mpool params
+ *
+ * MPIOC_PARAMS_GET ioctl handler to get mpool parameters
+ *
+ * Return:  Returns 0 if successful, -errno otherwise...
  */
-void mpctl_exit(void)
+static int mpioc_params_get(struct mpc_unit *unit, struct mpioc_params *get)
 {
 	struct mpc_softstate *ss = &mpc_softstate;
+	struct mpool_descriptor *desc;
+	struct mpool_params *params;
+	struct mpool_xprops xprops = { };
+	u8 mclass;
 
-	if (ss->ss_inited) {
-		idr_for_each(&ss->ss_unitmap, mpc_exit_unit, NULL);
-		idr_destroy(&ss->ss_unitmap);
+	if (!mpc_unit_ismpooldev(unit))
+		return -EINVAL;
 
-		if (ss->ss_devno != NODEV) {
-			if (ss->ss_class) {
-				if (ss->ss_cdev.ops)
-					cdev_del(&ss->ss_cdev);
-				class_destroy(ss->ss_class);
-			}
-			unregister_chrdev_region(ss->ss_devno, maxunits);
-		}
+	desc = unit->un_mpool->mp_desc;
 
-		ss->ss_inited = false;
-	}
+	mutex_lock(&ss->ss_lock);
+
+	params = &get->mps_params;
+	memset(params, 0, sizeof(*params));
+	params->mp_uid = unit->un_uid;
+	params->mp_gid = unit->un_gid;
+	params->mp_mode = unit->un_mode;
+	params->mp_mdc_captgt = MPOOL_ROOT_LOG_CAP;
+	params->mp_oidv[0] = unit->un_ds_oidv[0];
+	params->mp_oidv[1] = unit->un_ds_oidv[1];
+	params->mp_ra_pages_max = unit->un_ra_pages_max;
+	memcpy(&params->mp_utype, &unit->un_utype, sizeof(params->mp_utype));
+	strlcpy(params->mp_label, unit->un_label, sizeof(params->mp_label));
+	strlcpy(params->mp_name, unit->un_name, sizeof(params->mp_name));
+
+	/* Get mpool properties.. */
+	mpool_get_xprops(desc, &xprops);
+
+	for (mclass = 0; mclass < MP_MED_NUMBER; mclass++)
+		params->mp_mblocksz[mclass] = xprops.ppx_params.mp_mblocksz[mclass];
+
+	params->mp_spare_cap = xprops.ppx_drive_spares[MP_MED_CAPACITY];
+	params->mp_spare_stg = xprops.ppx_drive_spares[MP_MED_STAGING];
+
+	memcpy(params->mp_poolid.b, xprops.ppx_params.mp_poolid.b, MPOOL_UUID_SIZE);
+
+	mutex_unlock(&ss->ss_lock);
+
+	return 0;
 }
 
 /**
- * mpctl_init() - Load and initialize the mpool control module.
+ * mpioc_params_set() - set parameters of an activated mpool
+ * @unit:   mpool unit ptr
+ * @set:    mpool params
+ *
+ * MPIOC_PARAMS_SET ioctl handler to set mpool parameters
+ *
+ * Return:  Returns 0 if successful, -errno otherwise...
  */
-int mpctl_init(void)
+static int mpioc_params_set(struct mpc_unit *unit, struct mpioc_params *set)
 {
 	struct mpc_softstate *ss = &mpc_softstate;
-	struct mpool_config *cfg = NULL;
-	struct mpc_unit *ctlunit;
-	const char *errmsg = NULL;
-	int rc;
+	struct mpool_descriptor *mp;
+	struct mpool_params *params;
+	uuid_le uuidnull = { };
+	int rerr = 0, err = 0;
+	bool journal = false;
 
-	if (ss->ss_inited)
-		return -EBUSY;
+	if (!mpc_unit_ismpooldev(unit))
+		return -EINVAL;
 
-	ctlunit = NULL;
+	params = &set->mps_params;
 
-	maxunits = clamp_t(uint, maxunits, 8, 8192);
+	mutex_lock(&ss->ss_lock);
+	if (params->mp_uid != -1 || params->mp_gid != -1 || params->mp_mode != -1) {
+		err = mpc_mp_chown(unit, params);
+		if (err) {
+			mutex_unlock(&ss->ss_lock);
+			return err;
+		}
+		journal = true;
+	}
 
-	cdev_init(&ss->ss_cdev, &mpc_fops_default);
-	ss->ss_cdev.owner = THIS_MODULE;
+	if (params->mp_label[0]) {
+		mpc_toascii(params->mp_label, sizeof(params->mp_label));
+		strlcpy(unit->un_label, params->mp_label, sizeof(unit->un_label));
+		journal = true;
+	}
 
-	mutex_init(&ss->ss_lock);
-	idr_init(&ss->ss_unitmap);
-	ss->ss_class = NULL;
-	ss->ss_devno = NODEV;
-	sema_init(&ss->ss_op_sema, 1);
-	ss->ss_inited = true;
+	if (memcmp(&uuidnull, &params->mp_utype, sizeof(uuidnull))) {
+		memcpy(&unit->un_utype, &params->mp_utype, sizeof(unit->un_utype));
+		journal = true;
+	}
 
-	rc = alloc_chrdev_region(&ss->ss_devno, 0, maxunits, "mpool");
-	if (rc) {
-		errmsg = "cannot allocate control device major";
-		ss->ss_devno = NODEV;
-		goto errout;
+	if (params->mp_ra_pages_max != U32_MAX) {
+		unit->un_ra_pages_max = clamp_t(u32, params->mp_ra_pages_max,
+						0, MPOOL_RA_PAGES_MAX);
+		journal = true;
 	}
 
-	ss->ss_class = class_create(THIS_MODULE, module_name(THIS_MODULE));
-	if (IS_ERR(ss->ss_class)) {
-		errmsg = "class_create() failed";
-		rc = PTR_ERR(ss->ss_class);
-		ss->ss_class = NULL;
-		goto errout;
+	if (journal)
+		err = mpc_cf_journal(unit);
+	mutex_unlock(&ss->ss_lock);
+
+	if (err) {
+		mp_pr_err("%s: params commit failed", err, unit->un_name);
+		return err;
 	}
 
-	ss->ss_class->dev_uevent = mpc_uevent;
+	mp = unit->un_mpool->mp_desc;
 
-	rc = cdev_add(&ss->ss_cdev, ss->ss_devno, maxunits);
-	if (rc) {
-		errmsg = "cdev_add() failed";
-		ss->ss_cdev.ops = NULL;
+	if (params->mp_spare_cap != MPOOL_SPARES_INVALID) {
+		err = mpool_drive_spares(mp, MP_MED_CAPACITY, params->mp_spare_cap);
+		if (err && err != -ENOENT)
+			rerr = err;
+	}
+
+	if (params->mp_spare_stg != MPOOL_SPARES_INVALID) {
+		err = mpool_drive_spares(mp, MP_MED_STAGING, params->mp_spare_stg);
+		if (err && err != -ENOENT)
+			rerr = err;
+	}
+
+	return rerr;
+}
+
+/**
+ * mpioc_mp_mclass_get() - get information regarding an mpool's mclasses
+ * @unit:   mpool unit ptr
+ * @mcl:    mclass info struct
+ *
+ * MPIOC_MP_MCLASS_GET ioctl handler to get mclass information
+ *
+ * Return:  Returns 0 if successful, -errno otherwise...
+ */
+static int mpioc_mp_mclass_get(struct mpc_unit *unit, struct mpioc_mclass *mcl)
+{
+	struct mpool_descriptor *desc = unit->un_mpool->mp_desc;
+	struct mpool_mclass_xprops mcxv[MP_MED_NUMBER];
+	uint32_t mcxc = ARRAY_SIZE(mcxv);
+	int rc;
+
+	if (!mcl || !desc)
+		return -EINVAL;
+
+	if (!mcl->mcl_xprops) {
+		mpool_mclass_get_cnt(desc, &mcl->mcl_cnt);
+		return 0;
+	}
+
+	memset(mcxv, 0, sizeof(mcxv));
+
+	rc = mpool_mclass_get(desc, &mcxc, mcxv);
+	if (rc)
+		return rc;
+
+	if (mcxc > mcl->mcl_cnt)
+		mcxc = mcl->mcl_cnt;
+	mcl->mcl_cnt = mcxc;
+
+	rc = copy_to_user(mcl->mcl_xprops, mcxv, sizeof(mcxv[0]) * mcxc);
+
+	return rc ? -EFAULT : 0;
+}
+
+/**
+ * mpioc_devprops_get() - Get device properties
+ * @unit:   mpool unit ptr
+ *
+ * MPIOC_PROP_GET ioctl handler to retrieve properties for the specified device.
+ */
+static int mpioc_devprops_get(struct mpc_unit *unit, struct mpioc_devprops *devprops)
+{
+	int rc = 0;
+
+	if (unit->un_mpool) {
+		struct mpool_descriptor *mp = unit->un_mpool->mp_desc;
+
+		rc = mpool_get_devprops_by_name(mp, devprops->dpr_pdname, &devprops->dpr_devprops);
+	}
+
+	return rc;
+}
+
+/**
+ * mpioc_prop_get() - Get mpool properties.
+ * @unit:   mpool unit ptr
+ *
+ * MPIOC_PROP_GET ioctl handler to retrieve properties for the specified device.
+ */
+static void mpioc_prop_get(struct mpc_unit *unit, struct mpioc_prop *kprop)
+{
+	struct mpool_descriptor *desc = unit->un_mpool->mp_desc;
+	struct mpool_params *params;
+	struct mpool_xprops *xprops;
+
+	memset(kprop, 0, sizeof(*kprop));
+
+	/* Get unit properties.. */
+	params = &kprop->pr_xprops.ppx_params;
+	params->mp_uid = unit->un_uid;
+	params->mp_gid = unit->un_gid;
+	params->mp_mode = unit->un_mode;
+	params->mp_mdc_captgt = unit->un_mdc_captgt;
+	params->mp_oidv[0] = unit->un_ds_oidv[0];
+	params->mp_oidv[1] = unit->un_ds_oidv[1];
+	params->mp_ra_pages_max = unit->un_ra_pages_max;
+	memcpy(&params->mp_utype, &unit->un_utype, sizeof(params->mp_utype));
+	strlcpy(params->mp_label, unit->un_label, sizeof(params->mp_label));
+	strlcpy(params->mp_name, unit->un_name, sizeof(params->mp_name));
+
+	/* Get mpool properties.. */
+	xprops = &kprop->pr_xprops;
+	mpool_get_xprops(desc, xprops);
+	mpool_get_usage(desc, MP_MED_ALL, &kprop->pr_usage);
+
+	params->mp_spare_cap = xprops->ppx_drive_spares[MP_MED_CAPACITY];
+	params->mp_spare_stg = xprops->ppx_drive_spares[MP_MED_STAGING];
+
+	kprop->pr_mcxc = ARRAY_SIZE(kprop->pr_mcxv);
+	mpool_mclass_get(desc, &kprop->pr_mcxc, kprop->pr_mcxv);
+}
+
+/**
+ * mpioc_proplist_get_itercb() - Get properties iterator callback.
+ * @item:   unit ptr
+ * @arg:    argument list
+ *
+ * Return: Returns properties for each unit matching the input criteria.
+ */
+static int mpioc_proplist_get_itercb(int minor, void *item, void *arg)
+{
+	struct mpc_unit *unit = item;
+	struct mpioc_prop __user *uprop;
+	struct mpioc_prop kprop;
+	struct mpc_unit *match;
+	struct mpioc_list *ls;
+	void **argv = arg;
+	int *cntp, rc;
+	int *errp;
+
+	if (!unit)
+		return ITERCB_NEXT;
+
+	match = argv[0];
+	ls = argv[1];
+
+	if (mpc_unit_isctldev(match) && !mpc_unit_ismpooldev(unit) &&
+	    ls->ls_cmd != MPIOC_LIST_CMD_PROP_GET)
+		return ITERCB_NEXT;
+
+	if (mpc_unit_ismpooldev(match) && !mpc_unit_ismpooldev(unit) &&
+	    ls->ls_cmd != MPIOC_LIST_CMD_PROP_GET)
+		return ITERCB_NEXT;
+
+	if (mpc_unit_ismpooldev(match) && unit->un_mpool != match->un_mpool)
+		return ITERCB_NEXT;
+
+	cntp = argv[2];
+	errp = argv[3];
+
+	mpioc_prop_get(unit, &kprop);
+
+	uprop = (struct mpioc_prop __user *)ls->ls_listv + *cntp;
+
+	rc = copy_to_user(uprop, &kprop, sizeof(*uprop));
+	if (rc) {
+		*errp = -EFAULT;
+		return ITERCB_DONE;
+	}
+
+	return (++(*cntp) >= ls->ls_listc) ? ITERCB_DONE : ITERCB_NEXT;
+}
+
+/**
+ * mpioc_proplist_get() - Get mpool properties.
+ * @unit:   mpool unit ptr
+ * @ls:     properties parameter block
+ *
+ * MPIOC_PROP_GET ioctl handler to retrieve properties for one
+ * or more mpools.
+ *
+ * Return:  Returns 0 if successful, -errno otherwise...
+ */
+static int mpioc_proplist_get(struct mpc_unit *unit, struct mpioc_list *ls)
+{
+	struct mpc_softstate *ss = &mpc_softstate;
+	int err = 0;
+	int cnt = 0;
+	void *argv[] = { unit, ls, &cnt, &err };
+
+	if (!ls || ls->ls_listc < 1 || ls->ls_cmd == MPIOC_LIST_CMD_INVALID)
+		return -EINVAL;
+
+	mutex_lock(&ss->ss_lock);
+	idr_for_each(&ss->ss_unitmap, mpioc_proplist_get_itercb, argv);
+	mutex_unlock(&ss->ss_lock);
+
+	ls->ls_listc = cnt;
+
+	return err;
+}
+
+/**
+ * mpc_mpool_open() - Open the mpool specified by the given drive paths,
+ *                    and then create an mpool object to track the
+ *                    underlying mpool.
+ * @dpathc: drive count
+ * @dpathv: drive path name vector
+ * @mpoolp: mpool ptr. Set only if success.
+ * @pd_prop: PDs properties
+ *
+ * Return:  Returns 0 if successful and sets *mpoolp.
+ *          Returns -errno on error.
+ */
+static int mpc_mpool_open(uint dpathc, char **dpathv, struct mpc_mpool **mpoolp,
+			  struct pd_prop *pd_prop, struct mpool_params *params, u32 flags)
+{
+	struct mpc_softstate *ss = &mpc_softstate;
+	struct mpcore_params mpc_params;
+	struct mpc_mpool *mpool;
+	size_t mpoolsz, len;
+	int rc;
+
+	if (!ss || !dpathv || !mpoolp || !params)
+		return -EINVAL;
+
+	len = mpc_toascii(params->mp_name, sizeof(params->mp_name));
+	if (len < 1 || len >= MPOOL_NAMESZ_MAX)
+		return (len < 1) ? -EINVAL : -ENAMETOOLONG;
+
+	mpoolsz = sizeof(*mpool) + len + 1;
+
+	mpool = kzalloc(mpoolsz, GFP_KERNEL);
+	if (!mpool)
+		return -ENOMEM;
+
+	if (!try_module_get(THIS_MODULE)) {
+		kfree(mpool);
+		return -EBUSY;
+	}
+
+	mpool_to_mpcore_params(params, &mpc_params);
+
+	rc = mpool_activate(dpathc, dpathv, pd_prop, MPOOL_ROOT_LOG_CAP,
+			    &mpc_params, flags, &mpool->mp_desc);
+	if (rc) {
+		mp_pr_err("Activating %s failed", rc, params->mp_name);
+		module_put(THIS_MODULE);
+		kfree(mpool);
+		return rc;
+	}
+
+	kref_init(&mpool->mp_ref);
+	init_rwsem(&mpool->mp_lock);
+	mpool->mp_dpathc = dpathc;
+	mpool->mp_dpathv = dpathv;
+	strcpy(mpool->mp_name, params->mp_name);
+
+	*mpoolp = mpool;
+
+	return 0;
+}
+
+/**
+ * mpioc_mp_create() - create an mpool.
+ * @mp:      mpool parameter block
+ * @pd_prop:
+ * @dpathv:
+ *
+ * MPIOC_MP_CREATE ioctl handler to create an mpool.
+ *
+ * Return:  Returns 0 if the mpool is created, -errno otherwise...
+ */
+static int mpioc_mp_create(struct mpc_unit *ctl, struct mpioc_mpool *mp,
+			   struct pd_prop *pd_prop, char ***dpathv)
+{
+	struct mpc_softstate *ss = &mpc_softstate;
+	struct mpcore_params mpc_params;
+	struct mpool_config cfg = { };
+	struct mpc_mpool *mpool = NULL;
+	struct mpc_unit *unit = NULL;
+	size_t len;
+	mode_t mode;
+	uid_t uid;
+	gid_t gid;
+	int rc;
+
+	if (!ctl || !mp || !pd_prop || !dpathv)
+		return -EINVAL;
+
+	len = mpc_toascii(mp->mp_params.mp_name, sizeof(mp->mp_params.mp_name));
+	if (len < 1 || len >= MPOOL_NAMESZ_MAX)
+		return (len < 1) ? -EINVAL : -ENAMETOOLONG;
+
+	mpool_params_merge_defaults(&mp->mp_params);
+
+	uid  = mp->mp_params.mp_uid;
+	gid  = mp->mp_params.mp_gid;
+	mode = mp->mp_params.mp_mode;
+
+	if (uid == -1)
+		uid = mpc_default_uid;
+	if (gid == -1)
+		gid = mpc_default_gid;
+	if (mode == -1)
+		mode = mpc_default_mode;
+
+	mode &= 0777;
+
+	if (uid != mpc_current_uid() && !capable(CAP_CHOWN)) {
+		rc = -EPERM;
+		mp_pr_err("chown permission denied, uid %d", rc, uid);
+		return rc;
+	}
+
+	if (gid != mpc_current_gid() && !capable(CAP_CHOWN)) {
+		rc = -EPERM;
+		mp_pr_err("chown permission denied, gid %d", rc, gid);
+		return rc;
+	}
+
+	if (!capable(CAP_SYS_ADMIN)) {
+		rc = -EPERM;
+		mp_pr_err("chmod/activate permission denied", rc);
+		return rc;
+	}
+
+	mpool_to_mpcore_params(&mp->mp_params, &mpc_params);
+
+	rc = mpool_create(mp->mp_params.mp_name, mp->mp_flags, *dpathv,
+			  pd_prop, &mpc_params, MPOOL_ROOT_LOG_CAP);
+	if (rc) {
+		mp_pr_err("%s: create failed", rc, mp->mp_params.mp_name);
+		return rc;
+	}
+
+	/*
+	 * Create an mpc_mpool object through which we can (re)open and manage
+	 * the mpool.  If successful, mpc_mpool_open() adopts dpathv.
+	 */
+	mpool_params_merge_defaults(&mp->mp_params);
+
+	rc = mpc_mpool_open(mp->mp_dpathc, *dpathv, &mpool, pd_prop, &mp->mp_params, mp->mp_flags);
+	if (rc) {
+		mp_pr_err("%s: mpc_mpool_open failed", rc, mp->mp_params.mp_name);
+		mpool_destroy(mp->mp_dpathc, *dpathv, pd_prop, mp->mp_flags);
+		return rc;
+	}
+
+	*dpathv = NULL;
+
+	mlog_lookup_rootids(&cfg.mc_oid1, &cfg.mc_oid2);
+	cfg.mc_uid = uid;
+	cfg.mc_gid = gid;
+	cfg.mc_mode = mode;
+	cfg.mc_rsvd0 = mp->mp_params.mp_rsvd0;
+	cfg.mc_captgt = MPOOL_ROOT_LOG_CAP;
+	cfg.mc_ra_pages_max = mp->mp_params.mp_ra_pages_max;
+	cfg.mc_rsvd1 = mp->mp_params.mp_rsvd1;
+	cfg.mc_rsvd2 = mp->mp_params.mp_rsvd2;
+	cfg.mc_rsvd3 = mp->mp_params.mp_rsvd3;
+	cfg.mc_rsvd4 = mp->mp_params.mp_rsvd4;
+	memcpy(&cfg.mc_utype, &mp->mp_params.mp_utype, sizeof(cfg.mc_utype));
+	strlcpy(cfg.mc_label, mp->mp_params.mp_label, sizeof(cfg.mc_label));
+
+	rc = mpool_config_store(mpool->mp_desc, &cfg);
+	if (rc) {
+		mp_pr_err("%s: config store failed", rc, mp->mp_params.mp_name);
+		goto errout;
+	}
+
+	/* A unit is born with two references:  A birth reference, and one for the caller. */
+	rc = mpc_unit_setup(&mpc_uinfo_mpool, mp->mp_params.mp_name,
+			    &cfg, mpool, &unit);
+	if (rc) {
+		mp_pr_err("%s: unit setup failed", rc, mp->mp_params.mp_name);
+		goto errout;
+	}
+
+	/* Return resolved params to caller. */
+	mp->mp_params.mp_uid = uid;
+	mp->mp_params.mp_gid = gid;
+	mp->mp_params.mp_mode = mode;
+	mp->mp_params.mp_mdc_captgt = cfg.mc_captgt;
+	mp->mp_params.mp_oidv[0] = cfg.mc_oid1;
+	mp->mp_params.mp_oidv[1] = cfg.mc_oid2;
+
+	rc = mpc_params_register(unit, MPC_MPOOL_PARAMS_CNT);
+	if (rc) {
+		mpc_unit_put(unit); /* drop birth ref */
+		goto errout;
+	}
+
+	mutex_lock(&ss->ss_lock);
+	idr_replace(&ss->ss_unitmap, unit, MINOR(unit->un_devno));
+	mutex_unlock(&ss->ss_lock);
+
+	mpool = NULL;
+
+errout:
+	if (mpool) {
+		mpool_deactivate(mpool->mp_desc);
+		mpool->mp_desc = NULL;
+		mpool_destroy(mp->mp_dpathc, mpool->mp_dpathv, pd_prop, mp->mp_flags);
+	}
+
+	/*
+	 * For failures after mpc_unit_setup() (i.e., mpool != NULL)
+	 * dropping the final unit ref will release the mpool ref.
+	 */
+	if (unit)
+		mpc_unit_put(unit); /* Drop caller's ref */
+	else if (mpool)
+		mpc_mpool_put(mpool);
+
+	return rc;
+}
+
+/**
+ * mpioc_mp_activate() - activate an mpool.
+ * @mp:      mpool parameter block
+ * @pd_prop:
+ * @dpathv:
+ *
+ * MPIOC_MP_ACTIVATE ioctl handler to activate an mpool.
+ *
+ * Return:  Returns 0 if the mpool is activated, -errno otherwise...
+ */
+static int mpioc_mp_activate(struct mpc_unit *ctl, struct mpioc_mpool *mp,
+			     struct pd_prop *pd_prop, char ***dpathv)
+{
+	struct mpc_softstate *ss = &mpc_softstate;
+	struct mpool_config cfg;
+	struct mpc_mpool *mpool = NULL;
+	struct mpc_unit *unit = NULL;
+	size_t len;
+	int rc;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (!ctl || !mp || !pd_prop || !dpathv)
+		return -EINVAL;
+
+	len = mpc_toascii(mp->mp_params.mp_name, sizeof(mp->mp_params.mp_name));
+	if (len < 1 || len >= MPOOL_NAMESZ_MAX)
+		return (len < 1) ? -EINVAL : -ENAMETOOLONG;
+
+	mpool_params_merge_defaults(&mp->mp_params);
+
+	/*
+	 * Create an mpc_mpool object through which we can (re)open and manage
+	 * the mpool.  If successful, mpc_mpool_open() adopts dpathv.
+	 */
+	rc = mpc_mpool_open(mp->mp_dpathc, *dpathv, &mpool, pd_prop, &mp->mp_params, mp->mp_flags);
+	if (rc) {
+		mp_pr_err("%s: mpc_mpool_open failed", rc, mp->mp_params.mp_name);
+		return rc;
+	}
+
+	*dpathv = NULL; /* Was adopted by successful mpc_mpool_open() */
+
+	rc = mpool_config_fetch(mpool->mp_desc, &cfg);
+	if (rc) {
+		mp_pr_err("%s config fetch failed", rc, mp->mp_params.mp_name);
+		goto errout;
+	}
+
+	if (mpool_params_merge_config(&mp->mp_params, &cfg))
+		mpool_config_store(mpool->mp_desc, &cfg);
+
+	/* A unit is born with two references:  A birth reference, and one for the caller. */
+	rc = mpc_unit_setup(&mpc_uinfo_mpool, mp->mp_params.mp_name,
+			    &cfg, mpool, &unit);
+	if (rc) {
+		mp_pr_err("%s unit setup failed", rc, mp->mp_params.mp_name);
+		goto errout;
+	}
+
+	/* Return resolved params to caller. */
+	mp->mp_params.mp_uid = cfg.mc_uid;
+	mp->mp_params.mp_gid = cfg.mc_gid;
+	mp->mp_params.mp_mode = cfg.mc_mode;
+	mp->mp_params.mp_mdc_captgt = cfg.mc_captgt;
+	mp->mp_params.mp_oidv[0] = cfg.mc_oid1;
+	mp->mp_params.mp_oidv[1] = cfg.mc_oid2;
+	mp->mp_params.mp_ra_pages_max = cfg.mc_ra_pages_max;
+	mp->mp_params.mp_vma_size_max = cfg.mc_vma_size_max;
+	memcpy(&mp->mp_params.mp_utype, &cfg.mc_utype, sizeof(mp->mp_params.mp_utype));
+	strlcpy(mp->mp_params.mp_label, cfg.mc_label, sizeof(mp->mp_params.mp_label));
+
+	rc = mpc_params_register(unit, MPC_MPOOL_PARAMS_CNT);
+	if (rc) {
+		mpc_unit_put(unit); /* drop birth ref */
+		goto errout;
+	}
+
+	mutex_lock(&ss->ss_lock);
+	idr_replace(&ss->ss_unitmap, unit, MINOR(unit->un_devno));
+	mutex_unlock(&ss->ss_lock);
+
+	mpool = NULL;
+
+errout:
+	/*
+	 * For failures after mpc_unit_setup() (i.e., mpool != NULL)
+	 * dropping the final unit ref will release the mpool ref.
+	 */
+	if (unit)
+		mpc_unit_put(unit); /* drop caller's ref */
+	else if (mpool)
+		mpc_mpool_put(mpool);
+
+	return rc;
+}
+
+/**
+ * mpioc_mp_deactivate_impl() - deactivate an mpool.
+ * @unit:   control device unit ptr
+ * @mp:     mpool parameter block
+ *
+ * MPIOC_MP_DEACTIVATE ioctl handler to deactivate an mpool.
+ */
+static int mp_deactivate_impl(struct mpc_unit *ctl, struct mpioc_mpool *mp, bool locked)
+{
+	struct mpc_softstate *ss = &mpc_softstate;
+	struct mpc_unit *unit = NULL;
+	size_t len;
+	int rc;
+
+	if (!ctl || !mp)
+		return -EINVAL;
+
+	if (!mpc_unit_isctldev(ctl))
+		return -ENOTTY;
+
+	len = mpc_toascii(mp->mp_params.mp_name, sizeof(mp->mp_params.mp_name));
+	if (len < 1 || len >= MPOOL_NAMESZ_MAX)
+		return (len < 1) ? -EINVAL : -ENAMETOOLONG;
+
+	if (!locked) {
+		rc = down_interruptible(&ss->ss_op_sema);
+		if (rc)
+			return rc;
+	}
+
+	mpc_unit_lookup_by_name(ctl, mp->mp_params.mp_name, &unit);
+	if (!unit) {
+		rc = -ENXIO;
+		goto errout;
+	}
+
+	/*
+	 * In order to be determined idle, a unit shall not be open
+	 * and shall have a ref count of exactly two (the birth ref
+	 * and the lookup ref from above).
+	 */
+	mutex_lock(&ss->ss_lock);
+	if (unit->un_open_cnt > 0 || kref_read(&unit->un_ref) != 2) {
+		rc = -EBUSY;
+		mp_pr_err("%s: busy, cannot deactivate", rc, unit->un_name);
+	} else {
+		idr_replace(&ss->ss_unitmap, NULL, MINOR(unit->un_devno));
+		rc = 0;
+	}
+	mutex_unlock(&ss->ss_lock);
+
+	if (!rc)
+		mpc_unit_put(unit); /* drop birth ref */
+
+	mpc_unit_put(unit); /* drop lookup ref */
+
+errout:
+	if (!locked)
+		up(&ss->ss_op_sema);
+
+	return rc;
+}
+
+static int mpioc_mp_deactivate(struct mpc_unit *ctl, struct mpioc_mpool *mp)
+{
+	return mp_deactivate_impl(ctl, mp, false);
+}
+
+static int mpioc_mp_cmd(struct mpc_unit *ctl, uint cmd, struct mpioc_mpool *mp)
+{
+	struct mpc_softstate *ss = &mpc_softstate;
+	struct mpc_unit *unit = NULL;
+	struct pd_prop *pd_prop = NULL;
+	char **dpathv = NULL, *dpaths;
+	size_t dpathvsz, pd_prop_sz;
+	const char *action;
+	size_t len;
+	int rc, i;
+
+	if (!ctl || !mp)
+		return -EINVAL;
+
+	if (!mpc_unit_isctldev(ctl))
+		return -EOPNOTSUPP;
+
+	if (mp->mp_dpathc < 1 || mp->mp_dpathc > MPOOL_DRIVES_MAX)
+		return -EDOM;
+
+	len = mpc_toascii(mp->mp_params.mp_name, sizeof(mp->mp_params.mp_name));
+	if (len < 1 || len >= MPOOL_NAMESZ_MAX)
+		return (len < 1) ? -EINVAL : -ENAMETOOLONG;
+
+	switch (cmd) {
+	case MPIOC_MP_CREATE:
+		action = "create";
+		break;
+
+	case MPIOC_MP_DESTROY:
+		action = "destroy";
+		break;
+
+	case MPIOC_MP_ACTIVATE:
+		action = "activate";
+		break;
+
+	case MPIOC_MP_RENAME:
+		action = "rename";
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (!mp->mp_pd_prop || !mp->mp_dpaths) {
+		rc = -EINVAL;
+		mp_pr_err("%s: %s, (%d drives), drives names %p or PD props %p invalid",
+			  rc, mp->mp_params.mp_name, action, mp->mp_dpathc,
+			  mp->mp_dpaths, mp->mp_pd_prop);
+
+		return rc;
+	}
+
+	if (mp->mp_dpathssz > (mp->mp_dpathc + 1) * PATH_MAX)
+		return -EINVAL;
+
+	rc = down_interruptible(&ss->ss_op_sema);
+	if (rc)
+		return rc;
+
+	/*
+	 * If mpc_unit_lookup_by_name() succeeds it will have acquired
+	 * a reference on unit.  We release that reference at the
+	 * end of this function.
+	 */
+	mpc_unit_lookup_by_name(ctl, mp->mp_params.mp_name, &unit);
+
+	if (unit && cmd != MPIOC_MP_DESTROY) {
+		if (cmd == MPIOC_MP_ACTIVATE)
+			goto errout;
+		rc = -EEXIST;
+		mp_pr_err("%s: mpool already activated", rc, mp->mp_params.mp_name);
+		goto errout;
+	}
+
+	/*
+	 * The device path names are in one long string separated by
+	 * newlines.  Here we allocate one chunk of memory to hold
+	 * all the device paths and a vector of ptrs to them.
+	 */
+	dpathvsz = mp->mp_dpathc * sizeof(*dpathv) + mp->mp_dpathssz;
+	if (dpathvsz > MPOOL_DRIVES_MAX * (PATH_MAX + sizeof(*dpathv))) {
+		rc = -E2BIG;
+		mp_pr_err("%s: %s, too many member drives %zu",
+			  rc, mp->mp_params.mp_name, action, dpathvsz);
+		goto errout;
+	}
+
+	dpathv = kmalloc(dpathvsz, GFP_KERNEL);
+	if (!dpathv) {
+		rc = -ENOMEM;
+		goto errout;
+	}
+
+	dpaths = (char *)dpathv + mp->mp_dpathc * sizeof(*dpathv);
+
+	rc = copy_from_user(dpaths, mp->mp_dpaths, mp->mp_dpathssz);
+	if (rc) {
+		rc = -EFAULT;
+		goto errout;
+	}
+
+	for (i = 0; i < mp->mp_dpathc; ++i) {
+		dpathv[i] = strsep(&dpaths, "\n");
+		if (!dpathv[i]) {
+			rc = -EINVAL;
+			goto errout;
+		}
+	}
+
+	/* Get the PDs properties from user space buffer. */
+	pd_prop_sz = mp->mp_dpathc * sizeof(*pd_prop);
+	pd_prop = kmalloc(pd_prop_sz, GFP_KERNEL);
+	if (!pd_prop) {
+		rc = -ENOMEM;
+		mp_pr_err("%s: %s, alloc pd prop %zu failed",
+			  rc, mp->mp_params.mp_name, action, pd_prop_sz);
+		goto errout;
+	}
+
+	rc = copy_from_user(pd_prop, mp->mp_pd_prop, pd_prop_sz);
+	if (rc) {
+		rc = -EFAULT;
+		mp_pr_err("%s: %s, copyin pd prop %zu failed",
+			  rc, mp->mp_params.mp_name, action, pd_prop_sz);
+		goto errout;
+	}
+
+	switch (cmd) {
+	case MPIOC_MP_CREATE:
+		rc = mpioc_mp_create(ctl, mp, pd_prop, &dpathv);
+		break;
+
+	case MPIOC_MP_ACTIVATE:
+		rc = mpioc_mp_activate(ctl, mp, pd_prop, &dpathv);
+		break;
+
+	case MPIOC_MP_DESTROY:
+		if (unit) {
+			mpc_unit_put(unit);
+			unit = NULL;
+
+			rc = mp_deactivate_impl(ctl, mp, true);
+			if (rc) {
+				action = "deactivate";
+				break;
+			}
+		}
+		rc = mpool_destroy(mp->mp_dpathc, dpathv, pd_prop, mp->mp_flags);
+		break;
+
+	case MPIOC_MP_RENAME:
+		rc = mpool_rename(mp->mp_dpathc, dpathv, pd_prop, mp->mp_flags,
+				   mp->mp_params.mp_name);
+		break;
+	}
+
+	if (rc)
+		mp_pr_err("%s: %s failed", rc, mp->mp_params.mp_name, action);
+
+errout:
+	mpc_unit_put(unit);
+	up(&ss->ss_op_sema);
+
+	kfree(pd_prop);
+	kfree(dpathv);
+
+	return rc;
+}
+
+/**
+ * mpioc_mp_add() - add a device to an existing mpool
+ * @unit:   mpool unit ptr
+ * @drv:    mpool device parameter block
+ *
+ * MPIOC_MP_ADD ioctl handler to add a drive to a activated mpool
+ *
+ * Return:  Returns 0 if successful, -errno otherwise...
+ */
+static int mpioc_mp_add(struct mpc_unit *unit, struct mpioc_drive *drv)
+{
+	struct mpool_descriptor *desc = unit->un_mpool->mp_desc;
+	size_t pd_prop_sz, dpathvsz;
+	struct pd_prop *pd_prop;
+	char **dpathv, *dpaths;
+	int rc, i;
+
+	/*
+	 * The device path names are in one long string separated by
+	 * newlines.  Here we allocate one chunk of memory to hold
+	 * all the device paths and a vector of ptrs to them.
+	 */
+	dpathvsz = drv->drv_dpathc * sizeof(*dpathv) + drv->drv_dpathssz;
+	if (drv->drv_dpathc > MPOOL_DRIVES_MAX ||
+	    dpathvsz > MPOOL_DRIVES_MAX * (PATH_MAX + sizeof(*dpathv))) {
+		rc = -E2BIG;
+		mp_pr_err("%s: invalid pathc %u, pathsz %zu",
+			  rc, unit->un_name, drv->drv_dpathc, dpathvsz);
+		return rc;
+	}
+
+	dpathv = kmalloc(dpathvsz, GFP_KERNEL);
+	if (!dpathv) {
+		rc = -ENOMEM;
+		mp_pr_err("%s: alloc dpathv %zu failed", rc, unit->un_name, dpathvsz);
+		return rc;
+	}
+
+	dpaths = (char *)dpathv + drv->drv_dpathc * sizeof(*dpathv);
+	rc = copy_from_user(dpaths, drv->drv_dpaths, drv->drv_dpathssz);
+	if (rc) {
+		rc = -EFAULT;
+		mp_pr_err("%s: copyin dpaths %u failed", rc, unit->un_name, drv->drv_dpathssz);
+		kfree(dpathv);
+		return rc;
+	}
+
+	for (i = 0; i < drv->drv_dpathc; ++i) {
+		dpathv[i] = strsep(&dpaths, "\n");
+		if (!dpathv[i] || (strlen(dpathv[i]) > PATH_MAX - 1)) {
+			rc = -EINVAL;
+			mp_pr_err("%s: ill-formed dpathv list ", rc, unit->un_name);
+			kfree(dpathv);
+			return rc;
+		}
+	}
+
+	/* Get the PDs properties from user space buffer. */
+	pd_prop_sz = drv->drv_dpathc * sizeof(*pd_prop);
+
+	pd_prop = kmalloc(pd_prop_sz, GFP_KERNEL);
+	if (!pd_prop) {
+		rc = -ENOMEM;
+		mp_pr_err("%s: alloc pd prop %zu failed", rc, unit->un_name, pd_prop_sz);
+		kfree(dpathv);
+		return rc;
+	}
+
+	rc = copy_from_user(pd_prop, drv->drv_pd_prop, pd_prop_sz);
+	if (rc) {
+		rc = -EFAULT;
+		mp_pr_err("%s: copyin pd prop %zu failed", rc, unit->un_name, pd_prop_sz);
+		kfree(pd_prop);
+		kfree(dpathv);
+		return rc;
+	}
+
+	for (i = 0; i < drv->drv_dpathc; ++i) {
+		rc = mpool_drive_add(desc, dpathv[i], &pd_prop[i]);
+		if (rc)
+			break;
+	}
+
+	kfree(pd_prop);
+	kfree(dpathv);
+
+	return rc;
+}
+
+static struct mpc_softstate *mpc_cdev2ss(struct cdev *cdev)
+{
+	if (!cdev || cdev->owner != THIS_MODULE) {
+		mp_pr_crit("module dissociated", -EINVAL);
+		return NULL;
+	}
+
+	return container_of(cdev, struct mpc_softstate, ss_cdev);
+}
+
+static int mpc_bdi_alloc(void)
+{
+	mpc_bdi = bdi_alloc(NUMA_NO_NODE);
+	if (!mpc_bdi)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void mpc_bdi_save(struct mpc_unit *unit, struct inode *ip)
+{
+	unit->un_saved_bdi = ip->i_sb->s_bdi;
+	ip->i_sb->s_bdi = bdi_get(mpc_bdi);
+}
+
+static void mpc_bdi_restore(struct mpc_unit *unit, struct inode *ip)
+{
+	ip->i_sb->s_bdi = unit->un_saved_bdi;
+	bdi_put(mpc_bdi);
+}
+
+static int mpc_bdi_setup(void)
+{
+	int rc;
+
+	rc = mpc_bdi_alloc();
+	if (rc)
+		return rc;
+
+	mpc_bdi->capabilities = BDI_CAP_NO_ACCT_AND_WRITEBACK;
+	mpc_bdi->ra_pages = MPOOL_RA_PAGES_MAX;
+
+	return 0;
+}
+
+static void mpc_bdi_teardown(void)
+{
+	bdi_put(mpc_bdi);
+}
+
+/*
+ * MPCTL file operations.
+ */
+
+/**
+ * mpc_open() - Open an mpool device.
+ * @ip: inode ptr
+ * @fp: file ptr
+ *
+ * Return:  Returns 0 on success, -errno otherwise...
+ */
+static int mpc_open(struct inode *ip, struct file *fp)
+{
+	struct mpc_softstate *ss;
+	struct mpc_unit *unit;
+	bool firstopen;
+	int rc = 0;
+
+	ss = mpc_cdev2ss(ip->i_cdev);
+	if (!ss || ss != &mpc_softstate)
+		return -EBADFD;
+
+	/* Acquire a reference on the unit object.  We'll release it in mpc_release(). */
+	mpc_unit_lookup(iminor(fp->f_inode), &unit);
+	if (!unit)
+		return -ENODEV;
+
+	if (down_trylock(&unit->un_open_lock)) {
+		rc = (fp->f_flags & O_NONBLOCK) ? -EWOULDBLOCK :
+			down_interruptible(&unit->un_open_lock);
+
+		if (rc)
+			goto errout;
+	}
+
+	firstopen = (unit->un_open_cnt == 0);
+
+	if (!firstopen) {
+		if (fp->f_mapping != unit->un_mapping)
+			rc = -EBUSY;
+		else if (unit->un_open_excl || (fp->f_flags & O_EXCL))
+			rc = -EBUSY;
+		goto unlock;
+	}
+
+	if (!mpc_unit_ismpooldev(unit)) {
+		unit->un_open_excl = !!(fp->f_flags & O_EXCL);
+		goto unlock; /* control device */
+	}
+
+	/* First open of an mpool unit (not the control device). */
+	if (!fp->f_mapping || fp->f_mapping != ip->i_mapping) {
+		rc = -EINVAL;
+		goto unlock;
+	}
+
+	fp->f_op = &mpc_fops_default;
+
+	mpc_bdi_save(unit, ip);
+
+	unit->un_mapping = fp->f_mapping;
+
+	inode_lock(ip);
+	i_size_write(ip, 1ul << 63);
+	inode_unlock(ip);
+
+	unit->un_open_excl = !!(fp->f_flags & O_EXCL);
+
+unlock:
+	if (!rc) {
+		fp->private_data = unit;
+		nonseekable_open(ip, fp);
+		++unit->un_open_cnt;
+	}
+	up(&unit->un_open_lock);
+
+errout:
+	if (rc) {
+		if (rc != -EBUSY)
+			mp_pr_err("open %s failed", rc, unit->un_name);
+		mpc_unit_put(unit);
+	}
+
+	return rc;
+}
+
+/**
+ * mpc_release() - Close the specified mpool device.
+ * @ip: inode ptr
+ * @fp: file ptr
+ *
+ * Return:  Returns 0 on success, -errno otherwise...
+ */
+static int mpc_release(struct inode *ip, struct file *fp)
+{
+	struct mpc_unit *unit;
+	bool lastclose;
+
+	unit = fp->private_data;
+	if (!unit)
+		return -EBADFD;
+
+	down(&unit->un_open_lock);
+	lastclose = (--unit->un_open_cnt == 0);
+	if (!lastclose)
+		goto errout;
+
+	if (mpc_unit_ismpooldev(unit)) {
+		unit->un_mapping = NULL;
+
+		mpc_bdi_restore(unit, ip);
+	}
+
+	unit->un_open_excl = false;
+
+errout:
+	up(&unit->un_open_lock);
+
+	mpc_unit_put(unit);
+
+	return 0;
+}
+
+/**
+ * mpc_ioctl() - mpc driver ioctl entry point
+ * @fp:     file pointer
+ * @cmd:    an mpool ioctl command (i.e.,  MPIOC_*)
+ * @arg:    varies..
+ *
+ * Perform the specified mpool ioctl command.
+ *
+ * Return:  Returns 0 on success, -errno otherwise...
+ */
+static long mpc_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
+{
+	char argbuf[256] __aligned(16);
+	struct mpc_unit *unit;
+	size_t argbufsz;
+	void *argp;
+	ulong iosz;
+	int rc;
+
+	if (_IOC_TYPE(cmd) != MPIOC_MAGIC)
+		return -ENOTTY;
+
+	if ((fp->f_flags & O_ACCMODE) == O_RDONLY) {
+		switch (cmd) {
+		case MPIOC_PROP_GET:
+		case MPIOC_DEVPROPS_GET:
+		case MPIOC_MP_MCLASS_GET:
+			break;
+
+		default:
+			return -EINVAL;
+		}
+	}
+
+	unit = fp->private_data;
+	argbufsz = sizeof(argbuf);
+	iosz = _IOC_SIZE(cmd);
+	argp = (void *)arg;
+
+	if (!unit || (iosz > sizeof(union mpioc_union)))
+		return -EINVAL;
+
+	/* Set up argp/argbuf for read/write requests. */
+	if (_IOC_DIR(cmd) & (_IOC_READ | _IOC_WRITE)) {
+		argp = argbuf;
+		if (iosz > argbufsz) {
+			argbufsz = roundup_pow_of_two(iosz);
+
+			argp = kzalloc(argbufsz, GFP_KERNEL);
+			if (!argp)
+				return -ENOMEM;
+		}
+
+		if (_IOC_DIR(cmd) & _IOC_WRITE) {
+			if (copy_from_user(argp, (const void __user *)arg, iosz)) {
+				if (argp != argbuf)
+					kfree(argp);
+				return -EFAULT;
+			}
+		}
+	}
+
+	switch (cmd) {
+	case MPIOC_MP_CREATE:
+	case MPIOC_MP_ACTIVATE:
+	case MPIOC_MP_DESTROY:
+	case MPIOC_MP_RENAME:
+		rc = mpioc_mp_cmd(unit, cmd, argp);
+		break;
+
+	case MPIOC_MP_DEACTIVATE:
+		rc = mpioc_mp_deactivate(unit, argp);
+		break;
+
+	case MPIOC_DRV_ADD:
+		rc = mpioc_mp_add(unit, argp);
+		break;
+
+	case MPIOC_PARAMS_SET:
+		rc = mpioc_params_set(unit, argp);
+		break;
+
+	case MPIOC_PARAMS_GET:
+		rc = mpioc_params_get(unit, argp);
+		break;
+
+	case MPIOC_MP_MCLASS_GET:
+		rc = mpioc_mp_mclass_get(unit, argp);
+		break;
+
+	case MPIOC_PROP_GET:
+		rc = mpioc_proplist_get(unit, argp);
+		break;
+
+	case MPIOC_DEVPROPS_GET:
+		rc = mpioc_devprops_get(unit, argp);
+		break;
+
+	default:
+		rc = -ENOTTY;
+		mp_pr_rl("invalid command %x: dir=%u type=%c nr=%u size=%u",
+			 rc, cmd, _IOC_DIR(cmd), _IOC_TYPE(cmd), _IOC_NR(cmd), _IOC_SIZE(cmd));
+		break;
+	}
+
+	if (!rc && _IOC_DIR(cmd) & _IOC_READ) {
+		if (copy_to_user((void __user *)arg, argp, iosz))
+			rc = -EFAULT;
+	}
+
+	if (argp != argbuf)
+		kfree(argp);
+
+	return rc;
+}
+
+static const struct file_operations mpc_fops_default = {
+	.owner		= THIS_MODULE,
+	.open		= mpc_open,
+	.release	= mpc_release,
+	.unlocked_ioctl	= mpc_ioctl,
+};
+
+static int mpc_exit_unit(int minor, void *item, void *arg)
+{
+	mpc_unit_put(item);
+
+	return ITERCB_NEXT;
+}
+
+/**
+ * mpctl_exit() - Tear down and unload the mpool control module.
+ */
+void mpctl_exit(void)
+{
+	struct mpc_softstate *ss = &mpc_softstate;
+
+	if (ss->ss_inited) {
+		idr_for_each(&ss->ss_unitmap, mpc_exit_unit, NULL);
+		idr_destroy(&ss->ss_unitmap);
+
+		if (ss->ss_devno != NODEV) {
+			if (ss->ss_class) {
+				if (ss->ss_cdev.ops)
+					cdev_del(&ss->ss_cdev);
+				class_destroy(ss->ss_class);
+			}
+			unregister_chrdev_region(ss->ss_devno, maxunits);
+		}
+
+		ss->ss_inited = false;
+	}
+
+	mpc_bdi_teardown();
+}
+
+/**
+ * mpctl_init() - Load and initialize the mpool control module.
+ */
+int mpctl_init(void)
+{
+	struct mpc_softstate *ss = &mpc_softstate;
+	struct mpool_config *cfg = NULL;
+	struct mpc_unit *ctlunit;
+	const char *errmsg = NULL;
+	int rc;
+
+	if (ss->ss_inited)
+		return -EBUSY;
+
+	ctlunit = NULL;
+
+	maxunits = clamp_t(uint, maxunits, 8, 8192);
+
+	cdev_init(&ss->ss_cdev, &mpc_fops_default);
+	ss->ss_cdev.owner = THIS_MODULE;
+
+	mutex_init(&ss->ss_lock);
+	idr_init(&ss->ss_unitmap);
+	ss->ss_class = NULL;
+	ss->ss_devno = NODEV;
+	sema_init(&ss->ss_op_sema, 1);
+	ss->ss_inited = true;
+
+	rc = alloc_chrdev_region(&ss->ss_devno, 0, maxunits, "mpool");
+	if (rc) {
+		errmsg = "cannot allocate control device major";
+		ss->ss_devno = NODEV;
+		goto errout;
+	}
+
+	ss->ss_class = class_create(THIS_MODULE, module_name(THIS_MODULE));
+	if (IS_ERR(ss->ss_class)) {
+		errmsg = "class_create() failed";
+		rc = PTR_ERR(ss->ss_class);
+		ss->ss_class = NULL;
+		goto errout;
+	}
+
+	ss->ss_class->dev_uevent = mpc_uevent;
+
+	rc = cdev_add(&ss->ss_cdev, ss->ss_devno, maxunits);
+	if (rc) {
+		errmsg = "cdev_add() failed";
+		ss->ss_cdev.ops = NULL;
+		goto errout;
+	}
+
+	rc = mpc_bdi_setup();
+	if (rc) {
+		errmsg = "mpc bdi setup failed";
 		goto errout;
 	}
 
-- 
2.17.2

