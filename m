Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C7C5A9053
	for <lists+linux-block@lfdr.de>; Thu,  1 Sep 2022 09:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbiIAHdD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 1 Sep 2022 03:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbiIAHcm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Sep 2022 03:32:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC9E65808
        for <linux-block@vger.kernel.org>; Thu,  1 Sep 2022 00:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=oZ37gH4GcI6zuhqYXKYXANHATWQQe0itpTonSt2Fnqc=; b=vT1cmbGXj+1w6CirL0UtCN0cVg
        sR2SCy0EqGDal5Kzxk51u1M0ODyTt4YwiMdpd+NjIqg04rNb3FsuPYrbx7Yw/en7TnDCo+71cEXqp
        EPwKt8VqPx5hAojNHKRmJ1H16CC8umB0f9RcZCtVtpOB76JTqrWOWTVSX7y6Sq5ctYpCgZk3LRefE
        V2IHWU/C1JYnyQiBLxc0YgtmGLjg+BffDoj+e+SO8RD2yIwzh5GAI5I2lAkcyAhQBjdI/s2t6hKtO
        7xxrviRtYzrGbVke4gXVrSdqlZJdhuffuQ3LaQwkuHmMm4MsoAYkiJh2ozPMmCK2lJC09o0RPm69h
        qAAKM6Xg==;
Received: from 213-225-1-14.nat.highway.a1.net ([213.225.1.14] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTeeC-00AK0L-6f; Thu, 01 Sep 2022 07:29:56 +0000
Date:   Thu, 1 Sep 2022 10:29:51 +0300
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.0
Message-ID: <YxBfb38kb18Im/QB@infradead.org>
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

The following changes since commit 645b5ed871f408c9826a61276b97ea14048d439c:

  Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.0 (2022-08-24 13:58:37 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.0-2022-09-01

for you to fetch changes up to 478814a5584197fa1fb18377653626e3416e7cd6:

  nvmet-tcp: fix unhandled tcp states in nvmet_tcp_state_change() (2022-08-31 07:58:10 +0300)

----------------------------------------------------------------
nvme fixes for Linux 6.0

 - error handling fix for the new auth code (Hannes Reinecke)
 - fix unhandled tcp states in nvmet_tcp_state_change (Maurizio Lombardi)
 - add NVME_QUIRK_BOGUS_NID for Lexar NM610 (Shyamin Ayesh)

----------------------------------------------------------------
Hannes Reinecke (1):
      nvmet-auth: add missing goto in nvmet_setup_auth()

Maurizio Lombardi (1):
      nvmet-tcp: fix unhandled tcp states in nvmet_tcp_state_change()

Shyamin Ayesh (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Lexar NM610

 drivers/nvme/host/pci.c    | 2 ++
 drivers/nvme/target/auth.c | 1 +
 drivers/nvme/target/tcp.c  | 3 +++
 3 files changed, 6 insertions(+)
