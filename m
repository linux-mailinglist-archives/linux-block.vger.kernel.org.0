Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9E25819B3
	for <lists+linux-block@lfdr.de>; Tue, 26 Jul 2022 20:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiGZSae (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 26 Jul 2022 14:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiGZSac (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 14:30:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA66465F7
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 11:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=KJgoWaO3tVfXSoZIqgxZQNuvNdOSPgOIbtc7s3573bw=; b=pdPiEDztr5rggieA0hZn2dNdle
        6l0Ab7fnxc8W6ioixlRmpDlLEzchaeFnEvGvGZ5VStghJKU7u0vA55CuEmvZMBDT6pbYyUoJqyYCx
        cm5weNWiQMJJqHe4KfgIMtv1++4eUyuFtIRPtTcImZs2BpwuwwjBqbzThzlbR3RklLIofC7T5iBTv
        c+s/FU9PfLU56YKiZJW7D+5hqdHZRfxRS0tRhYAYeD1CugtR4+3bFbHqdgCQPXViANrNLi6dOe9tS
        2vCbVhOk+6or7fQcjkMB+U5UpXHYErwXiA3X+kxigMM9kPGTp/el4fb11MLj8CxOh8l9wt1qRVZZi
        f2jIqBJg==;
Received: from [2001:67c:370:1998:f991:c4cf:cf3d:dfb6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oGPKA-0027rr-PT; Tue, 26 Jul 2022 18:30:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: bio splitting cleanups v3
Date:   Tue, 26 Jul 2022 14:30:23 -0400
Message-Id: <20220726183029.2950008-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series has two parts:  the first part moves the ->bio_split
bio_set to the gendisk as it only is used for file system style I/O.

The other patches reshuffle the bio splitting code so that in the future
blk_bio_segment_split can be used to split REQ_OP_ZONE_APPEND bios
under file system / remapping driver control.  I plan to use that in
btrfs in the next merge window.

Changes since v2:
 - trivial rebase to the for-next tree

Changes since v1:
 - drop a bogus patch
 - fix a comment typo
 - fix a commit log typo
 - clean up the blk_queue_split calling convention and name

