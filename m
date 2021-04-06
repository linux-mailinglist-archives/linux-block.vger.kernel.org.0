Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8BB354CB3
	for <lists+linux-block@lfdr.de>; Tue,  6 Apr 2021 08:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243955AbhDFGXP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Apr 2021 02:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbhDFGXP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 02:23:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C208C06174A;
        Mon,  5 Apr 2021 23:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=rWd+nCfH/kQRM6z436qd9iWvpFvu1mNdI4jRJZLaQDU=; b=KMPuBlMJsTKYpp73Z3ImJRoJgJ
        PLdq/8KeW2v3wjB26Zep32M+8e46h00i5MaNlEU5vPvzuIPId6RVDO0DxxS+sZReHYnaxrZq0wZJd
        Ng3KBkS1orMMDdruZZ1NCgc1s22fRsKdkGrV39WL1QiOwRfAkhGXLSRJnPuwZYTZtW71QM6IhSGy1
        920gGtt7OKgN47wwZVRh/fbKO29MTwrqOu4DojgNyZfRlopgSNXkG+Lf40bgBEskvdCYs3F3kj9P2
        T1VLGKvypa0oEKm53jcEjuoQq9+4kLV1TKVwaa/UJKbuNQZPEgZuY9AgpmdE9iIjPoleIzYMB6MOa
        Wm72XtsQ==;
Received: from [2001:4bb8:188:4907:c664:b479:e725:f367] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTf7A-007o7p-Sm; Tue, 06 Apr 2021 06:23:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: partition iteration simplifications
Date:   Tue,  6 Apr 2021 08:22:51 +0200
Message-Id: <20210406062303.811835-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

with the switch to an xarray for storing the partitions of a gendisk we
can now use the xarray iterators for iterating over the partitions and don't
really need the disk_part_iter_* scheme.  Also clean up the teardown of
partitions where I think we have a (very unlikely to hit) race currently.

Diffstat:
 block/blk.h                     |    1 
 block/genhd.c                   |  183 +++++++++++-----------------------------
 block/partitions/core.c         |   54 +++++------
 drivers/s390/block/dasd_genhd.c |    3 
 fs/block_dev.c                  |    8 +
 include/linux/genhd.h           |   21 ----
 6 files changed, 84 insertions(+), 186 deletions(-)
