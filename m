Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D6250CB5B
	for <lists+linux-block@lfdr.de>; Sat, 23 Apr 2022 16:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiDWOnT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 23 Apr 2022 10:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiDWOnM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Apr 2022 10:43:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACC6FDFAE
        for <linux-block@vger.kernel.org>; Sat, 23 Apr 2022 07:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650724811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hi7lL+uHEvjGcmxe1RXhBh46Ye9HEjaAkiU/ZDSXGds=;
        b=KjhrtuVZrOZ7vERz9IaMqOLW6Ys3McsCxLYPY7cBihuYeMZ2wRFq6kQ/1QN4L5PpPMZ/93
        YvDZt3rKZDOM8bhV/xiS4jqVT/n51xNS30v2KBqZAt6To2bEt9SOkhXOtCmlT/RUOXKynH
        TN7utt1CviHRtwXKHrzh8XB0sX6DlGs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-tlSETiZ_NMOvrAhFHoBnHw-1; Sat, 23 Apr 2022 10:40:10 -0400
X-MC-Unique: tlSETiZ_NMOvrAhFHoBnHw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B59ED101AA42;
        Sat, 23 Apr 2022 14:40:09 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C413841636C;
        Sat, 23 Apr 2022 14:40:08 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ming Lei <ming.lei@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH V2 1/2] debugfs: fix declaration of debugfs_rename
Date:   Sat, 23 Apr 2022 22:39:51 +0800
Message-Id: <20220423143952.3162999-2-ming.lei@redhat.com>
In-Reply-To: <20220423143952.3162999-1-ming.lei@redhat.com>
References: <20220423143952.3162999-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

debugfs_rename() declaration isn't same between CONFIG_DEBUG_FS
and !CONFIG_DEBUG_FS, which causes the following warning in case
of !CONFIG_DEBUG_FS:

   include/linux/debugfs.h:252:47: note: expected 'char *' but argument is of type 'const char *'
     252 |                 struct dentry *new_dir, char *new_name)
         |                                         ~~~~~~^~~~~~~~

So fix declaration of debugfs_rename().

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/debugfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index c869f1e73d75..bba0f514d97e 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -249,7 +249,7 @@ static inline ssize_t debugfs_attr_write(struct file *file,
 }
 
 static inline struct dentry *debugfs_rename(struct dentry *old_dir, struct dentry *old_dentry,
-                struct dentry *new_dir, char *new_name)
+                struct dentry *new_dir, const char *new_name)
 {
 	return ERR_PTR(-ENODEV);
 }
-- 
2.31.1

