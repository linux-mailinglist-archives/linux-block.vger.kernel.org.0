Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7D425803A
	for <lists+linux-block@lfdr.de>; Mon, 31 Aug 2020 20:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbgHaSEy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 31 Aug 2020 14:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbgHaSEv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 14:04:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70850C061573
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 11:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=qYyW4hc9qjpSS5UmqflCZv3xsBGC0qxe14GEI033KiM=; b=WnTarPBG51IDhZC5k8hV2t0+ns
        Z7aUPNIFJfTmKENij9oyLUZL5HxOHQBCXzCQY2lRB6DRHxWJlpF92B0GAi4AnEg7cp7OoN0/snVZo
        y1rBbCXeCps42tODdsGeI1bb5nT7TMeR9WJ+0BIa5KE8gh6762x0ovEv9MrlSWPcgfZTev9/ovxCB
        rmVyLBrPI756QYVx3+0TOFw8Fi9CKl2alKEw5VBVuliXED4XORcnFJBn7c0XA8SZsXCkq0aBwjwRt
        YGk7nvFCNkJQweRC4lYLz2XQ7EwlP9AS2CnQeCjcv5i8StstPOLODXp7e4LTJw1iVg8PO7Yea8hrO
        sCfKhL0g==;
Received: from 213-225-6-196.nat.highway.a1.net ([213.225.6.196] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCoAj-0001iK-PB; Mon, 31 Aug 2020 18:04:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: misc cleanups
Date:   Mon, 31 Aug 2020 20:02:32 +0200
Message-Id: <20200831180239.2372776-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series has a bunch of misc cleanups that didn't fit any other
series.
