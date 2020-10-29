Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BE029E529
	for <lists+linux-block@lfdr.de>; Thu, 29 Oct 2020 08:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbgJ2Hwy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 29 Oct 2020 03:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731157AbgJ2Hwj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 03:52:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56127C0613DA
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2020 00:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p3iQcYH361prErvGHX4sJGajGKvlZVvIrVGNwazv4CI=; b=T73gE+O7tTThyZi9IGPSq1ys8d
        YaiV1iI6guWUdhzdma52CNbF6i+nLLtFdyudo5M8UORGhcOGu+cfmRCN1KiOjFHjNsyolqTh9ZFoP
        UPSADMIqn1r59O547WtgWC1vrW0bJrkMd2cAs59pGMC1R+PRxitVe+8iDip9HuwEdHiFosxpUXvC5
        iSL3aQ+vGkB+yhf+YVwZNpKI1CumLZJhXt4AKRuAlNJLGh1AzsM8s65gZcKuBGz85nSxT3o/xFjYM
        rcfDQICa6nB5TBrpI8udbPWbeI89tdh4lPTqxhKT1gR4bOSlszpnpKjOmnV6OxH8BJX38jL6LeWXG
        PhlyoNjg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kY2ir-00024G-Bs; Thu, 29 Oct 2020 07:51:49 +0000
Date:   Thu, 29 Oct 2020 07:51:49 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        lining <lining2020x@163.com>, Josef Bacik <josef@toxicpanda.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] nbd: don't update block size after device is started
Message-ID: <20201029075149.GA1602@infradead.org>
References: <20201028072434.1922108-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028072434.1922108-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 28, 2020 at 03:24:34PM +0800, Ming Lei wrote:
> Mounted NBD device can be resized, one use case is rbd-nbd.
> 
> Fix the issue by setting up default block size, then not touch it
> in nbd_size_update() any more. This kind of usage is aligned with loop
> which has same use case too.

I think the only reasonable fix here is to remove the set_blocksize
call entirely.  The concept of block size set by it is a file system
construct and nbd has not business setting it at all.
