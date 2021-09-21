Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F182412EA3
	for <lists+linux-block@lfdr.de>; Tue, 21 Sep 2021 08:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhIUGdl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 21 Sep 2021 02:33:41 -0400
Received: from verein.lst.de ([213.95.11.211]:55122 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhIUGdk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 02:33:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5C95C67373; Tue, 21 Sep 2021 08:32:09 +0200 (CEST)
Date:   Tue, 21 Sep 2021 08:32:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-block@vger.kernel.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Subject: Re: [PATCH 3/3] block: warn if ->groups is set when calling
 add_disk
Message-ID: <20210921063209.GA23736@lst.de>
References: <20210920072726.1159572-1-hch@lst.de> <20210920072726.1159572-4-hch@lst.de> <CAPcyv4iVL7bevm_MeFnkRK12SkwO4k5aR3-4KOAGMxThmJwOuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iVL7bevm_MeFnkRK12SkwO4k5aR3-4KOAGMxThmJwOuA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 20, 2021 at 04:50:03PM -0700, Dan Williams wrote:
> >
> >         ddev->parent = parent;
> > -       ddev->groups = groups;
> > +       if (!WARN_ON_ONCE(ddev->groups))
> > +               ddev->groups = groups;
> 
> That feels too compact to me, and dev_WARN_ONCE() might save someone a
> git blame to look up the reason for the warning:
> 
>     dev_WARN_ONCE(parent, ddev->groups, "unexpected pre-populated
> attribute group\n");
>     if (!ddev->groups)
>         ddev->groups = groups;
> 
> ...but not a deal breaker. Either way you can add:
> 

I'd rather keep it simple and optmize for the normal case..
