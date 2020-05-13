Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8921D12D3
	for <lists+linux-block@lfdr.de>; Wed, 13 May 2020 14:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbgEMMgE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 May 2020 08:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbgEMMgE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 08:36:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D58C061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 05:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=PoIy9qcXNN72y+r5TbpvjW2S+LuauIiPveO7OBQ10AA=; b=cMWXTeCDuuQk1gAMCMVJJ8QOkm
        9MHYY1z7At5WxJXqb/VR9HRe7CnAcSxqgvVqWH90msePc1Woj63ZS+/5y1PL97pycF8e0dp5YLj/x
        Nh4raKpQyLe6srAeyR07XbyVYIPG10K75EP8gzgQkuuMyTwr4Lz3jYfCpNqqLrJeHh2qXpiFhAaxQ
        0uVEJjL5vRXwYCGHKOtzEQ3z6PWk9qDyPkIKuFo4j0gqBe4Gi/VMAMA6/r7WAyrUxBvoM0oEMlYzL
        q18kLOhoOWmzaO1CzyeL9VzJSsGRSqM3c3Z7ugR6P5Di5dW2u9nY029ipHUWw2uk8Dmx0XOKnzP/h
        jMksWdZw==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYqcF-0004Qh-KC; Wed, 13 May 2020 12:36:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: small blkdev_issue_flush cleanups
Date:   Wed, 13 May 2020 14:35:59 +0200
Message-Id: <20200513123601.2465370-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

two small cleanups for blkdev_issue_flush below.
