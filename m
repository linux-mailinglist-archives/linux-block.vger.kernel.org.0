Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86E240A718
	for <lists+linux-block@lfdr.de>; Tue, 14 Sep 2021 09:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240572AbhINHK4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 14 Sep 2021 03:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240419AbhINHKv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 03:10:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C130DC061574
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 00:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=dfl1sK45D1Zp1CN7VKwgHtnSAsfPpe+2vVKDvLnEe0I=; b=H5uutOkD1jWUZJMgn4amsEw11C
        k9rBxJIBvGNbQJCkx7AVJGvPgynHibJaUg1qea8H/A9YrwCFsQ9q8yz4JX40lmNDqNQTXFUUh4Got
        ITVTWQWZOGus/7ETddAjiGYzvE4EI3fd4IHDjTZ2pA9a9yzHLlR1fMp2L4hjXl7d48sQBnwF8UCoh
        eD6ooTiNcN0iFg/nfL4eWZRMovzeXx+47St185N+SKV+/zKhyVVPxF+n16akmnXG2mqHQU8GIx5Fi
        z7grx9cIY9VzEi8YjndBWpCn7AVoK2Na77XzW6q5IDZGfDE0iYNVzziAa+YIvt+w1PCTNX4gZFnS/
        3ciQEvGg==;
Received: from [2001:4bb8:184:72db:7baf:b601:6734:7149] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQ2Wy-00EMmu-Gp; Tue, 14 Sep 2021 07:07:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, martin.petersen@oracle.com
Cc:     Lihong Kou <koulihong@huawei.com>, kbusch@kernel.org,
        sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: fix an integrity profile unregistration race
Date:   Tue, 14 Sep 2021 09:06:54 +0200
Message-Id: <20210914070657.87677-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

this series fixes a race when the integrity profile is unregistered on a
live gendisk.  This is a slight twist on a patch sent by Lihong, which
I've taken over as she is out on vacation for the next two weeks.
