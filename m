Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C12BF106556
	for <lists+linux-block@lfdr.de>; Fri, 22 Nov 2019 07:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfKVFvh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 22 Nov 2019 00:51:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728200AbfKVFvg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Nov 2019 00:51:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A9312068E;
        Fri, 22 Nov 2019 05:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401896;
        bh=3STd+I0ZH/0LNTU+Yvg39crAO7P5nDqtGIPmBwkDu20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RyNXQ6BtGSEOPCPc+bVanQCCWoiKOtuqtwcooMW1nRvGnKEZpZXkmLg6BT6lZc24a
         5pGfeM3bmtRge16jbJx1nNbo1PCA0EjU0z3LQBL1Igini9G72WkIjN7wGgyqi6iwe+
         2QKWytmRho7r422mQ2MbvD8+/282lUH7vK9hqdVI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Roland Kammerer <roland.kammerer@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 128/219] drbd: fix print_st_err()'s prototype to match the definition
Date:   Fri, 22 Nov 2019 00:47:40 -0500
Message-Id: <20191122054911.1750-121-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

[ Upstream commit 2c38f035117331eb78d0504843c79ea7c7fabf37 ]

print_st_err() is defined with its 4th argument taking an
'enum drbd_state_rv' but its prototype use an int for it.

Fix this by using 'enum drbd_state_rv' in the prototype too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Roland Kammerer <roland.kammerer@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/drbd/drbd_state.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_state.h
index ea58301d0895c..b2a390ba73a05 100644
--- a/drivers/block/drbd/drbd_state.h
+++ b/drivers/block/drbd/drbd_state.h
@@ -131,7 +131,7 @@ extern enum drbd_state_rv _drbd_set_state(struct drbd_device *, union drbd_state
 					  enum chg_state_flags,
 					  struct completion *done);
 extern void print_st_err(struct drbd_device *, union drbd_state,
-			union drbd_state, int);
+			union drbd_state, enum drbd_state_rv);
 
 enum drbd_state_rv
 _conn_request_state(struct drbd_connection *connection, union drbd_state mask, union drbd_state val,
-- 
2.20.1

