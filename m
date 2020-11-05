Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B1B2A7859
	for <lists+linux-block@lfdr.de>; Thu,  5 Nov 2020 08:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgKEHyF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 5 Nov 2020 02:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgKEHyE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Nov 2020 02:54:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932C2C0613CF
        for <linux-block@vger.kernel.org>; Wed,  4 Nov 2020 23:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mOhOWDxrQ1uCMUW6Zl0QtcyfSeit42+ZAPakn17q4ng=; b=pD+aJ1++EsMGx16o96Y7zHt5/C
        H4NxV8Uj0cBmLhFo2n9/lZamjmRO8udLakRtmd6g6Iuq/c2/SB89Sv+0kp+OOEiJol/mXaMCP9AwD
        nH7pJSRGsVWlh+p3Mw5PrkSA2EhEVNLyddRgVjq1ndSZBdkVCXtSbFEj5+tC8Oo03R2Qqw+YzIlJf
        BojrQtJFaC4yYmxIn1NosyJRwcwnDbAsgbHbxKRWNegfnnFCuh19xcE+f+wbLlDzvL1XKpqEsfFLr
        q7kNg0mLIBjJapnJCcTjz0mR04ya0Xkhz4Edy/I5ny/ptmIVB09yaOwv68eQmRqEYjYgxM3CozEyT
        GgXCkAQw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaa5q-00057b-9t; Thu, 05 Nov 2020 07:54:02 +0000
Date:   Thu, 5 Nov 2020 07:54:02 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] null_blk: Set mq device as blocking with zoned mode
Message-ID: <20201105075402.GA19304@infradead.org>
References: <20201105065008.401112-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105065008.401112-1-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 05, 2020 at 03:50:08PM +0900, Damien Le Moal wrote:
> Commit aa1c09cb65e2 ("null_blk: Fix locking in zoned mode") changed zone
> locking to using the potentially sleeping wait_on_bit_io() function. A
> zoned null_blk device must thus be marked as blocking to avoid calls to
> queue_rq() from invalid contexts triggering might_sleep() warnings.

That's going to have a fair amount of overhead.  Can't you change the
locking to avoid blocking?
