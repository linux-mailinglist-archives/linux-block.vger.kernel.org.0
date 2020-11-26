Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2304A2C5128
	for <lists+linux-block@lfdr.de>; Thu, 26 Nov 2020 10:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389407AbgKZJ0w (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Nov 2020 04:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389405AbgKZJ0v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 04:26:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27FFC0613D4
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 01:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=sIxrjYYGY/DG65N02a5zfcHxju
        u1dtDeUL/J4hJzXa1PJ2mHu95Corgrc3qVSksK4ZW4zMnwRWBIqCR2Lc2f/KTlmUe0Hsg8sd1zktp
        Qqic9tzFd3VDY5oaCPLSvlPSBJubw/imu5jRqA+pXRMzDrYbcwAmcYfBtOAayuhWrVNBeHCuzr0fw
        VminCFqwTcJaS3zhvZ+GFxBFTEfjzHnzoEZfs3BozLHDxeSqGqpyxBcUJ0TESAExaJddzrQiY4zBC
        bVub3fAuI92ii/sBx8AlHTBcg3GecpgpKLvdyYhLk3UffMCo6+2llEFW3o1orokNsFoL1cUdlEhEX
        eQnA5Qeg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiDY8-0006xP-MB; Thu, 26 Nov 2020 09:26:48 +0000
Date:   Thu, 26 Nov 2020 09:26:48 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v9] block: disable iopoll for split bio
Message-ID: <20201126092648.GA26667@infradead.org>
References: <20201126091852.8588-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126091852.8588-1-jefflexu@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
