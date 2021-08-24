Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8498F3F596F
	for <lists+linux-block@lfdr.de>; Tue, 24 Aug 2021 09:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbhHXHyJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 Aug 2021 03:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbhHXHyH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 03:54:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466A5C061575
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 00:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=M1dtIQSuJoglJXvW/+msAv181482a5Lu31gmC2TPC4E=; b=CQVP+0B1AyPwF6t6wwyOnWbAlC
        F2qEtIG5aAnOFPJoZRf9Mu/JdBwoGgCnfB6jeQHQsnwOrFw06Uv8e+6iPg+nh+Lmfu9Dz6konJtmQ
        nl0MLl4Bih/8CKCUu1c5rw58+fA+9wJR/1YvL3rK0Hm1AyKsdAj8cnVviLWoOFrXW8Juuk+Gm5e3P
        EOlXfOhzoFhHYD7qxfbJd5GRZH431Tq+dvH2wv0mfQIYVquguMPjbSf//LouixSndiqNOEeeLghVC
        Z8HZwxxhxxUQXxLivgoFeTmbG+DSIEq8ZMpDUAIbesFQhUwgijeI/i8mqnSRoHjn8O8XI20xDtySa
        ppVROm8Q==;
Received: from [2001:4bb8:193:fd10:f8c0:1a4c:b688:f5a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIREI-00AkM5-0V; Tue, 24 Aug 2021 07:52:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: extended dev_t tidyups
Date:   Tue, 24 Aug 2021 09:52:14 +0200
Message-Id: <20210824075216.1179406-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

two small tidyups for the extended dev_t code.  One removes
a not necessary maksing of a variable that already contains
the minor number, and the other removes some long obsolete
debugging code.
