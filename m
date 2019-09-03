Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D85A3A64AA
	for <lists+linux-block@lfdr.de>; Tue,  3 Sep 2019 11:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfICJGd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 3 Sep 2019 05:06:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbfICJGd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Sep 2019 05:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oBjpCRpRDQSJHiqEdgIm+/1wOaU8qzMDDxE9rA0ssJY=; b=Xdg+yHeFJZjvJo1iPHsGiKmdO
        IZ7nuJrkyxzp081wstVMDBwZ6ZKLyOdCfyPsRXqfHJUqTIeIhuNLjkTTFg9rV0mPmJwgoLlTipPkJ
        FcUF2CMNrjuyHTnGwbaeZwtzu8hmC9iPv6+w2d3S4C8LHIpm4HZJJ9woJFBfs74BE9LMLDynU+hs0
        +PSEx8kmc4Jcr6Va485ylnhdsKJJarLxYRD/ajlEjxrmp7/x30fHQcvfer2zrn29VCVc4Aor9n/of
        InW5AeXam1HkyXY5zcI/CUQhcZyt0L6IwcTQEPATJxEMdvZIaA9hfsiHson/Ll4F+GUlo4moGIQ3l
        u44eI4HsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i54ll-0002lM-5U; Tue, 03 Sep 2019 09:06:33 +0000
Date:   Tue, 3 Sep 2019 02:06:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v2 2/4] kernel-parameters.txt: Remove elevator argument
Message-ID: <20190903090633.GB10407@infradead.org>
References: <20190828011930.29791-5-marcos.souza.org@gmail.com>
 <20190901232916.4692-1-marcos.souza.org@gmail.com>
 <20190901232916.4692-3-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901232916.4692-3-marcos.souza.org@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Sep 01, 2019 at 08:29:14PM -0300, Marcos Paulo de Souza wrote:
> This argument was not being used since the legacy IO path was removed,
> when blk-mq was enabled by default. So removed it from the kernel
> parameters documentation.
> 
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
> Reviewed-by: Hannes Reinecke <hare@suse.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

That beeing said I would have folded it into the previous patch.
