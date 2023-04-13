Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9626E06AE
	for <lists+linux-block@lfdr.de>; Thu, 13 Apr 2023 08:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjDMGHB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 13 Apr 2023 02:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDMGHA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 02:07:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC024ED8
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 23:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=xk9ErOk3gqYPfRs4ppF6pT2M2wzqcDyHB90u9neKn4Q=; b=Gtq0POfn+FreYPw6m3w7l/e5ya
        cJRblkS36v6NeoBL+XE2slctj3LA8F9TYDkulcoQKRJXOjMxc4Z64tMEti/z4A8maYrwP2brHQVVl
        Jf+TWZuI4n8LAP9imErPNBgWrA1tVj60ft6P56jxDJgAN9+58qr1vDDyDeGipz03+llcIyVGw4NkY
        JNmflpNZfGPUTMuxAhIJ3OOTM7Yj/IxikeLmEe5L0ICnansydgYZO1TylmHWRxechy+JvOD8HbSxC
        JNK771f/hhxEDpYdC4J3XeHrCmUOnNqKOb1Jh8cxDn0axvnURGwtwUqE/RCNkgHuuEYGDNG+pjX2H
        BSzyN1Xw==;
Received: from [2001:4bb8:192:2d6c:85e:8df8:d35f:4448] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmq6i-0057hj-0P;
        Thu, 13 Apr 2023 06:06:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: cleanup blk_mq_run_hw_queue v2
Date:   Thu, 13 Apr 2023 08:06:46 +0200
Message-Id: <20230413060651.694656-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
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

this series cleans up blk_mq_run_hw_queue and related functions.

Changes since v1:
 - drop pointless blk_mq_hctx_stopped calls
 - additional cleanups

Diffstat:
 blk-mq-sched.c |   31 ++++++++++------------
 blk-mq.c       |   79 ++++++++++++++++-----------------------------------------
 2 files changed, 37 insertions(+), 73 deletions(-)
