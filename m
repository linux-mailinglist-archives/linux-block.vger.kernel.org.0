Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A7055920E
	for <lists+linux-block@lfdr.de>; Fri, 24 Jun 2022 07:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiFXFZP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 24 Jun 2022 01:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiFXFZO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 01:25:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5056D69253
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 22:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=p4lzlLgPW/FzIh3b8dNfsmPfsGisrRq8P7kcfvLZyTQ=; b=OCwZ4b2/CSslTOJkZli4O5jalO
        kd6E+guJcehy8zrMUN7u6MsZ5H6qjO+H99XNk1bhKEBDPi99lNLv8djpJeSwH8t7z6LxHzd7uYebN
        tnsyWJjuuMAGvlq+xL9YL6PKAnYqkdiO/Z3xIunWMhCOQNkeXKpvW6QZeG/TsyguZCOLzT1BDinTW
        beWPBeyRRydjQDmSjVo6o2tkPq29PEW0My5l1goTVLJZHrUK2xqXCGE6wJuokCh7EA1ud1Ch32SOp
        HCcJppkIa3v9A+ylUi3jDorhlinTnft8fKbwPJ+9BDIp9goXHNe4CKzuVkOeu1lxyvL7vMtIfSGf2
        NqDEVtIA==;
Received: from [2001:4bb8:189:7251:508b:56d3:aa35:3dd8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4boe-000c7r-JX; Fri, 24 Jun 2022 05:25:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: cleanup block layer sysfs handling
Date:   Fri, 24 Jun 2022 07:25:04 +0200
Message-Id: <20220624052510.3996673-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series cleans up various loose ends in the block layer sysfs handling.
It sits on top of the "fully tear down the queue in del_gendisk" series
submitted last week.

Diffstat:
 block/blk-mq-sysfs.c         |   45 +++++++++++++++++++++----------------------
 block/blk-mq.c               |    4 +--
 block/blk-mq.h               |    7 +++---
 block/blk-sysfs.c            |   36 ++++++++++------------------------
 block/blk.h                  |    2 +
 block/genhd.c                |    3 ++
 block/partitions/core.c      |    1 
 include/linux/blk-mq.h       |    1 
 include/linux/blktrace_api.h |   10 ---------
 kernel/trace/blktrace.c      |   11 ----------
 10 files changed, 44 insertions(+), 76 deletions(-)
