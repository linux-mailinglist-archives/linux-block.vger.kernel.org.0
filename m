Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7A835AB83
	for <lists+linux-block@lfdr.de>; Sat, 10 Apr 2021 08:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbhDJGwt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 10 Apr 2021 02:52:49 -0400
Received: from verein.lst.de ([213.95.11.211]:42647 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231933AbhDJGwt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 10 Apr 2021 02:52:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 77DB367373; Sat, 10 Apr 2021 08:52:31 +0200 (CEST)
Date:   Sat, 10 Apr 2021 08:52:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Steffen Maier <maier@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Khalid Aziz <khalid@gonehiking.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Ondrej Zary <linux@rainbow-software.org>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Benjamin Block <bblock@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH 5/8] scsi: remove the unchecked_isa_dma flag
Message-ID: <20210410065231.GA16173@lst.de>
References: <20210331073001.46776-1-hch@lst.de> <20210331073001.46776-6-hch@lst.de> <2fa7fad0-2689-24c9-d356-50f98ca3535d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fa7fad0-2689-24c9-d356-50f98ca3535d@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 09, 2021 at 05:46:09PM +0200, Steffen Maier wrote:
> Is it OK to remove a long standing sysfs attribute?
> Was there any deprecation phase?
>
> I just noticed it in our CI reporting fails due to this change since at 
> least linux-next 20210409. Suppose it came via 
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.13/block&id=aaff5ebaa2694f283b7d07fdd55fb287ffc4f1e9
>
> Wanted to ask before I adapt the test cases.

What does your CI do with it?

It would be kinda of sad to carry around this baggage, but if real
userspace is broken by the chance we'll have to do it.  I'm just not
entirely sure testcases qualify as real userspace yet.
