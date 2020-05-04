Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215641C3C11
	for <lists+linux-block@lfdr.de>; Mon,  4 May 2020 16:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgEDOCR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 May 2020 10:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbgEDOCR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 May 2020 10:02:17 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B06AC061A10
        for <linux-block@vger.kernel.org>; Mon,  4 May 2020 07:02:16 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so9165788wmh.3
        for <linux-block@vger.kernel.org>; Mon, 04 May 2020 07:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N7fDFqCq0ADGatm/DjyFprRRN9Ur5QK+1mnQDI1yctA=;
        b=Z9P0fPmflG42Yjdcy89uw6BctUnuVaNez4rJIg5EU33jv1CY6gXuZBfdqOJz3WYR/E
         SV1AaS6HjbgYhBCj04YySaZ4tTXfKRNRDVI3S/PYV1EZrBh3Mw4eEOl/B2iAnY+8T/xX
         gNeCy0Y/5yFYi7D8rCXYJjfW+NKctjhvGK4F0pkDN52xlG06GbdoSZovIDfH+smhK5Vx
         xx6ZFLMGKB5U8KLGugF/SK7WP8M1oripIU37qeVZU6wnkgkwWj3MqetXOdkI1FYXpTzC
         2BcksTgO43lB95+xtBg7kkfvv/BoLO61Jve+nG+dMb5KS0VDojXhDX2vTizBQetkw1Qy
         mFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N7fDFqCq0ADGatm/DjyFprRRN9Ur5QK+1mnQDI1yctA=;
        b=GXEUPz4B2GXKjTbBa6+rWWk4PqKdMKq6whIAqqbAL2QmFfpXdgLBLLYSdlPH2yflhM
         tdeVVZIb1Ms36FWhPQOxEp1ubvbunNLik0ltef8Hu7YXnJ5u1EZlZfflnirRTUo35ht8
         N03gQEc+FamjDINVU/3ZL3o9jU9+VBHYceP6Hy/LTZO0BLerPZ1Zq8t3QbNDAzkN+684
         y7jwb3yPdGjg+LbgzVUSVJU5cpT3BA308panzoLs46QleZCP1kFqQcbYO5dJeLI4H/MQ
         TrPG99LJgYH3bdU7YpXBuEnjywqKqQIkatlvwX6aPDjqTPMzK5dXEg/UhV96LA/48jzH
         Wckw==
X-Gm-Message-State: AGi0PuYF2833scYsgM13SSdGBJnThCcSyAkWHa12Ft8RrN0MYfhDuRfN
        P4b4jusmR5Ai0nZDdr1GVxEmpqu4sqVRXiw=
X-Google-Smtp-Source: APiQypI8qJA+5M8p3cJmLPNWq9hgLlbiwiUr6BpX3wgz3qlqgTIQpS+KT615qQ9HXV9+15okfLZXmA==
X-Received: by 2002:a7b:c1c4:: with SMTP id a4mr15102064wmj.86.1588600935017;
        Mon, 04 May 2020 07:02:15 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id a13sm11681559wrv.67.2020.05.04.07.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 07:02:14 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v14 05/25] RDMA/rtrs: client: private header with client structs and functions
Date:   Mon,  4 May 2020 16:00:55 +0200
Message-Id: <20200504140115.15533-6-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504140115.15533-1-danil.kipnis@cloud.ionos.com>
References: <20200504140115.15533-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

This header describes main structs and functions used by rtrs-client
module, mainly for managing rtrs sessions, creating/destroying sysfs
entries, accounting statistics on client side.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.h | 251 +++++++++++++++++++++++++
 1 file changed, 251 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt.h

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
new file mode 100644
index 000000000000..039a2ebba2f9
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -0,0 +1,251 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * RDMA Transport Layer
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
+ */
+
+#ifndef RTRS_CLT_H
+#define RTRS_CLT_H
+
+#include <linux/device.h>
+#include "rtrs-pri.h"
+
+/**
+ * enum rtrs_clt_state - Client states.
+ */
+enum rtrs_clt_state {
+	RTRS_CLT_CONNECTING,
+	RTRS_CLT_CONNECTING_ERR,
+	RTRS_CLT_RECONNECTING,
+	RTRS_CLT_CONNECTED,
+	RTRS_CLT_CLOSING,
+	RTRS_CLT_CLOSED,
+	RTRS_CLT_DEAD,
+};
+
+enum rtrs_mp_policy {
+	MP_POLICY_RR,
+	MP_POLICY_MIN_INFLIGHT,
+};
+
+/* see Documentation/ABI/testing/sysfs-class-rtrs-client for details */
+struct rtrs_clt_stats_reconnects {
+	int successful_cnt;
+	int fail_cnt;
+};
+
+/* see Documentation/ABI/testing/sysfs-class-rtrs-client for details */
+struct rtrs_clt_stats_cpu_migr {
+	atomic_t from;
+	int to;
+};
+
+/* stats for Read and write operation.
+ * see Documentation/ABI/testing/sysfs-class-rtrs-client for details
+ */
+struct rtrs_clt_stats_rdma {
+	struct {
+		u64 cnt;
+		u64 size_total;
+	} dir[2];
+
+	u64 failover_cnt;
+};
+
+struct rtrs_clt_stats_pcpu {
+	struct rtrs_clt_stats_cpu_migr		cpu_migr;
+	struct rtrs_clt_stats_rdma		rdma;
+};
+
+struct rtrs_clt_stats {
+	struct kobject				kobj_stats;
+	struct rtrs_clt_stats_pcpu    __percpu	*pcpu_stats;
+	struct rtrs_clt_stats_reconnects	reconnects;
+	atomic_t				inflight;
+};
+
+struct rtrs_clt_con {
+	struct rtrs_con	c;
+	struct rtrs_iu		*rsp_ius;
+	u32			queue_size;
+	unsigned int		cpu;
+	atomic_t		io_cnt;
+	int			cm_err;
+};
+
+/**
+ * rtrs_permit - permits the memory allocation for future RDMA operation.
+ *		 Combine with irq pinning to keep IO on same CPU.
+ */
+struct rtrs_permit {
+	enum rtrs_clt_con_type con_type;
+	unsigned int cpu_id;
+	unsigned int mem_id;
+	unsigned int mem_off;
+};
+
+/**
+ * rtrs_clt_io_req - describes one inflight IO request
+ */
+struct rtrs_clt_io_req {
+	struct list_head        list;
+	struct rtrs_iu		*iu;
+	struct scatterlist	*sglist; /* list holding user data */
+	unsigned int		sg_cnt;
+	unsigned int		sg_size;
+	unsigned int		data_len;
+	unsigned int		usr_len;
+	void			*priv;
+	bool			in_use;
+	struct rtrs_clt_con	*con;
+	struct rtrs_sg_desc	*desc;
+	struct ib_sge		*sge;
+	struct rtrs_permit	*permit;
+	enum dma_data_direction dir;
+	void			(*conf)(void *priv, int errno);
+	unsigned long		start_jiffies;
+
+	struct ib_mr		*mr;
+	struct ib_cqe		inv_cqe;
+	struct completion	inv_comp;
+	int			inv_errno;
+	bool			need_inv_comp;
+	bool			need_inv;
+};
+
+struct rtrs_rbuf {
+	u64 addr;
+	u32 rkey;
+};
+
+struct rtrs_clt_sess {
+	struct rtrs_sess	s;
+	struct rtrs_clt	*clt;
+	wait_queue_head_t	state_wq;
+	enum rtrs_clt_state	state;
+	atomic_t		connected_cnt;
+	struct mutex		init_mutex;
+	struct rtrs_clt_io_req	*reqs;
+	struct delayed_work	reconnect_dwork;
+	struct work_struct	close_work;
+	unsigned int		reconnect_attempts;
+	bool			established;
+	struct rtrs_rbuf	*rbufs;
+	size_t			max_io_size;
+	u32			max_hdr_size;
+	u32			chunk_size;
+	size_t			queue_depth;
+	u32			max_pages_per_mr;
+	int			max_send_sge;
+	u32			flags;
+	struct kobject		kobj;
+	struct rtrs_clt_stats	*stats;
+	/* cache hca_port and hca_name to display in sysfs */
+	u8			hca_port;
+	char                    hca_name[IB_DEVICE_NAME_MAX];
+	struct list_head __percpu
+				*mp_skip_entry;
+};
+
+struct rtrs_clt {
+	struct list_head	paths_list; /* rcu protected list */
+	size_t			paths_num;
+	struct rtrs_clt_sess
+	__rcu * __percpu	*pcpu_path;
+	uuid_t			paths_uuid;
+	int			paths_up;
+	struct mutex		paths_mutex;
+	struct mutex		paths_ev_mutex;
+	char			sessname[NAME_MAX];
+	u16			port;
+	unsigned int		max_reconnect_attempts;
+	unsigned int		reconnect_delay_sec;
+	unsigned int		max_segments;
+	void			*permits;
+	unsigned long		*permits_map;
+	size_t			queue_depth;
+	size_t			max_io_size;
+	wait_queue_head_t	permits_wait;
+	size_t			pdu_sz;
+	void			*priv;
+	void			(*link_ev)(void *priv,
+					   enum rtrs_clt_link_ev ev);
+	struct device		dev;
+	struct kobject		*kobj_paths;
+	enum rtrs_mp_policy	mp_policy;
+};
+
+static inline struct rtrs_clt_con *to_clt_con(struct rtrs_con *c)
+{
+	return container_of(c, struct rtrs_clt_con, c);
+}
+
+static inline struct rtrs_clt_sess *to_clt_sess(struct rtrs_sess *s)
+{
+	return container_of(s, struct rtrs_clt_sess, s);
+}
+
+static inline int permit_size(struct rtrs_clt *clt)
+{
+	return sizeof(struct rtrs_permit) + clt->pdu_sz;
+}
+
+static inline struct rtrs_permit *get_permit(struct rtrs_clt *clt, int idx)
+{
+	return (struct rtrs_permit *)(clt->permits + permit_size(clt) * idx);
+}
+
+int rtrs_clt_reconnect_from_sysfs(struct rtrs_clt_sess *sess);
+int rtrs_clt_disconnect_from_sysfs(struct rtrs_clt_sess *sess);
+int rtrs_clt_create_path_from_sysfs(struct rtrs_clt *clt,
+				     struct rtrs_addr *addr);
+int rtrs_clt_remove_path_from_sysfs(struct rtrs_clt_sess *sess,
+				     const struct attribute *sysfs_self);
+
+void rtrs_clt_set_max_reconnect_attempts(struct rtrs_clt *clt, int value);
+int rtrs_clt_get_max_reconnect_attempts(const struct rtrs_clt *clt);
+void free_sess(struct rtrs_clt_sess *sess);
+
+/* rtrs-clt-stats.c */
+
+int rtrs_clt_init_stats(struct rtrs_clt_stats *stats);
+
+void rtrs_clt_inc_failover_cnt(struct rtrs_clt_stats *s);
+
+void rtrs_clt_update_wc_stats(struct rtrs_clt_con *con);
+void rtrs_clt_update_all_stats(struct rtrs_clt_io_req *req, int dir);
+
+int rtrs_clt_reset_rdma_lat_distr_stats(struct rtrs_clt_stats *stats,
+					 bool enable);
+ssize_t rtrs_clt_stats_rdma_lat_distr_to_str(struct rtrs_clt_stats *stats,
+					      char *page, size_t len);
+int rtrs_clt_reset_cpu_migr_stats(struct rtrs_clt_stats *stats, bool enable);
+int rtrs_clt_stats_migration_cnt_to_str(struct rtrs_clt_stats *stats, char *buf,
+					 size_t len);
+int rtrs_clt_reset_reconnects_stat(struct rtrs_clt_stats *stats, bool enable);
+int rtrs_clt_stats_reconnects_to_str(struct rtrs_clt_stats *stats, char *buf,
+				      size_t len);
+int rtrs_clt_reset_wc_comp_stats(struct rtrs_clt_stats *stats, bool enable);
+int rtrs_clt_stats_wc_completion_to_str(struct rtrs_clt_stats *stats, char *buf,
+					 size_t len);
+int rtrs_clt_reset_rdma_stats(struct rtrs_clt_stats *stats, bool enable);
+ssize_t rtrs_clt_stats_rdma_to_str(struct rtrs_clt_stats *stats,
+				    char *page, size_t len);
+int rtrs_clt_reset_all_stats(struct rtrs_clt_stats *stats, bool enable);
+ssize_t rtrs_clt_reset_all_help(struct rtrs_clt_stats *stats,
+				 char *page, size_t len);
+
+/* rtrs-clt-sysfs.c */
+
+int rtrs_clt_create_sysfs_root_files(struct rtrs_clt *clt);
+void rtrs_clt_destroy_sysfs_root_folders(struct rtrs_clt *clt);
+void rtrs_clt_destroy_sysfs_root_files(struct rtrs_clt *clt);
+
+int rtrs_clt_create_sess_files(struct rtrs_clt_sess *sess);
+void rtrs_clt_destroy_sess_files(struct rtrs_clt_sess *sess,
+				  const struct attribute *sysfs_self);
+
+#endif /* RTRS_CLT_H */
-- 
2.20.1

