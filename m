Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB1420ED11
	for <lists+linux-block@lfdr.de>; Tue, 30 Jun 2020 06:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgF3E6R (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 30 Jun 2020 00:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgF3E6R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 00:58:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5625BC061755
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2020 21:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NfrIF2nrADGCCwEVy51kcXMR2iudhEXVzGYolR1qt6E=; b=cccFPV0xU3uBlbsk0SFdf1P3cd
        tNuPB9JenW8LkLDlBv8T4bvyMs0sGJGicEzNd5ht3O59GeioPORa7kGnYbDqea6LXxpaNzrdjdVYF
        BaK1tOMlnWXyGVfcH+vSj0xO+KfgIYx9Qtdb78/3mDgV8VqFZvKDHfJCYaR0pIoehXZi9fmpnV47K
        Rtf1E6ycT+IKK/KRJSzwBvipmnF4WyDDSDeVc6JNl1nTJJ7L3YhwIPOT6jx9V63cMSK4CoRWBRNDA
        7aEwmiMtBlwmM/eOmaPY69gTJLp+WVsVmDYU6/nEqNlvXxPHXZyLq/6Xz0OPaxSdLZLVi4OqMWZOJ
        0n++OxKg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jq8LX-0004ty-DW; Tue, 30 Jun 2020 04:58:15 +0000
Date:   Tue, 30 Jun 2020 05:58:15 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/3] blk-mq: move blk_mq_put_driver_tag() into blk-mq.c
Message-ID: <20200630045815.GD17653@infradead.org>
References: <20200630022356.2149607-1-ming.lei@redhat.com>
 <20200630022356.2149607-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630022356.2149607-3-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 30, 2020 at 10:23:55AM +0800, Ming Lei wrote:
> It is used by blk-mq.c only, so move it to the source file.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

