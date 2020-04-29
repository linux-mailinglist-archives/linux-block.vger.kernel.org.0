Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E401BD5F8
	for <lists+linux-block@lfdr.de>; Wed, 29 Apr 2020 09:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgD2H0C (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 Apr 2020 03:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgD2H0B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 03:26:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7229C03C1AD
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 00:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QU1zGj8/5O+pba0a5q9h4mkQe9EuzWQ61q7DzM4B3EY=; b=YP0vCmyWadsPB0D0JXgGmCsmAJ
        vCg0gBxpl5YAoCwUNxJtvlmCaMPIvVQJMSfJ4LyCNvhIg2KHl0IEhfy/mscG0Kbud2+vrtwHE0Hux
        fqDK6jZaJf7yeSyE2JG0gZpM9FKpNptc5mH/ra9gG+rMuoQKscK37vCpXPwYUre1deisF/A2jbvDL
        vyimXsvcAG/0xfYC0nT+e3Yff1jZES+roPQTd7U0aRJF/iR69nhQuk86roixBp9HYA7ZSxM3jA9xB
        YF8v6MaTtzmbUTuBPyUOewuiPS70pko6zTFq4Ci95IO0cyCQC8psEkwOsAY4SRLTWBJCbTeXoyXV/
        fxA8eNdw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTh6X-0000pn-2v; Wed, 29 Apr 2020 07:26:01 +0000
Date:   Wed, 29 Apr 2020 00:26:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zheng Bin <zhengbin13@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-mq: make function '__blk_mq_sched_dispatch_requests'
 static
Message-ID: <20200429072601.GD11410@infradead.org>
References: <20200429013632.38276-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429013632.38276-1-zhengbin13@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 29, 2020 at 09:36:32AM +0800, Zheng Bin wrote:
> Fix sparse warnings:
> 
> block/blk-mq-sched.c:209:5: warning: symbol '__blk_mq_sched_dispatch_requests' was not declared. Should it be static?

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
