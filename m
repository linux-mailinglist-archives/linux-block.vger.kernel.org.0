Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32D33A5CB6
	for <lists+linux-block@lfdr.de>; Mon, 14 Jun 2021 08:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhFNGFx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 14 Jun 2021 02:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhFNGFx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jun 2021 02:05:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED938C061574
        for <linux-block@vger.kernel.org>; Sun, 13 Jun 2021 23:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=jYFBcpRvJIDdBAqQD5aNwJIJlLuy6wqSLXp5JYoFeyE=; b=pC3cNCdLvYIknO79xX6ibUr+wr
        9ozrhkKZj6LPjPPcf74KZf3aFqCS13ls9R8CWBm23cL1Tu7swoTIBEVc7JS28+PfcZCW6MYjJi9cA
        ZIJBqKQfpN0e1rqtG2vsZ9lo+Q8kyMh5Dxi3M26mTmEe4UvZbxOi9iJzR9xX/V+QXp6c4jLviPZwl
        1qVcZwya3myqIPV7E4BhCl6OrUNDzPKPycmZU7O9sBieK5ITn87r0UgZsbzON4r6g9/MuHKcTCbm7
        u3Uqu/NcV9rZ/Z+3SfNp6UVQby0joqiQSOe+ooTT3ZgDgtd6rwWXlF0joG4oXbQc/p3NS47DSMP3Z
        YqQit35g==;
Received: from [2001:4bb8:19b:fdce:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lsfhO-00Cfrt-8O; Mon, 14 Jun 2021 06:03:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: mtip32xx cleanups
Date:   Mon, 14 Jun 2021 08:03:41 +0200
Message-Id: <20210614060343.3965416-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series cleans up the sysfs setup in the mtip32xx driver and then
converts it to use the new blk_mq_alloc_disk and blk_cleanup_disk helpers
added in the for-5.14/block tree.


