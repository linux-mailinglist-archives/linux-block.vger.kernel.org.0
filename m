Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17EAD388A45
	for <lists+linux-block@lfdr.de>; Wed, 19 May 2021 11:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344569AbhESJMq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 19 May 2021 05:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344419AbhESJMq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 05:12:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3661C06175F;
        Wed, 19 May 2021 02:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S+GXIxnyztqO6WpluIWtZxNepeT0kBKu2hEqSTJxobU=; b=IkAmWIHe0jueEAQlaREsEzo0f8
        TKeHznwF8uW08WoJ+YIgODPYSl3GGAeFvIuhSMr8MXx6V6GlXkpxL/ZGx9ZnXdzC7wGhrXt06bCbD
        ZP29KLxMauKxGoEP2j7NlwhRGDDQQ+tpc4RgnvayWm52AT+trmflBgK+dHA26UjkzFKriMHUOazjJ
        WgpAl84+1X9OM0cKCrAgth3p0wzVuBcseHPktB9FZkOKx8GvHNmarHqfiqAHB0+9AAKfJH3rfcVOi
        xLUHx/TmEVOyo4tgqYls1nVybghNzuLb5pD3ieaWjDCtJ8TxXxJjfCCT71NsXuTazwH+iGLx7xxc5
        cMzmI7Yw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljID6-00EnJl-3V; Wed, 19 May 2021 09:10:02 +0000
Date:   Wed, 19 May 2021 10:09:48 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: Re: [PATCH v2 3/3] block/Kconfig.iosched: Whitespace and indentation
 cleanups
Message-ID: <YKTV3Gr4mBznVfZL@infradead.org>
References: <20210519085615.12101-1-juergh@canonical.com>
 <20210519085615.12101-4-juergh@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519085615.12101-4-juergh@canonical.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 19, 2021 at 10:56:15AM +0200, Juerg Haefliger wrote:
> Replace multiple whitespaces with a tab and make the help text indendation
> 1 tab + 2 spaces which seems to be the convention.
> 
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
