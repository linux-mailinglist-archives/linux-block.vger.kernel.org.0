Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5985135D74C
	for <lists+linux-block@lfdr.de>; Tue, 13 Apr 2021 07:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244403AbhDMFfo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 13 Apr 2021 01:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244195AbhDMFfo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 01:35:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFB7C061574;
        Mon, 12 Apr 2021 22:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4nHqymoUjhwuGUnmLwhbCBfP7uu8fV2kGYzvhzRXkp0=; b=nLg/6+EFx/gKW1kCBlF9LkCvAi
        quraJDOggmiiroJo5zhDcj0SYUZtyvwSZ2aGZ2sCQa/qkRZFSJ61VFpWMpaLN6FxkVSzHxPhq3AHS
        gEglJ2lsN0zi0tbijTBKx+YRo30/lCpeI3vu7j3PG758CzP6dWAXpKgbCgdNlJlOTPIu15UQY5y8+
        ur2z+S8A9svTBJdkEKaYJQ+gHC4goUHgcmdiznuNAYs6GqdbGHOBxw22CKJxgKFEwvG9tNXSFyhY4
        PJzLQs8UAEDqh73JeYyMaamI62001JKHj5W5ZLzUwZ4QvhkZ60EdK/mYEcvMDLr8PG27RAjDgrS2l
        vpyBo17w==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lWBfW-005IzO-5L; Tue, 13 Apr 2021 05:33:08 +0000
Date:   Tue, 13 Apr 2021 06:32:58 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Changheun Lee <nanich.lee@samsung.com>
Cc:     ming.lei@redhat.com, Damien.LeMoal@wdc.com,
        Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, bvanassche@acm.org, gregkh@linuxfoundation.org,
        hch@infradead.org, jisoo2146.oh@samsung.com,
        junho89.kim@samsung.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mj0123.lee@samsung.com,
        osandov@fb.com, patchwork-bot@kernel.org,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        tj@kernel.org, tom.leiming@gmail.com, woosung2.lee@samsung.com,
        yt0928.kim@samsung.com
Subject: Re: [RESEND,v5,1/2] bio: limit bio max size
Message-ID: <20210413053258.GA1264305@infradead.org>
References: <YHO9LQUt1e0J6+l9@T590>
 <CGME20210413045517epcas1p32b058646dd795e59389401ca997c4cac@epcas1p3.samsung.com>
 <20210413043733.28880-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413043733.28880-1-nanich.lee@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

And more importantly please test with a file system that uses the
iomap direct I/O code (btrfs, gfs2, ext4, xfs, zonefs) as we should
never just work aroudn a legacy codebase that should go away in the
block layer.
