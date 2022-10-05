Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8B25F5F0D
	for <lists+linux-block@lfdr.de>; Thu,  6 Oct 2022 04:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiJFCwL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 5 Oct 2022 22:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiJFCvx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Oct 2022 22:51:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4F588A2C;
        Wed,  5 Oct 2022 19:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98CB261826;
        Thu,  6 Oct 2022 02:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7910CC433D7;
        Thu,  6 Oct 2022 02:51:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="H33AAW3b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665024667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pCtfPLuB59xtyVGGwiYzh/7nHC3MVq66YuwTagwZhhk=;
        b=H33AAW3bmZsvxlYjQqpPfS6bvl9N0yvO+e7q7RNlbeh4sjpBBiG1cpUWg2HijndZBXnzDt
        5/l+XaIVma1EoKE8uP0dilJbTmWAYSPsRHYgLVSs8H/rMMFz4jTgpMZVzLjcrfBPZ9Y+Ax
        CDyBrh0ihvHAVqgNRdnV9rga8eeiw9k=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fbb9ee0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 6 Oct 2022 02:51:06 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        brcm80211-dev-list.pdl@broadcom.com, cake@lists.bufferbloat.net,
        ceph-devel@vger.kernel.org, coreteam@netfilter.org,
        dccp@vger.kernel.org, dev@openvswitch.org,
        dmaengine@vger.kernel.org, drbd-dev@lists.linbit.com,
        dri-devel@lists.freedesktop.org, kasan-dev@googlegroups.com,
        linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fbdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hams@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mm@kvack.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-raid@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-sctp@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-xfs@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lvs-devel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, rds-devel@oss.oracle.com,
        SHA-cyfmac-dev-list@infineon.com, target-devel@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net
Subject: [PATCH v1 3/5] treewide: use get_random_u32() when possible
Date:   Wed,  5 Oct 2022 23:48:42 +0200
Message-Id: <20221005214844.2699-4-Jason@zx2c4.com>
In-Reply-To: <20221005214844.2699-1-Jason@zx2c4.com>
References: <20221005214844.2699-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The prandom_u32() function has been a deprecated inline wrapper around
get_random_u32() for several releases now, and compiles down to the
exact same code. Replace the deprecated wrapper with a direct call to
the real function.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 Documentation/networking/filter.rst            |  2 +-
 drivers/infiniband/hw/cxgb4/cm.c               |  4 ++--
 drivers/infiniband/hw/hfi1/tid_rdma.c          |  2 +-
 drivers/infiniband/hw/mlx4/mad.c               |  2 +-
 drivers/infiniband/ulp/ipoib/ipoib_cm.c        |  2 +-
 drivers/md/raid5-cache.c                       |  2 +-
 drivers/mtd/nand/raw/nandsim.c                 |  2 +-
 drivers/net/bonding/bond_main.c                |  2 +-
 drivers/net/ethernet/broadcom/cnic.c           |  2 +-
 .../chelsio/inline_crypto/chtls/chtls_cm.c     |  2 +-
 drivers/net/ethernet/rocker/rocker_main.c      |  6 +++---
 .../net/wireless/marvell/mwifiex/cfg80211.c    |  4 ++--
 .../net/wireless/microchip/wilc1000/cfg80211.c |  2 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c  |  2 +-
 drivers/nvme/common/auth.c                     |  2 +-
 drivers/scsi/cxgbi/cxgb4i/cxgb4i.c             |  4 ++--
 drivers/target/iscsi/cxgbit/cxgbit_cm.c        |  2 +-
 drivers/thunderbolt/xdomain.c                  |  2 +-
 drivers/video/fbdev/uvesafb.c                  |  2 +-
 fs/exfat/inode.c                               |  2 +-
 fs/ext2/ialloc.c                               |  2 +-
 fs/ext4/ialloc.c                               |  4 ++--
 fs/ext4/ioctl.c                                |  4 ++--
 fs/ext4/mmp.c                                  |  2 +-
 fs/f2fs/namei.c                                |  2 +-
 fs/fat/inode.c                                 |  2 +-
 fs/nfsd/nfs4state.c                            |  4 ++--
 fs/ubifs/journal.c                             |  2 +-
 fs/xfs/libxfs/xfs_ialloc.c                     |  2 +-
 fs/xfs/xfs_icache.c                            |  2 +-
 fs/xfs/xfs_log.c                               |  2 +-
 include/net/netfilter/nf_queue.h               |  2 +-
 include/net/red.h                              |  2 +-
 include/net/sock.h                             |  2 +-
 kernel/kcsan/selftest.c                        |  2 +-
 lib/random32.c                                 |  2 +-
 lib/reed_solomon/test_rslib.c                  |  6 +++---
 lib/test_fprobe.c                              |  2 +-
 lib/test_kprobes.c                             |  2 +-
 lib/test_rhashtable.c                          |  6 +++---
 mm/shmem.c                                     |  2 +-
 net/802/garp.c                                 |  2 +-
 net/802/mrp.c                                  |  2 +-
 net/core/pktgen.c                              |  4 ++--
 net/ipv4/tcp_cdg.c                             |  2 +-
 net/ipv4/udp.c                                 |  2 +-
 net/ipv6/ip6_flowlabel.c                       |  2 +-
 net/ipv6/output_core.c                         |  2 +-
 net/netfilter/ipvs/ip_vs_conn.c                |  2 +-
 net/netfilter/xt_statistic.c                   |  2 +-
 net/openvswitch/actions.c                      |  2 +-
 net/rds/bind.c                                 |  2 +-
 net/sched/sch_cake.c                           |  2 +-
 net/sched/sch_netem.c                          | 18 +++++++++---------
 net/sunrpc/auth_gss/gss_krb5_wrap.c            |  4 ++--
 net/sunrpc/xprt.c                              |  2 +-
 net/unix/af_unix.c                             |  2 +-
 57 files changed, 79 insertions(+), 79 deletions(-)

diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index 43cdc4d34745..f69da5074860 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -305,7 +305,7 @@ Possible BPF extensions are shown in the following table:
   vlan_tci                              skb_vlan_tag_get(skb)
   vlan_avail                            skb_vlan_tag_present(skb)
   vlan_tpid                             skb->vlan_proto
-  rand                                  prandom_u32()
+  rand                                  get_random_u32()
   ===================================   =================================================
 
 These extensions can also be prefixed with '#'.
diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index 14392c942f49..499a425a3379 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -734,7 +734,7 @@ static int send_connect(struct c4iw_ep *ep)
 				   &ep->com.remote_addr;
 	int ret;
 	enum chip_type adapter_type = ep->com.dev->rdev.lldi.adapter_type;
-	u32 isn = (prandom_u32() & ~7UL) - 1;
+	u32 isn = (get_random_u32() & ~7UL) - 1;
 	struct net_device *netdev;
 	u64 params;
 
@@ -2469,7 +2469,7 @@ static int accept_cr(struct c4iw_ep *ep, struct sk_buff *skb,
 	}
 
 	if (!is_t4(adapter_type)) {
-		u32 isn = (prandom_u32() & ~7UL) - 1;
+		u32 isn = (get_random_u32() & ~7UL) - 1;
 
 		skb = get_skb(skb, roundup(sizeof(*rpl5), 16), GFP_KERNEL);
 		rpl5 = __skb_put_zero(skb, roundup(sizeof(*rpl5), 16));
diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
index 2a7abf7a1f7f..18b05ffb415a 100644
--- a/drivers/infiniband/hw/hfi1/tid_rdma.c
+++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
@@ -850,7 +850,7 @@ void hfi1_kern_init_ctxt_generations(struct hfi1_ctxtdata *rcd)
 	int i;
 
 	for (i = 0; i < RXE_NUM_TID_FLOWS; i++) {
-		rcd->flows[i].generation = mask_generation(prandom_u32());
+		rcd->flows[i].generation = mask_generation(get_random_u32());
 		kern_set_hw_flow(rcd, KERN_GENERATION_RESERVED, i);
 	}
 }
diff --git a/drivers/infiniband/hw/mlx4/mad.c b/drivers/infiniband/hw/mlx4/mad.c
index d13ecbdd4391..a37cfac5e23f 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -96,7 +96,7 @@ static void __propagate_pkey_ev(struct mlx4_ib_dev *dev, int port_num,
 __be64 mlx4_ib_gen_node_guid(void)
 {
 #define NODE_GUID_HI	((u64) (((u64)IB_OPENIB_OUI) << 40))
-	return cpu_to_be64(NODE_GUID_HI | prandom_u32());
+	return cpu_to_be64(NODE_GUID_HI | get_random_u32());
 }
 
 __be64 mlx4_ib_get_new_demux_tid(struct mlx4_ib_demux_ctx *ctx)
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
index fd9d7f2c4d64..a605cf66b83e 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -465,7 +465,7 @@ static int ipoib_cm_req_handler(struct ib_cm_id *cm_id,
 		goto err_qp;
 	}
 
-	psn = prandom_u32() & 0xffffff;
+	psn = get_random_u32() & 0xffffff;
 	ret = ipoib_cm_modify_rx_qp(dev, cm_id, p->qp, psn);
 	if (ret)
 		goto err_modify;
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index f4e1cc1ece43..5b0fc783bf01 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -2993,7 +2993,7 @@ static int r5l_load_log(struct r5l_log *log)
 	}
 create:
 	if (create_super) {
-		log->last_cp_seq = prandom_u32();
+		log->last_cp_seq = get_random_u32();
 		cp = 0;
 		r5l_log_write_empty_meta_block(log, cp, log->last_cp_seq);
 		/*
diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index 50bcf745e816..4bdaf4aa7007 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -1402,7 +1402,7 @@ static int ns_do_read_error(struct nandsim *ns, int num)
 
 static void ns_do_bit_flips(struct nandsim *ns, int num)
 {
-	if (bitflips && prandom_u32() < (1 << 22)) {
+	if (bitflips && get_random_u32() < (1 << 22)) {
 		int flips = 1;
 		if (bitflips > 1)
 			flips = prandom_u32_max(bitflips) + 1;
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 86d42306aa5e..c8543394a3bb 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4806,7 +4806,7 @@ static u32 bond_rr_gen_slave_id(struct bonding *bond)
 
 	switch (packets_per_slave) {
 	case 0:
-		slave_id = prandom_u32();
+		slave_id = get_random_u32();
 		break;
 	case 1:
 		slave_id = this_cpu_inc_return(*bond->rr_tx_counter);
diff --git a/drivers/net/ethernet/broadcom/cnic.c b/drivers/net/ethernet/broadcom/cnic.c
index f597b313acaa..2198e35d9e18 100644
--- a/drivers/net/ethernet/broadcom/cnic.c
+++ b/drivers/net/ethernet/broadcom/cnic.c
@@ -4164,7 +4164,7 @@ static int cnic_cm_init_bnx2_hw(struct cnic_dev *dev)
 {
 	u32 seed;
 
-	seed = prandom_u32();
+	seed = get_random_u32();
 	cnic_ctx_wr(dev, 45, 0, seed);
 	return 0;
 }
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
index ac452a0111a9..b71ce6c5b512 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
@@ -1063,7 +1063,7 @@ static void chtls_pass_accept_rpl(struct sk_buff *skb,
 	opt2 |= WND_SCALE_EN_V(WSCALE_OK(tp));
 	rpl5->opt0 = cpu_to_be64(opt0);
 	rpl5->opt2 = cpu_to_be32(opt2);
-	rpl5->iss = cpu_to_be32((prandom_u32() & ~7UL) - 1);
+	rpl5->iss = cpu_to_be32((get_random_u32() & ~7UL) - 1);
 	set_wr_txq(skb, CPL_PRIORITY_SETUP, csk->port_id);
 	t4_set_arp_err_handler(skb, sk, chtls_accept_rpl_arp_failure);
 	cxgb4_l2t_send(csk->egress_dev, skb, csk->l2t_entry);
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index fc83ec23bd1d..8c3bbafabb07 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -129,7 +129,7 @@ static int rocker_reg_test(const struct rocker *rocker)
 	u64 test_reg;
 	u64 rnd;
 
-	rnd = prandom_u32();
+	rnd = get_random_u32();
 	rnd >>= 1;
 	rocker_write32(rocker, TEST_REG, rnd);
 	test_reg = rocker_read32(rocker, TEST_REG);
@@ -139,9 +139,9 @@ static int rocker_reg_test(const struct rocker *rocker)
 		return -EIO;
 	}
 
-	rnd = prandom_u32();
+	rnd = get_random_u32();
 	rnd <<= 31;
-	rnd |= prandom_u32();
+	rnd |= get_random_u32();
 	rocker_write64(rocker, TEST_REG64, rnd);
 	test_reg = rocker_read64(rocker, TEST_REG64);
 	if (test_reg != rnd * 2) {
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 134114ac1ac0..4fbb5c876b12 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -238,7 +238,7 @@ mwifiex_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	tx_info->pkt_len = pkt_len;
 
 	mwifiex_form_mgmt_frame(skb, buf, len);
-	*cookie = prandom_u32() | 1;
+	*cookie = get_random_u32() | 1;
 
 	if (ieee80211_is_action(mgmt->frame_control))
 		skb = mwifiex_clone_skb_for_tx_status(priv,
@@ -302,7 +302,7 @@ mwifiex_cfg80211_remain_on_channel(struct wiphy *wiphy,
 					 duration);
 
 	if (!ret) {
-		*cookie = prandom_u32() | 1;
+		*cookie = get_random_u32() | 1;
 		priv->roc_cfg.cookie = *cookie;
 		priv->roc_cfg.chan = *chan;
 
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index 3ac373d29d93..84b9d3454e57 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1159,7 +1159,7 @@ static int mgmt_tx(struct wiphy *wiphy,
 	const u8 *vendor_ie;
 	int ret = 0;
 
-	*cookie = prandom_u32();
+	*cookie = get_random_u32();
 	priv->tx_cookie = *cookie;
 	mgmt = (const struct ieee80211_mgmt *)buf;
 
diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
index 1593e810b3ca..9c5416141d3c 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -449,7 +449,7 @@ qtnf_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 {
 	struct qtnf_vif *vif = qtnf_netdev_get_priv(wdev->netdev);
 	const struct ieee80211_mgmt *mgmt_frame = (void *)params->buf;
-	u32 short_cookie = prandom_u32();
+	u32 short_cookie = get_random_u32();
 	u16 flags = 0;
 	u16 freq;
 
diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 04bd28f17dcc..d90e4f0c08b7 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -23,7 +23,7 @@ u32 nvme_auth_get_seqnum(void)
 
 	mutex_lock(&nvme_dhchap_mutex);
 	if (!nvme_dhchap_seqnum)
-		nvme_dhchap_seqnum = prandom_u32();
+		nvme_dhchap_seqnum = get_random_u32();
 	else {
 		nvme_dhchap_seqnum++;
 		if (!nvme_dhchap_seqnum)
diff --git a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
index 53d91bf9c12a..c07d2e3b4bcf 100644
--- a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
+++ b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
@@ -254,7 +254,7 @@ static void send_act_open_req(struct cxgbi_sock *csk, struct sk_buff *skb,
 	} else if (is_t5(lldi->adapter_type)) {
 		struct cpl_t5_act_open_req *req =
 				(struct cpl_t5_act_open_req *)skb->head;
-		u32 isn = (prandom_u32() & ~7UL) - 1;
+		u32 isn = (get_random_u32() & ~7UL) - 1;
 
 		INIT_TP_WR(req, 0);
 		OPCODE_TID(req) = cpu_to_be32(MK_OPCODE_TID(CPL_ACT_OPEN_REQ,
@@ -282,7 +282,7 @@ static void send_act_open_req(struct cxgbi_sock *csk, struct sk_buff *skb,
 	} else {
 		struct cpl_t6_act_open_req *req =
 				(struct cpl_t6_act_open_req *)skb->head;
-		u32 isn = (prandom_u32() & ~7UL) - 1;
+		u32 isn = (get_random_u32() & ~7UL) - 1;
 
 		INIT_TP_WR(req, 0);
 		OPCODE_TID(req) = cpu_to_be32(MK_OPCODE_TID(CPL_ACT_OPEN_REQ,
diff --git a/drivers/target/iscsi/cxgbit/cxgbit_cm.c b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
index 3336d2b78bf7..d9204c590d9a 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_cm.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
@@ -1202,7 +1202,7 @@ cxgbit_pass_accept_rpl(struct cxgbit_sock *csk, struct cpl_pass_accept_req *req)
 	opt2 |= CONG_CNTRL_V(CONG_ALG_NEWRENO);
 
 	opt2 |= T5_ISS_F;
-	rpl5->iss = cpu_to_be32((prandom_u32() & ~7UL) - 1);
+	rpl5->iss = cpu_to_be32((get_random_u32() & ~7UL) - 1);
 
 	opt2 |= T5_OPT_2_VALID_F;
 
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index c31c0d94d8b3..76075e29696c 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -2438,7 +2438,7 @@ int tb_xdomain_init(void)
 	tb_property_add_immediate(xdomain_property_dir, "deviceid", 0x1);
 	tb_property_add_immediate(xdomain_property_dir, "devicerv", 0x80000100);
 
-	xdomain_property_block_gen = prandom_u32();
+	xdomain_property_block_gen = get_random_u32();
 	return 0;
 }
 
diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 4df6772802d7..285b83c20326 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -167,7 +167,7 @@ static int uvesafb_exec(struct uvesafb_ktask *task)
 	memcpy(&m->id, &uvesafb_cn_id, sizeof(m->id));
 	m->seq = seq;
 	m->len = len;
-	m->ack = prandom_u32();
+	m->ack = get_random_u32();
 
 	/* uvesafb_task structure */
 	memcpy(m + 1, &task->t, sizeof(task->t));
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index a795437b86d0..5590a1e83126 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -552,7 +552,7 @@ static int exfat_fill_inode(struct inode *inode, struct exfat_dir_entry *info)
 	inode->i_uid = sbi->options.fs_uid;
 	inode->i_gid = sbi->options.fs_gid;
 	inode_inc_iversion(inode);
-	inode->i_generation = prandom_u32();
+	inode->i_generation = get_random_u32();
 
 	if (info->attr & ATTR_SUBDIR) { /* directory */
 		inode->i_generation &= ~1;
diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
index 998dd2ac8008..e439a872c398 100644
--- a/fs/ext2/ialloc.c
+++ b/fs/ext2/ialloc.c
@@ -277,7 +277,7 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent)
 		int best_ndir = inodes_per_group;
 		int best_group = -1;
 
-		group = prandom_u32();
+		group = get_random_u32();
 		parent_group = (unsigned)group % ngroups;
 		for (i = 0; i < ngroups; i++) {
 			group = (parent_group + i) % ngroups;
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index f73e5eb43eae..954ec9736a8d 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -465,7 +465,7 @@ static int find_group_orlov(struct super_block *sb, struct inode *parent,
 			ext4fs_dirhash(parent, qstr->name, qstr->len, &hinfo);
 			grp = hinfo.hash;
 		} else
-			grp = prandom_u32();
+			grp = get_random_u32();
 		parent_group = (unsigned)grp % ngroups;
 		for (i = 0; i < ngroups; i++) {
 			g = (parent_group + i) % ngroups;
@@ -1280,7 +1280,7 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 					EXT4_GROUP_INFO_IBITMAP_CORRUPT);
 		goto out;
 	}
-	inode->i_generation = prandom_u32();
+	inode->i_generation = get_random_u32();
 
 	/* Precompute checksum seed for inode metadata */
 	if (ext4_has_metadata_csum(sb)) {
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 3cf3ec4b1c21..99df5b8ae149 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -453,8 +453,8 @@ static long swap_inode_boot_loader(struct super_block *sb,
 
 	inode->i_ctime = inode_bl->i_ctime = current_time(inode);
 
-	inode->i_generation = prandom_u32();
-	inode_bl->i_generation = prandom_u32();
+	inode->i_generation = get_random_u32();
+	inode_bl->i_generation = get_random_u32();
 	ext4_reset_inode_seed(inode);
 	ext4_reset_inode_seed(inode_bl);
 
diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 9af68a7ecdcf..588cb09c5291 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -265,7 +265,7 @@ static unsigned int mmp_new_seq(void)
 	u32 new_seq;
 
 	do {
-		new_seq = prandom_u32();
+		new_seq = get_random_u32();
 	} while (new_seq > EXT4_MMP_SEQ_MAX);
 
 	return new_seq;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index bf00d5057abb..939536982c3e 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -50,7 +50,7 @@ static struct inode *f2fs_new_inode(struct user_namespace *mnt_userns,
 	inode->i_blocks = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 	F2FS_I(inode)->i_crtime = inode->i_mtime;
-	inode->i_generation = prandom_u32();
+	inode->i_generation = get_random_u32();
 
 	if (S_ISDIR(inode->i_mode))
 		F2FS_I(inode)->i_current_depth = 1;
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index a38238d75c08..1cbcc4608dc7 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -523,7 +523,7 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 	inode->i_uid = sbi->options.fs_uid;
 	inode->i_gid = sbi->options.fs_gid;
 	inode_inc_iversion(inode);
-	inode->i_generation = prandom_u32();
+	inode->i_generation = get_random_u32();
 
 	if ((de->attr & ATTR_DIR) && !IS_FREE(de->name)) {
 		inode->i_generation &= ~1;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c5d199d7e6b4..e10c16cd7881 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4346,8 +4346,8 @@ void nfsd4_init_leases_net(struct nfsd_net *nn)
 	nn->nfsd4_grace = 90;
 	nn->somebody_reclaimed = false;
 	nn->track_reclaim_completes = false;
-	nn->clverifier_counter = prandom_u32();
-	nn->clientid_base = prandom_u32();
+	nn->clverifier_counter = get_random_u32();
+	nn->clientid_base = get_random_u32();
 	nn->clientid_counter = nn->clientid_base + 1;
 	nn->s2s_cp_cl_id = nn->clientid_counter++;
 
diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 75dab0ae3939..4619652046cf 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -503,7 +503,7 @@ static void mark_inode_clean(struct ubifs_info *c, struct ubifs_inode *ui)
 static void set_dent_cookie(struct ubifs_info *c, struct ubifs_dent_node *dent)
 {
 	if (c->double_hash)
-		dent->cookie = (__force __le32) prandom_u32();
+		dent->cookie = (__force __le32) get_random_u32();
 	else
 		dent->cookie = 0;
 }
diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 7838b31126e2..94db50eb706a 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -805,7 +805,7 @@ xfs_ialloc_ag_alloc(
 	 * number from being easily guessable.
 	 */
 	error = xfs_ialloc_inode_init(args.mp, tp, NULL, newlen, pag->pag_agno,
-			args.agbno, args.len, prandom_u32());
+			args.agbno, args.len, get_random_u32());
 
 	if (error)
 		return error;
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 2bbe7916a998..eae7427062cf 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -596,7 +596,7 @@ xfs_iget_cache_miss(
 	 */
 	if (xfs_has_v3inodes(mp) &&
 	    (flags & XFS_IGET_CREATE) && !xfs_has_ikeep(mp)) {
-		VFS_I(ip)->i_generation = prandom_u32();
+		VFS_I(ip)->i_generation = get_random_u32();
 	} else {
 		struct xfs_buf		*bp;
 
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 386b0307aed8..ad8652cbf245 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -3544,7 +3544,7 @@ xlog_ticket_alloc(
 	tic->t_curr_res		= unit_res;
 	tic->t_cnt		= cnt;
 	tic->t_ocnt		= cnt;
-	tic->t_tid		= prandom_u32();
+	tic->t_tid		= get_random_u32();
 	if (permanent)
 		tic->t_flags |= XLOG_TIC_PERM_RESERV;
 
diff --git a/include/net/netfilter/nf_queue.h b/include/net/netfilter/nf_queue.h
index 980daa6e1e3a..c81021ab07aa 100644
--- a/include/net/netfilter/nf_queue.h
+++ b/include/net/netfilter/nf_queue.h
@@ -43,7 +43,7 @@ void nf_queue_entry_free(struct nf_queue_entry *entry);
 static inline void init_hashrandom(u32 *jhash_initval)
 {
 	while (*jhash_initval == 0)
-		*jhash_initval = prandom_u32();
+		*jhash_initval = get_random_u32();
 }
 
 static inline u32 hash_v4(const struct iphdr *iph, u32 initval)
diff --git a/include/net/red.h b/include/net/red.h
index be11dbd26492..56d0647d7356 100644
--- a/include/net/red.h
+++ b/include/net/red.h
@@ -364,7 +364,7 @@ static inline unsigned long red_calc_qavg(const struct red_parms *p,
 
 static inline u32 red_random(const struct red_parms *p)
 {
-	return reciprocal_divide(prandom_u32(), p->max_P_reciprocal);
+	return reciprocal_divide(get_random_u32(), p->max_P_reciprocal);
 }
 
 static inline int red_mark_probability(const struct red_parms *p,
diff --git a/include/net/sock.h b/include/net/sock.h
index d08cfe190a78..ca2b26686677 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2091,7 +2091,7 @@ static inline kuid_t sock_net_uid(const struct net *net, const struct sock *sk)
 
 static inline u32 net_tx_rndhash(void)
 {
-	u32 v = prandom_u32();
+	u32 v = get_random_u32();
 
 	return v ?: 1;
 }
diff --git a/kernel/kcsan/selftest.c b/kernel/kcsan/selftest.c
index 75712959c84e..58b94deae5c0 100644
--- a/kernel/kcsan/selftest.c
+++ b/kernel/kcsan/selftest.c
@@ -26,7 +26,7 @@
 static bool __init test_requires(void)
 {
 	/* random should be initialized for the below tests */
-	return prandom_u32() + prandom_u32() != 0;
+	return get_random_u32() + get_random_u32() != 0;
 }
 
 /*
diff --git a/lib/random32.c b/lib/random32.c
index d5d9029362cb..d4f19e1a69d4 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -47,7 +47,7 @@
  *	@state: pointer to state structure holding seeded state.
  *
  *	This is used for pseudo-randomness with no outside seeding.
- *	For more random results, use prandom_u32().
+ *	For more random results, use get_random_u32().
  */
 u32 prandom_u32_state(struct rnd_state *state)
 {
diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
index 4d241bdc88aa..848e7eb5da92 100644
--- a/lib/reed_solomon/test_rslib.c
+++ b/lib/reed_solomon/test_rslib.c
@@ -164,7 +164,7 @@ static int get_rcw_we(struct rs_control *rs, struct wspace *ws,
 
 	/* Load c with random data and encode */
 	for (i = 0; i < dlen; i++)
-		c[i] = prandom_u32() & nn;
+		c[i] = get_random_u32() & nn;
 
 	memset(c + dlen, 0, nroots * sizeof(*c));
 	encode_rs16(rs, c, dlen, c + dlen, 0);
@@ -178,7 +178,7 @@ static int get_rcw_we(struct rs_control *rs, struct wspace *ws,
 	for (i = 0; i < errs; i++) {
 		do {
 			/* Error value must be nonzero */
-			errval = prandom_u32() & nn;
+			errval = get_random_u32() & nn;
 		} while (errval == 0);
 
 		do {
@@ -206,7 +206,7 @@ static int get_rcw_we(struct rs_control *rs, struct wspace *ws,
 			/* Erasure with corrupted symbol */
 			do {
 				/* Error value must be nonzero */
-				errval = prandom_u32() & nn;
+				errval = get_random_u32() & nn;
 			} while (errval == 0);
 
 			errlocs[errloc] = 1;
diff --git a/lib/test_fprobe.c b/lib/test_fprobe.c
index ed70637a2ffa..e0381b3ec410 100644
--- a/lib/test_fprobe.c
+++ b/lib/test_fprobe.c
@@ -145,7 +145,7 @@ static unsigned long get_ftrace_location(void *func)
 static int fprobe_test_init(struct kunit *test)
 {
 	do {
-		rand1 = prandom_u32();
+		rand1 = get_random_u32();
 	} while (rand1 <= div_factor);
 
 	target = fprobe_selftest_target;
diff --git a/lib/test_kprobes.c b/lib/test_kprobes.c
index a5edc2ebc947..eeb1d728d974 100644
--- a/lib/test_kprobes.c
+++ b/lib/test_kprobes.c
@@ -341,7 +341,7 @@ static int kprobes_test_init(struct kunit *test)
 	stacktrace_driver = kprobe_stacktrace_driver;
 
 	do {
-		rand1 = prandom_u32();
+		rand1 = get_random_u32();
 	} while (rand1 <= div_factor);
 	return 0;
 }
diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
index 5a1dd4736b56..b358a74ed7ed 100644
--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -291,7 +291,7 @@ static int __init test_rhltable(unsigned int entries)
 	if (WARN_ON(err))
 		goto out_free;
 
-	k = prandom_u32();
+	k = get_random_u32();
 	ret = 0;
 	for (i = 0; i < entries; i++) {
 		rhl_test_objects[i].value.id = k;
@@ -369,12 +369,12 @@ static int __init test_rhltable(unsigned int entries)
 	pr_info("test %d random rhlist add/delete operations\n", entries);
 	for (j = 0; j < entries; j++) {
 		u32 i = prandom_u32_max(entries);
-		u32 prand = prandom_u32();
+		u32 prand = get_random_u32();
 
 		cond_resched();
 
 		if (prand == 0)
-			prand = prandom_u32();
+			prand = get_random_u32();
 
 		if (prand & 1) {
 			prand >>= 1;
diff --git a/mm/shmem.c b/mm/shmem.c
index 42e5888bf84d..6f2cef73808d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2330,7 +2330,7 @@ static struct inode *shmem_get_inode(struct super_block *sb, struct inode *dir,
 		inode_init_owner(&init_user_ns, inode, dir, mode);
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
-		inode->i_generation = prandom_u32();
+		inode->i_generation = get_random_u32();
 		info = SHMEM_I(inode);
 		memset(info, 0, (char *)inode - (char *)info);
 		spin_lock_init(&info->lock);
diff --git a/net/802/garp.c b/net/802/garp.c
index f6012f8e59f0..c1bb67e25430 100644
--- a/net/802/garp.c
+++ b/net/802/garp.c
@@ -407,7 +407,7 @@ static void garp_join_timer_arm(struct garp_applicant *app)
 {
 	unsigned long delay;
 
-	delay = (u64)msecs_to_jiffies(garp_join_time) * prandom_u32() >> 32;
+	delay = (u64)msecs_to_jiffies(garp_join_time) * get_random_u32() >> 32;
 	mod_timer(&app->join_timer, jiffies + delay);
 }
 
diff --git a/net/802/mrp.c b/net/802/mrp.c
index 35e04cc5390c..3e9fe9f5d9bf 100644
--- a/net/802/mrp.c
+++ b/net/802/mrp.c
@@ -592,7 +592,7 @@ static void mrp_join_timer_arm(struct mrp_applicant *app)
 {
 	unsigned long delay;
 
-	delay = (u64)msecs_to_jiffies(mrp_join_time) * prandom_u32() >> 32;
+	delay = (u64)msecs_to_jiffies(mrp_join_time) * get_random_u32() >> 32;
 	mod_timer(&app->join_timer, jiffies + delay);
 }
 
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 5ca4f953034c..c3763056c554 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2464,7 +2464,7 @@ static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 		for (i = 0; i < pkt_dev->nr_labels; i++)
 			if (pkt_dev->labels[i] & MPLS_STACK_BOTTOM)
 				pkt_dev->labels[i] = MPLS_STACK_BOTTOM |
-					     ((__force __be32)prandom_u32() &
+					     ((__force __be32)get_random_u32() &
 						      htonl(0x000fffff));
 	}
 
@@ -2568,7 +2568,7 @@ static void mod_cur_headers(struct pktgen_dev *pkt_dev)
 
 			for (i = 0; i < 4; i++) {
 				pkt_dev->cur_in6_daddr.s6_addr32[i] =
-				    (((__force __be32)prandom_u32() |
+				    (((__force __be32)get_random_u32() |
 				      pkt_dev->min_in6_daddr.s6_addr32[i]) &
 				     pkt_dev->max_in6_daddr.s6_addr32[i]);
 			}
diff --git a/net/ipv4/tcp_cdg.c b/net/ipv4/tcp_cdg.c
index ddc7ba0554bd..efcd145f06db 100644
--- a/net/ipv4/tcp_cdg.c
+++ b/net/ipv4/tcp_cdg.c
@@ -243,7 +243,7 @@ static bool tcp_cdg_backoff(struct sock *sk, u32 grad)
 	struct cdg *ca = inet_csk_ca(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	if (prandom_u32() <= nexp_u32(grad * backoff_factor))
+	if (get_random_u32() <= nexp_u32(grad * backoff_factor))
 		return false;
 
 	if (use_ineff) {
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 560d9eadeaa5..1a5b2464548e 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -246,7 +246,7 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
 		inet_get_local_port_range(net, &low, &high);
 		remaining = (high - low) + 1;
 
-		rand = prandom_u32();
+		rand = get_random_u32();
 		first = reciprocal_scale(rand, remaining) + low;
 		/*
 		 * force rand to be an odd multiple of UDP_HTABLE_SIZE
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index ceb85c67ce39..18481eb76a0a 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -220,7 +220,7 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
 	spin_lock_bh(&ip6_fl_lock);
 	if (label == 0) {
 		for (;;) {
-			fl->label = htonl(prandom_u32())&IPV6_FLOWLABEL_MASK;
+			fl->label = htonl(get_random_u32())&IPV6_FLOWLABEL_MASK;
 			if (fl->label) {
 				lfl = __fl_lookup(net, fl->label);
 				if (!lfl)
diff --git a/net/ipv6/output_core.c b/net/ipv6/output_core.c
index 2880dc7d9a49..2685c3f15e9d 100644
--- a/net/ipv6/output_core.c
+++ b/net/ipv6/output_core.c
@@ -18,7 +18,7 @@ static u32 __ipv6_select_ident(struct net *net,
 	u32 id;
 
 	do {
-		id = prandom_u32();
+		id = get_random_u32();
 	} while (!id);
 
 	return id;
diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index fb67f1ca2495..8c04bb57dd6f 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -1308,7 +1308,7 @@ void ip_vs_random_dropentry(struct netns_ipvs *ipvs)
 	 * Randomly scan 1/32 of the whole table every second
 	 */
 	for (idx = 0; idx < (ip_vs_conn_tab_size>>5); idx++) {
-		unsigned int hash = prandom_u32() & ip_vs_conn_tab_mask;
+		unsigned int hash = get_random_u32() & ip_vs_conn_tab_mask;
 
 		hlist_for_each_entry_rcu(cp, &ip_vs_conn_tab[hash], c_list) {
 			if (cp->ipvs != ipvs)
diff --git a/net/netfilter/xt_statistic.c b/net/netfilter/xt_statistic.c
index 203e24ae472c..b26c1dcfc27b 100644
--- a/net/netfilter/xt_statistic.c
+++ b/net/netfilter/xt_statistic.c
@@ -34,7 +34,7 @@ statistic_mt(const struct sk_buff *skb, struct xt_action_param *par)
 
 	switch (info->mode) {
 	case XT_STATISTIC_MODE_RANDOM:
-		if ((prandom_u32() & 0x7FFFFFFF) < info->u.random.probability)
+		if ((get_random_u32() & 0x7FFFFFFF) < info->u.random.probability)
 			ret = !ret;
 		break;
 	case XT_STATISTIC_MODE_NTH:
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 868db4669a29..ca3ebfdb3023 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -1033,7 +1033,7 @@ static int sample(struct datapath *dp, struct sk_buff *skb,
 	actions = nla_next(sample_arg, &rem);
 
 	if ((arg->probability != U32_MAX) &&
-	    (!arg->probability || prandom_u32() > arg->probability)) {
+	    (!arg->probability || get_random_u32() > arg->probability)) {
 		if (last)
 			consume_skb(skb);
 		return 0;
diff --git a/net/rds/bind.c b/net/rds/bind.c
index 5b5fb4ca8d3e..052776ddcc34 100644
--- a/net/rds/bind.c
+++ b/net/rds/bind.c
@@ -104,7 +104,7 @@ static int rds_add_bound(struct rds_sock *rs, const struct in6_addr *addr,
 			return -EINVAL;
 		last = rover;
 	} else {
-		rover = max_t(u16, prandom_u32(), 2);
+		rover = max_t(u16, get_random_u32(), 2);
 		last = rover - 1;
 	}
 
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 637ef1757931..48e3e05228a1 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -573,7 +573,7 @@ static bool cobalt_should_drop(struct cobalt_vars *vars,
 
 	/* Simple BLUE implementation.  Lack of ECN is deliberate. */
 	if (vars->p_drop)
-		drop |= (prandom_u32() < vars->p_drop);
+		drop |= (get_random_u32() < vars->p_drop);
 
 	/* Overload the drop_next field as an activity timeout */
 	if (!vars->count)
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 3ca320f1a031..88c1fa2e1d15 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -171,7 +171,7 @@ static inline struct netem_skb_cb *netem_skb_cb(struct sk_buff *skb)
 static void init_crandom(struct crndstate *state, unsigned long rho)
 {
 	state->rho = rho;
-	state->last = prandom_u32();
+	state->last = get_random_u32();
 }
 
 /* get_crandom - correlated random number generator
@@ -184,9 +184,9 @@ static u32 get_crandom(struct crndstate *state)
 	unsigned long answer;
 
 	if (!state || state->rho == 0)	/* no correlation */
-		return prandom_u32();
+		return get_random_u32();
 
-	value = prandom_u32();
+	value = get_random_u32();
 	rho = (u64)state->rho + 1;
 	answer = (value * ((1ull<<32) - rho) + state->last * rho) >> 32;
 	state->last = answer;
@@ -200,7 +200,7 @@ static u32 get_crandom(struct crndstate *state)
 static bool loss_4state(struct netem_sched_data *q)
 {
 	struct clgstate *clg = &q->clg;
-	u32 rnd = prandom_u32();
+	u32 rnd = get_random_u32();
 
 	/*
 	 * Makes a comparison between rnd and the transition
@@ -268,15 +268,15 @@ static bool loss_gilb_ell(struct netem_sched_data *q)
 
 	switch (clg->state) {
 	case GOOD_STATE:
-		if (prandom_u32() < clg->a1)
+		if (get_random_u32() < clg->a1)
 			clg->state = BAD_STATE;
-		if (prandom_u32() < clg->a4)
+		if (get_random_u32() < clg->a4)
 			return true;
 		break;
 	case BAD_STATE:
-		if (prandom_u32() < clg->a2)
+		if (get_random_u32() < clg->a2)
 			clg->state = GOOD_STATE;
-		if (prandom_u32() > clg->a3)
+		if (get_random_u32() > clg->a3)
 			return true;
 	}
 
@@ -632,7 +632,7 @@ static void get_slot_next(struct netem_sched_data *q, u64 now)
 
 	if (!q->slot_dist)
 		next_delay = q->slot_config.min_delay +
-				(prandom_u32() *
+				(get_random_u32() *
 				 (q->slot_config.max_delay -
 				  q->slot_config.min_delay) >> 32);
 	else
diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gss_krb5_wrap.c
index 5f96e75f9eec..48337687848c 100644
--- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
+++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
@@ -130,8 +130,8 @@ gss_krb5_make_confounder(char *p, u32 conflen)
 
 	/* initialize to random value */
 	if (i == 0) {
-		i = prandom_u32();
-		i = (i << 32) | prandom_u32();
+		i = get_random_u32();
+		i = (i << 32) | get_random_u32();
 	}
 
 	switch (conflen) {
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index f8fae7815649..9407007f47ae 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1868,7 +1868,7 @@ xprt_alloc_xid(struct rpc_xprt *xprt)
 static void
 xprt_init_xid(struct rpc_xprt *xprt)
 {
-	xprt->xid = prandom_u32();
+	xprt->xid = get_random_u32();
 }
 
 static void
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index bf338b782fc4..35bd8132113f 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1116,7 +1116,7 @@ static int unix_autobind(struct sock *sk)
 	addr->name->sun_family = AF_UNIX;
 	refcount_set(&addr->refcnt, 1);
 
-	ordernum = prandom_u32();
+	ordernum = get_random_u32();
 	lastnum = ordernum & 0xFFFFF;
 retry:
 	ordernum = (ordernum + 1) & 0xFFFFF;
-- 
2.37.3

