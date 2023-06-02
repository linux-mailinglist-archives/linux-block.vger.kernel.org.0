Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7A37207C1
	for <lists+linux-block@lfdr.de>; Fri,  2 Jun 2023 18:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbjFBQj0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 2 Jun 2023 12:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbjFBQjY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Jun 2023 12:39:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A863194;
        Fri,  2 Jun 2023 09:39:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AC0901FDEE;
        Fri,  2 Jun 2023 16:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685723961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=leWSNybkvgM5TIQBj/WwVrrY7dWbgHg5e1qUYq/uf14=;
        b=nJjkvjwjEpcu7ZZba+FDG127CCriUvha0t+ipVSWxv9CuvOld3ODMf6CUYkJbdhK7hbeRE
        0RP790tcuREHDGj+D0CJPqnGt27oD1TDSXFO5yC86KZ/yUGZcciA5KcUhO8qCr6Y0XIqpk
        L8hm/+phBTcCYPDleOPTqfTeQs6l9ys=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EFCF133E6;
        Fri,  2 Jun 2023 16:39:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QBOWETkbemSEDwAAMHmgww
        (envelope-from <mwilck@suse.com>); Fri, 02 Jun 2023 16:39:21 +0000
From:   mwilck@suse.com
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     James Bottomley <jejb@linux.vnet.ibm.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/3] bsg: increase number of devices
Date:   Fri,  2 Jun 2023 18:38:43 +0200
Message-Id: <20230602163845.32108-2-mwilck@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602163845.32108-1-mwilck@suse.com>
References: <20230602163845.32108-1-mwilck@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Hannes Reinecke <hare@suse.de>

Larger setups may need to allocate more than 32k bsg devices, so
increase the number of devices to the full range of minor device
numbers.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block/bsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bsg.c b/block/bsg.c
index 7eca43f33d7f..c53f24243bf2 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -36,7 +36,7 @@ static inline struct bsg_device *to_bsg_device(struct inode *inode)
 }
 
 #define BSG_DEFAULT_CMDS	64
-#define BSG_MAX_DEVS		32768
+#define BSG_MAX_DEVS		(1 << MINORBITS)
 
 static DEFINE_IDA(bsg_minor_ida);
 static struct class *bsg_class;
-- 
2.40.1

