Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8FF347FDB
	for <lists+linux-block@lfdr.de>; Wed, 24 Mar 2021 18:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbhCXRya (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 24 Mar 2021 13:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbhCXRyO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 13:54:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33268C061763
        for <linux-block@vger.kernel.org>; Wed, 24 Mar 2021 10:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZiBfODeomyuTigUBXo5s1eRclCIXhL2WWaW+suptxpw=; b=EJPFw2vRiBfeiL7W0l/Vx3aNWR
        TY5KCpXWbs0Djm0ftvD7CPYn2QLBKXBQeMlCeWuE7bjGykICvwHv6BA4esj/Jq7qQU5ms1Lyi3eQr
        jW3n8hXTY8/sroZTSO8CyB4cmE140IQNpHot7XtYh1nLkwz8yCBsgLtCa8GYLDO82IxnXMLCH7hCb
        rXN8CmIfHosp5VylPfa7v0RSs9gksRST3E00s17gdREwCSflhAvQ5bB9pmWsKpFA2Kn3lvT7OhNGj
        C0QbeIk/4q+ZcEUt1NyyS2UXXNAuIg7zn3PjCFicZqcKJOZGIxgH9gE1TzfLtNkHbrIuTm/vE8+IF
        wftFqX4g==;
Received: from [2001:4bb8:191:f692:b499:58dc:411a:54d1] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lP7ho-004Dao-TP; Wed, 24 Mar 2021 17:54:09 +0000
Date:   Wed, 24 Mar 2021 18:54:06 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V3 01/13] block: add helper of blk_queue_poll
Message-ID: <YFt8vpnRHZ0CRN2O@infradead.org>
References: <20210324121927.362525-1-ming.lei@redhat.com>
 <20210324121927.362525-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324121927.362525-2-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 24, 2021 at 08:19:15PM +0800, Ming Lei wrote:
> There has been 3 users, and will be more, so add one such helper.
> 
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Can't say I'm a huge fan of these wrappers that obsfucate what
actually is checked here.  But it does fit the style used for
other flags.
