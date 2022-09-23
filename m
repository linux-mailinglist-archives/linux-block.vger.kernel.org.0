Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B6A5E73D1
	for <lists+linux-block@lfdr.de>; Fri, 23 Sep 2022 08:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiIWGRn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 23 Sep 2022 02:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiIWGRm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 02:17:42 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440541176CA;
        Thu, 22 Sep 2022 23:17:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQVS12A_1663913802;
Received: from localhost.localdomain(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VQVS12A_1663913802)
          by smtp.aliyun-inc.com;
          Fri, 23 Sep 2022 14:17:38 +0800
From:   ZiyangZhang <ZiyangZhang@linux.alibaba.com>
To:     ming.lei@redhat.com
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: [RESEND PATCH V5 6/7] ublk_drv: add START_USER_RECOVERY and END_USER_RECOVERY support
Date:   Fri, 23 Sep 2022 14:15:04 +0800
Message-Id: <20220923061505.52007-7-ZiyangZhang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220923061505.52007-1-ZiyangZhang@linux.alibaba.com>
References: <20220923061505.52007-1-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

START_USER_RECOVERY and END_USER_RECOVERY are two new control commands
to support user recovery feature.

After a crash, user should send START_USER_RECOVERY, it will:
(1) check if (a)current ublk_device is UBLK_S_DEV_QUIESCED which was
    set by quiesce_work and (b)chardev is released
(2) reinit all ubqs, including:
    (a) put the task_struct and reset ->ubq_daemon to NULL.
    (b) reset all ublk_io.
(3) reset ub->mm to NULL.

Then, user should start a new process and send FETCH_REQ on each
ubq_daemon.

Finally, user should send END_USER_RECOVERY, it will:
(1) wait for all new ubq_daemons getting ready.
(2) update ublksrv_pid
(3) unquiesce the request queue and expect incoming ublk_queue_rq()
(4) convert ub's state to UBLK_S_DEV_LIVE

Note: we can handle STOP_DEV between START_USER_RECOVERY and
END_USER_RECOVERY. This is helpful to users who cannot start new process
after sending START_USER_RECOVERY ctrl-cmd.

Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
---
 drivers/block/ublk_drv.c      | 116 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/ublk_cmd.h |   3 +-
 2 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3d7b067e0b99..f31d80f66fd6 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1862,6 +1862,116 @@ static int ublk_ctrl_set_params(struct io_uring_cmd *cmd)
 	return ret;
 }
 
+static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
+{
+	int i;
+
+	WARN_ON_ONCE(!(ubq->ubq_daemon && ubq_daemon_is_dying(ubq)));
+	/* All old ioucmds have to be completed */
+	WARN_ON_ONCE(ubq->nr_io_ready);
+	/* old daemon is PF_EXITING, put it now */
+	put_task_struct(ubq->ubq_daemon);
+	/* We have to reset it to NULL, otherwise ub won't accept new FETCH_REQ */
+	ubq->ubq_daemon = NULL;
+
+	for (i = 0; i < ubq->q_depth; i++) {
+		struct ublk_io *io = &ubq->ios[i];
+
+		/* forget everything now and be ready for new FETCH_REQ */
+		io->flags = 0;
+		io->cmd = NULL;
+		io->addr = 0;
+	}
+}
+
+static int ublk_ctrl_start_recovery(struct io_uring_cmd *cmd)
+{
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	struct ublk_device *ub;
+	int ret = -EINVAL;
+	int i;
+
+	ub = ublk_get_device_from_id(header->dev_id);
+	if (!ub)
+		return ret;
+
+	mutex_lock(&ub->mutex);
+	if (!ublk_can_use_recovery(ub))
+		goto out_unlock;
+	/*
+	 * START_RECOVERY is only allowd after:
+	 *
+	 * (1) UB_STATE_OPEN is not set, which means the dying process is exited
+	 *     and related io_uring ctx is freed so file struct of /dev/ublkcX is
+	 *     released.
+	 *
+	 * (2) UBLK_S_DEV_QUIESCED is set, which means the quiesce_work:
+	 *     (a)has quiesced request queue
+	 *     (b)has requeued every inflight rqs whose io_flags is ACTIVE
+	 *     (c)has requeued/aborted every inflight rqs whose io_flags is NOT ACTIVE
+	 *     (d)has completed/camceled all ioucmds owned by ther dying process
+	 */
+	if (test_bit(UB_STATE_OPEN, &ub->state) ||
+			ub->dev_info.state != UBLK_S_DEV_QUIESCED) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	pr_devel("%s: start recovery for dev id %d.\n", __func__, header->dev_id);
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
+	/* set to NULL, otherwise new ubq_daemon cannot mmap the io_cmd_buf */
+	ub->mm = NULL;
+	ub->nr_queues_ready = 0;
+	init_completion(&ub->completion);
+	ret = 0;
+ out_unlock:
+	mutex_unlock(&ub->mutex);
+	ublk_put_device(ub);
+	return ret;
+}
+
+static int ublk_ctrl_end_recovery(struct io_uring_cmd *cmd)
+{
+	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
+	int ublksrv_pid = (int)header->data[0];
+	struct ublk_device *ub;
+	int ret = -EINVAL;
+
+	ub = ublk_get_device_from_id(header->dev_id);
+	if (!ub)
+		return ret;
+
+	pr_devel("%s: Waiting for new ubq_daemons(nr: %d) are ready, dev id %d...\n",
+			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
+	/* wait until new ubq_daemon sending all FETCH_REQ */
+	wait_for_completion_interruptible(&ub->completion);
+	pr_devel("%s: All new ubq_daemons(nr: %d) are ready, dev id %d\n",
+			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
+
+	mutex_lock(&ub->mutex);
+	if (!ublk_can_use_recovery(ub))
+		goto out_unlock;
+
+	if (ub->dev_info.state != UBLK_S_DEV_QUIESCED) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	ub->dev_info.ublksrv_pid = ublksrv_pid;
+	pr_devel("%s: new ublksrv_pid %d, dev id %d\n",
+			__func__, ublksrv_pid, header->dev_id);
+	blk_mq_unquiesce_queue(ub->ub_disk->queue);
+	pr_devel("%s: queue unquiesced, dev id %d.\n",
+			__func__, header->dev_id);
+	blk_mq_kick_requeue_list(ub->ub_disk->queue);
+	ub->dev_info.state = UBLK_S_DEV_LIVE;
+	schedule_delayed_work(&ub->monitor_work, UBLK_DAEMON_MONITOR_PERIOD);
+	ret = 0;
+ out_unlock:
+	mutex_unlock(&ub->mutex);
+	ublk_put_device(ub);
+	return ret;
+}
+
 static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
@@ -1903,6 +2013,12 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 	case UBLK_CMD_SET_PARAMS:
 		ret = ublk_ctrl_set_params(cmd);
 		break;
+	case UBLK_CMD_START_USER_RECOVERY:
+		ret = ublk_ctrl_start_recovery(cmd);
+		break;
+	case UBLK_CMD_END_USER_RECOVERY:
+		ret = ublk_ctrl_end_recovery(cmd);
+		break;
 	default:
 		break;
 	}
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 332370628757..8f88e3a29998 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -17,7 +17,8 @@
 #define	UBLK_CMD_STOP_DEV	0x07
 #define	UBLK_CMD_SET_PARAMS	0x08
 #define	UBLK_CMD_GET_PARAMS	0x09
-
+#define	UBLK_CMD_START_USER_RECOVERY	0x10
+#define	UBLK_CMD_END_USER_RECOVERY	0x11
 /*
  * IO commands, issued by ublk server, and handled by ublk driver.
  *
-- 
2.27.0

