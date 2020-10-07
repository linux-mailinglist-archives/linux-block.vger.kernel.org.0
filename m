Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292C8286125
	for <lists+linux-block@lfdr.de>; Wed,  7 Oct 2020 16:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgJGOX2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 7 Oct 2020 10:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgJGOX2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Oct 2020 10:23:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02268C061755
        for <linux-block@vger.kernel.org>; Wed,  7 Oct 2020 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=L3w1admStvlY1PqJj30y2+BznKvimoaQSz33TlBXa68=; b=jnpz+tBzZiFogXHyre0BlAESMu
        J/cgxXLdnunBgRbdMkmKKNOPU8trqXto1GJi4aJt78Jplo0EZvmxBHb3Cix6sEySEA6PU+TMIjB9/
        3RxSl6QlR+ElEix7omQZLSI1e5vUnO2FnKbq/78aSY7ufdVa9/2z//0GliJNY4QQpOoWVondMcGnE
        rE/G3dflsb0Bxhh8/KAJ3qpY+chTscm+/ACIDOtX6UYGorp9qVOIsaATvUgLbfQWogoyoqySwuXHJ
        Lh15wIgj2cOZuAehhNk6iMuo4jV3ecr80wUSeiuGosA0+UqmefakOqZGtuRfWFgz99/TFVvOHqff1
        Gi2GufhQ==;
Received: from [2001:4bb8:184:92a2:f749:31f9:6664:a99d] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQALk-0003AR-QG; Wed, 07 Oct 2020 14:23:25 +0000
Date:   Wed, 7 Oct 2020 16:23:24 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fix for 5.9
Message-ID: <20201007142324.GA1458015@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit 6d53a9fe5a1983490bc14b3a64d49fabb4ccc651:

  block/scsi-ioctl: Fix kernel-infoleak in scsi_put_cdrom_generic_arg() (2020-10-02 12:01:47 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.9-2020-10-07

for you to fetch changes up to 4bab69093044ca81f394bd0780be1b71c5a4d308:

  nvme-core: put ctrl ref when module ref get fail (2020-10-07 07:55:40 +0200)

----------------------------------------------------------------
nvme fix for 5.9:

 - fix a recently introduced controller leak (Logan Gunthorpe)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvme-core: put ctrl ref when module ref get fail

 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
