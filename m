Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F45F5B38BB
	for <lists+linux-block@lfdr.de>; Fri,  9 Sep 2022 15:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiIINPZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 9 Sep 2022 09:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiIINPY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Sep 2022 09:15:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8916E59259
        for <linux-block@vger.kernel.org>; Fri,  9 Sep 2022 06:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ppgQW83oZ4SbZ6loJJPiD3epta/36/6Yg0HxALLev48=; b=s2EtgNhioXqYy6N3P+G0T5YkGm
        F08v7uQ16cxM5RhJpZ3nC8De1b9X/UWkJ04pEJpSI+7BVv0Aj6nfA+W04AID8StJr6CGfPV6K+0oV
        d3wDZsdvs4s7ZdIkQMubOiHdznk3ZOqsTOKEjDK0sGAUVl8fs4whTBJARlcHNK3Y5usjeu8cjpzsJ
        juRU8TC6QP/avogt8J6ZdzgPCF77OfQuPkV4XwIk2yzfu03dquE7fkAH83mWD9SBJlehDIX9ZCE4O
        eQhDPfgRwVqn1teRPWqjn8LQyBJjSI4ioW5ZS40XbO6Pxcl8IV7g4+FRY+wfLKxa9DJMQ8HdkcXGQ
        dH1yHbMQ==;
Received: from [2001:4bb8:198:38af:a077:6a38:dc23:be2c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWdqr-00GGuc-Tc; Fri, 09 Sep 2022 13:15:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/4] rnbd-srv: remove rnbd_endio
Date:   Fri,  9 Sep 2022 15:15:07 +0200
Message-Id: <20220909131509.3263924-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220909131509.3263924-1-hch@lst.de>
References: <20220909131509.3263924-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fold rnbd_endio into the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/block/rnbd/rnbd-srv-dev.h |  2 --
 drivers/block/rnbd/rnbd-srv.c     | 20 +++++++-------------
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv-dev.h b/drivers/block/rnbd/rnbd-srv-dev.h
index 8eeb3d607e7b5..328dc915832cd 100644
--- a/drivers/block/rnbd/rnbd-srv-dev.h
+++ b/drivers/block/rnbd/rnbd-srv-dev.h
@@ -29,6 +29,4 @@ struct rnbd_dev *rnbd_dev_open(const char *path, fmode_t flags);
  */
 void rnbd_dev_close(struct rnbd_dev *dev);
 
-void rnbd_endio(void *priv, int error);
-
 #endif /* RNBD_SRV_DEV_H */
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 735d3f8d923e4..d487281a37f85 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -85,18 +85,6 @@ static inline void rnbd_put_sess_dev(struct rnbd_srv_sess_dev *sess_dev)
 	kref_put(&sess_dev->kref, rnbd_sess_dev_release);
 }
 
-void rnbd_endio(void *priv, int error)
-{
-	struct rnbd_io_private *rnbd_priv = priv;
-	struct rnbd_srv_sess_dev *sess_dev = rnbd_priv->sess_dev;
-
-	rnbd_put_sess_dev(sess_dev);
-
-	rtrs_srv_resp_rdma(rnbd_priv->id, error);
-
-	kfree(priv);
-}
-
 static struct rnbd_srv_sess_dev *
 rnbd_get_sess_dev(int dev_id, struct rnbd_srv_session *srv_sess)
 {
@@ -117,7 +105,13 @@ rnbd_get_sess_dev(int dev_id, struct rnbd_srv_session *srv_sess)
 
 static void rnbd_dev_bi_end_io(struct bio *bio)
 {
-	rnbd_endio(bio->bi_private, blk_status_to_errno(bio->bi_status));
+	struct rnbd_io_private *rnbd_priv = bio->bi_private;
+	struct rnbd_srv_sess_dev *sess_dev = rnbd_priv->sess_dev;
+
+	rnbd_put_sess_dev(sess_dev);
+	rtrs_srv_resp_rdma(rnbd_priv->id, blk_status_to_errno(bio->bi_status));
+
+	kfree(rnbd_priv);
 	bio_put(bio);
 }
 
-- 
2.30.2

