Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B463AEF162
	for <lists+linux-block@lfdr.de>; Tue,  5 Nov 2019 00:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbfKDXsm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 Nov 2019 18:48:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34728 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729595AbfKDXsm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 18:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fwh+7XdlA3kwIckKjJir6jJ95P1oMQ4Gl0PSeObXbKg=; b=jMYjxA/VYPzRAUu+Dc1DorMXe
        /zaVcXlhp727LLsQaPzDsYMHZdkek/46a0WI7M6r2jVZlGFA0jG5NaDc3xivG5YkawTN1kyUJ/DgQ
        UdRO9hjCiU4BNT20pDHnQI57eyiFjG8QcJVZhLmvWdBVwWBX8HJ8cITsCtoTvVlbldS2PB0bCwZ6g
        9DgwvCFBT1oH73DDTFqN+NtWcoCrahZWjIQFnJ76iuV/ydcDzh5dAsdkt8BnCaJGsJTVbrbBxDnVj
        BqdoMAP0NPHNA0//e1CRAkqEpvaUWuTzS1NdBmIAskyET4SXa5fm36/ERG6H0ZVZSNCEQ8nLKSRsK
        9rBYZ1cyQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iRm5R-00023w-QJ; Mon, 04 Nov 2019 23:48:41 +0000
Date:   Mon, 4 Nov 2019 15:48:41 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2] bdev: Refresh bdev size for disks without
 partitioning
Message-ID: <20191104234841.GA7593@infradead.org>
References: <20191021083132.5351-1-jack@suse.cz>
 <bdc9f71e-09ea-9a4c-08fd-d5b60263f11d@kernel.dk>
 <20191104080847.GA22379@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104080847.GA22379@quack2.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 04, 2019 at 09:08:47AM +0100, Jan Kara wrote:
> Thanks Jens! I'll look into refactoring the size change / revalidation code
> so that it's easier to understand what's going on...

I actualy have a series for this.  I've started rebasing it on top
of you work and will need to do some testing.  My current WIP is here:

http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/partition-cleanup
