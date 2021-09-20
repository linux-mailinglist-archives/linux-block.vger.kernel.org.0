Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499AC41100C
	for <lists+linux-block@lfdr.de>; Mon, 20 Sep 2021 09:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbhITH3w (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 20 Sep 2021 03:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbhITH3w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 03:29:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62BBC061574
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 00:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=4qmK5NhvGVzzMGRfpnQq6oGtQAHH/DFWMMTjbybRt/U=; b=rkN1YhM6AjGJ92OxKuqn3OTRWG
        jIEJIg5pjhcOmmu/fBLvsp/mEREpSYmXWSFnZMVO93MlQQ0u+HdWCK66auOl8WjUjHg1hxadr0pPi
        qio2fpDK98dIZUl7lAy8QKZKUE6eXXF4LS07mJSfxvHIhA2UvBXe1xvvQCJe2FYfjMXh2JiKQO2km
        2q7ypsnmlsE7V67jwOGZg70/d7cx5D8apIN/sJXornkos4lFsFXIQXtF3FxxzuBiq2IEkmJ2gaBw3
        +pNMzZIUomF89jFt11CYU3MQjJi1N2Almh1lVq44OHDW9u8yVbJ7taxtk/N+OZC4tSWZLahkmF0xz
        lx9lgscQ==;
Received: from 213-225-6-64.nat.highway.a1.net ([213.225.6.64] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSDi5-002SRp-G7; Mon, 20 Sep 2021 07:27:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-block@vger.kernel.org,
        nvdimm@lists.linux.dev
Subject: fix a dax/block device attribute registration regression
Date:   Mon, 20 Sep 2021 09:27:23 +0200
Message-Id: <20210920072726.1159572-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Dan and Jens,

this series fixed a regression in how the dax/write_cache attribute of the
pmem devices was registere.  It does so by both fixing the API abuse in the
driver and (temporarily) the behavior change in the block layer that made
this API abuse not work anymore.

Diffstat:
 block/genhd.c         |    3 +-
 drivers/dax/super.c   |   64 --------------------------------------------------
 drivers/nvdimm/pmem.c |   48 ++++++++++++++++++++++++++++++++++---
 include/linux/dax.h   |    2 -
 4 files changed, 46 insertions(+), 71 deletions(-)
