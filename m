Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F2B41A70F
	for <lists+linux-block@lfdr.de>; Tue, 28 Sep 2021 07:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbhI1F1R (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Sep 2021 01:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbhI1F1Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Sep 2021 01:27:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704CFC061604;
        Mon, 27 Sep 2021 22:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NPzymWGZFZtOe+/jKRLbVu5DHM/rAWyTP2BsW0jWWww=; b=Y0f7Dd33ee5lwoWyq+hGjkHpRY
        ZJSXiwIPf1WeFsInpvFPzHSupGwHwdq/mLNc3gzXPT13ulK0dWgLGT/KiB57wEc9qdY3JKK80LRDc
        yEGi1Ehvg9ftTz68tUMsIbcwbC7+UCznNj4v4x5c/Gf0mCI5GYEgbakV24riqWCPUKYEDSqJYp0ns
        smKAnxOfCJxHLLN3zY5m8Frt/u0Ac2YWIE3eoFp+6wCz5qRvfWxa7KezBJTN8desq+SEHTWda8IjI
        26PSuhx0FhFRFboEL+usfS6uhnHVROEibZu6I81r4EsZk66nVYNCjY0SSy4rL5st6BThzHjJ1Rc8+
        jSM/Eh3Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mV5bU-00AWDA-1t; Tue, 28 Sep 2021 05:24:48 +0000
Date:   Tue, 28 Sep 2021 06:24:32 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 0/4] block: clean up Kconfig and Makefile
Message-ID: <YVKnECFT5nieGg+G@infradead.org>
References: <20210927140000.866249-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927140000.866249-1-masahiroy@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The whole series looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
