Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 057C94D14F
	for <lists+linux-block@lfdr.de>; Thu, 20 Jun 2019 17:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbfFTPDp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 Jun 2019 11:03:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35421 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfFTPDo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 11:03:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id p26so5213969edr.2;
        Thu, 20 Jun 2019 08:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K+WVPCYPL9w9InA58BMkQUAJSM/OchKnfUSNww3VA1A=;
        b=hhfuoMeDcwdL0FvXwZ92d6jFNkrL9+w1NnxylhIbDbKd3OFtninGIqSY/+tQDhAvJD
         zqDciUKsvFq2kBN+K4ERMcVcSfSsX4ofOpgEUl2TxrStshqRFA0EZV//VvX1GQVYrrME
         3FFSgCJq2rr6p0Jj+mNyiaItGvDKGbkafjxiVxOL7ufU73kmC6BrQR/fK76SCcjH5mZL
         fjj7qI7jRdQYP1lqc16It6AX/vdDaryr3dgkGpPw7ATs9H1jUDnXbiXiUHfxxLSfZ75C
         w4zMfAj/SK9r9/JAwc9vrlHsx7IiyV6N7yCZCwasHCebHbW0h/A2gHnpEAP8ZlGbemZ6
         1AQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K+WVPCYPL9w9InA58BMkQUAJSM/OchKnfUSNww3VA1A=;
        b=kAIwqThOqO/8Gch1gtfg++ngs3zqmX69CZHiI/6JVqtX7jOqC998idcaEu7z66Wj/0
         x0SMNIGLgvKb4yOG9zWnNFQD/cs/MtUb0ugEf7pawEQm33n6AXjVypOnIpiWus9pa7BK
         X1sklYMVlBsJ9k9cLQY6Au8PCJzNKEnyC2YHApPEGb4+ZFQetNY/edQ9PtTK00fULp14
         9EfNeljtJpLeEVzdJzg++FW5lh6lC+gwJq5y0OGnqz7bKqTepWjFPlKBchli2mVris27
         YdhgtsDDnoGP8cCrDm6EoVf9/NO6CTAe1B5IrruLF69CMm90Dqp4ewzGJ/u+dxaM3Cf9
         nxoA==
X-Gm-Message-State: APjAAAW0ZJz/e6J3ilQNRuUjRivWs+BCbTJIVIE3Vcsq2k6tN4v7Wv4N
        2TE9hlmwG1RVbJdiBGRZ/P4y7gWHYsE=
X-Google-Smtp-Source: APXvYqzVaXVrOx6O0PXxv4UfJHruiPgjNtuV6vJGwbqdkNV9nUeC2VyGE5KgEzC2NsI6RClAWTeLKQ==
X-Received: by 2002:a50:91ae:: with SMTP id g43mr20063914eda.279.1561043022558;
        Thu, 20 Jun 2019 08:03:42 -0700 (PDT)
Received: from jwang-Latitude-5491.pb.local ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id a20sm3855817ejj.21.2019.06.20.08.03.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 08:03:42 -0700 (PDT)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v4 02/25] ibtrs: public interface header to establish RDMA connections
Date:   Thu, 20 Jun 2019 17:03:14 +0200
Message-Id: <20190620150337.7847-3-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620150337.7847-1-jinpuwang@gmail.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Roman Pen <roman.penyaev@profitbricks.com>

Introduce public header which provides set of API functions to
establish RDMA connections from client to server machine using
IBTRS protocol, which manages RDMA connections for each session,
does multipathing and load balancing.

Main functions for client (active) side:

 ibtrs_clt_open() - Creates set of RDMA connections incapsulated
                    in IBTRS session and returns pointer on IBTRS
		    session object.
 ibtrs_clt_close() - Closes RDMA connections associated with IBTRS
                     session.
 ibtrs_clt_request() - Requests zero-copy RDMA transfer to/from
                       server.

Main functions for server (passive) side:

 ibtrs_srv_open() - Starts listening for IBTRS clients on specified
                    port and invokes IBTRS callbacks for incoming
		    RDMA requests or link events.
 ibtrs_srv_close() - Closes IBTRS server context.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/ibtrs/ibtrs.h | 318 +++++++++++++++++++++++++++
 1 file changed, 318 insertions(+)
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs.h

diff --git a/drivers/infiniband/ulp/ibtrs/ibtrs.h b/drivers/infiniband/ulp/ibtrs/ibtrs.h
new file mode 100644
index 000000000000..f5434f0bb85c
--- /dev/null
+++ b/drivers/infiniband/ulp/ibtrs/ibtrs.h
@@ -0,0 +1,318 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * InfiniBand Transport Layer
+ *
+ * Copyright (c) 2014 - 2017 ProfitBricks GmbH. All rights reserved.
+ * Authors: Fabian Holler <mail@fholler.de>
+ *          Jack Wang <jinpu.wang@profitbricks.com>
+ *          Kleber Souza <kleber.souza@profitbricks.com>
+ *          Danil Kipnis <danil.kipnis@profitbricks.com>
+ *          Roman Penyaev <roman.penyaev@profitbricks.com>
+ *          Milind Dumbare <Milind.dumbare@gmail.com>
+ *
+ * Copyright (c) 2017 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Authors: Danil Kipnis <danil.kipnis@profitbricks.com>
+ *          Roman Penyaev <roman.penyaev@profitbricks.com>
+ *
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Authors: Roman Penyaev <roman.penyaev@profitbricks.com>
+ *          Jack Wang <jinpu.wang@cloud.ionos.com>
+ *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
+ */
+
+#ifndef IBTRS_H
+#define IBTRS_H
+
+#include <linux/socket.h>
+#include <linux/scatterlist.h>
+
+struct ibtrs_tag;
+struct ibtrs_clt;
+struct ibtrs_srv_ctx;
+struct ibtrs_srv;
+struct ibtrs_srv_op;
+
+/*
+ * Here goes IBTRS client API
+ */
+
+/**
+ * enum ibtrs_clt_link_ev - Events about connectivity state of a client
+ * @IBTRS_CLT_LINK_EV_RECONNECTED	Client was reconnected.
+ * @IBTRS_CLT_LINK_EV_DISCONNECTED	Client was disconnected.
+ */
+enum ibtrs_clt_link_ev {
+	IBTRS_CLT_LINK_EV_RECONNECTED,
+	IBTRS_CLT_LINK_EV_DISCONNECTED,
+};
+
+/**
+ * Source and destination address of a path to be established
+ */
+struct ibtrs_addr {
+	struct sockaddr_storage *src;
+	struct sockaddr_storage *dst;
+};
+
+typedef void (link_clt_ev_fn)(void *priv, enum ibtrs_clt_link_ev ev);
+/**
+ * ibtrs_clt_open() - Open a session to a IBTRS client
+ * @priv:		User supplied private data.
+ * @link_ev:		Event notification for connection state changes
+ *	@priv:			user supplied data that was passed to
+ *				ibtrs_clt_open()
+ *	@ev:			Occurred event
+ * @sessname: name of the session
+ * @paths: Paths to be established defined by their src and dst addresses
+ * @path_cnt: Number of elemnts in the @paths array
+ * @port: port to be used by the IBTRS session
+ * @pdu_sz: Size of extra payload which can be accessed after tag allocation.
+ * @max_inflight_msg: Max. number of parallel inflight messages for the session
+ * @max_segments: Max. number of segments per IO request
+ * @reconnect_delay_sec: time between reconnect tries
+ * @max_reconnect_attempts: Number of times to reconnect on error before giving
+ *			    up, 0 for * disabled, -1 for forever
+ *
+ * Starts session establishment with the ibtrs_server. The function can block
+ * up to ~2000ms until it returns.
+ *
+ * Return a valid pointer on success otherwise PTR_ERR.
+ */
+struct ibtrs_clt *ibtrs_clt_open(void *priv, link_clt_ev_fn *link_ev,
+				 const char *sessname,
+				 const struct ibtrs_addr *paths,
+				 size_t path_cnt, short port,
+				 size_t pdu_sz, u8 reconnect_delay_sec,
+				 u16 max_segments,
+				 s16 max_reconnect_attempts);
+
+/**
+ * ibtrs_clt_close() - Close a session
+ * @sess: Session handler, is freed on return
+ */
+void ibtrs_clt_close(struct ibtrs_clt *sess);
+
+/**
+ * ibtrs_tag_from_pdu() - converts opaque pdu pointer to ibtrs_tag
+ * @pdu: opaque pointer
+ */
+struct ibtrs_tag *ibtrs_tag_from_pdu(void *pdu);
+
+/**
+ * ibtrs_tag_to_pdu() - converts ibtrs_tag to opaque pdu pointer
+ * @tag: IBTRS tag pointer
+ */
+void *ibtrs_tag_to_pdu(struct ibtrs_tag *tag);
+
+enum {
+	IBTRS_TAG_NOWAIT = 0,
+	IBTRS_TAG_WAIT   = 1,
+};
+
+/**
+ * enum ibtrs_clt_con_type() type of ib connection to use with a given tag
+ * @USR_CON - use connection reserved vor "service" messages
+ * @IO_CON - use a connection reserved for IO
+ */
+enum ibtrs_clt_con_type {
+	IBTRS_USR_CON,
+	IBTRS_IO_CON
+};
+
+/**
+ * ibtrs_clt_get_tag() - allocates tag for future RDMA operation
+ * @sess:	Current session
+ * @con_type:	Type of connection to use with the tag
+ * @wait:	Wait type
+ *
+ * Description:
+ *    Allocates tag for the following RDMA operation.  Tag is used
+ *    to preallocate all resources and to propagate memory pressure
+ *    up earlier.
+ *
+ * Context:
+ *    Can sleep if @wait == IBTRS_TAG_WAIT
+ */
+struct ibtrs_tag *ibtrs_clt_get_tag(struct ibtrs_clt *sess,
+				    enum ibtrs_clt_con_type con_type,
+				    int wait);
+
+/**
+ * ibtrs_clt_put_tag() - puts allocated tag
+ * @sess:	Current session
+ * @tag:	Tag to be freed
+ *
+ * Context:
+ *    Does not matter
+ */
+void ibtrs_clt_put_tag(struct ibtrs_clt *sess, struct ibtrs_tag *tag);
+
+typedef void (ibtrs_conf_fn)(void *priv, int errno);
+/**
+ * ibtrs_clt_request() - Request data transfer to/from server via RDMA.
+ *
+ * @dir:	READ/WRITE
+ * @conf:	callback function to be called as confirmation
+ * @sess:	Session
+ * @tag:	Preallocated tag
+ * @priv:	User provided data, passed back with corresponding
+ *		@(conf) confirmation.
+ * @vec:	Message that is send to server together with the request.
+ *		Sum of len of all @vec elements limited to <= IO_MSG_SIZE.
+ *		Since the msg is copied internally it can be allocated on stack.
+ * @nr:		Number of elements in @vec.
+ * @len:	length of data send to/from server
+ * @sg:		Pages to be sent/received to/from server.
+ * @sg_cnt:	Number of elements in the @sg
+ *
+ * Return:
+ * 0:		Success
+ * <0:		Error
+ *
+ * On dir=READ ibtrs client will request a data transfer from Server to client.
+ * The data that the server will respond with will be stored in @sg when
+ * the user receives an %IBTRS_CLT_RDMA_EV_RDMA_REQUEST_WRITE_COMPL event.
+ * On dir=WRITE ibtrs client will rdma write data in sg to server side.
+ */
+int ibtrs_clt_request(int dir, ibtrs_conf_fn *conf, struct ibtrs_clt *sess,
+		      struct ibtrs_tag *tag, void *priv, const struct kvec *vec,
+		      size_t nr, size_t len, struct scatterlist *sg,
+		      unsigned int sg_cnt);
+
+/**
+ * ibtrs_attrs - IBTRS session attributes
+ */
+struct ibtrs_attrs {
+	u32	queue_depth;
+	u32	max_io_size;
+	u8	sessname[NAME_MAX];
+	struct kobject *sess_kobj;
+};
+
+/**
+ * ibtrs_clt_query() - queries IBTRS session attributes
+ *
+ * Returns:
+ *    0 on success
+ *    -ECOMM		no connection to the server
+ */
+int ibtrs_clt_query(struct ibtrs_clt *sess, struct ibtrs_attrs *attr);
+
+/*
+ * Here goes IBTRS server API
+ */
+
+/**
+ * enum ibtrs_srv_link_ev - Server link events
+ * @IBTRS_SRV_LINK_EV_CONNECTED:	Connection from client established
+ * @IBTRS_SRV_LINK_EV_DISCONNECTED:	Connection was disconnected, all
+ *					connection IBTRS resources were freed.
+ */
+enum ibtrs_srv_link_ev {
+	IBTRS_SRV_LINK_EV_CONNECTED,
+	IBTRS_SRV_LINK_EV_DISCONNECTED,
+};
+
+/**
+ * rdma_ev_fn():	Event notification for RDMA operations
+ *			If the callback returns a value != 0, an error message
+ *			for the data transfer will be sent to the client.
+
+ *	@sess:		Session
+ *	@priv:		Private data set by ibtrs_srv_set_sess_priv()
+ *	@id:		internal IBTRS operation id
+ *	@dir:		READ/WRITE
+ *	@data:		Pointer to (bidirectional) rdma memory area:
+ *			- in case of %IBTRS_SRV_RDMA_EV_RECV contains
+ *			data sent by the client
+ *			- in case of %IBTRS_SRV_RDMA_EV_WRITE_REQ points to the
+ *			memory area where the response is to be written to
+ *	@datalen:	Size of the memory area in @data
+ *	@usr:		The extra user message sent by the client (%vec)
+ *	@usrlen:	Size of the user message
+ */
+typedef int (rdma_ev_fn)(struct ibtrs_srv *sess, void *priv,
+			 struct ibtrs_srv_op *id, int dir,
+			 void *data, size_t datalen, const void *usr,
+			 size_t usrlen);
+
+/**
+ * link_ev_fn():	Events about connective state changes
+ *			If the callback returns != 0 and the event
+ *			%IBTRS_SRV_LINK_EV_CONNECTED the corresponding session
+ *			will be destroyed.
+ *	@sess:		Session
+ *	@ev:		event
+ *	@priv:		Private data from user if previously set with
+ *			ibtrs_srv_set_sess_priv()
+ */
+typedef int (link_ev_fn)(struct ibtrs_srv *sess, enum ibtrs_srv_link_ev ev,
+			 void *priv);
+
+/**
+ * ibtrs_srv_open() - open IBTRS server context
+ * @ops:		callback functions
+ *
+ * Creates server context with specified callbacks.
+ *
+ * Return a valid pointer on success otherwise PTR_ERR.
+ */
+struct ibtrs_srv_ctx *ibtrs_srv_open(rdma_ev_fn *rdma_ev, link_ev_fn *link_ev,
+				     unsigned int port);
+
+/**
+ * ibtrs_srv_close() - close IBTRS server context
+ * @ctx: pointer to server context
+ *
+ * Closes IBTRS server context with all client sessions.
+ */
+void ibtrs_srv_close(struct ibtrs_srv_ctx *ctx);
+
+/**
+ * ibtrs_srv_resp_rdma() - Finish an RDMA request
+ *
+ * @id:		Internal IBTRS operation identifier
+ * @errno:	Response Code send to the other side for this operation.
+ *		0 = success, <=0 error
+ *
+ * Finish a RDMA operation. A message is sent to the client and the
+ * corresponding memory areas will be released.
+ */
+void ibtrs_srv_resp_rdma(struct ibtrs_srv_op *id, int errno);
+
+/**
+ * ibtrs_srv_set_sess_priv() - Set private pointer in ibtrs_srv.
+ * @sess:	Session
+ * @priv:	The private pointer that is associated with the session.
+ */
+void ibtrs_srv_set_sess_priv(struct ibtrs_srv *sess, void *priv);
+
+/**
+ * ibtrs_srv_get_sess_qdepth() - Get ibtrs_srv qdepth.
+ * @sess:	Session
+ */
+int ibtrs_srv_get_queue_depth(struct ibtrs_srv *sess);
+
+/**
+ * ibtrs_srv_get_sess_name() - Get ibtrs_srv peer hostname.
+ * @sess:	Session
+ * @sessname:	Sessname buffer
+ * @len:	Length of sessname buffer
+ */
+int ibtrs_srv_get_sess_name(struct ibtrs_srv *sess, char *sessname, size_t len);
+
+/**
+ * ibtrs_addr_to_sockaddr() - convert path string "src,dst" to sockaddreses
+ * @str		string containing source and destination addr of a path
+ *		separated by comma. I.e. "ip:1.1.1.1,ip:1.1.1.2". If str
+ *		contains only one address it's considered to be destination.
+ * @len		string length
+ * @addr->dst	will be set to the destination sockadddr.
+ * @addr->src	will be set to the source address or to NULL
+ *		if str doesn't contain any sorce address.
+ *
+ * Returns zero if conversion successful. Non-zero otherwise.
+ */
+int ibtrs_addr_to_sockaddr(const char *str, size_t len, short port,
+			   struct ibtrs_addr *addr);
+#endif
-- 
2.17.1

