Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27DD232327
	for <lists+linux-block@lfdr.de>; Wed, 29 Jul 2020 19:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgG2RJ7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 Jul 2020 13:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2RJ6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jul 2020 13:09:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55D8C061794
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2020 10:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=YGZFT1jduogNT8bWnTl8FAaFgIB2Yz6RQX35IjcX/xo=; b=v+hdm0SP2Rl9s8DmDBzfcmi3hf
        iL2mKEIswS4VdGldP3rr1ef5oOYpRFtrVLqwhrqdAVknExbikUFw/N72C9JQYR3gm2W1GdDPsCJLm
        xgf30pAKiIumtHCgwl+F3kIqQ44uCckMUPSiv7psEDfNYyDv8Z23gfZyhbzOus1A3Fk1KudIH0WiN
        rCeelzTeIlqJz8a06TuLOkUxP9v1s8JKUU1GV5yilx5uqfFuirhEANrvdAvWBCJ/Dqzf6tAcJZfqW
        qV+0sixtf9vSDk65oplB+LRX9tpyR1fZoyMRtKoA1rR0cK0nON/xc03DyTPQDimbWnB8OfJJMZ47n
        aAhvqSvA==;
Received: from 138.57.168.109.cust.ip.kpnqwest.it ([109.168.57.138] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0paT-0002Vi-Mj; Wed, 29 Jul 2020 17:09:53 +0000
Date:   Wed, 29 Jul 2020 19:09:52 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 5.8
Message-ID: <20200729170952.GA21060@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following changes since commit adc99fd378398f4c58798a1c57889872967d56a6:

  nvme-tcp: fix possible hang waiting for icresp response (2020-07-26 17:24:27 +0200)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.8

for you to fetch changes up to 5bedd3afee8eb01ccd256f0cd2cc0fa6f841417a:

  nvme: add a Identify Namespace Identification Descriptor list quirk (2020-07-29 08:05:44 +0200)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: add a Identify Namespace Identification Descriptor list quirk

Kai-Heng Feng (1):
      nvme-pci: prevent SK hynix PC400 from using Write Zeroes command

 drivers/nvme/host/core.c | 15 +++------------
 drivers/nvme/host/nvme.h |  7 +++++++
 drivers/nvme/host/pci.c  |  4 ++++
 3 files changed, 14 insertions(+), 12 deletions(-)
