Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10DE349578
	for <lists+linux-block@lfdr.de>; Thu, 25 Mar 2021 16:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhCYPad (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 25 Mar 2021 11:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhCYP37 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Mar 2021 11:29:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908F5C06174A
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:29:58 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u9so3592408ejj.7
        for <linux-block@vger.kernel.org>; Thu, 25 Mar 2021 08:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EdgX4znbSbRT87gcC/hvyjTwqemHSW7vhlSYDeMUDTc=;
        b=IFLk+3wFj3mqBv1fPVZiujR90GnqvE1imlSz1F+fkiYs9DjomyVHuDj63XRPRjSPfO
         5MvWaoL5sydCM9OW3o92pR1GPMzDYvCyIebvdKLP5XhG2dJjuZpf0H23xEYTvlGNUrLs
         BNZaY9SlcYlw/hL+wMpWzh53s5skpKVQaTyZSlrORaznB7BnNokQNxXmTjp12TIHUV53
         SahzKUQ8EzbUTeuNyc0AF89RZ60M6FtPwj5DZMyZlnN6yMpMojyGSS431pRrtgZ3UwFq
         rXUwDwP0RutPgTPDks8Pr7ZvStsfwMNjER2ltpILzHfRjzNAbyW30wQa++4EuWndFrsA
         InHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EdgX4znbSbRT87gcC/hvyjTwqemHSW7vhlSYDeMUDTc=;
        b=YlEl4gX+kQ9lShFbPNUc97u/UsMhb0aIwaPAFjEdaJc+PNsP0rlfP2YsLQNBRQsnWV
         j4IElj621Q/z1xpBrGY8ALmT1CGYsGyuszHDmNaILSJ4+lriBdt7vNb6eSg/9iljHeyX
         xWzcbUBy+6DJ3zm5fL+TajRLTZLbczJpkRKFx2GMIhW3Y/qdn/r2pxRBGrwasCNPUVqy
         4wR63BQ1zxiHWgsdQ774wJWQIyGntDpNuCI2jBSCJF3tUBKyaEx9UePVyzzS0W0HeKk6
         GDZ1UOkVojnPsZdwqGL8wY19mCvvGfNa70ISXwvhche1mdSURCMvu1qHG9tO7anMdkB8
         tEfA==
X-Gm-Message-State: AOAM5328SRl290Y1JUPP7WzWWtOHEyQUPsIWVSfxaMaQxXYzKACxPgn3
        LSPZ7zQgF4FwCX41JpKp8XQHmJVNZ9jirQ==
X-Google-Smtp-Source: ABdhPJxc4yV+tJyK8r+w6lFIdhu2U1nYXCzCqkI/QJoCd64OjROObhMmc/TPrMb/k8TIJdeCWQblYw==
X-Received: by 2002:a17:907:8323:: with SMTP id mq35mr186720ejc.109.1616686197219;
        Thu, 25 Mar 2021 08:29:57 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id b18sm2574837ejb.77.2021.03.25.08.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:29:57 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Guoqing Jiang <guoqing.jiang@gmx.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH for-rc 08/24] block/rnbd-clt: Remove some arguments from insert_dev_if_not_exists_devpath
Date:   Thu, 25 Mar 2021 16:28:55 +0100
Message-Id: <20210325152911.1213627-9-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
References: <20210325152911.1213627-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@gmx.com>

Remove 'pathname' and 'sess' since we can dereference it from 'dev'.

Signed-off-by: Guoqing Jiang <guoqing.jiang@gmx.com>
Reviewed-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 8c9a02c8b8bd..c8de016553a9 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1477,14 +1477,13 @@ static bool exists_devpath(const char *pathname, const char *sessname)
 	return found;
 }
 
-static bool insert_dev_if_not_exists_devpath(const char *pathname,
-					     struct rnbd_clt_session *sess,
-					     struct rnbd_clt_dev *dev)
+static bool insert_dev_if_not_exists_devpath(struct rnbd_clt_dev *dev)
 {
 	bool found;
+	struct rnbd_clt_session *sess = dev->sess;
 
 	mutex_lock(&sess_lock);
-	found = __exists_dev(pathname, sess->sessname);
+	found = __exists_dev(dev->pathname, sess->sessname);
 	if (!found) {
 		mutex_lock(&sess->lock);
 		list_add_tail(&dev->list, &sess->devs_list);
@@ -1528,7 +1527,7 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 		ret = PTR_ERR(dev);
 		goto put_sess;
 	}
-	if (insert_dev_if_not_exists_devpath(pathname, sess, dev)) {
+	if (insert_dev_if_not_exists_devpath(dev)) {
 		ret = -EEXIST;
 		goto put_dev;
 	}
-- 
2.25.1

