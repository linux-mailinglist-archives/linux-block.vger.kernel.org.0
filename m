Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF52E1C3F16
	for <lists+linux-block@lfdr.de>; Mon,  4 May 2020 17:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgEDPzB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 May 2020 11:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725941AbgEDPzB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 May 2020 11:55:01 -0400
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222BFC061A0E;
        Mon,  4 May 2020 08:55:01 -0700 (PDT)
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 1C45A2E14BE;
        Mon,  4 May 2020 18:54:59 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id unjaBONJEP-svAi9BRl;
        Mon, 04 May 2020 18:54:59 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588607699; bh=ENcg5Bf9VUdHKlHIUgm/DkthSsQoFPP4xREmFmfnUxI=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=PI2azLgj/qi1u4obicwsghWBMKHSF7d2CVimRri+0mk15qdEuEJw3kD6ayLzlDmfZ
         LRsGm2CP2MnHAvOPsI3QMnT5qQVWUJ5bMXxeU2IDl4VAZJzH63nXlsED2Hfd2Y9myf
         XjO8paKl1j+KQDJA6WQDIF2VvNKk5puP/QNTJWWY=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:409::1:8])
        by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id oIkNNHFTF1-svX88CIP;
        Mon, 04 May 2020 18:54:57 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH RFC 2/2] fs/direct-io: pass NOWAIT to also for read requests
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Date:   Mon, 04 May 2020 18:54:57 +0300
Message-ID: <158860769737.32485.3674517821826063792.stgit@buzz>
In-Reply-To: <158860769311.32485.8003552176738816448.stgit@buzz>
References: <158860769311.32485.8003552176738816448.stgit@buzz>
User-Agent: StGit/0.22-32-g6a05
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For some reason NOWAIT currently is passed only for writes.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Fixes: 03a07c92a9ed ("block: return on congested block device")
---
 fs/direct-io.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 00b4d15bb811..dbb6afef6be9 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1234,11 +1234,11 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	if (iov_iter_rw(iter) == WRITE) {
 		dio->op = REQ_OP_WRITE;
 		dio->op_flags = REQ_SYNC | REQ_IDLE;
-		if (iocb->ki_flags & IOCB_NOWAIT)
-			dio->op_flags |= REQ_NOWAIT;
 	} else {
 		dio->op = REQ_OP_READ;
 	}
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		dio->op_flags |= REQ_NOWAIT;
 	if (iocb->ki_flags & IOCB_HIPRI)
 		dio->op_flags |= REQ_HIPRI;
 

