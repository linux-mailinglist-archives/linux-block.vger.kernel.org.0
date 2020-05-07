Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051031C8E35
	for <lists+linux-block@lfdr.de>; Thu,  7 May 2020 16:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgEGOQj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 7 May 2020 10:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgEGOQj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 May 2020 10:16:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A3BC05BD43
        for <linux-block@vger.kernel.org>; Thu,  7 May 2020 07:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uO7tl0cp162HcXhxD1NkPPYsYQdQT6SqKhLOaP9lrf8=; b=PjZ+HGc3kcFW3GiXAQ1s7/DVmo
        Fe1igo8Ws38TbL5S3fhaLxCaejwmyAWrXQhpceVANbUBiYgwN/R9phHe/r3g9ccDcR80pkpxM0l6C
        EEI8Rrz/KszAOthXzecD+HNbKsstk+29RW5rtsFViff36rOO+Jcxtm0Nte1SqHJhh06VLLGciCj4N
        L+G/0fWh8ERJ7O08ORhxFEpgzeAohid3i9KnQubg3djApKZcW9/J4QM7v50ox3CHvfLeDKJslngf5
        4l4MRP+yPsu11NiXlH5+040egFDvoCtyt0Lxsr2Ya31yeK77oTXWrVsV9dQwaqXzUFLJNvOkwWfQA
        KR/DGPCw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWhKI-0002C8-Hz; Thu, 07 May 2020 14:16:38 +0000
Date:   Thu, 7 May 2020 07:16:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: Re: [PATCH 2/4] block: only define 'nr_sects_seq' in hd_part for
 32bit SMP
Message-ID: <20200507141638.GB11551@infradead.org>
References: <20200507085239.1354854-1-ming.lei@redhat.com>
 <20200507085239.1354854-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507085239.1354854-3-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 07, 2020 at 04:52:37PM +0800, Ming Lei wrote:
> The seqcount of 'nr_sects_seq' is only needed in case of 32bit SMP,
> so define it just for 32bit SMP.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
