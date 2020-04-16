Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E281AB772
	for <lists+linux-block@lfdr.de>; Thu, 16 Apr 2020 07:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406894AbgDPFg5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 Apr 2020 01:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406891AbgDPFgz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 01:36:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67B3C061A0C
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2020 22:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qb+jdoDJIU9fBJH5uTIamXl3JzkVNnuhRUHKDnvTIcY=; b=fJFbG/siCzethB36RhbQ1JUiYd
        6PU8f5DzrRBG3d97VxzrKCczVsHU8rFnCkpaOhd6ES+ju/14rg1GupxMkpVa2UM1EkK+TbAybcLCX
        AwmH84JZJxpDHfRyZpULmG0Sjp7I9gEJvw69Y3D/sXTkcgeAulXdz3ZTHGd7RGp+Dikjt5EsXl13q
        zuRoTtLt4s/Halzaa3+W2cQJTzeL+vXaqSn9UrTHlxrTn41Zxj2/9rF1GotQ9gltPeegG7QYAKH0C
        +Fa7ugO41Hcx27X423DLA9TbasotIeyb5f/hQpecEGEie2rdUYXlXPAZJCnrcx+WkWCHCKBz9MBYz
        q8elMx4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOxCl-0006hh-01; Thu, 16 Apr 2020 05:36:51 +0000
Date:   Wed, 15 Apr 2020 22:36:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, tj@kernel.org, bvanassche@acm.org,
        tytso@mit.edu, gregkh@linuxfoundation.org
Subject: Re: [PATCH v4 0/6] bdi: fix use-after-free for bdi device
Message-ID: <20200416053650.GA522@infradead.org>
References: <20200325123843.47452-1-yuyufen@huawei.com>
 <20200414155228.GA17487@infradead.org>
 <20200415093459.GH501@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415093459.GH501@quack2.suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 15, 2020 at 11:34:59AM +0200, Jan Kara wrote:
> Yeah, that's what I was suggesting as well [1] - especially since we
> already have bdi->name with a dubious value (but looking into it now, we
> would need a separate dev_name field since bdi->name is visible in sysfs so
> we cannot change that).

That is a little anoying, but not the end of the world.

> But Yufen explained to me that this could result in
> bogus name being reported when bdi gets re-registered. Not sure if that's
> serious enough but it could happen...

I don't think that is a problem at all.  If it is a problem we can just
replace the ->dev_name pointer with one that says "(unregistered)" at
unregister time, but to me that seems worse than just keeping the name
around.
