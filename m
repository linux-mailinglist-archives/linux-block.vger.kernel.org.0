Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35090708EE3
	for <lists+linux-block@lfdr.de>; Fri, 19 May 2023 06:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjESEk6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 19 May 2023 00:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjESEk5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 00:40:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB12EE69
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 21:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=jvxfOn2r8YBxZYslrcHfYj+oK5yABp/kuIMlh0XI0h8=; b=A0cEpj28IsW8Lm6U35G5G9ZNrN
        7kRxmIKxb4/gL5/ar3adyho0UqlY/Do55ve5R9wY6EoRP/khRipCYg5e0FwibHYGxYnHT1e92DVfy
        RETlhPwnKHhRCqaSdkSWnD+zv1d0Qp8X0V0gf4BEBsfspYBL2OPRhhuynAZhEBYtAxvp1EQ+AbhU5
        TCmcz7q3732nwSY2N921k2qBZ4EJFu1Pw6X5rUZcKsbD+0U2NEIhvHMiyazwU0lKhmVvHeBDpirk5
        t1mOiwLl/EjQJ2dip0UZLQy8HXRWEBixyyUnhy0tOObIIHP0Z+qP30hLuMAwbLyjZ6H4uA47hL8bC
        1EGrkAsA==;
Received: from [2001:4bb8:188:3dd5:8711:951c:9ab6:1400] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzrvB-00F4Wd-0a;
        Fri, 19 May 2023 04:40:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: less special casing for flush requests v2
Date:   Fri, 19 May 2023 06:40:43 +0200
Message-Id: <20230519044050.107790-1-hch@lst.de>
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

inspired by Barts quest for less reording during requeues, this series
aims to limit the scope of requeues.  This is mostly done by simply
sending down more than we currently do down the normal submission path
with the help of Bart's patch to allow requests that are in the flush
state machine to still be seen by the I/O schedulers.

Changes since v1:
 - rebased
 - fix a bug in the blk state machine insertation order

Diffstat:
 block/blk-flush.c      |  110 +++++++++++++++++++++++++++----------------------
 block/blk-mq-debugfs.c |    1 
 block/blk-mq.c         |   54 ++++++++----------------
 block/blk-mq.h         |    5 --
 block/blk.h            |    2 
 include/linux/blk-mq.h |   31 +++++--------
 include/linux/blkdev.h |    1 
 7 files changed, 94 insertions(+), 110 deletions(-)
