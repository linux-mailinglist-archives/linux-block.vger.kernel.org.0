Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DCC24B104
	for <lists+linux-block@lfdr.de>; Thu, 20 Aug 2020 10:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgHTI3X (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 Aug 2020 04:29:23 -0400
Received: from verein.lst.de ([213.95.11.211]:41242 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgHTI3W (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Aug 2020 04:29:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B6C3868AFE; Thu, 20 Aug 2020 10:29:18 +0200 (CEST)
Date:   Thu, 20 Aug 2020 10:29:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de
Subject: Re: [PATCH 1/3] nvme-core: improve avoiding false remove namespace
Message-ID: <20200820082918.GA12926@lst.de>
References: <20200820035357.1634-1-lengchao@huawei.com> <ead8ccd0-d89d-b47e-0a6f-22c976a3b3a6@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ead8ccd0-d89d-b47e-0a6f-22c976a3b3a6@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 19, 2020 at 09:33:22PM -0700, Sagi Grimberg wrote:
> We really need to take a step back here, I really don't like how
> we are growing implicit assumptions on how statuses are interpreted.
>
> Why don't we remove the -ENODEV error propagation back and instead
> take care of it in the specific call-sites where we want to ignore
> errors with proper quirks?

So the one thing I'm not even sure about is if just ignoring the
errors was a good idea to start with.  They obviously are if we just
did a rescan and did run into an error while rescanning a namespace
that didn't change.  But what if it actually did change?

So I think a logic like in this patch kinda makes sense, but I think
we also need to retry and scan again on these kinds of errors.  Btw,
did you ever actually see -ENOMEM in practice?  With the small
allocations that we do it really should not happen normally, so
special casing for it always felt a little strange.

FYI, I've started rebasing various bits of work I've done to start
untangling the mess.  Here is my current WIP, which in this form
is completely untested:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/nvme-scanning-cleanup
