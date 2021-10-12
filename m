Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D2642A9A7
	for <lists+linux-block@lfdr.de>; Tue, 12 Oct 2021 18:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbhJLQji (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 12 Oct 2021 12:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhJLQjg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 12:39:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD6CC061745
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=JVQcbwjGfh5yznC2SC9P6AWye8t++S4V3/FPFJywOB4=; b=uDUkktTXQtOv6+D4pALtEarOwD
        uBcq0dDnS1sGOIHgh7tox77gyQOQx4p0K+uift2IDoI5IZCoZIVwZeng0SpWTLYC8miHfLnt1dfDB
        Kk1EdT/ILh53KIHzIyZC0EKQn0IWQodiiPWzek//FAxTt42bbUfSNdVIqvMSSoxXOl0mebDyDdkmG
        0GttuuUGuuiSDF0gmWv6ZeDvj/KkQ728IQN/MmtH9FsnBXUroummY0jlNn5cNl8dQiGr43EFeNI5g
        URVktxkcuMjF9mb9r93MeRadRxaheJCaAfytKLwESYHv4qf2U2uuVo+cLDo5BY3b/fYFAbZz5Gyfk
        cC2vyAbw==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maKlB-006egY-Kn; Tue, 12 Oct 2021 16:36:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: simplify I/O size calculation helpers
Date:   Tue, 12 Oct 2021 18:36:08 +0200
Message-Id: <20211012163613.994933-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series calculates various I/O size calculations.

Diffstat:
 block/blk-merge.c      |   33 ++++++++++++++++++---------------
 drivers/md/dm.c        |   18 ++++++------------
 include/linux/blkdev.h |   27 ++++++++-------------------
 3 files changed, 32 insertions(+), 46 deletions(-)
