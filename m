Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066F028CD11
	for <lists+linux-block@lfdr.de>; Tue, 13 Oct 2020 13:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgJML4b (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 13 Oct 2020 07:56:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbgJMLyt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:49 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C62622518;
        Tue, 13 Oct 2020 11:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590081;
        bh=vURsakoJx7789kBICOX+8pUBm2V03RF9X0CGqrvM0qA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2N+EjEfvBlBo3nSVPWwyNWr13FPak60CE6NtFsdRAaPEz0rN0ICQtS05oom+eKjV
         SQ57FyeFUJO0OLamoOialkxd/bBNXVG5NveQs2CO0Uz7kjJ9/KGsLI7zicxYHDLr5Z
         uqxqYIp5F6ard5j/xMHvQjqlR2VI23F7LHa/sC6I=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt5-006CW5-F7; Tue, 13 Oct 2020 13:54:39 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 62/80] docs: bio: fix a kerneldoc markup
Date:   Tue, 13 Oct 2020 13:54:17 +0200
Message-Id: <59415c83f2bc8a9f53cfb906017e0c3a8b5e9bf4.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix this warning:

	./block/bio.c:1098: WARNING: Inline emphasis start-string without end-string.

The thing is that *iter is not a valid markup.

That seems to be a typo:
	*iter -> @iter

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index cee87a9ff799..8dcb508b651c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1095,7 +1095,7 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
  * released.
  *
  * The function tries, but does not guarantee, to pin as many pages as
- * fit into the bio, or are requested in *iter, whatever is smaller. If
+ * fit into the bio, or are requested in @iter, whatever is smaller. If
  * MM encounters an error pinning the requested pages, it stops. Error
  * is returned only if 0 pages could be pinned.
  */
-- 
2.26.2

