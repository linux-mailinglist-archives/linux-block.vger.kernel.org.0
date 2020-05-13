Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464D61D1088
	for <lists+linux-block@lfdr.de>; Wed, 13 May 2020 13:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbgEMLEZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 May 2020 07:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730214AbgEMLEZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 07:04:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B788C061A0E
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 04:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Wzj0BE24Orj82qvRKqxawxLi7MPwKCncErumtFghwV4=; b=LQ63f9PriiRssz6kuyhNEMPEYd
        pyrBa6l5+zCix6t4GwhMg/93DXySHreE2b7F/J45vBgKASaPpc7V34lF/OsDNgMVg9r1wqOojJcuW
        5P1P/VkzneMU5URgT4Pnfci8OL8J5K/MIAhpEFWuKOTOAV0L2YZm+cQ6A4R94F9S8vMEc8Q9VliFL
        VhBU4otXGanLkMxeFHzZou17qwuhx9GpL9WV2bXuamuzpJFqFp60tZi4WLgpOL34yyA+IEXCtB3y3
        RSDyOoRIRsvZ2F+AgyUZK/uY7KMuKQw23sHVIsslFJriK7UyEhW6F+BI+Xd36t7rSQnViK5TEGobJ
        12YCkb9A==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYpBW-0006i8-7c; Wed, 13 May 2020 11:04:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: avoid a few q_usage_counter roundtrips
Date:   Wed, 13 May 2020 13:04:15 +0200
Message-Id: <20200513110419.2362556-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

the way we track reference on q_usage_counter is a little weird at the
moment, in that we often have to grab another reference in addition to
the current one.  This small series reshuffles that to avoid the extra
references in the normal I/O path.
