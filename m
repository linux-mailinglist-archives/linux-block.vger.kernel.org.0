Return-Path: <linux-block+bounces-40-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A76A27E50D0
	for <lists+linux-block@lfdr.de>; Wed,  8 Nov 2023 08:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36FF8B20D7E
	for <lists+linux-block@lfdr.de>; Wed,  8 Nov 2023 07:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3E6D26C;
	Wed,  8 Nov 2023 07:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KqM1BXo8"
X-Original-To: linux-block@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72484D266
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 07:10:41 +0000 (UTC)
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6278910D3
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 23:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1699427438; bh=jwb1s6BdmK/eBLbgQTraLTMZRylWtwUjWZChOl9ziE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KqM1BXo84eqz6yhrukTtR3XVKh91BSPQ4yu9DNYy/TIP6wvoiMPem0wSUJQe29aHE
	 x+F06XknIUT48R+nKxXqQW6rfjbN6aAp+wlaVBSA9Fm63mAf2ml0grDU7ru9hw/DyT
	 mT5YJSmQiLPo29PS2LUfmNGpkBg82Usn3zHg3kqk=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id EE7AE8A2; Wed, 08 Nov 2023 14:59:39 +0800
X-QQ-mid: xmsmtpt1699426779t7xjzjoo0
Message-ID: <tencent_6E1A9EAE1BB04B3A1B592506BAEABB313308@qq.com>
X-QQ-XMAILINFO: OW5M9fEmm+WRH3xryyrai3s7qa0iRol32PfZBYEBMOQnrm7zZNGnz77lFag3cq
	 BWQpTZCiZGxv/Ld7TqpZTLSJca8vRD3fTclJoM99K308NtToQ/TKnR9AU6vj41N2UbL1i2yK6Da5
	 E7B7TWTBBbrb4SzMPk/shV/tJL5TAaUG/i0qkqWiz+ACT/d6ZjyuR/hJUU0WMwZkWSRVcs80fTBB
	 ZygS/DORRY/1mxn7vA5KckVtE7SYwy6ZlQxviuYt+FaZMYtSMBAg7F3OrW96XzKQQfXTmeUg2yaf
	 +NFpyYFIRiTjoFcn6RfAEdThPdwUfX7DTiAUeT91zyzt+oMFyKTnl02gHn91mDraNh7Co3lYlk8P
	 WwOCTSuEIEmmW2/MIBiZ7WEgIjLJS1FLzoTu/Zs/q6ajOvzb7J+pwO5AOOGyT2Hh3Laky1FH33bz
	 SEL0iC1gtnycAKe2IYStYIvfy8Mv3o/zADFZOAhiwfj5VOjmA/RvMCQcToZEPxhELBc/3eP7hls1
	 vvoyL4jXKuQ9asZGanevmX1wteknFb98beXnOcd7kqtAEyp5h5TVzWdjj42kH5z+h6TCRnu3T/QL
	 0Bt8+rvI9HS6xFM9JXnbvrUIOXs0UED96nCSNjm+klgsPeJNwU4VPWKtQbjxKNRVIo3r45gUEEyo
	 k6ZoT6Rq9SfsRsDhN5B9QZjWjrez0st75frGnWeo1uVNub3tFJjB/Th2lgYW9J4HoeiVqEa2sQ4B
	 YKHCf26XAPmPTUJP4q274cbP3PjgvjD0kexKZ2OAIlZK6Z7D8T3shb4vwl0EfSlkeJIJ3b6sQiS6
	 40lQfJplsT/06vc9nk0drEuIBtNBnFjJ37kGw+Py4mQ6/KP8yg+Sac4NGDrwZupKoDj+QXrinOBo
	 7Q5HAiq0XOvsgUZcp5h01xjrKHenmF9gSWZPi8kY+2W4OlXuzmKCG5tWGIYAILGCNVR9iWVnfbnU
	 8mHY/uiJJBnLNPtAfygY8FkHfnb3rcoSdqqDAxfH1Ws7aH5UfSsg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: bvanassche@acm.org
Cc: axboe@kernel.dk,
	eadavis@qq.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V2] blk-mq: fix warning in blk_mq_start_request
Date: Wed,  8 Nov 2023 14:59:40 +0800
X-OQ-MSGID: <20231108065939.1489316-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <25a94b23-b42b-49fc-a1c8-3e635f536aae@acm.org>
References: <25a94b23-b42b-49fc-a1c8-3e635f536aae@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before call queue_rq(), initialize rq->state to MQ_RQ_IDLE.

Reported-and-tested-by: syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 block/blk-mq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e2d11183f62e..26f2921cbc50 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2575,6 +2575,8 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	 * Any other error (busy), just add it to our list as we
 	 * previously would have done.
 	 */
+	if (READ_ONCE(rq->state))
+		WRITE_ONCE(rq->state, MQ_RQ_IDLE);
 	ret = q->mq_ops->queue_rq(hctx, &bd);
 	switch (ret) {
 	case BLK_STS_OK:
-- 
2.25.1


