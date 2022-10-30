Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38CD612B38
	for <lists+linux-block@lfdr.de>; Sun, 30 Oct 2022 16:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJ3Pbv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 30 Oct 2022 11:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJ3Pbu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 11:31:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BFDAE69
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=r9lOpqfssN28sQpin7zqVohVSYlRtAzGx3hN7KKKv9E=; b=sujq/9CKvZxD6g3eUoSr9GqH/u
        3plgHeYfLxgV+bITtV2HJITS0mw691RNomdm3F60qMFLfMStQX9pClDGfK1CZ0VPhIdorsNO//nHl
        BESnxlrBaUjr/pcErGPyNzuRQpa5Tof4OanG8Si5pONJ/gzaoFQguMLJMm+iBMagzHnV/LJSJulaw
        /ToGEA3Xv+SaZu63kvlW1LU+nNdTJl8tOzAkRFCW1tgkhBlhrw3iwsKGXBNVZSa5YWSQJUv9lPLTy
        vXzXod4hNZNpJXl/XyJty3S3XN5jo6SqvQAj5/Amao8NVMoXZ0lwJebAvgPH9VATSeyoM/VGhAQmC
        8bKSGbSw==;
Received: from 213-225-37-80.nat.highway.a1.net ([213.225.37.80] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opAHc-00HVfD-Gm; Sun, 30 Oct 2022 15:31:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: fix delayed holder tracking v2
Date:   Sun, 30 Oct 2022 16:31:12 +0100
Message-Id: <20221030153120.1045101-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

Hi all,

this series tries to fix the delayed holder tracking that is only used by
dm by moving it into dm, where we can track the lifetimes much better.

Changes since v1: 
 - don't blow away ->bd_holder_dir in del_gendisk or add_disk failure
   as the holder unregistration references it
 - add an extra cleanup patch

Diffstat:
 block/genhd.c          |    6 --
 block/holder.c         |   85 ++++++++++------------------------
 drivers/md/dm.c        |  122 ++++++++++++++++++++++++++-----------------------
 include/linux/blkdev.h |    5 --
 4 files changed, 93 insertions(+), 125 deletions(-)
