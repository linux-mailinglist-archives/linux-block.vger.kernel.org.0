Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B3B28F4A0
	for <lists+linux-block@lfdr.de>; Thu, 15 Oct 2020 16:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgJOOZi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 15 Oct 2020 10:25:38 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:50890 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbgJOOZi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Oct 2020 10:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1602771937;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ISsVjYKh083/gZzNPG9aHljTD9ZFK2BfAgEw3ykuDXk=;
  b=BobE1rCarGZ9nVw2WcDiq8YHioWA0x+bV+tZ/GJbvyTgjhhxMWfZZmQW
   gc4Mt/10nXktSsOJi0rxg+xykpnxW5MA/Rk8UqxJVXhnwW9g6GnQ5WedJ
   cDzkTg4anPh2IZPiSPXISbwJfKpt4I2jd9Xgp26+ax1F1Yv1OSLa9IFkb
   g=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: smY+e8aDkg2xJlFhPHHTjL7NFnuIum4Ix6GjOJ6YaxdZqsg8/1UJjJ32TKlqd1YxwjNbde6up8
 yC7T+ITSUXgNSY2a4I3MXHsYxUw76HFH6qA/2yGGUKm/+pj+rQybqlXAf1cXaThs6mkhm2wK3k
 pqMVlh9ZBlPOIKL6m1DFiAf9wxcsIcngd8kR/3HsJM2Q3Ubz6Pyt+VYHiMUuLtKqUOdGokDeuy
 sj416JtmG+wqd2uYZ2gp8ubZH6U3MNyhAgzr4CD2wFciLv47sWjDpXD1cheNq65fDjPfGzQP8J
 XSU=
X-SBRS: 2.5
X-MesageID: 30126341
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,379,1596513600"; 
   d="scan'208";a="30126341"
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        SeongJae Park <sjpark@amazon.de>,
        <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        =?UTF-8?q?J=C3=BCrgen=20Gro=C3=9F?= <jgross@suse.com>,
        "J . Roeleveld" <joost@antarean.org>
Subject: [PATCH 0/2] xen/blkback: add LRU purge parameters
Date:   Thu, 15 Oct 2020 16:24:14 +0200
Message-ID: <20201015142416.70294-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add the LRU parameters as tunables.

Roger Pau Monne (2):
  xen/blkback: turn the cache purge LRU interval into a parameter
  xen/blkback: turn the cache purge percent into a parameter

 .../ABI/testing/sysfs-driver-xen-blkback      | 19 +++++++++++++++++++
 drivers/block/xen-blkback/blkback.c           | 16 +++++++++++-----
 2 files changed, 30 insertions(+), 5 deletions(-)

-- 
2.28.0

