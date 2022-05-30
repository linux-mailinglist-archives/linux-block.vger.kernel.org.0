Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF12538294
	for <lists+linux-block@lfdr.de>; Mon, 30 May 2022 16:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239444AbiE3OYh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 30 May 2022 10:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242231AbiE3OSe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 May 2022 10:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0438611CB79;
        Mon, 30 May 2022 06:49:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79F6760F24;
        Mon, 30 May 2022 13:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF80FC3411C;
        Mon, 30 May 2022 13:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653918539;
        bh=Tda2yIK/e/Kan92RH1YHYbg3Uneascketgw7j/W6VgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MX0euYwhwkShw3pc0PsOJz6iJlghB8gfNZgIGvHsyRtWGgVJxSS1xX7AVsnGi9E9i
         mMi1gGgQ1Ekr2S0hobeM6C7GvUG05vPLy81GbHLIwz9w1KiLSUI6ptQgkPzbn1XMZG
         99vZNquxTLQRTTWjz2XWq0MTLA2FjDDt597BmNZTBoRJINWAq9elptNNtmTjKbiEv6
         NkqOFWAWLynN7OUMvHUTEdk7v6jgQYa6ARLBFC676VipZ5Bus8Nt+B9VezQjaKtXmy
         YPCvT84ttk/IGO6bQc0ZP8ThLGfXNVz4yG5AnvXynjFoSKYzv6yV1GwNw0EcT6aveN
         EkMR7u34Fku8A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xie Yongji <xieyongji@bytedance.com>,
        Xu Jianhai <zero.xu@bytedance.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH AUTOSEL 5.4 47/55] nbd: Fix hung on disconnect request if socket is closed before
Date:   Mon, 30 May 2022 09:46:53 -0400
Message-Id: <20220530134701.1935933-47-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220530134701.1935933-1-sashal@kernel.org>
References: <20220530134701.1935933-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xie Yongji <xieyongji@bytedance.com>

[ Upstream commit 491bf8f236fdeec698fa6744993f1ecf3fafd1a5 ]

When userspace closes the socket before sending a disconnect
request, the following I/O requests will be blocked in
wait_for_reconnect() until dead timeout. This will cause the
following disconnect request also hung on blk_mq_quiesce_queue().
That means we have no way to disconnect a nbd device if there
are some I/O requests waiting for reconnecting until dead timeout.
It's not expected. So let's wake up the thread waiting for
reconnecting directly when a disconnect request is sent.

Reported-by: Xu Jianhai <zero.xu@bytedance.com>
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Link: https://lore.kernel.org/r/20220322080639.142-1-xieyongji@bytedance.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 25e81b1a59a5..510e75435c43 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -865,11 +865,15 @@ static int wait_for_reconnect(struct nbd_device *nbd)
 	struct nbd_config *config = nbd->config;
 	if (!config->dead_conn_timeout)
 		return 0;
-	if (test_bit(NBD_RT_DISCONNECTED, &config->runtime_flags))
+
+	if (!wait_event_timeout(config->conn_wait,
+				test_bit(NBD_RT_DISCONNECTED,
+					 &config->runtime_flags) ||
+				atomic_read(&config->live_connections) > 0,
+				config->dead_conn_timeout))
 		return 0;
-	return wait_event_timeout(config->conn_wait,
-				  atomic_read(&config->live_connections) > 0,
-				  config->dead_conn_timeout) > 0;
+
+	return !test_bit(NBD_RT_DISCONNECTED, &config->runtime_flags);
 }
 
 static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
@@ -2014,6 +2018,7 @@ static void nbd_disconnect_and_put(struct nbd_device *nbd)
 	mutex_lock(&nbd->config_lock);
 	nbd_disconnect(nbd);
 	sock_shutdown(nbd);
+	wake_up(&nbd->config->conn_wait);
 	/*
 	 * Make sure recv thread has finished, so it does not drop the last
 	 * config ref and try to destroy the workqueue from inside the work
-- 
2.35.1

