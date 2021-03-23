Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665B434663D
	for <lists+linux-block@lfdr.de>; Tue, 23 Mar 2021 18:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhCWRZd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 Mar 2021 13:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhCWRZF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 13:25:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C94FC061574;
        Tue, 23 Mar 2021 10:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ctH3/GX/nBozXg2N2Ovzg6pqL698nNQj+uNQZVeo0SI=; b=KDCKEfKiLv3e+MQ2bIpRcf9hR2
        27l56euS0eGXlguc0ZZPXINXb3CQGglD3EuuTV6jVb1YKVy/LVlg5kw6D1JB7da5yuRmeBcvUbex8
        50PKU8nsCZ7ZvgP11YfLjEsDj8a6zqHynWmCMPiq45rjxLg10bxY6g+OEAzKVL9HjQYLPiYY7O4St
        rsY+cjAkhFlkM5j8xVB5a/OIz5Vt5bSrCFSpqWrZv7eCw92tb8mEdZAGvG0rMRIjtSjtEJ07SuXd5
        Eoel3D7kVqvRIKC35cSISz2F0SJ22028hqlvBw/XPBFItQ7UpEwZdegyxmd23LBXjtN3fuJuobRdW
        0c5wQ78A==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOklh-00AKzg-PP; Tue, 23 Mar 2021 17:24:49 +0000
Date:   Tue, 23 Mar 2021 17:24:37 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] block/umem: convert tasklet to threaded irq
Message-ID: <20210323172437.GA2463754@infradead.org>
References: <20210323004856.10206-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323004856.10206-1-dave@stgolabs.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 22, 2021 at 05:48:56PM -0700, Davidlohr Bueso wrote:
> Tasklets have long been deprecated as being too heavy on the system
> by running in irq context - and this is not a performance critical
> path. If a higher priority process wants to run, it must wait for
> the tasklet to finish before doing so. A more suitable equivalent
> is to converted to threaded irq instead and deal with the async
> processing in task context.

I'm really curious if this driver is still in use at all, or if we
can drop it.
