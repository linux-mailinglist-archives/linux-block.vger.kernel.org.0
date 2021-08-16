Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F8D3EDA99
	for <lists+linux-block@lfdr.de>; Mon, 16 Aug 2021 18:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhHPQMp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 16 Aug 2021 12:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhHPQMp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 12:12:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CF2C061764
        for <linux-block@vger.kernel.org>; Mon, 16 Aug 2021 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZsWA0r06G7OeDyZcsrcZCuD02cJEzD/J089geosJ9vs=; b=WoACpXrk/AedqTI8YC6SYIG3aA
        cHwS1cUBiwH9wrY/OCZpV5inqF4qyIg5n5mSOMMV2DI/wNgckyBkVVlrPfMgn2OeSobiNyvuig4/x
        X+JJU96TotqkTD5E49SGud7TAh8+H48cFFhbpgKs1G0SAfsS83IVV8uMmi4j6/AxzcQ8nAaFP2uV3
        EvUv+Q8lO2tA3gWB2gd/x5CW9E2GlPIaQZE0GIFK2k6nLYMq8BcXsk1gmOwWk4IIdO4tsw7nm3OoQ
        e86oqGHZCU4GQdP7QgqcdkmVI1U/8LpBAJpRzRoS8ezNUmjfPbZ7ifhWadYTkV6j3M9CsP6K2zs+e
        yfaE7Prw==;
Received: from [2001:4bb8:188:1b1:3731:604a:a6cd:dc60] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFfCi-001Z7k-9p; Mon, 16 Aug 2021 16:11:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org
Subject: paride initialization cleanup
Date:   Mon, 16 Aug 2021 18:11:06 +0200
Message-Id: <20210816161110.909076-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

the paride drivers currently have a major Linux 1.x-style mess for
initializing the gendisks.  This series refactors them to be modular
and self-contained in preparation of error handling for add_disk.

Diffstat:
 pcd.c |  298 +++++++++++++++++++++++++++++-------------------------------------
 pd.c  |  142 +++++++++++++++----------------
 pf.c  |  223 +++++++++++++++++++++----------------------------
 3 files changed, 303 insertions(+), 360 deletions(-)
