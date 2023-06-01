Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69FA71943A
	for <lists+linux-block@lfdr.de>; Thu,  1 Jun 2023 09:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjFAH2s (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 1 Jun 2023 03:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjFAH2r (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Jun 2023 03:28:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C92D189
        for <linux-block@vger.kernel.org>; Thu,  1 Jun 2023 00:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=sCDYYe7o4PDHQlOmvetFFCEi6QYvm9XGlRFBInan+3g=; b=0vGqb/xC/hl8LBBGjj2pzMgkfr
        As0KWOr+mcgVSiudlPorUGVaMV1cvtd9URIKNMT8wXpQICxLQdtZT6XHfO87u7z0lIJoGGljJD/+T
        78YpHEqdwDy52+TSCycoNy07QOZrS3Nw68++lZfX59ZHJS0rkzDMFIwec1rfI/qmazcB1IKihuETn
        xvpYuNDWNm8lJ8rlTP7qkFIk+8AoQv9OOBZxyBn87dpxq91h3hkEcquU8xikNRAf8YaL7Kbnc+VOG
        kh42TXg43jU02zV2kvfiFF+jjGcWqkfqxOx+AdEeVPPlZkgMdjvwgBqvENn9W7RhivA+PC8RfeQ8o
        bGvEdmdw==;
Received: from [2001:4bb8:182:6d06:35f3:1da0:1cc3:d86d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4cjZ-002MKH-0R;
        Thu, 01 Jun 2023 07:28:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: enforce read-only state at the block layer
Date:   Thu,  1 Jun 2023 09:28:26 +0200
Message-Id: <20230601072829.1258286-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
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

Hi all,

I've recently got a report where a file system can write to a read-only
block device, and while I've not found the root cause yet, it is very
clear that we should not prevents writes to read-only at all.

This did in fact get fixed 5 years ago, but Linus reverted it as older
lvm2 tools relying on this broken behavior.  This series tries to
restore it, although I'm still worried about thee older lvm2 tools
to be honest.  Question to the device mapper maintainers:  is the
any good way to work around that behavior in device mapper if needed
instead of leaving the core block layer and drivers exposed?

Diffstat:
 block/blk-core.c       |   20 ++++++++------------
 include/linux/blkdev.h |    1 -
 2 files changed, 8 insertions(+), 13 deletions(-)
