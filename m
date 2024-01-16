Return-Path: <linux-block+bounces-1892-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6BE82FA7B
	for <lists+linux-block@lfdr.de>; Tue, 16 Jan 2024 22:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EC92B23748
	for <lists+linux-block@lfdr.de>; Tue, 16 Jan 2024 21:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467B3153503;
	Tue, 16 Jan 2024 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G52QtEOp"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4CE35297;
	Tue, 16 Jan 2024 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435174; cv=none; b=UML5swH86y0FFM2zdW5ecriqSauNInRZZDkXFfs9jaMOikiHodCE6WkoXxgtrb7rL2JC8e5mrW210+GFAu1Z2ubn/Xi+iwXQjQ53sf6r0EG2uz61xP+FR19S348PBEhc98RfdBbBolBYA+J0Ly48BjpsGdaBcI9G2YU+i0qA740=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435174; c=relaxed/simple;
	bh=a+KrDWCnpTc9Oe+bt3uIiX6ilR1oCzG95M1fdhNxqIk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=tL5fzWxrk1PGsWuJMSsuN9NWXm9w6QgJrlb15ZcGIXHo4R65BsuablAIDtWNUEvU2Hxhj0IWvQRvSt3FPlF/Iiioaau+1EffAokzkJnDeEtB5ZkUQvJ0UsOhw4HtyxZaxit1JPbaHm4rQDNaoA8ar74J3VWHA7ebK/BngUcUYtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G52QtEOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCFBC43399;
	Tue, 16 Jan 2024 19:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435174;
	bh=a+KrDWCnpTc9Oe+bt3uIiX6ilR1oCzG95M1fdhNxqIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G52QtEOpBNCRBFyoec/Z8lC9wazfL4YmAnUZq0eRUtTXqGSomH+ops0jfUrvko97o
	 2d56epKApuZaQadF5BtPAhTTOzM9WloX6tkLgW9wLPX44WgJy5jX1o4XibdyaP8ZZ/
	 4211PgdF13GURrq4odLJyJF5Uw66YaT7QrPIXy8iyuWB1a33AzUhms83oxgLHXLKVV
	 aVaHNvnmSBal6r0xB8GWyBgN/5+fEX4w4eIf/H5fRMOqc9RnHucPjeb1Z+t41LDnI5
	 8BaSHCeY3ujNUVhwXsbEtsB/P4HK+rwMWFUt3lxlhvpkHf6uvGLRv1qKPI43f61+FO
	 znWycG89zbvJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	kernel test robot <lkp@intel.com>,
	"Md . Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 27/47] block/rnbd-srv: Check for unlikely string overflow
Date: Tue, 16 Jan 2024 14:57:30 -0500
Message-ID: <20240116195834.257313-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195834.257313-1-sashal@kernel.org>
References: <20240116195834.257313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 9e4bf6a08d1e127bcc4bd72557f2dfafc6bc7f41 ]

Since "dev_search_path" can technically be as large as PATH_MAX,
there was a risk of truncation when copying it and a second string
into "full_path" since it was also PATH_MAX sized. The W=1 builds were
reporting this warning:

drivers/block/rnbd/rnbd-srv.c: In function 'process_msg_open.isra':
drivers/block/rnbd/rnbd-srv.c:616:51: warning: '%s' directive output may be truncated writing up to 254 bytes into a region of size between 0 and 4095 [-Wformat-truncation=]
  616 |                 snprintf(full_path, PATH_MAX, "%s/%s",
      |                                                   ^~
In function 'rnbd_srv_get_full_path',
    inlined from 'process_msg_open.isra' at drivers/block/rnbd/rnbd-srv.c:721:14: drivers/block/rnbd/rnbd-srv.c:616:17: note: 'snprintf' output between 2 and 4351 bytes into a destination of size 4096
  616 |                 snprintf(full_path, PATH_MAX, "%s/%s",
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  617 |                          dev_search_path, dev_name);
      |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~

To fix this, unconditionally check for truncation (as was already done
for the case where "%SESSNAME%" was present).

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312100355.lHoJPgKy-lkp@intel.com/
Cc: Md. Haris Iqbal <haris.iqbal@ionos.com>
Cc: Jack Wang <jinpu.wang@ionos.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc:  <linux-block@vger.kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Link: https://lore.kernel.org/r/20231212214738.work.169-kees@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/rnbd/rnbd-srv.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 1896cde8135e..86a6242d9c20 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -606,6 +606,7 @@ static char *rnbd_srv_get_full_path(struct rnbd_srv_session *srv_sess,
 {
 	char *full_path;
 	char *a, *b;
+	int len;
 
 	full_path = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (!full_path)
@@ -617,19 +618,19 @@ static char *rnbd_srv_get_full_path(struct rnbd_srv_session *srv_sess,
 	 */
 	a = strnstr(dev_search_path, "%SESSNAME%", sizeof(dev_search_path));
 	if (a) {
-		int len = a - dev_search_path;
+		len = a - dev_search_path;
 
 		len = snprintf(full_path, PATH_MAX, "%.*s/%s/%s", len,
 			       dev_search_path, srv_sess->sessname, dev_name);
-		if (len >= PATH_MAX) {
-			pr_err("Too long path: %s, %s, %s\n",
-			       dev_search_path, srv_sess->sessname, dev_name);
-			kfree(full_path);
-			return ERR_PTR(-EINVAL);
-		}
 	} else {
-		snprintf(full_path, PATH_MAX, "%s/%s",
-			 dev_search_path, dev_name);
+		len = snprintf(full_path, PATH_MAX, "%s/%s",
+			       dev_search_path, dev_name);
+	}
+	if (len >= PATH_MAX) {
+		pr_err("Too long path: %s, %s, %s\n",
+		       dev_search_path, srv_sess->sessname, dev_name);
+		kfree(full_path);
+		return ERR_PTR(-EINVAL);
 	}
 
 	/* eliminitate duplicated slashes */
-- 
2.43.0


