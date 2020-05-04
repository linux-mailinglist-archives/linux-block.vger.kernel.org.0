Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E201C3F14
	for <lists+linux-block@lfdr.de>; Mon,  4 May 2020 17:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgEDPy5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 May 2020 11:54:57 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:50070 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbgEDPy5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 May 2020 11:54:57 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 18D6F2E09E9;
        Mon,  4 May 2020 18:54:55 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id cnviD0Vdqo-srbWrmGi;
        Mon, 04 May 2020 18:54:55 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588607695; bh=0FKUDXZII6543UwYfLVn60N9RWRP2M0duzvLt3V5HU0=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=tAU9zHpBxpqFihRlc9C7NpH8T2004p5g5r8q3zRNcUk6xkE8jwnR0YReumnAHUR/k
         ornfqLVWTWhvjoHi1/rcjUn5koQ5NsvtE/Y8v7vSnqMebZ1be8Uya/E5HWC41EB6uR
         7WAX+PvsaZARkBXxDs0da+mf8StU0w+0NO3PHF0U=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:409::1:8])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id EpnOoMbJTQ-srWuiU9X;
        Mon, 04 May 2020 18:54:53 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH RFC 1/2] fs/iomap/direct-io: pass NOWAIT to bio flags
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Date:   Mon, 04 May 2020 18:54:53 +0300
Message-ID: <158860769311.32485.8003552176738816448.stgit@buzz>
User-Agent: StGit/0.22-32-g6a05
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is required to avoid waiting in lower layers.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 fs/iomap/direct-io.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 20dde5aadcdd..9b53fa7651e3 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -63,6 +63,8 @@ static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
 {
 	atomic_inc(&dio->ref);
 
+	if (dio->iocb->ki_flags & IOCB_NOWAIT)
+		bio->bi_opf |= REQ_NOWAIT;
 	if (dio->iocb->ki_flags & IOCB_HIPRI)
 		bio_set_polled(bio, dio->iocb);
 

