Return-Path: <linux-block+bounces-8251-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9828FC516
	for <lists+linux-block@lfdr.de>; Wed,  5 Jun 2024 09:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5097A1C21CEF
	for <lists+linux-block@lfdr.de>; Wed,  5 Jun 2024 07:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408DB18C334;
	Wed,  5 Jun 2024 07:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucWZJcqb"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1987A18F2D5;
	Wed,  5 Jun 2024 07:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573913; cv=none; b=fP+WWOqstOApwLJjRoHKElfjKQ6ABll8F26vq6u6En+ZDkRVE3voEsnLVD4hd8FRg9Tq/fPZ5SB8MhRfxOvh06zF2OzteOedRY4wJTAv+JTkrY0TT/oQzey6TkoYd9nmXh3p3/pteJQZAgh79qd+JFBTFGSWYPgZMaL7hC3pKZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573913; c=relaxed/simple;
	bh=YLLeAqo0oJNGbUIK+PqjgrRgbWDA3jO4XHY6G2Ud5sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e69ZfgxV9xgXPr2c9sJRi7O5TPJlp90ROStCrUUnMFivGqH+7tdfWOBCmL3sS7FtGsN2BCjUeFrQyu1h7Gt/9QqXgiMIMTUhJcCfTaWzJH7Bo2SQduP+DB9VIkA6Vq/u95gOcRS7mylOxTYVTzgB0Uf4KnUJF/LY7s2o7fRh7IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucWZJcqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6907BC3277B;
	Wed,  5 Jun 2024 07:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717573912;
	bh=YLLeAqo0oJNGbUIK+PqjgrRgbWDA3jO4XHY6G2Ud5sE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ucWZJcqbd922L74XSfTI+TbrdX4CQ5QGMTshGCSZdO1t5Hq7BLzcK1sdRIC7xcJM9
	 4rwjenws6NB7hrk7ERLY4mmNf5PJseF1rWx5JUadcncAxbwl0ePMnbCxks6dPPhEke
	 hIlqGT1qQ9t62C0x/HD2SW3jRU46IszCxN52UvBd9xcZ6pVDmsYZNBcxder8aApISP
	 1vpiUvvySoj8IcrMo/e3tEyFnsMYbtwBlaIlB3q6yDFZvAU96AzMtBBgylujkOd+4K
	 AIe0/Th76ZEiGkJ8VK2op/ttTQ8hzQh1ALUgxaJPL6ktcNZoigCqy7QEtCOewobfT8
	 00Febzh1OR9fA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Benjamin Marzinski <bmarzins@redhat.com>
Subject: [PATCH v4 3/3] dm: Remove unused macro DM_ZONE_INVALID_WP_OFST
Date: Wed,  5 Jun 2024 16:51:44 +0900
Message-ID: <20240605075144.153141-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240605075144.153141-1-dlemoal@kernel.org>
References: <20240605075144.153141-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the switch to using the zone append emulation of the block layer
zone write plugging, the macro DM_ZONE_INVALID_WP_OFST is no longer used
in dm-zone.c. Remove its definition.

Fixes: f211268ed1f9 ("dm: Use the block layer zone append emulation")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/md/dm-zone.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 1199804b05c5..164dc840d1f2 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -13,8 +13,6 @@
 
 #define DM_MSG_PREFIX "zone"
 
-#define DM_ZONE_INVALID_WP_OFST		UINT_MAX
-
 /*
  * For internal zone reports bypassing the top BIO submission path.
  */
-- 
2.45.1


