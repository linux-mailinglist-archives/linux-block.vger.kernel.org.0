Return-Path: <linux-block+bounces-2976-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF1084B628
	for <lists+linux-block@lfdr.de>; Tue,  6 Feb 2024 14:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20F011F24F71
	for <lists+linux-block@lfdr.de>; Tue,  6 Feb 2024 13:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E26130E5F;
	Tue,  6 Feb 2024 13:17:07 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFB812FF91
	for <linux-block@vger.kernel.org>; Tue,  6 Feb 2024 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225427; cv=none; b=Y+TA0Ap9m6NiwGDqsvTxtE5QSDC8NI8VTcI9O4x+YEo7uyotWpmFibbx3gIbr4/AzeTb/OJcQFbch9aJWsCQS6WktvzX+qeZ5MrbxI/feJvSDpYAoyv2PjXuWB+8K95wkOv1CQMbrFX+EJHgIwVvdQsrEsEPFjgi/6qfegA56mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225427; c=relaxed/simple;
	bh=Cz7Vnm/V1Q76FHuq87QRBY8MfWmhKX8yFZHCQ2vvOlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ni1W0PrqYxqBgmhz5onyA8bHkUZMGoQR6sT5wkPnkawatPub9ecuIaeSAbeN0P9Jl6nwyxXhDLMX1PF6/vjh0zYZCMAxtqktvJv6fJvsV54QWjM4FCHwTryuRKOvouGqhOLDtIJqFOvzOuMmVUB04RwghUWxPS4UZO801Fg1obU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 85627221A7;
	Tue,  6 Feb 2024 13:17:04 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6705F132DD;
	Tue,  6 Feb 2024 13:17:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eil7F1AxwmVxOgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 06 Feb 2024 13:17:04 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 1/5] nvme/029: fix local variable declarations
Date: Tue,  6 Feb 2024 14:16:51 +0100
Message-ID: <20240206131655.32050-2-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206131655.32050-1-dwagner@suse.de>
References: <20240206131655.32050-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 85627221A7
X-Spam-Flag: NO

The syntax for local variables declarations uses whitespace as separator
and not commas:

tests/nvme/029: line 24: local: `bs,': not a valid identifier
tests/nvme/029: line 24: local: `size,': not a valid identifier
tests/nvme/029: line 24: local: `img,': not a valid identifier

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/029 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/029 b/tests/nvme/029
index caed0f7ec476..db6e8b91f707 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -21,7 +21,7 @@ test_user_io()
 	local disk="$1"
 	local start=$2
 	local cnt=$3
-	local bs, size, img, img1
+	local bs size img img1
 
 	bs="$(blockdev --getss "$disk")"
 	size=$((cnt * bs))
-- 
2.43.0


