Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4B66DB4D9
	for <lists+linux-block@lfdr.de>; Fri,  7 Apr 2023 22:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjDGUIu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 7 Apr 2023 16:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjDGUIr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2023 16:08:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01404BBB8;
        Fri,  7 Apr 2023 13:08:45 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337Fwuxx017400;
        Fri, 7 Apr 2023 20:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=zsWPgf3lxVpJrhgy1Lk5+dJ1206CLLPepev3QZNrx94=;
 b=rNJ9w0V56pEEnggcEZR/QXOzgh6Dbx+fnHJPjzP5j9lzFcpKwC9bzZ2sD5eAr11ZoQA2
 6zCQ6yy2X/J5q09rVP1L4SINBJq7g9YjbeqKHSqD3eqz7hXWCv4mfj5B78GCEpzcGwzn
 eImRO7OaQsn2v7gV0zxkcgaCkTtBNGPbWGB9N/7oOMrJqAqw1+ejhNdHq5PkH+2oFs79
 ShiMEZeKBv1gYqCYLs/aXqIeRROWoq3Zqu9HP8LGJw9uTnVYCaMDW0LBalXTypteSMFj
 O1qpmO29pA/9Y58mRmJqI4JWY7EBrGSCDGV409Q/bgvlI+nlUJrXk/x3khfa96jeFJay 5w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcnd5wve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Apr 2023 20:06:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 337ISbGX034201;
        Fri, 7 Apr 2023 20:06:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjxef7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Apr 2023 20:06:32 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 337K5trK010228;
        Fri, 7 Apr 2023 20:06:32 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-128-1.vpn.oracle.com [10.154.128.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pptjxeeam-15;
        Fri, 07 Apr 2023 20:06:32 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        snitzer@kernel.org, axboe@kernel.dk,
        linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
        kbusch@kernel.org, target-devel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v6 14/18] scsi: target: Rename sbc_ops to exec_cmd_ops
Date:   Fri,  7 Apr 2023 15:05:47 -0500
Message-Id: <20230407200551.12660-15-michael.christie@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230407200551.12660-1-michael.christie@oracle.com>
References: <20230407200551.12660-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070180
X-Proofpoint-GUID: UaehV3dzj317zY9L7Yce8rO9Htg6khhS
X-Proofpoint-ORIG-GUID: UaehV3dzj317zY9L7Yce8rO9Htg6khhS
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The next patches allow us to call the block layer's pr_ops from the
backends. This will require allowing the backends to hook into the cmd
processing for SPC commands, so this renames sbc_ops to a more generic
exec_cmd_ops.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/target/target_core_file.c    |  4 ++--
 drivers/target/target_core_iblock.c  |  4 ++--
 drivers/target/target_core_rd.c      |  4 ++--
 drivers/target/target_core_sbc.c     | 13 +++++++------
 drivers/target/target_core_spc.c     |  4 ++--
 include/target/target_core_backend.h |  4 ++--
 6 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index ce0e000b74fc..4d447520bab8 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -896,7 +896,7 @@ static void fd_free_prot(struct se_device *dev)
 	fd_dev->fd_prot_file = NULL;
 }
 
-static struct sbc_ops fd_sbc_ops = {
+static struct exec_cmd_ops fd_exec_cmd_ops = {
 	.execute_rw		= fd_execute_rw,
 	.execute_sync_cache	= fd_execute_sync_cache,
 	.execute_write_same	= fd_execute_write_same,
@@ -906,7 +906,7 @@ static struct sbc_ops fd_sbc_ops = {
 static sense_reason_t
 fd_parse_cdb(struct se_cmd *cmd)
 {
-	return sbc_parse_cdb(cmd, &fd_sbc_ops);
+	return sbc_parse_cdb(cmd, &fd_exec_cmd_ops);
 }
 
 static const struct target_backend_ops fileio_ops = {
diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index cc838ffd1294..d93f24f9687d 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -869,7 +869,7 @@ static unsigned int iblock_get_io_opt(struct se_device *dev)
 	return bdev_io_opt(bd);
 }
 
-static struct sbc_ops iblock_sbc_ops = {
+static struct exec_cmd_ops iblock_exec_cmd_ops = {
 	.execute_rw		= iblock_execute_rw,
 	.execute_sync_cache	= iblock_execute_sync_cache,
 	.execute_write_same	= iblock_execute_write_same,
@@ -879,7 +879,7 @@ static struct sbc_ops iblock_sbc_ops = {
 static sense_reason_t
 iblock_parse_cdb(struct se_cmd *cmd)
 {
-	return sbc_parse_cdb(cmd, &iblock_sbc_ops);
+	return sbc_parse_cdb(cmd, &iblock_exec_cmd_ops);
 }
 
 static bool iblock_get_write_cache(struct se_device *dev)
diff --git a/drivers/target/target_core_rd.c b/drivers/target/target_core_rd.c
index 6648c1c90e19..6f67cc09c2b5 100644
--- a/drivers/target/target_core_rd.c
+++ b/drivers/target/target_core_rd.c
@@ -643,14 +643,14 @@ static void rd_free_prot(struct se_device *dev)
 	rd_release_prot_space(rd_dev);
 }
 
-static struct sbc_ops rd_sbc_ops = {
+static struct exec_cmd_ops rd_exec_cmd_ops = {
 	.execute_rw		= rd_execute_rw,
 };
 
 static sense_reason_t
 rd_parse_cdb(struct se_cmd *cmd)
 {
-	return sbc_parse_cdb(cmd, &rd_sbc_ops);
+	return sbc_parse_cdb(cmd, &rd_exec_cmd_ops);
 }
 
 static const struct target_backend_ops rd_mcp_ops = {
diff --git a/drivers/target/target_core_sbc.c b/drivers/target/target_core_sbc.c
index 7536ca797606..6a02561cc20c 100644
--- a/drivers/target/target_core_sbc.c
+++ b/drivers/target/target_core_sbc.c
@@ -192,7 +192,7 @@ EXPORT_SYMBOL(sbc_get_write_same_sectors);
 static sense_reason_t
 sbc_execute_write_same_unmap(struct se_cmd *cmd)
 {
-	struct sbc_ops *ops = cmd->protocol_data;
+	struct exec_cmd_ops *ops = cmd->protocol_data;
 	sector_t nolb = sbc_get_write_same_sectors(cmd);
 	sense_reason_t ret;
 
@@ -271,7 +271,8 @@ static inline unsigned long long transport_lba_64(unsigned char *cdb)
 }
 
 static sense_reason_t
-sbc_setup_write_same(struct se_cmd *cmd, unsigned char flags, struct sbc_ops *ops)
+sbc_setup_write_same(struct se_cmd *cmd, unsigned char flags,
+		     struct exec_cmd_ops *ops)
 {
 	struct se_device *dev = cmd->se_dev;
 	sector_t end_lba = dev->transport->get_blocks(dev) + 1;
@@ -340,7 +341,7 @@ sbc_setup_write_same(struct se_cmd *cmd, unsigned char flags, struct sbc_ops *op
 static sense_reason_t
 sbc_execute_rw(struct se_cmd *cmd)
 {
-	struct sbc_ops *ops = cmd->protocol_data;
+	struct exec_cmd_ops *ops = cmd->protocol_data;
 
 	return ops->execute_rw(cmd, cmd->t_data_sg, cmd->t_data_nents,
 			       cmd->data_direction);
@@ -566,7 +567,7 @@ static sense_reason_t compare_and_write_callback(struct se_cmd *cmd, bool succes
 static sense_reason_t
 sbc_compare_and_write(struct se_cmd *cmd)
 {
-	struct sbc_ops *ops = cmd->protocol_data;
+	struct exec_cmd_ops *ops = cmd->protocol_data;
 	struct se_device *dev = cmd->se_dev;
 	sense_reason_t ret;
 	int rc;
@@ -764,7 +765,7 @@ sbc_check_dpofua(struct se_device *dev, struct se_cmd *cmd, unsigned char *cdb)
 }
 
 sense_reason_t
-sbc_parse_cdb(struct se_cmd *cmd, struct sbc_ops *ops)
+sbc_parse_cdb(struct se_cmd *cmd, struct exec_cmd_ops *ops)
 {
 	struct se_device *dev = cmd->se_dev;
 	unsigned char *cdb = cmd->t_task_cdb;
@@ -1076,7 +1077,7 @@ EXPORT_SYMBOL(sbc_get_device_type);
 static sense_reason_t
 sbc_execute_unmap(struct se_cmd *cmd)
 {
-	struct sbc_ops *ops = cmd->protocol_data;
+	struct exec_cmd_ops *ops = cmd->protocol_data;
 	struct se_device *dev = cmd->se_dev;
 	unsigned char *buf, *ptr = NULL;
 	sector_t lba;
diff --git a/drivers/target/target_core_spc.c b/drivers/target/target_core_spc.c
index fcc7b10a7ae3..00d34616df5d 100644
--- a/drivers/target/target_core_spc.c
+++ b/drivers/target/target_core_spc.c
@@ -1431,7 +1431,7 @@ static struct target_opcode_descriptor tcm_opcode_write_verify16 = {
 
 static bool tcm_is_ws_enabled(struct se_cmd *cmd)
 {
-	struct sbc_ops *ops = cmd->protocol_data;
+	struct exec_cmd_ops *ops = cmd->protocol_data;
 	struct se_device *dev = cmd->se_dev;
 
 	return (dev->dev_attrib.emulate_tpws && !!ops->execute_unmap) ||
@@ -1544,7 +1544,7 @@ static struct target_opcode_descriptor tcm_opcode_sync_cache16 = {
 
 static bool tcm_is_unmap_enabled(struct se_cmd *cmd)
 {
-	struct sbc_ops *ops = cmd->protocol_data;
+	struct exec_cmd_ops *ops = cmd->protocol_data;
 	struct se_device *dev = cmd->se_dev;
 
 	return ops->execute_unmap && dev->dev_attrib.emulate_tpu;
diff --git a/include/target/target_core_backend.h b/include/target/target_core_backend.h
index a3c193df25b3..c5df78959532 100644
--- a/include/target/target_core_backend.h
+++ b/include/target/target_core_backend.h
@@ -62,7 +62,7 @@ struct target_backend_ops {
 	struct configfs_attribute **tb_dev_action_attrs;
 };
 
-struct sbc_ops {
+struct exec_cmd_ops {
 	sense_reason_t (*execute_rw)(struct se_cmd *cmd, struct scatterlist *,
 				     u32, enum dma_data_direction);
 	sense_reason_t (*execute_sync_cache)(struct se_cmd *cmd);
@@ -86,7 +86,7 @@ sense_reason_t	spc_emulate_report_luns(struct se_cmd *cmd);
 sense_reason_t	spc_emulate_inquiry_std(struct se_cmd *, unsigned char *);
 sense_reason_t	spc_emulate_evpd_83(struct se_cmd *, unsigned char *);
 
-sense_reason_t	sbc_parse_cdb(struct se_cmd *cmd, struct sbc_ops *ops);
+sense_reason_t	sbc_parse_cdb(struct se_cmd *cmd, struct exec_cmd_ops *ops);
 u32	sbc_get_device_rev(struct se_device *dev);
 u32	sbc_get_device_type(struct se_device *dev);
 sector_t	sbc_get_write_same_sectors(struct se_cmd *cmd);
-- 
2.25.1

