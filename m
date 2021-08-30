Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A67E3FBEBC
	for <lists+linux-block@lfdr.de>; Tue, 31 Aug 2021 00:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238848AbhH3WL0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 30 Aug 2021 18:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbhH3WLY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Aug 2021 18:11:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC07C061796;
        Mon, 30 Aug 2021 15:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hX7HRTcv4QfX8vcdgUwPONffQyFjE2f8SSCFViSYJH8=; b=0e8f1gVleL+xeNyRndnSQ8MsoM
        R7hquXfqn2bRJ9h/SwbMOe57+vv9uBmTnONlUMrGcoWlLzaS/TZiRJPGLY56cGFwKyT8grpYK8AJg
        EkU2q1IqxEEYrfKdG6umd2+I+3djwPkGRnPJRHRvu4xnZ54P+elZThpyn2dUD8QKDeukkhDmMrW75
        Ii26qjx31okgyenvglZfgJ1y8nxSRxY8VI4nlqGuewquUECgwZwlvhbuJtl/gPYn46yryIDd6UF1X
        ffLroqGM9MtGzBhDqcDaFPf3/8p3VxMZ6Z/dzRSuFkNfFjA1FH3J3t1uSat5boFMD5DdNGhrd4hon
        YviAMKxw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKpTk-000khk-DF; Mon, 30 Aug 2021 22:10:08 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, justin@coraid.com, geert@linux-m68k.org,
        ulf.hansson@linaro.org, hare@suse.de, tj@kernel.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes.berg@intel.com, chris.obbard@collabora.com,
        krisman@collabora.com, zhuyifei1999@gmail.com, thehajime@gmail.com,
        chris@zankel.net, jcmvbkbc@gmail.com, tim@cyberelk.net
Cc:     linux-xtensa@linux-xtensa.org, linux-um@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 15/15] pd: add error handling support for add_disk()
Date:   Mon, 30 Aug 2021 15:10:00 -0700
Message-Id: <20210830221000.179369-16-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210830221000.179369-1-mcgrof@kernel.org>
References: <20210830221000.179369-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/paride/pd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 500b89a4bdaf..226ed5c93b68 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -938,8 +938,12 @@ static int pd_probe_drive(struct pd_unit *disk, int autoprobe, int port,
 	if (ret)
 		goto put_disk;
 	set_capacity(disk->gd, disk->capacity);
-	add_disk(disk->gd);
+	ret = add_disk(disk->gd);
+	if (ret)
+		goto cleanup_disk;
 	return 0;
+cleanup_disk:
+	blk_cleanup_disk(&disk);
 put_disk:
 	put_disk(p);
 	disk->gd = NULL;
-- 
2.30.2

