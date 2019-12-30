Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54E8612CEBE
	for <lists+linux-block@lfdr.de>; Mon, 30 Dec 2019 11:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfL3K3v (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 30 Dec 2019 05:29:51 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36202 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfL3K3u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Dec 2019 05:29:50 -0500
Received: by mail-ed1-f68.google.com with SMTP id j17so32197803edp.3;
        Mon, 30 Dec 2019 02:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1xHoxxSLGfnkXvsGmvlzGOgX4FWYhCygBKVj40K2zyM=;
        b=otaXciAD8UZWL8qrMgV4Z911Y9Lf/c3GNktcZzk++xGdg/uwJAhFIz+Hd68Mrp1eMC
         IfqKkDoHTLUOBNShqHlywEtelM8thJASHJ8M8BJmnxC1tCtTo7ycnVjuKssouDPFub0F
         qVECkY0R3X88GEZPcQYiKzk8u5ccrpez1QvNrzPpywnqUPV6pgrHIqmTGRPhYNdI/yIz
         ccHOLztX3TQA1kpsvHVDlAegMgz8d9wNaUqiOUc2eFz8wMwCuzqCtrzXs1ZmvSRZfaFv
         ZJZaVTg85aEoqQYDdZ88akNntlo8jpl9y7PH7RGE/IGktJv3PKs3Z3pJ5/NJ5VJcBL0p
         MQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1xHoxxSLGfnkXvsGmvlzGOgX4FWYhCygBKVj40K2zyM=;
        b=Hu1JHM6RLho8pqK/a7jauc5/G3umt+O2tsOU/xMZkGDAWhmO4H6sx3/1Seesfl7jcC
         F3em27eLGSKsDtADa3jfVoaDNUHnE+GgzTI1vEzpi8ulERPWVzCv8QcjqkZxSZMf8Anq
         cGTuQ2cEqHsaIN7XTiTNXMP6X+IWgnAJuUkru/tMJkIDS8uR7PgBiFtC6bXp2ma0odo+
         hNL2nBq2nq5nxFZP1MfpsnpUX77qFH7Mpc7yPToD6xh/cW+VvqevzT5qIxqKn4f4UeQl
         phb5TF+Kk+X9EFh0/v3qypRqTwaoFuOgR9CvNOBtBtz5eu5v9CO+qomXRG6G/GZhGlEP
         Q2fA==
X-Gm-Message-State: APjAAAXEXgfiloNjB/iuL4mL/BNXqr4+LQpnvrlFxlI04DKmLPtJvTqR
        IRuBOBwg4I0YIWIBuBhNo4e8Gu0G
X-Google-Smtp-Source: APXvYqzuWVVXqXj2rqSqYo0YiWLZNVXu+BTbJEV74uOSezXDF/p0BU2re0pomFb3xDr4BPnjB0RPHw==
X-Received: by 2002:a17:906:9511:: with SMTP id u17mr68416247ejx.13.1577701788029;
        Mon, 30 Dec 2019 02:29:48 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4955:5100:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id v8sm5246630edw.21.2019.12.30.02.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 02:29:47 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v6 03/25] rtrs: private headers with rtrs protocol structs and helpers
Date:   Mon, 30 Dec 2019 11:29:20 +0100
Message-Id: <20191230102942.18395-4-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230102942.18395-1-jinpuwang@gmail.com>
References: <20191230102942.18395-1-jinpuwang@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

These are common private headers with rtrs protocol structures,
logging, sysfs and other helper functions, which are used on
both client and server sides.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-log.h |  32 ++
 drivers/infiniband/ulp/rtrs/rtrs-pri.h | 408 +++++++++++++++++++++++++
 2 files changed, 440 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-log.h
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-pri.h

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-log.h b/drivers/infiniband/ulp/rtrs/rtrs-log.h
new file mode 100644
index 000000000000..570329a73ee4
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-log.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * InfiniBand Transport Layer
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ *
+ * Copyright (c) 2019 1&1 IONOS SE. All rights reserved.
+ */
+#ifndef RTRS_LOG_H
+#define RTRS_LOG_H
+
+#define rtrs_prefix(obj) (obj->sessname)
+
+#define rtrs_log(fn, obj, fmt, ...)				\
+	fn("<%s>: " fmt, rtrs_prefix(obj), ##__VA_ARGS__)
+
+#define rtrs_err(obj, fmt, ...)	\
+	rtrs_log(pr_err, obj, fmt, ##__VA_ARGS__)
+#define rtrs_err_rl(obj, fmt, ...)	\
+	rtrs_log(pr_err_ratelimited, obj, fmt, ##__VA_ARGS__)
+#define rtrs_wrn(obj, fmt, ...)	\
+	rtrs_log(pr_warn, obj, fmt, ##__VA_ARGS__)
+#define rtrs_wrn_rl(obj, fmt, ...) \
+	rtrs_log(pr_warn_ratelimited, obj, fmt, ##__VA_ARGS__)
+#define rtrs_info(obj, fmt, ...) \
+	rtrs_log(pr_info, obj, fmt, ##__VA_ARGS__)
+#define rtrs_info_rl(obj, fmt, ...) \
+	rtrs_log(pr_info_ratelimited, obj, fmt, ##__VA_ARGS__)
+
+#endif /* RTRS_LOG_H */
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
new file mode 100644
index 000000000000..f215e6c0ce73
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -0,0 +1,408 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * InfiniBand Transport Layer
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ *
+ * Copyright (c) 2019 1&1 IONOS SE. All rights reserved.
+ */
+
+#ifndef RTRS_PRI_H
+#define RTRS_PRI_H
+
+#include <linux/uuid.h>
+#include <rdma/rdma_cm.h>
+#include <rdma/ib_verbs.h>
+#include <rdma/ib.h>
+
+#include "rtrs.h"
+
+#define RTRS_PROTO_VER_MAJOR 2
+#define RTRS_PROTO_VER_MINOR 0
+
+#define RTRS_PROTO_VER_STRING __stringify(RTRS_PROTO_VER_MAJOR) "." \
+			       __stringify(RTRS_PROTO_VER_MINOR)
+
+enum rtrs_imm_const {
+	MAX_IMM_TYPE_BITS = 4,
+	MAX_IMM_TYPE_MASK = ((1 << MAX_IMM_TYPE_BITS) - 1),
+	MAX_IMM_PAYL_BITS = 28,
+	MAX_IMM_PAYL_MASK = ((1 << MAX_IMM_PAYL_BITS) - 1),
+};
+
+enum rtrs_imm_type {
+	RTRS_IO_REQ_IMM       = 0, /* client to server */
+	RTRS_IO_RSP_IMM       = 1, /* server to client */
+	RTRS_IO_RSP_W_INV_IMM = 2, /* server to client */
+
+	RTRS_HB_MSG_IMM = 8,
+	RTRS_HB_ACK_IMM = 9,
+
+	RTRS_LAST_IMM,
+};
+
+enum {
+	SERVICE_CON_QUEUE_DEPTH = 512,
+
+	MIN_RTR_CNT = 1,
+	MAX_RTR_CNT = 7,
+
+	MAX_PATHS_NUM = 128,
+
+	/*
+	 * With the current size of the tag allocated on the client, 4K
+	 * is the maximum number of tags we can allocate.  This number is
+	 * also used on the client to allocate the IU for the user connection
+	 * to receive the RDMA addresses from the server.
+	 */
+	MAX_SESS_QUEUE_DEPTH = 4096,
+
+	RTRS_HB_INTERVAL_MS = 5000,
+	RTRS_HB_MISSED_MAX = 5,
+
+	RTRS_MAGIC = 0x1BBD,
+	RTRS_PROTO_VER = (RTRS_PROTO_VER_MAJOR << 8) | RTRS_PROTO_VER_MINOR,
+};
+
+struct rtrs_ib_dev;
+
+struct rtrs_ib_dev_pool_ops {
+	struct rtrs_ib_dev *(*alloc)(void);
+	void (*free)(struct rtrs_ib_dev *dev);
+	int (*init)(struct rtrs_ib_dev *dev);
+	void (*deinit)(struct rtrs_ib_dev *dev);
+};
+
+struct rtrs_ib_dev_pool {
+	struct mutex		mutex;
+	struct list_head	list;
+	enum ib_pd_flags	pd_flags;
+	const struct rtrs_ib_dev_pool_ops *ops;
+};
+
+struct rtrs_ib_dev {
+	struct ib_device	 *ib_dev;
+	struct ib_pd		 *ib_pd;
+	struct kref		 ref;
+	struct list_head	 entry;
+	struct rtrs_ib_dev_pool *pool;
+};
+
+struct rtrs_con {
+	struct rtrs_sess	*sess;
+	struct ib_qp		*qp;
+	struct ib_cq		*cq;
+	struct rdma_cm_id	*cm_id;
+	unsigned int		cid;
+};
+
+typedef void (rtrs_hb_handler_t)(struct rtrs_con *con);
+
+struct rtrs_sess {
+	struct list_head	entry;
+	struct sockaddr_storage dst_addr;
+	struct sockaddr_storage src_addr;
+	char			sessname[NAME_MAX];
+	uuid_t			uuid;
+	struct rtrs_con	**con;
+	unsigned int		con_num;
+	unsigned int		recon_cnt;
+	struct rtrs_ib_dev	*dev;
+	int			dev_ref;
+	struct ib_cqe		*hb_cqe;
+	rtrs_hb_handler_t	*hb_err_handler;
+	struct workqueue_struct *hb_wq;
+	struct delayed_work	hb_dwork;
+	unsigned int		hb_interval_ms;
+	unsigned int		hb_missed_cnt;
+	unsigned int		hb_missed_max;
+};
+
+struct rtrs_iu {
+	struct list_head        list;
+	struct ib_cqe           cqe;
+	dma_addr_t              dma_addr;
+	void                    *buf;
+	size_t                  size;
+	enum dma_data_direction direction;
+};
+
+/**
+ * enum rtrs_msg_types - RTRS message types.
+ * @RTRS_MSG_INFO_REQ:		Client additional info request to the server
+ * @RTRS_MSG_INFO_RSP:		Server additional info response to the client
+ * @RTRS_MSG_WRITE:		Client writes data per RDMA to server
+ * @RTRS_MSG_READ:		Client requests data transfer from server
+ * @RTRS_MSG_RKEY_RSP:		Server refreshed rkey for rbuf
+ */
+enum rtrs_msg_types {
+	RTRS_MSG_INFO_REQ,
+	RTRS_MSG_INFO_RSP,
+	RTRS_MSG_WRITE,
+	RTRS_MSG_READ,
+	RTRS_MSG_RKEY_RSP,
+};
+
+/**
+ * enum rtrs_msg_flags - RTRS message flags.
+ * @RTRS_NEED_INVAL:	Send invalidation in response.
+ * @RTRS_MSG_NEW_RKEY_F: Send refreshed rkey in response.
+ */
+enum rtrs_msg_flags {
+	RTRS_MSG_NEED_INVAL_F = 1 << 0,
+	RTRS_MSG_NEW_RKEY_F = 1 << 1,
+};
+
+/**
+ * struct rtrs_sg_desc - RDMA-Buffer entry description
+ * @addr:	Address of RDMA destination buffer
+ * @key:	Authorization rkey to write to the buffer
+ * @len:	Size of the buffer
+ */
+struct rtrs_sg_desc {
+	__le64			addr;
+	__le32			key;
+	__le32			len;
+};
+
+/**
+ * struct rtrs_msg_conn_req - Client connection request to the server
+ * @magic:	   RTRS magic
+ * @version:	   RTRS protocol version
+ * @cid:	   Current connection id
+ * @cid_num:	   Number of connections per session
+ * @recon_cnt:	   Reconnections counter
+ * @sess_uuid:	   UUID of a session (path)
+ * @paths_uuid:	   UUID of a group of sessions (paths)
+ *
+ * NOTE: max size 56 bytes, see man rdma_connect().
+ */
+struct rtrs_msg_conn_req {
+	u8		__cma_version; /* Is set to 0 by cma.c in case of
+					* AF_IB, do not touch that.
+					*/
+	u8		__ip_version;  /* On sender side that should be
+					* set to 0, or cma_save_ip_info()
+					* extract garbage and will fail.
+					*/
+	__le16		magic;
+	__le16		version;
+	__le16		cid;
+	__le16		cid_num;
+	__le16		recon_cnt;
+	uuid_t		sess_uuid;
+	uuid_t		paths_uuid;
+	u8		reserved[12];
+};
+
+/**
+ * struct rtrs_msg_conn_rsp - Server connection response to the client
+ * @magic:	   RTRS magic
+ * @version:	   RTRS protocol version
+ * @errno:	   If rdma_accept() then 0, if rdma_reject() indicates error
+ * @queue_depth:   max inflight messages (queue-depth) in this session
+ * @max_io_size:   max io size server supports
+ * @max_hdr_size:  max msg header size server supports
+ *
+ * NOTE: size is 56 bytes, max possible is 136 bytes, see man rdma_accept().
+ */
+struct rtrs_msg_conn_rsp {
+	__le16		magic;
+	__le16		version;
+	__le16		errno;
+	__le16		queue_depth;
+	__le32		max_io_size;
+	__le32		max_hdr_size;
+	__le32		flags;
+	u8		reserved[36];
+};
+
+/**
+ * struct rtrs_msg_info_req
+ * @type:		@RTRS_MSG_INFO_REQ
+ * @sessname:		Session name chosen by client
+ */
+struct rtrs_msg_info_req {
+	__le16		type;
+	u8		sessname[NAME_MAX];
+	u8		reserved[15];
+};
+
+/**
+ * struct rtrs_msg_info_rsp
+ * @type:		@RTRS_MSG_INFO_RSP
+ * @sg_cnt:		Number of @desc entries
+ * @desc:		RDMA buffers where the client can write to server
+ */
+struct rtrs_msg_info_rsp {
+	__le16		type;
+	__le16          sg_cnt;
+	u8              reserved[4];
+	struct rtrs_sg_desc desc[];
+};
+
+/**
+ * struct rtrs_msg_rkey_rsp
+ * @type:		@RTRS_MSG_RKEY_RSP
+ * @buf_id:		RDMA buf_id of the new rkey
+ * @rkey:		new remote key for RDMA buffers id from server
+ */
+struct rtrs_msg_rkey_rsp {
+	__le16		type;
+	__le16          buf_id;
+	__le32		rkey;
+};
+
+/**
+ * struct rtrs_msg_rdma_read - RDMA data transfer request from client
+ * @type:		always @RTRS_MSG_READ
+ * @usr_len:		length of user payload
+ * @sg_cnt:		number of @desc entries
+ * @desc:		RDMA buffers where the server can write the result to
+ */
+struct rtrs_msg_rdma_read {
+	__le16			type;
+	__le16			usr_len;
+	__le16			flags;
+	__le16			sg_cnt;
+	struct rtrs_sg_desc    desc[];
+};
+
+/**
+ * struct_msg_rdma_write - Message transferred to server with RDMA-Write
+ * @type:		always @RTRS_MSG_WRITE
+ * @usr_len:		length of user payload
+ */
+struct rtrs_msg_rdma_write {
+	__le16			type;
+	__le16			usr_len;
+};
+
+/**
+ * struct_msg_rdma_hdr - header for read or write request
+ * @type:		@RTRS_MSG_WRITE | @RTRS_MSG_READ
+ */
+struct rtrs_msg_rdma_hdr {
+	__le16			type;
+};
+
+/* rtrs.c */
+
+struct rtrs_iu *rtrs_iu_alloc(u32 queue_size, size_t size, gfp_t t,
+			      struct ib_device *dev, enum dma_data_direction,
+			      void (*done)(struct ib_cq *cq, struct ib_wc *wc));
+void rtrs_iu_free(struct rtrs_iu *iu, enum dma_data_direction dir,
+		  struct ib_device *dev, u32 queue_size);
+int rtrs_iu_post_recv(struct rtrs_con *con, struct rtrs_iu *iu);
+int rtrs_iu_post_send(struct rtrs_con *con, struct rtrs_iu *iu, size_t size,
+		      struct ib_send_wr *head);
+int rtrs_iu_post_rdma_write_imm(struct rtrs_con *con, struct rtrs_iu *iu,
+				struct ib_sge *sge, unsigned int num_sge,
+				u32 rkey, u64 rdma_addr, u32 imm_data,
+				enum ib_send_flags flags,
+				struct ib_send_wr *head);
+
+int rtrs_post_recv_empty(struct rtrs_con *con, struct ib_cqe *cqe);
+int rtrs_post_recv_empty_x2(struct rtrs_con *con, struct ib_cqe *cqe);
+int rtrs_post_rdma_write_imm_empty(struct rtrs_con *con, struct ib_cqe *cqe,
+				   u32 imm_data, enum ib_send_flags flags,
+				   struct ib_send_wr *head);
+
+int rtrs_cq_qp_create(struct rtrs_sess *rtrs_sess, struct rtrs_con *con,
+		      u32 max_send_sge, int cq_vector, u16 cq_size,
+		      u16 wr_queue_size, enum ib_poll_context poll_ctx);
+void rtrs_cq_qp_destroy(struct rtrs_con *con);
+
+void rtrs_init_hb(struct rtrs_sess *sess, struct ib_cqe *cqe,
+		  unsigned int interval_ms, unsigned int missed_max,
+		  rtrs_hb_handler_t *err_handler,
+		  struct workqueue_struct *wq);
+void rtrs_start_hb(struct rtrs_sess *sess);
+void rtrs_stop_hb(struct rtrs_sess *sess);
+void rtrs_send_hb_ack(struct rtrs_sess *sess);
+
+void rtrs_ib_dev_pool_init(enum ib_pd_flags pd_flags,
+			   struct rtrs_ib_dev_pool *pool);
+void rtrs_ib_dev_pool_deinit(struct rtrs_ib_dev_pool *pool);
+
+struct rtrs_ib_dev *rtrs_ib_dev_find_or_add(struct ib_device *ib_dev,
+					    struct rtrs_ib_dev_pool *pool);
+int rtrs_ib_dev_put(struct rtrs_ib_dev *dev);
+
+static inline u32 rtrs_to_imm(u32 type, u32 payload)
+{
+	BUILD_BUG_ON(MAX_IMM_PAYL_BITS + MAX_IMM_TYPE_BITS != 32);
+	BUILD_BUG_ON(RTRS_LAST_IMM > (1<<MAX_IMM_TYPE_BITS));
+	return ((type & MAX_IMM_TYPE_MASK) << MAX_IMM_PAYL_BITS) |
+		(payload & MAX_IMM_PAYL_MASK);
+}
+
+static inline void rtrs_from_imm(u32 imm, u32 *type, u32 *payload)
+{
+	*payload = (imm & MAX_IMM_PAYL_MASK);
+	*type = (imm >> MAX_IMM_PAYL_BITS);
+}
+
+static inline u32 rtrs_to_io_req_imm(u32 addr)
+{
+	return rtrs_to_imm(RTRS_IO_REQ_IMM, addr);
+}
+
+static inline u32 rtrs_to_io_rsp_imm(u32 msg_id, int errno, bool w_inval)
+{
+	enum rtrs_imm_type type;
+	u32 payload;
+
+	/* 9 bits for errno, 19 bits for msg_id */
+	payload = (abs(errno) & 0x1ff) << 19 | (msg_id & 0x7ffff);
+	type = (w_inval ? RTRS_IO_RSP_W_INV_IMM : RTRS_IO_RSP_IMM);
+
+	return rtrs_to_imm(type, payload);
+}
+
+static inline void rtrs_from_io_rsp_imm(u32 payload, u32 *msg_id, int *errno)
+{
+	/* 9 bits for errno, 19 bits for msg_id */
+	*msg_id = (payload & 0x7ffff);
+	*errno = -(int)((payload >> 19) & 0x1ff);
+}
+
+#define STAT_STORE_FUNC(type, set_value, reset)				\
+static ssize_t set_value##_store(struct kobject *kobj,			\
+			     struct kobj_attribute *attr,		\
+			     const char *buf, size_t count)		\
+{									\
+	int ret = -EINVAL;						\
+	type *sess = container_of(kobj, type, kobj_stats);		\
+									\
+	if (sysfs_streq(buf, "1"))					\
+		ret = reset(&sess->stats, true);			\
+	else if (sysfs_streq(buf, "0"))					\
+		ret = reset(&sess->stats, false);			\
+	if (ret)							\
+		return ret;						\
+									\
+	return count;							\
+}
+
+#define STAT_SHOW_FUNC(type, get_value, print)				\
+static ssize_t get_value##_show(struct kobject *kobj,			\
+			   struct kobj_attribute *attr,			\
+			   char *page)					\
+{									\
+	type *sess = container_of(kobj, type, kobj_stats);		\
+									\
+	return print(&sess->stats, page, PAGE_SIZE);			\
+}
+
+#define STAT_ATTR(type, stat, print, reset)				\
+STAT_STORE_FUNC(type, stat, reset)					\
+STAT_SHOW_FUNC(type, stat, print)					\
+static struct kobj_attribute stat##_attr =				\
+		__ATTR(stat, 0644,					\
+		       stat##_show,					\
+		       stat##_store)
+
+#endif /* RTRS_PRI_H */
-- 
2.17.1

