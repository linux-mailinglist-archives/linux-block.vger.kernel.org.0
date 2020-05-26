Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE81C1D12DF
	for <lists+linux-block@lfdr.de>; Wed, 13 May 2020 14:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbgEMMhd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 May 2020 08:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729975AbgEMMhd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 08:37:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC97C061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 05:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=VKQArHr+x1FSI7a5LzSZ1cPP7K
        q37O5DHBaJY/StgbxQIDuKBbLeRHKpZS3aQ2aOWMHVMIfj1Ut8awfJwK3pSPQkduXECM/Q/3hf+Wc
        H4jSvrgmYpiJukBkkqKJw91ymN+ZIqfmU/mS9WPEbA+Cc4r+3sXjuJf6K9dQRK2vndWWayEopCCBp
        qC9ckDEhe2ga1g/4UeWNuNVyIpm5XZm3SEHExrXJYVO3VClqGRmX+FlxwHOuc3iNo9FcJvyr0naHc
        ogQml041j9SkPTsJyVYIXXheNcyXH392kO5CZ/YeOsJTj5WTF9vFcBx72sTaFPE0/vSeqNr4CHd26
        Xt9KQF/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYqdg-0004ks-Fu; Wed, 13 May 2020 12:37:32 +0000
Date:   Wed, 13 May 2020 05:37:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/9] blk-mq: move getting driver tag and bugget into one
 helper
Message-ID: <20200513123732.GD23958@infradead.org>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
 <20200513095443.2038859-5-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513095443.2038859-5-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
