Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3C1700F93
	for <lists+linux-block@lfdr.de>; Fri, 12 May 2023 22:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjELUUU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 12 May 2023 16:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjELUUT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 16:20:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F68C3AA5
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 13:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v//jXC53eQelPPZES2NMMfhOcwsfVIR2krz2SLTthY8=; b=M9FViGrrzlB2X2npLrzN5v+Fx+
        dmu7Z02w2Gv7go99kt2vJQXZ1TPgUEGM10kk9ClChKVRE1bZO8mURHwz1BXOpSo4KAm12N9BJW6bU
        OJmR96Vcy4DJ0GyDLpRup38CPvJlLMWYDTRUIVctk73mPqVts6Ck+Toq4AiMNvLAP1mRXavsrAr38
        ZkvloWoF72FneoLK/NxxV59kXCeGiNSVkkZdoDWQXymHDll7qcBieKY5P4JBZSBq78JuoIsnQioWl
        imf2VH+SpUc+dFtMRELPXlSt4d3nSL4mndVa9HisLAmZWV25U9qqi6xH6o5QIH1pSenLyMHNiZqx2
        r0nmXbGw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pxZFP-00Cs6Q-16;
        Fri, 12 May 2023 20:20:15 +0000
Date:   Fri, 12 May 2023 13:20:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Guangwu Zhang <guazhang@redhat.com>,
        Yu Kuai <yukuai1@huaweicloud.com>
Subject: Re: [PATCH] blk-mq: don't queue passthrough request into scheduler
Message-ID: <ZF6ff2l7SKiCrTt0@infradead.org>
References: <20230512150328.192908-1-ming.lei@redhat.com>
 <70478f95-2852-9bf1-f8f7-630c74641c0f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70478f95-2852-9bf1-f8f7-630c74641c0f@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 12, 2023 at 09:08:54AM -0600, Jens Axboe wrote:
> On 5/12/23 9:03?AM, Ming Lei wrote:
> > Passthrough(pt) request shouldn't be queued to scheduler, especially some
> > schedulers(such as bfq) supposes that req->bio is always available and
> > blk-cgroup can be retrieved via bio.
> > 
> > Sometimes pt request could be part of error handling, so it is better to always
> > queue it into hctx->dispatch directly.
> > 
> > Fix this issue by queuing pt request from plug list to hctx->dispatch
> > directly.
> 
> Why not just add the check to the BFQ insertion? That would be a lot
> more trivial and would not be poluting the core with this stuff.

Because we really need to keep the passthrough code separate.  The
fact that a passthrough request can leak into common code in various
places is really a bit of a problem.  We have most of these nicely
separate with two exceptions:

 - the plug list
 - the requeue list

The higher level and the more obvious we special case the passthrough
request there, the better for debuggability and maintainability.
