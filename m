Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C42402A7B
	for <lists+linux-block@lfdr.de>; Tue,  7 Sep 2021 16:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbhIGOOz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 Sep 2021 10:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbhIGOOy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 10:14:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AED7C061575
        for <linux-block@vger.kernel.org>; Tue,  7 Sep 2021 07:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Yo1Z3G+JIL6ORcfJg3kbu8PNQRMo8aCrsvfSkB/qjy8=; b=sqoIBCeydL34WsYLIvFvIMHUFM
        jC75ygTlZ0386+TaUZMFBBI139CapLC1jupqtBZt1vblHpRxQe0sGuBZdE1xFQRYa+wy5BxexqtqP
        vi7Y00HX9V7GOKQMEh7lHrzPHVMFQXWrajHm/AvPbSPQkbBS7NDd/VomsmT9qSoTuuBq4T/um+UUq
        qnCVWNVz5YahkTpJ5N6ZHttE9EsMhfNWhu+cO9hgLVx43v8V0nIvEUeaDsIOiv/jv5xnuO6gtv5As
        yz8SVp97b7AbpxvRmclgFQjRTFDkqcKJ2mLPXWPB0N9gRnvE8FcruPrxJSGqxZXRviw8DhcTxhRdk
        1fbjVByg==;
Received: from 089144201074.atnat0010.highway.a1.net ([89.144.201.74] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNbqT-007vod-7D; Tue, 07 Sep 2021 14:13:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: split and move block_dev.c
Date:   Tue,  7 Sep 2021 16:13:01 +0200
Message-Id: <20210907141303.1371844-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

block_dev.c has been mis-placed in the fs/ directory forever, and
also contains a weird mix.  This series splits it into two files,
and moves both of them to block.  The second week of the -rc1 window
might be the best time to do something like this to avoid conflicts.
