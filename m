Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 069B51943A6
	for <lists+linux-block@lfdr.de>; Thu, 26 Mar 2020 16:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgCZPz6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Mar 2020 11:55:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55358 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgCZPz6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Mar 2020 11:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6p7M0oF06E9R88/xU23XER6eK4MkYLCH3j3MxDEX7fw=; b=qPCV1RnsoX1EfevxTvJ7K14S0D
        bPw4mn5ohQol+5sF6Sk9KKiStYtLusdBF9m/78N5T6dAZQgZO15UF338ljaTBiDb2PTbvT05ZhFq+
        smn5z89yq4vQDdpFivGrQZQAuIbPI7zYLGc2qKIL1s0Oxapu+E3SQUaGUY7ni5/8ZTxzkP7DLtxrK
        IHw3XwZV5eL2ufFAjHq/gdfaZGECZy1dlwWhxPh8RJmrixEsSiNG3GH1N+Ii5CJzDb8NlQuFZK5HG
        Vumu4jlqDOUA+a+4AhQXQNqUontS51b5mDOwfohl+0BmNqas8VOwdZDtV2b+IrCPVmXnqSqfCPnJN
        ThfhlSQA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHUrN-0001x6-KM; Thu, 26 Mar 2020 15:55:57 +0000
Date:   Thu, 26 Mar 2020 08:55:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, kernel@collabora.com
Subject: Re: [PATCH RESEND 1/2] loop: Report EOPNOTSUPP properly
Message-ID: <20200326155557.GA6043@infradead.org>
References: <20200317151111.25749-2-andrzej.p@collabora.com>
 <20200317165106.29282-1-andrzej.p@collabora.com>
 <20200326145253.GA18623@infradead.org>
 <CAE=gft5w_8XwSGRNS6DZ0kppOihoUtYxrMfaTrM5eRifjBYYNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=gft5w_8XwSGRNS6DZ0kppOihoUtYxrMfaTrM5eRifjBYYNQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 26, 2020 at 08:51:21AM -0700, Evan Green wrote:
> On Thu, Mar 26, 2020 at 7:53 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, Mar 17, 2020 at 05:51:06PM +0100, Andrzej Pietrasiewicz wrote:
> > > From: Evan Green <evgreen@chromium.org>
> > >
> > > Properly plumb out EOPNOTSUPP from loop driver operations, which may
> > > get returned when for instance a discard operation is attempted but not
> > > supported by the underlying block device. Before this change, everything
> > > was reported in the log as an I/O error, which is scary and not
> > > helpful in debugging.
> >
> > This really should be using errno_to_blk_status.
> 
> I had that here in v7:
> https://lore.kernel.org/lkml/20191114235008.185111-1-evgreen@chromium.org/

Well, it wasn't in the version you sent the ping for..
