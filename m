Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E1D58FE06
	for <lists+linux-block@lfdr.de>; Thu, 11 Aug 2022 16:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbiHKOFy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 11 Aug 2022 10:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbiHKOFg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Aug 2022 10:05:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFCA27CE1
        for <linux-block@vger.kernel.org>; Thu, 11 Aug 2022 07:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=eNVCBqUqn8SFOfBc/qsyONTEJOmB7aKbelzMUwsw9NI=; b=YLk5zhnM4QVq/Lvx+QZ5lzJDfY
        jUXY19MHtdR0yowliSqrBqP/+6C4CbPHbAfLYJrg/9eSqXxxNUvtkvjwVg4EMgHzQ5iunEDhHIiKn
        pA2Rq/9+N8atAUkeXqixmOQ1yXT+WkX55EM1KuGyoteAQOKsRCF0Jm4Fs9IrLIa2OpyXa6NhgEJAH
        IJi4MGKNqDjDDf0o4bZ35OQ6+w8otGfF1JgwGGkbcS4a/8l4e/cDWZkCqESr9GjTP6Bj29yfCDTeR
        pTnMuyN4to0alGtrr4RepPwrF9pO5/Dj5C3HHNJrcnlvQJM0x380HYClM8qYXOoa3oZjA+YcTvVWP
        WmTArSGA==;
Received: from [2001:4bb8:182:2eeb:8088:4912:c90b:f14d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oM8oP-00D2Qy-EV; Thu, 11 Aug 2022 14:05:25 +0000
Date:   Thu, 11 Aug 2022 16:05:25 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.0
Message-ID: <YvUMpS5PxgJSykCB@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit fa9db655d0e112c108fe838809608caf759bdf5e:

  Merge tag 'for-5.20/block-2022-08-04' of git://git.kernel.dk/linux-block (2022-08-04 20:00:14 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.0-2022-08-11

for you to fetch changes up to f37527a09dac324c74bb341c841096395a2f2566:

  nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG GAMMIX S70 (2022-08-11 14:10:16 +0200)

----------------------------------------------------------------
nvme fixes for Linux 6.0

 - print nvme connect Linux error codes properly (Amit Engel)
 - fix the fc_appid_store return value (Christoph Hellwig)
 - fix a typo in an error message (Christophe JAILLET)
 - add another non-unique identifier quirk (Dennis P. Kliem)
 - check if the queue is allocated before stopping it in nvme-tcp
   (Maurizio Lombardi)
 - restart admin queue if the caller needs to restart queue in nvme-fc
   (Ming Lei)
 - use kmemdup instead of kmalloc + memcpy in nvme-auth (Zhang Xiaoxu)

----------------------------------------------------------------
Amit Engel (1):
      nvme-fabrics: parse nvme connect Linux error codes

Christoph Hellwig (1):
      nvme-fc: fix the fc_appid_store return value

Christophe JAILLET (1):
      nvme-fabrics: Fix a typo in an error message

Dennis P. Kliem (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG GAMMIX S70

Maurizio Lombardi (1):
      nvme-tcp: check if the queue is allocated before stopping it

Ming Lei (1):
      nvme-fc: restart admin queue if the caller needs to restart queue

Zhang Xiaoxu (1):
      nvmet-auth: use kmemdup instead of kmalloc + memcpy

 drivers/nvme/host/fabrics.c            | 8 +++++++-
 drivers/nvme/host/fc.c                 | 5 ++++-
 drivers/nvme/host/pci.c                | 2 ++
 drivers/nvme/host/tcp.c                | 3 +++
 drivers/nvme/target/fabrics-cmd-auth.c | 4 ++--
 5 files changed, 18 insertions(+), 4 deletions(-)
