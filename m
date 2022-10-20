Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9747E6057AA
	for <lists+linux-block@lfdr.de>; Thu, 20 Oct 2022 08:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJTGsc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 Oct 2022 02:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJTGsb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 02:48:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DAE13F1E
        for <linux-block@vger.kernel.org>; Wed, 19 Oct 2022 23:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=VyMnsOARPbsb64hgKY2pu9mi3spUjLgxnAj/Ug7ukBw=; b=ctZU469qylk2mxV6zKoDdq7ML+
        nEiCGhmlWo5cObkok09q2W+pYlJUk5mDJfQZKqo3fbLJcVkDRLLG/o6MSK2QlYJRCUPna3+o9BDl8
        mpuWDmrnHtikj41EI+rdpHcSvMJxbGqLmMBHifHzIRW/Y2E3exVpHHFdDwGNY8Pj+P9E7BG4SK+UU
        9/gHP7eUzcQT6Qw+Sg4AiqdeVCkYTBZUGV5XNfMHkGw1vEHiuJ7QmBexGYjZhKPQ+cR9R3EwOSt8Y
        t3KyMuPX2aTvEgFYSDzAztKc8B+1P996lcTKm7ehhPQP3gZoj0WZHauoyRf9C5JbkH8YBBGjEhnzu
        247pI/0Q==;
Received: from [88.128.92.141] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olPLt-00BJVc-GX; Thu, 20 Oct 2022 06:48:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jinlong Chen <nickyc975@zju.edu.cn>, linux-block@vger.kernel.org
Subject: elevator refcount fixes
Date:   Thu, 20 Oct 2022 08:48:15 +0200
Message-Id: <20221020064819.1469928-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series is a take on the elevator refcount fixes from Jinlong.
I've added a cleanup patch, and one that improves on one of the incidental
fixes he did, as well as splitting the main patch into two and improving
some comments.

Diffstat:
 blk-mq-sched.c |    1 +
 blk-mq.c       |   13 ++++---------
 elevator.c     |   43 +++++++++++++++++++------------------------
 elevator.h     |   15 +++++++++++++++
 4 files changed, 39 insertions(+), 33 deletions(-)
