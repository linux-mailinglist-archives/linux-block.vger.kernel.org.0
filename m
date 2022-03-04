Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B281F4CD874
	for <lists+linux-block@lfdr.de>; Fri,  4 Mar 2022 17:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiCDQEi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 4 Mar 2022 11:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbiCDQEg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Mar 2022 11:04:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FA01AEEF1;
        Fri,  4 Mar 2022 08:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FnZ1fpykhfq9OvBcy/Lm11zVWshjv7O0KP30y4r9KR0=; b=dLKoxtaVVTKaA1w9vFRyv7HZ1E
        kD6ixBRyzZRhwEJ2mbKPQBuzAGzseEbJoDDV/ANELkDFn01LKRkCjjL5iWwhFlc+zhB8CpXmGqKjW
        oQwWwAwWMPiJX+t9JdTvrBtLwqxKSoZq7Qmqhw15yWVtRPI5pGb1vrEmD7eZ9IzqOvIivQi3Z7DCa
        7xyrlY4NMQ7xfmWLz0M0yEKW/PYz0l14vtJ58CSu8XirLSiQfm1lSyD/bE0LD5pC/DOHUeGl3fVMf
        NhISqJ9N2T2Z2yJmB+3ftzrEzl5BUrvK6LpsA7JRcQbjML+bEscSsgoIyYJTJcheGd/i7PZOe/0f3
        mVkfyJJw==;
Received: from [2001:4bb8:180:5296:7360:567:acd5:aaa2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQAP6-00Atza-5S; Fri, 04 Mar 2022 16:03:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 02/14] blk-mq: handle already freed tags gracefully in blk_mq_free_rqs
Date:   Fri,  4 Mar 2022 17:03:19 +0100
Message-Id: <20220304160331.399757-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220304160331.399757-1-hch@lst.de>
References: <20220304160331.399757-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

To simplify further changes allow for double calling blk_mq_free_rqs on
a queue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
[hch: split out from a larger patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ab4b646551334..6fd0b0f652514 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3070,6 +3070,9 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 	struct blk_mq_tags *drv_tags;
 	struct page *page;
 
+	if (list_empty(&tags->page_list))
+		return;
+
 	if (blk_mq_is_shared_tags(set->flags))
 		drv_tags = set->shared_tags;
 	else
-- 
2.30.2

