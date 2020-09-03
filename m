Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D995D25BAD8
	for <lists+linux-block@lfdr.de>; Thu,  3 Sep 2020 08:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgICGHN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 3 Sep 2020 02:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgICGHF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 02:07:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2D2C061245
        for <linux-block@vger.kernel.org>; Wed,  2 Sep 2020 23:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=1M+jzkWK63Gf7kuHSHTA6mlkdC4zqq5/l+CfFM+e57w=; b=M28Z4O5ywi9Ehpb8Js6nfO5J9a
        XbRTGf4DjRqYk6hp8QrQhNUN9lcN3uwO46H0yoWuu9H/Ho29h6oqWNpQIInQAz/suwXtCFhqlxtol
        OjePsHkotMliLHgUyHxNt8l2xZYwgblwA60Pf8awm05EYli5kB19N5ymiKyI0hsaFO2pIN2QYvCrK
        XVibo7u45QH6YtS8gOL9xfZMNLVLtf52ommiLT7CxqMsl9gaFyw0XO3QF/1SdnzI63rOFfnvHGJ1m
        sYgSOjrKT8LYELtHZXj6P+NjClkA3jD5HfnLZ84sP6QFz2eS0zthDuq0mTnP5xUsbbXQdGMQv8jzX
        GQ6gG+UQ==;
Received: from [2001:4bb8:184:af1:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDiOk-0000Sw-44; Thu, 03 Sep 2020 06:07:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: improve the block queue sysfs helper macros
Date:   Thu,  3 Sep 2020 08:06:59 +0200
Message-Id: <20200903060701.229481-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series improves the macros to generate the queue sysfs boilerplate.

Diffstat:
 blk-sysfs.c |  272 +++++++++++++-----------------------------------------------
 1 file changed, 63 insertions(+), 209 deletions(-)
