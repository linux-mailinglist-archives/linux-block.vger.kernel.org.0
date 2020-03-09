Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF3AA17EB5E
	for <lists+linux-block@lfdr.de>; Mon,  9 Mar 2020 22:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgCIVmQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 9 Mar 2020 17:42:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38972 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgCIVmQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Mar 2020 17:42:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id m13so13796524edb.6
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2020 14:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PNMYVTyVQxW/Xuk8DRsaSA6RKwc3tmfh5S/KRiKryIA=;
        b=D+8Qg09R6q/LhGmAOM4zf9Y3K44eHoBziCMZYu1GSWkjDOj5OmSSRBt8lUB8cxKoSp
         p9rqKqr1hr5qWPClRqnGr5Jx2BsbeOol6HmLUOQ2CmJ7SnO7/sTQr5BFmzsO7k2qX32f
         A73gj+jc/X6kGrknM9Tx87tMJ2R0PQcRw9/a2MkWMzj0Q+tx8jkaK5A6WAGQK+qrYDqV
         AsC5OtUVDdn8UuerqUAjawfmEyhsYXpyp4YzJGNBfbSBwvq9MTPBaiEFOdKRsWbJTe2n
         uh5TO0H5OKK4wX5b2FS/nkxMinsCZYDvmOVnz8wkeWb4MTqgcFWFHIyK1YXqlQescNZy
         Hxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PNMYVTyVQxW/Xuk8DRsaSA6RKwc3tmfh5S/KRiKryIA=;
        b=snSKaqNtQ3E3kuIsJMi8HrHA+tx6SGSwHOfOGlge/5YImt9VM1raOUkFnTscn3Del+
         65ejTKD0vf+bpcwlRVMA0FIndBNDKO4I/eY4eVLuDEBINW+ybbFAkwK2nNPPxKA/HO2z
         yCaFH8mAS6lt4/t6IFt7bzGVF2++LQLCygNnrjKY9ePIewPLU6mEZ8/1oWVJNOMTylbh
         difCXyq9Y7rTa95EG4brhtDy9nU3TxvofgnqKibmKV0DmC7502XUxuaRAQwXb/sCzmZY
         AM5fALSGxz3LIEZJ0emfXNpqFWU4rPYF5Nhe0KITkWLzQhbufojOLVskXB4oiUduK3vK
         /dsA==
X-Gm-Message-State: ANhLgQ3G8e+bvLeWRJFmfHf7i24e0NDqpkMcE6q/f5vmMado5197MZ6D
        wnKcDZo3HpPPQbQEqov9o7JyXg==
X-Google-Smtp-Source: ADFU+vs+W7pZMjFzMel2GprIKeFPCgFc9jO5HuA1EMgaCxEEel27cVLYITIDH9A3GUYr+jXe9XYQAg==
X-Received: by 2002:a50:9fe2:: with SMTP id c89mr19428710edf.371.1583790133184;
        Mon, 09 Mar 2020 14:42:13 -0700 (PDT)
Received: from nb01257.fritz.box ([2001:16b8:4824:700:55b0:6e1e:26ab:27a5])
        by smtp.gmail.com with ESMTPSA id g6sm3828488edm.29.2020.03.09.14.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:42:12 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH V2 3/6] block: remove redundant setting of QUEUE_FLAG_DYING
Date:   Mon,  9 Mar 2020 22:41:35 +0100
Message-Id: <20200309214138.30770-4-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309214138.30770-1-guoqing.jiang@cloud.ionos.com>
References: <20200309214138.30770-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Previously, blk_cleanup_queue has called blk_set_queue_dying to set the
flag, no need to do it again.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 6d36c2ad40ba..883ffda216e4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -346,7 +346,6 @@ void blk_cleanup_queue(struct request_queue *q)
 
 	blk_queue_flag_set(QUEUE_FLAG_NOMERGES, q);
 	blk_queue_flag_set(QUEUE_FLAG_NOXMERGES, q);
-	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
 
 	/*
 	 * Drain all requests queued before DYING marking. Set DEAD flag to
-- 
2.17.1

