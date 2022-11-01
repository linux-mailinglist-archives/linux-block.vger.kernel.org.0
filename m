Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F281614DD0
	for <lists+linux-block@lfdr.de>; Tue,  1 Nov 2022 16:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiKAPIC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 1 Nov 2022 11:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiKAPHn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 11:07:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F221E72A
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 08:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=h76+5d/iC4L1V1jcubbcI5HntloJCHxklBhBHsPzTWc=; b=njVQZA7sgz/tRTijC4nWjZ3MS6
        O9VOEl2vl9LmeRfZnc8c4ZUbhYlug+Kq6VdMZOe396r5yLNvkvSZhshedXfW+HtICtlm494emEpZz
        +oRna+E8YGvjIU5c3u5198C9tbntg0aezH6JsJcn0oVJgq6x48fSIgww9dLM+eXZwFF6IFbNWqz0Q
        pMZxq7g/21H+OT4DhcZqngX9fiY+v7BZG/tgxxr3JxsvnC0ewtfLYe7VukdcjCbDvS/xFIb32g6lf
        Pf+mPR1Dwlt7wAI9ohzkcuwHqxQ9mVClposPJedO0Ku88Vn/hX115Y/8NNi/E1FskzPYMSMOsL5cH
        M1V5zbhA==;
Received: from [2001:4bb8:180:e42a:50da:325f:4a06:8830] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opsl3-005gcI-N8; Tue, 01 Nov 2022 15:00:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: per-tagset SRCU struct and quiesce v3
Date:   Tue,  1 Nov 2022 16:00:36 +0100
Message-Id: <20221101150050.3510-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

this series moves the SRCU struct used for quiescing to the tag_set
as the SRCU critical sections for dispatch take about the same time
on all queues anyway, and then adopts the series from Chao that provides
tagset-wide quiesce to use that infrastructure.

To do so this series cleans up a lot of code in nvme that is related
to quiescing queues.

Changes since v2:
 - check blk_queue_skip_tagset_quiesce in blk_mq_unquiesce_tagset
 - drop "nvme-pci: don't warn about the lack of I/O queues for admin
   controllers"
 - drop "nvme: don't call nvme_kill_queues from nvme_remove_namespaces"
 - drop "nvme-pci: mark the namespaces dead earlier in nvme_remove"
 - minor fixups for the above dropped patches
 - fix up a few commit messages

Changes since v1:
 - a whole bunch of new nvme cleanups
 - use the notify version of set_capacity in blk_mark_disk_dead
 - improve the documentation for blk_mq_wait_quiesce_done
 - dynamically allocate the srcu_struct in struct blk_mq_tag_set
 - minor spelling fixes
