Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459581D12E4
	for <lists+linux-block@lfdr.de>; Wed, 13 May 2020 14:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbgEMMiq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 May 2020 08:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbgEMMiq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 08:38:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07428C061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 05:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q44iWygWB8NbxugxBweN047hcJFs3ZJ3q++GfUyXrak=; b=j4TW6C2HqyrI+wszf28vHTHyUL
        Rxu2ye8hCwiFB9LGU7mOxVOuxBb8sWkAmkvj+ogcLGtQ5mMVyQ3s46bqoKPtTEXOwr7atoeI5x7e7
        cfDIFmX3u6UiIXQTXARQBgJJ4m4WBXjUs7BPwURaez5cOsbCheoYpaieLNPZIsz+5XZr3e6WWRD1T
        BNRhoHr76SHshZQoEGi+BpMOCvYXNv4Fl6gNuzjsFJElD863XKkmNRgHoXrsGUClVC0pxuej8RtTl
        /kTdK44YTdBn815VkzFm2FbWw+mc7bvdwF1aMhIX9ydCUzmXTwqyjUQNrd0HTQWLX8MdIPwlER7hW
        kVrasYYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYqeq-0004pZ-Pn; Wed, 13 May 2020 12:38:44 +0000
Date:   Wed, 13 May 2020 05:38:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 5/9] blk-mq: move .queue_rq code into one helper
Message-ID: <20200513123844.GE23958@infradead.org>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
 <20200513095443.2038859-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513095443.2038859-6-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 13, 2020 at 05:54:39PM +0800, Ming Lei wrote:
> Move code for queueing rq into one helper, so that blk_mq_dispatch_rq_list
> gets a bit simpified, and easier to read.
> 
> No functional change.

I don't see much benefit.  Especially moving the list_del out of the
main function doesn't really help readability.
