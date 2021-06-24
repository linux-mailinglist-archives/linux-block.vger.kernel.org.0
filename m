Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46F13B2F11
	for <lists+linux-block@lfdr.de>; Thu, 24 Jun 2021 14:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhFXMhK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 24 Jun 2021 08:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbhFXMhJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 08:37:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E93C061574
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 05:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=00guITiQGIAyvJOU8JO2bz5uS0zGCgYJUrwTgg1JLNg=; b=dgW3qvreW1ZxvB3zrKSnJqiFQ2
        9yl5iudL67RGCwq8P4FLI3B5lZbo/b6t54p2W7TBkIieCAv5qWl3188nlcoWtO+mRPgnHj/4IiBXG
        X8Sb2HoGkC9hy+CDvWNbxNIoY9BNr0q99bET+LzVTthC6EO2M/+u2omyEqLUbm8gzeegJ3f9tjUEv
        co8pmuIHWRKt1PPXHiPkaWJvxNng9DjhdHp1iZ3scEAO8+nyAlX2pUG8qyhOpksSKq4yYohGYLs3x
        qL0hHJdUT4P4eoTzoUMN0K7qioZXWMvK/sN8mzsF8aQ7IRTeR6doPLod0qGMvaiIJcE3dhRw2LRiU
        4O0e6Jsw==;
Received: from 213-225-9-92.nat.highway.a1.net ([213.225.9.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwOZ3-00GZQ7-2c; Thu, 24 Jun 2021 12:34:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: minor cleanups to bdev_disk_changed
Date:   Thu, 24 Jun 2021 14:32:38 +0200
Message-Id: <20210624123240.441814-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

two patches to clean up bdev_disk_changed that got lost large merge
window to avoid merge conflicts.
