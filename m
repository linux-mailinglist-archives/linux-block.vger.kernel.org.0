Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC81217EB5D
	for <lists+linux-block@lfdr.de>; Mon,  9 Mar 2020 22:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgCIVmN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 9 Mar 2020 17:42:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36196 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgCIVmN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Mar 2020 17:42:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id a13so13815701edh.3
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2020 14:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4lLh34hcI9Vv1/qu93oMcltt6ZZ1B9e/hOy5aTXC8Fs=;
        b=fUYn2DzRt125iB1Brx6SUIFF0Xbk8bZqnYEgGK99TpjUrJG9JWMs3FE275voUvAY+E
         uYS4AhqKy1BW+dKLk3AlYbM6H7THEkqFtT8nyjOJ2Ldu8FEIqZb9v90E5Vt519fZwV1T
         nbRuCcUcM7BxQ2TOZXswe2UecSmSlf8qNwWuZ9CfeKZk1dhebzZjGkCoZd+7R01zCZMY
         Wrwkj1QgDr+HxBHS3XYHOXn/dmYf8QW3eysdy70gqMk0wZ5b5320cn8yBj0HyAXqU0ak
         xffc9tMOxhfABdREn1jeWHy96o7+y5ei2luef0QG0Q7s0w/RAptNwSGr8CzHQr6SGWeI
         NCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4lLh34hcI9Vv1/qu93oMcltt6ZZ1B9e/hOy5aTXC8Fs=;
        b=bkyEoZtx841egneIbBbluFNNIfIlcJeyZmx5bDLjoWbK9L76mxx2fsfxO/96U22Cyq
         dsuhLFqVWHDWFn51yLXs7DYU4vbWDuoaAJDZ+s0kBtXaOwmb+O+qzQh4QF2ySLBlCLpF
         wJ/xwoDsd/oDbV4mYcOQeMRhfd/YwkNxTx1xalE/yBd5XQh1OqMs3pWqREGDcsw34qib
         LKHYlbYQ5dmRWzxDWu9H9rU/fQhswWoWVjFzZBYuGUNQYEC752FzIIcKru4joI8wRYbI
         Xv4yBU+Q5GIGS8h8ISnOw7r9ruVwq/JEXjBfPS1gXnv4oLvIEK3e7b0PSiakg/Fv2h/7
         z6xg==
X-Gm-Message-State: ANhLgQ2+6dK1EAQuOZC2pB+8EccoVVW5UJw4UoQJDoQxDN9DV2//V/bI
        XlB3hXyCMqYXxto65XT6svSJ9Q==
X-Google-Smtp-Source: ADFU+vtFbRI8WUlLApd3ZvppN7Knua51YgwsID9ChUyYlrVyBBrRGR/JU2l5O7tZ1BxnYNBUwGV4Vw==
X-Received: by 2002:a50:eb04:: with SMTP id y4mr18539433edp.170.1583790131807;
        Mon, 09 Mar 2020 14:42:11 -0700 (PDT)
Received: from nb01257.fritz.box ([2001:16b8:4824:700:55b0:6e1e:26ab:27a5])
        by smtp.gmail.com with ESMTPSA id g6sm3828488edm.29.2020.03.09.14.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:42:11 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V2 2/6] block: use bio_{wouldblock,io}_error in direct_make_request
Date:   Mon,  9 Mar 2020 22:41:34 +0100
Message-Id: <20200309214138.30770-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309214138.30770-1-guoqing.jiang@cloud.ionos.com>
References: <20200309214138.30770-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the two functions to simplify code.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fd43266029be..6d36c2ad40ba 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1121,10 +1121,9 @@ blk_qc_t direct_make_request(struct bio *bio)
 
 	if (unlikely(blk_queue_enter(q, nowait ? BLK_MQ_REQ_NOWAIT : 0))) {
 		if (nowait && !blk_queue_dying(q))
-			bio->bi_status = BLK_STS_AGAIN;
+			bio_wouldblock_error(bio);
 		else
-			bio->bi_status = BLK_STS_IOERR;
-		bio_endio(bio);
+			bio_io_error(bio);
 		return BLK_QC_T_NONE;
 	}
 
-- 
2.17.1

