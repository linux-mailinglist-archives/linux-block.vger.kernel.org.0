Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F484C000B
	for <lists+linux-block@lfdr.de>; Tue, 22 Feb 2022 18:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbiBVRVi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Feb 2022 12:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiBVRVh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 12:21:37 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4480216EAB8
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 09:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ODZCuSBjQhksmUnbHy/MkBswdOY9450Nx3HESL8Ibmc=; b=k4ASTipm63Z1llNKMRWA9cTADp
        D+beWfiwG5naIa4o4Q5FlRcU0R75jOsvSQY2BFpMPF08Mb2Fa6QChkvflxs45yjoTNSYeUCX2BySD
        LhC2ik8uL1iJa1iCwxNx2EFAY3uP9HJGo7XeXbuY3iUOJ18NqSOXzVTX/1UnZRajQc1k7LkS0zzZe
        mO78qAb9sWKj0LJu2hVAiN6Cp5lCebz7PTy5hcdC94N572KLFbC6iPkOdC2DbG3NXzh1GPT+0mu5i
        eeIwU9OA3AozCTnPpL58Y4geibfWpOy4jrJUsipaWSguy9/EMxZZvN5hG/9lzXise6wQ6wLm9yfYK
        j+HaHQvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMYqc-00Awzo-S2; Tue, 22 Feb 2022 17:21:10 +0000
Date:   Tue, 22 Feb 2022 09:21:10 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme fixes for Linux 5.17
Message-ID: <YhUbhsy+C7Q16ihM@infradead.org>
References: <YgTB0csAbKyI5WvN@infradead.org>
 <d165d411-4499-12aa-fb59-05ff1e2faaa2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d165d411-4499-12aa-fb59-05ff1e2faaa2@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 10, 2022 at 06:57:10AM -0700, Jens Axboe wrote:
> On 2/10/22 12:42 AM, Christoph Hellwig wrote:
> > The following changes since commit b13e0c71856817fca67159b11abac350e41289f5:
> > 
> >   block: bio-integrity: Advance seed correctly for larger interval sizes (2022-02-03 21:09:24 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.infradead.org/nvme.git tags/nvme-5.17-2022-02-10
> 
> Pulled, thanks.

Looks like it isn't in the block-5.17 branch any more.  Should I
just resend it for this week?
