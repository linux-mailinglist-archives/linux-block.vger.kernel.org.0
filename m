Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8754774ADFD
	for <lists+linux-block@lfdr.de>; Fri,  7 Jul 2023 11:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjGGJqb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 7 Jul 2023 05:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGGJqa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jul 2023 05:46:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A39FF
        for <linux-block@vger.kernel.org>; Fri,  7 Jul 2023 02:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=2HsqxOe5loAP5LPrdJ/BTaueXxa+4EwOIboAeohNz/Y=; b=jit7ri+3D/aZqrMl1BLiZzStUg
        8jxveEkXBuhUHnERfmucD26MoKSWC2rl+E+c+lngitXrxulKZtUdl7C5YlOzt8FkZ+iBtrUmnSiE+
        NWZZ1FC8ZhR7+ylLSy+qMa+NOI/S7QYbXNH4xQcSZCKppUH5eSbbU3vqg+GhGuaEDpZzTpJ6DPU83
        3T/QPtSZd82jt/rIuDGJZjunO8RnO8Yg0uEi7u3ZSupy/2uF3PixrVbSfmglSebYe/MIAEvaiGJUD
        rrBPzA2XXyARDriCNDLmPW53P0kqMQc99nxGe8ShTYg6cf/7P/85Dob0OUVbDtnt5JuwTjCdN+39l
        ZzDz1WIA==;
Received: from [89.144.223.112] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHi2l-0049gn-2T;
        Fri, 07 Jul 2023 09:46:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: fix discard limits
Date:   Fri,  7 Jul 2023 11:46:12 +0200
Message-Id: <20230707094616.108430-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

this series fixes a few issues related to max_discard_sector limits
in the block layer and nvme.

Subject:
 block/blk-settings.c     |    4 +++-
 drivers/nvme/host/core.c |   35 +++++++++++++----------------------
 drivers/nvme/host/nvme.h |    3 +--
 3 files changed, 17 insertions(+), 25 deletions(-)
