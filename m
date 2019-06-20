Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7554D169
	for <lists+linux-block@lfdr.de>; Thu, 20 Jun 2019 17:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbfFTPEA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 Jun 2019 11:04:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38941 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732086AbfFTPD7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 11:03:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id m10so5181027edv.6;
        Thu, 20 Jun 2019 08:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SU8xpXayFsHybNjcv+wZMIMBWpWBG7iUzh3CgzLfyJU=;
        b=ljrYdPQOQbEytPLBySA22ASw1ok/9RtVwaObwVLphBEw3J3GZfWBZyVv6g9IYWq6xd
         5HZY3sccYEkwgABAnH7VwJszJqS6f69vZVOBMC7RKuMA/Vb3gEe2AkEHFgBlabe58hds
         96g4G5IP975KtehnbnkmMlEaWhnC59NuZUpqgcPdlVdtH03G4OB7B35ARhoPTui7VqTv
         p7+N5jmKPefxCDLiEPmdP3HdB1yi4dop4pQenheLODP26UWAtpZ3gdervw3KmDkF5lkX
         vpTeMZvqAoi4r3A7jIBlp/5lgGVxj+4YswZllqH4P6NLCZ5Hba8wOSFVLKDdvtEHFrLz
         crQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SU8xpXayFsHybNjcv+wZMIMBWpWBG7iUzh3CgzLfyJU=;
        b=nAxMOc/+vKE2Li9mAW1DDmQGVh0Vmxv1pg2Bby/Z9N8mDc9KNl+JRQKRsWs93VqSUh
         HAG7aB0oFk9Kcbw7e64yw7eZdAfluc2VSDQC3p+CwBpSKdhzODLe458QhFtvQ+lNZ2Sc
         A8h2VEnjZyyPgmPEvThoE04lf4WsBFWJW0dO3d/StbD+HHsnxy9jYN2bzrGqhlySWqu2
         OJsvHFIQJbYso5k3bSDl5qnaF3cktR+MfVjBZ0XGJA8QqkFLboiQfXmwrjh2vplcfrgn
         AisMdOn/y8Rt8tWSixD3P5dgE7wAoB1l70wmdH98NVo2K7Ea1ftuHwA4UWQxBx44GJeT
         fwkQ==
X-Gm-Message-State: APjAAAUaFO9sX+6nUGVOCGp99swGoaXQm2CGMuF6d9KK0Dqsc4JK7Wgl
        oGQoNn0W4Lg/hctjiYb4TVbH4tYnz8Y=
X-Google-Smtp-Source: APXvYqz1hysgBQrYgpyyd2ub9Pu/nHlEacatyVZ3sRikEJjEM6u3IXAG5+va+XkUhCx5IT6BDpM/5Q==
X-Received: by 2002:a50:9871:: with SMTP id h46mr121304890edb.69.1561043036870;
        Thu, 20 Jun 2019 08:03:56 -0700 (PDT)
Received: from jwang-Latitude-5491.pb.local ([62.217.45.26])
        by smtp.gmail.com with ESMTPSA id a20sm3855817ejj.21.2019.06.20.08.03.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 08:03:56 -0700 (PDT)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH v4 14/25] ibtrs: a bit of documentation
Date:   Thu, 20 Jun 2019 17:03:26 +0200
Message-Id: <20190620150337.7847-15-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620150337.7847-1-jinpuwang@gmail.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Roman Pen <roman.penyaev@profitbricks.com>

README with description of major sysfs entries.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/ibtrs/README | 385 ++++++++++++++++++++++++++++
 1 file changed, 385 insertions(+)
 create mode 100644 drivers/infiniband/ulp/ibtrs/README

diff --git a/drivers/infiniband/ulp/ibtrs/README b/drivers/infiniband/ulp/ibtrs/README
new file mode 100644
index 000000000000..86d5cf836097
--- /dev/null
+++ b/drivers/infiniband/ulp/ibtrs/README
@@ -0,0 +1,385 @@
+****************************
+InfiniBand Transport (IBTRS)
+****************************
+
+IBTRS (InfiniBand Transport) is a reliable high speed transport library
+which provides support to establish optimal number of connections
+between client and server machines using RDMA (InfiniBand, RoCE, iWarp)
+transport. It is optimized to transfer (read/write) IO blocks.
+
+In its core interface it follows the BIO semantics of providing the
+possibility to either write data from an sg list to the remote side
+or to request ("read") data transfer from the remote side into a given
+sg list.
+
+IBTRS provides I/O fail-over and load-balancing capabilities by using
+multipath I/O (see "add_path" and "mp_policy" configuration entries).
+
+IBTRS is used by the IBNBD (Infiniband Network Block Device) modules.
+
+======================
+Client Sysfs Interface
+======================
+
+This chapter describes only the most important files of sysfs interface
+on client side.
+
+Entries under /sys/devices/virtual/ibtrs-client/
+================================================
+
+When a user of IBTRS API creates a new session, a directory entry with
+the name of that session is created.
+
+Entries under /sys/devices/virtual/ibtrs-client/<session-name>/
+===============================================================
+
+add_path (RW)
+-------------
+
+Adds a new path (connection) to an existing session. Expected format is the
+following:
+
+  <[source addr,]destination addr>
+
+  *addr ::= [ ip:<ipv4|ipv6> | gid:<gid> ]
+
+max_reconnect_attempts (RW)
+---------------------------
+
+Maximum number reconnect attempts the client should make before giving up
+after connection breaks unexpectedly.
+
+mp_policy (RW)
+--------------
+
+Multipath policy specifies which path should be selected on each IO:
+
+   round-robin (0):
+       select path in per CPU round-robin manner.
+
+   min-inflight (1):
+       select path with minimum inflights.
+
+Entries under /sys/devices/virtual/ibtrs-client/<session-name>/paths/
+=====================================================================
+
+
+Each path belonging to a given session is listed here by its source and
+destination address. When a new path is added to a session by writing to
+the "add_path" entry, a directory <src@dst> is created.
+
+Entries under /sys/devices/virtual/ibtrs-client/<session-name>/paths/<src@dst>/
+===============================================================================
+
+state (R)
+---------
+
+Contains "connected" if the session is connected to the peer and fully
+functional.  Otherwise the file contains "disconnected"
+
+reconnect (RW)
+--------------
+
+Write "1" to the file in order to reconnect the path.
+Operation is blocking and returns 0 if reconnect was successful.
+
+disconnect (RW)
+---------------
+
+Write "1" to the file in order to disconnect the path.
+Operation blocks until IBTRS path is disconnected.
+
+remove_path (RW)
+----------------
+
+Write "1" to the file in order to disconnected and remove the path
+from the session.  Operation blocks until the path is disconnected
+and removed from the session.
+
+hca_name (R)
+------------
+
+Contains the the name of HCA the connection established on.
+
+hca_port (R)
+------------
+
+Contains the port number of active port traffic is going through.
+
+src_addr (R)
+------------
+
+Contains the source address of the path
+
+dst_addr (R)
+------------
+
+Contains the destination address of the path
+
+
+Entries under /sys/devices/virtual/ibtrs-client/<session-name>/paths/<src@dst>/stats/
+=====================================================================================
+
+Write "0" to any file in that directory to reset corresponding statistics.
+
+reset_all (RW)
+--------------
+
+Read will return usage help, write 0 will clear all the statistics.
+
+sg_entries (RW)
+---------------
+
+Data to be transferred via RDMA is passed to IBTRS as scatter-gather
+list. A scatter-gather list can contain multiple entries.
+Scatter-gather list with less entries require less processing power
+and can therefore transferred faster. The file sg_entries outputs a
+per-CPU distribution table for the number of entries in the
+scatter-gather lists, that were passed to the IBTRS API function
+ibtrs_clt_request (READ or WRITE).
+
+cpu_migration (RW)
+------------------
+
+IBTRS expects that each HCA IRQ is pinned to a separate CPU. If it's
+not the case, the processing of an I/O response could be processed on a
+different CPU than where it was originally submitted.  This file shows
+how many interrupts where generated on a non expected CPU.
+"from:" is the CPU on which the IRQ was expected, but not generated.
+"to:" is the CPU on which the IRQ was generated, but not expected.
+
+reconnects (RW)
+---------------
+
+Contains 2 unsigned int values, the first one records number of successful
+reconnects in the path lifetime, the second one records number of failed
+reconnects in the path lifetime.
+
+rdma_lat (RW)
+-------------
+
+Latency distribution of IBTRS requests.
+The format is:
+   1 ms: <CNT-LAT-READ> <CNT-LAT-WRITE>
+   2 ms: <CNT-LAT-READ> <CNT-LAT-WRITE>
+   4 ms: <CNT-LAT-READ> <CNT-LAT-WRITE>
+   8 ms: <CNT-LAT-READ> <CNT-LAT-WRITE>
+  16 ms: <CNT-LAT-READ> <CNT-LAT-WRITE>
+  ...
+  65536 ms: <CNT-LAT-READ> <CNT-LAT-WRITE>
+  >= 65536 ms: <CNT-LAT-READ> <CNT-LAT-WRITE>
+  maximum ms: <CNT-LAT-READ> <CNT-LAT-WRITE>
+
+wc_completion (RW)
+------------------
+
+Contains 2 unsigned int values, the first one records max number of work
+requests processed in work_completion in session lifetime, the second
+one records average number of work requests processed in work_completion
+in session lifetime.
+
+rdma (RW)
+---------
+
+Contains statistics regarding rdma operations and inflight operations.
+The output consists of 6 values:
+
+<read-count> <read-total-size> <write-count> <write-total-size> \
+<inflights> <failovered>
+
+======================
+Server Sysfs Interface
+======================
+
+Entries under /sys/devices/virtual/ibtrs-server/
+================================================
+
+When a user of IBTRS API creates a new session on a client side, a
+directory entry with the name of that session is created in here.
+
+Entries under /sys/devices/virtual/ibtrs-server/<session-name>/paths/
+=====================================================================
+
+When new path is created by writing to "add_path" entry on client side,
+a directory entry named as <source address>@<destination address> is created
+on server.
+
+Entries under /sys/devices/virtual/ibtrs-server/<session-name>/paths/<src@dst>/
+===============================================================================
+
+disconnect (RW)
+---------------
+
+When "1" is written to the file, the IBTRS session is being disconnected.
+Operations is non-blocking and returns control immediately to the caller.
+
+hca_name (R)
+------------
+
+Contains the the name of HCA the connection established on.
+
+hca_port (R)
+------------
+
+Contains the port number of active port traffic is going through.
+
+src_addr (R)
+------------
+
+Contains the source address of the path
+
+dst_addr (R)
+------------
+
+Contains the destination address of the path
+
+Entries under /sys/devices/virtual/ibtrs-server/<session-name>/paths/<src@dst>/stats/
+=====================================================================================
+
+When "0" is written to a file in this directory, the corresponding counters
+will be reset.
+
+reset_all (RW)
+--------------
+
+Read will return usage help, write 0 will clear all the counters about
+stats.
+
+rdma (RW)
+---------
+
+Contains statistics regarding rdma operations and inflight operations.
+The output consists of 5 values:
+
+<read-count> <read-total-size> <write-count> <write-total-size> <inflights>
+
+wc_completion (RW)
+------------------
+
+Contains 3 values, the first one is int, records max number of work
+requests processed in work_completion in session lifetime, the second
+one long int records total number of work requests processed in
+work_completion in session lifetime and the 3rd one long int records
+total number of calls to the cq completion handler. Division of 2nd
+number through 3rd gives the average number of completions processed
+in completion handler.
+
+==================
+Transport protocol
+==================
+
+Overview
+--------
+An established connection between a client and a server is called ibtrs
+session. A session is associated with a set of memory chunks reserved on the
+server side for a given client for rdma transfer. A session
+consists of multiple paths, each representing a separate physical link
+between client and server. Those are used for load balancing and failover.
+Each path consists of as many connections (QPs) as there are cpus on
+the client.
+
+When processing an incoming rdma write or read request ibtrs client uses memory
+chunks reserved for him on the server side. Their number, size and addresses
+need to be exchanged between client and server during the connection
+establishment phase. Apart from the memory related information client needs to
+inform the server about the session name and identify each path and connection
+individually.
+
+On an established session client sends to server write or read messages.
+Server uses immediate field to tell the client which request is being
+acknowledged and for errno. Client uses immediate field to tell the server
+which of the memory chunks has been accessed and at which offset the message
+can be found.
+
+Connection establishment
+------------------------
+
+1. Client starts establishing connections belonging to a path of a session one
+by one via attaching IBTRS_MSG_CON_REQ messages to the rdma_connect requests.
+Those include uuid of the session and uuid of the path to be
+established. They are used by the server to find a persisting session/path or
+to create a new one when necessary. The message also contains the protocol
+version and magic for compatibility, total number of connections per session
+(as many as cpus on the client), the id of the current connection and
+the reconnect counter, which is used to resolve the situations where
+client is trying to reconnect a path, while server is still destroying the old
+one.
+
+2. Server accepts the connection requests one by one and attaches
+IBTRS_MSG_CONN_RSP messages to the rdma_accept. Apart from magic and
+protocol version, the messages include error code, queue depth supported by
+the server (number of memory chunks which are going to be allocated for that
+session) and the maximum size of one io.
+
+3. After all connections of a path are established client sends to server the
+IBTRS_MSG_INFO_REQ message, containing the name of the session. This message
+requests the address information from the server.
+
+4. Server replies to the session info request message with IBTRS_MSG_INFO_RSP,
+which contains the addresses and keys of the RDMA buffers allocated for that
+session.
+
+5. Session becomes connected after all paths to be established are connected
+(i.e. steps 1-4 finished for all paths requested for a session)
+
+6. Server and client exchange periodically heartbeat messages (empty rdma
+messages with an immediate field) which are used to detect a crash on remote
+side or network outage in an absence of IO.
+
+7. On any RDMA related error or in the case of a heartbeat timeout, the
+corresponding path is disconnected, all the inflight IO are failed over to a
+healthy path, if any, and the reconnect mechanism is triggered.
+
+CLT                                     SRV
+*for each connection belonging to a path and for each path:
+IBTRS_MSG_CON_REQ  ------------------->
+                   <------------------- IBTRS_MSG_CON_RSP
+...
+*after all connections are established:
+IBTRS_MSG_INFO_REQ ------------------->
+                   <------------------- IBTRS_MSG_INFO_RSP
+*heartbeat is started from both sides:
+                   -------------------> [IBTRS_HB_MSG_IMM]
+[IBTRS_HB_MSG_ACK] <-------------------
+[IBTRS_HB_MSG_IMM] <-------------------
+                   -------------------> [IBTRS_HB_MSG_ACK]
+
+IO path
+-------
+
+* Write *
+
+1. When processing a write request client selects one of the memory chunks
+on the server side and rdma writes there the user data, user header and the
+IBTRS_MSG_RDMA_WRITE message. Apart from the type (write), the message only
+contains size of the user header. The client tells the server which chunk has
+been accessed and at what offset the IBTRS_MSG_RDMA_WRITE can be found by
+using the IMM field.
+
+2. When confirming a write request server sends an "empty" rdma message with
+an immediate field. The 32 bit field is used to specify the outstanding
+inflight IO and for the error code.
+
+CLT                                                          SRV
+usr_data + usr_hdr + ibtrs_msg_rdma_write -----------------> [IBTRS_IO_REQ_IMM]
+[IBTRS_IO_RSP_IMM]                        <----------------- (id + errno)
+
+* Read *
+
+1. When processing a read request client selects one of the memory chunks
+on the server side and rdma writes there the user header and the
+IBTRS_MSG_RDMA_READ message. This message contains the type (read), size of
+the user header, flags (specifying if memory invalidation is necessary) and the
+list of addresses along with keys for the data to be read into.
+
+2. When confirming a read request server transfers the requested data first,
+attaches an invalidation message if requested and finally an "empty" rdma
+message with an immediate field. The 32 bit field is used to specify the
+outstanding inflight IO and the error code.
+
+CLT                                           SRV
+usr_hdr + ibtrs_msg_rdma_read --------------> [IBTRS_IO_REQ_IMM]
+[IBTRS_IO_RSP_IMM]            <-------------- usr_data + (id + errno)
+or in case client requested invalidation:
+[IBTRS_IO_RSP_IMM_W_INV]      <-------------- usr_data + (INV) + (id + errno)
+
-- 
2.17.1

