Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A8A254990
	for <lists+linux-block@lfdr.de>; Thu, 27 Aug 2020 17:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgH0Phv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 27 Aug 2020 11:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0Phv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 11:37:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFAEC061264
        for <linux-block@vger.kernel.org>; Thu, 27 Aug 2020 08:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=lK33/eQXH/kp/btKCrcaXNgVnMKith2dpirznDXkgSA=; b=oYabEJ721rEVYPL/H3x4Ztv1kO
        zsC+cHDh4b5h25Dwdauu3uG2f4v8XpUM2IKI/1mj4JnbQnUBx7yyTBAcvrFqfIwYsyMb5fiTACcvb
        t7LnOABQOkwP6+/pJeg5ax8ST3ti9yiGI7FTl7O038D+yLevpc7v+2MXNRRQt7oJmXWqBz2vlQ/pG
        27V7cluaKsH191bH2WdEtgcsc53mIFn2gi70Wxv8uKwDiDje8/nsP1SBW2Lqp3hdYDX/1bIqDfa84
        0UIHHEti00Oq96QxUn9S/Fwmwzi0KRR3ABjuRj+/fYRubNVKesRQYTQSV7Mx/7lkmsIm3cmoKuDJm
        M2XK3NGw==;
Received: from [2001:4bb8:18c:45ba:9892:9e86:5202:32f0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBJyH-0006xM-7h; Thu, 27 Aug 2020 15:37:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: simlify the blk_rq_map* implementation and reclaim two bio flags
Date:   Thu, 27 Aug 2020 17:37:44 +0200
Message-Id: <20200827153748.378424-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series cleans up some of the passthrough remapping code, and as
part of that reclaims two bio flags.
