Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF34C1D1293
	for <lists+linux-block@lfdr.de>; Wed, 13 May 2020 14:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbgEMMZA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 May 2020 08:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731489AbgEMMZA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 08:25:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C73C061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 05:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=jQO4I/YhX/SRB+GlMC0WxV/9iv
        6gojQZys+cVDZHFt+OAgN7WaaxPelqrOscxOjE4NtIcU7Ns+QulMVsrIeWzlTLP8g0AtJpQ/VM/aa
        Zgu7+sD/lueUB4jwD/yKzFctTkYA1yZVs09jNsgpdew/tzo96m8Zpf6kuzJk3Pq76zF8/RlWnYm9m
        VKl78FgO+FPA0Jq6AsqEeyb9zUWV+DFXG7sRLCRUu4jlODimVg1LTsP7Dyfxf4u7vBH0l0G3Qci9R
        d0ws1D4VZW/q/e3R+Wg0/9agkjkKFc9mfAorbbvtmBUBJOKub5V7bBb7i1PjTPcFD+EVj3xDig/zH
        QyaO//yg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYqRU-0003WW-9w; Wed, 13 May 2020 12:24:56 +0000
Date:   Wed, 13 May 2020 05:24:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/9] blk-mq: pass request queue into get/put budget
 callback
Message-ID: <20200513122456.GA23958@infradead.org>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
 <20200513095443.2038859-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513095443.2038859-2-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
