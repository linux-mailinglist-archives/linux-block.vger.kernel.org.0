Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B9B6025F3
	for <lists+linux-block@lfdr.de>; Tue, 18 Oct 2022 09:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiJRHih (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 18 Oct 2022 03:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiJRHid (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 03:38:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC032316A
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 00:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WTDLXjVpdzMNIOJpP7k0taW4hNaCp+a3vRo/RcHplZE=; b=3oX/4eoWyCi7BlG/pa7ZZ2g+59
        qSR8qAbVN8qJL+zhPaG6n/ziOZ4bwBz517uSAJd+cewPDlaBv6zQOm3a741uXuvao3TjnL+IMSoq3
        n8kZ0T8aKerA4U8onZ1m7/P+5g2DtSiTeJrYlTytV7vwkDEqUcJEnRYC0WRFKeWIRPUXP05qi749g
        QsI6wcu/vfW+bx7MMzrTprAdg08G8UwI6m44S59rP1G77rpJ2dTOmEiVBR5zShJeJgWeOOwNCc87A
        MqZHtMhj0nqGsg/qADaJ7Em5Z+VWGUCIaDlN68W02AMD2Q6+TWDcrhu7EWgFeLjWNz5TUmuu6Aehj
        KtsBfh+w==;
Received: from [2001:4bb8:199:ad84:bc07:8d59:28dc:d7d9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okhBH-003sen-72; Tue, 18 Oct 2022 07:38:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai1@huaweicloud.com>
Subject: [PATCH 2/2] block: clear the holder releated fields on late disk_add failure
Date:   Tue, 18 Oct 2022 09:38:22 +0200
Message-Id: <20221018073822.646207-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221018073822.646207-1-hch@lst.de>
References: <20221018073822.646207-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Zero out the pointers to the holder related kobjects so that
bd_unlink_disk_holder does the right thing when dm cleans up the delayed
holders after add_disk fails.

Fixes: 89f871af1b26 ("dm: delay registering the gendisk")
Reported-by: Yu Kuai <yukuai1@huaweicloud.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 6123005154b2a..734c2e74f42e3 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -530,8 +530,10 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	bd_unregister_all_holders(disk);
 out_put_slave_dir:
 	kobject_put(disk->slave_dir);
+	disk->slave_dir = NULL;
 out_put_holder_dir:
 	kobject_put(disk->part0->bd_holder_dir);
+	disk->part0->bd_holder_dir = NULL;
 out_del_integrity:
 	blk_integrity_del(disk);
 out_del_block_link:
-- 
2.30.2

