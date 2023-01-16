Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D42C66D0BC
	for <lists+linux-block@lfdr.de>; Mon, 16 Jan 2023 22:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjAPVKW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 16 Jan 2023 16:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbjAPVKV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2023 16:10:21 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358171CAE3;
        Mon, 16 Jan 2023 13:10:21 -0800 (PST)
Received: from fedcomp.intra.ispras.ru (unknown [46.242.14.200])
        by mail.ispras.ru (Postfix) with ESMTPSA id 6242740D403D;
        Mon, 16 Jan 2023 21:10:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6242740D403D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1673903419;
        bh=JgF6PdGUqUIiW+PcAMJiQ/9RP2j3tExghwoZn9wrIig=;
        h=From:To:Cc:Subject:Date:From;
        b=KkhWXRfpLeToZU3rkquVnGfm4EHcU1i5LWLYoWHWDVaJtlye4kq/ORrphzAFEKAgt
         oyzHOsXFLo/2ECq0WOjp58mpa1Dk0AbvotogEbFlnB4XhP5EnWIS4aW5xF4M3dc9+A
         HTJznExyVaTW8+VfGSzj4IS2Z1kygMCmEAYH2fXg=
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH 4.19] block: fix and cleanup bio_check_ro
Date:   Tue, 17 Jan 2023 00:10:13 +0300
Message-Id: <20230116211013.822998-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

commit 57e95e4670d1126c103305bcf34a9442f49f6d6a upstream.

Don't use a WARN_ONCE when printing a potentially user triggered
condition.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Link: https://lore.kernel.org/r/20220304180105.409765-2-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 block/blk-core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 80f3e729fdd4..4fbf915d9cb0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2179,10 +2179,7 @@ static inline bool bio_check_ro(struct bio *bio, struct hd_struct *part)
 
 		if (op_is_flush(bio->bi_opf) && !bio_sectors(bio))
 			return false;
-
-		WARN_ONCE(1,
-		       "generic_make_request: Trying to write "
-			"to read-only block-device %s (partno %d)\n",
+		pr_warn("Trying to write to read-only block-device %s (partno %d)\n",
 			bio_devname(bio, b), part->partno);
 		/* Older lvm-tools actually trigger this */
 		return false;
-- 
2.34.1

