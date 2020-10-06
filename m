Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D4A2846C4
	for <lists+linux-block@lfdr.de>; Tue,  6 Oct 2020 09:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgJFHH1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Oct 2020 03:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgJFHH0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 03:07:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49877C0613D1
        for <linux-block@vger.kernel.org>; Tue,  6 Oct 2020 00:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Ff2jFJh0FRndRP3bl2afs5fC24CFNg6Ah2U3NllsnAI=; b=q/raBzteDwp4tg/Hh3t0Rl2Rq1
        dl/tvEFHF+bEzckGg4irikqfx6P0v7WGLLVWnVWmHoWJn0anxwP64eeoqMUpMKqooqc9HGqkq10oL
        AT7PwR3f1u7rQfhC7hpl1fxpLXj5/8X0I901zHVjo6tXaAxNLmBWnZyY5NNfFJHmgl5wREhOFsyCd
        pJ/Cp5T24Qvq7e5MXFc4JDPn41/yAK4O+ePs1vC3HuYXINYC65sWKYABaYQCQtFDam5tqVXeaZeEA
        C0Jxb4lmdJ9L/MJIpTOtVKWxlCnnWzjBB9l3UI20zX+EWCWcvwwxQfTJRd9k43Xyar3MyKEShfaiX
        1C70wQTQ==;
Received: from [2001:4bb8:184:92a2:9ae2:c87f:2c64:2882] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPh4D-0002X2-3c; Tue, 06 Oct 2020 07:07:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org
Subject: trivial block layer merging cleanups
Date:   Tue,  6 Oct 2020 09:07:16 +0200
Message-Id: <20201006070719.427627-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series has a bunch of trivial cleanups for the merging code.
