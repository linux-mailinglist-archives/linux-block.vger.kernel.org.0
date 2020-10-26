Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939912998CB
	for <lists+linux-block@lfdr.de>; Mon, 26 Oct 2020 22:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388125AbgJZVbw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 26 Oct 2020 17:31:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387923AbgJZVbw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Oct 2020 17:31:52 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3697A207F7;
        Mon, 26 Oct 2020 21:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603747912;
        bh=RfaaRXXDypEyfGrWvZfAg+SElczaMQlEQ5YNcGDpRao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HaO9wKfnBQEhqzxbcvXQWCZkQT61uifKjtS2TlNL2jxYl/QBgN96WVqx5XzuSVvrl
         9P2JNjkliN/CVl1wFiRR+eJQUWsc++ZryEY8ZBgvVDFb1IDPG5lIdPXaI1DUWQXRVj
         +0NltgMWpfLu93k3QYq9n/89GsDnoKfnAzWqv5tM=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH net-next 03/11] rsxx: remove extraneous 'const' qualifier
Date:   Mon, 26 Oct 2020 22:29:50 +0100
Message-Id: <20201026213040.3889546-3-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201026213040.3889546-1-arnd@kernel.org>
References: <20201026213040.3889546-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The returned string from rsxx_card_state_to_str is 'const',
but the other qualifier doesn't change anything here except
causing a warning with 'clang -Wextra':

drivers/block/rsxx/core.c:393:21: warning: 'const' type qualifier on return type has no effect [-Wignored-qualifiers]
static const char * const rsxx_card_state_to_str(unsigned int state)

Fixes: f37912039eb0 ("block: IBM RamSan 70/80 trivial changes.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/rsxx/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index 63f549889f87..d0af46d7b681 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -390,7 +390,7 @@ static irqreturn_t rsxx_isr(int irq, void *pdata)
 }
 
 /*----------------- Card Event Handler -------------------*/
-static const char * const rsxx_card_state_to_str(unsigned int state)
+static const char *rsxx_card_state_to_str(unsigned int state)
 {
 	static const char * const state_strings[] = {
 		"Unknown", "Shutdown", "Starting", "Formatting",
-- 
2.27.0

