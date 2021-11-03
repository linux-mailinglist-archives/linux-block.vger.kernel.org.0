Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD982444115
	for <lists+linux-block@lfdr.de>; Wed,  3 Nov 2021 13:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhKCMML (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 3 Nov 2021 08:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhKCMML (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Nov 2021 08:12:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29BAC061714;
        Wed,  3 Nov 2021 05:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CjPiVZ6CEwcX8p9oXTmszPrcj/hHgUiyD1EHf7MNfJ0=; b=XzurOMddznm+TyCj4XwsbSfH2s
        1YvfP1uoDLueWcdGH6UKl91Nyt8gDKHB0EJZ9p8GXoSZkeyuoSw8ro4Qpg/tDKhMXt+c9mW+5gvig
        1va8ZDP9Nh1ngmnObtCgD9fU47k2fhRPj3dXSX7Q+lTu01AKUdRC9it3Sa+tHTmhK+XCPW1Cv90gO
        R7V7DN8rv4o6RTbex5YLZcw3/fTiPGmDhJ63Nqpe7IxNAF3+ifnr4KV8D9upZ1LHWc4QF6we1wMvN
        WLVU2pP8uA+m+xTONlFSZ1fqKx40wQtgin3/iIOHuvwTzaVliOxqefui88Q0pUzR6ZvdAPQHMeiq9
        WniQlaUA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miF4r-0053yg-Mm; Wed, 03 Nov 2021 12:09:13 +0000
Date:   Wed, 3 Nov 2021 05:09:13 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jim Paris <jim@jtan.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, senozhatsky@chromium.org,
        Richard Weinberger <richard@nod.at>, miquel.raynal@bootlin.com,
        vigneshr@ti.com, Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-mtd@lists.infradead.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-nvme@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/13] nvdimm/blk: avoid calling del_gendisk() on early
 failures
Message-ID: <YYJ76awe81sC9CHw@bombadil.infradead.org>
References: <20211015235219.2191207-1-mcgrof@kernel.org>
 <20211015235219.2191207-7-mcgrof@kernel.org>
 <CAPcyv4j+xLT=5RUodHWgnPjNq6t5OcmX1oM2zK2ML0U+OS_16Q@mail.gmail.com>
 <YYHTejXKvsGoDlOa@bombadil.infradead.org>
 <CAPcyv4h1dqBm71OQ_A5Qv4agT3PhV7uoojmSB1pEpS-CXaWb5w@mail.gmail.com>
 <51f86768-04ca-bc7d-c17c-3d0357d84271@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51f86768-04ca-bc7d-c17c-3d0357d84271@kernel.dk>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 02, 2021 at 07:28:02PM -0600, Jens Axboe wrote:
> On 11/2/21 6:49 PM, Dan Williams wrote:
> > On Tue, Nov 2, 2021 at 5:10 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >>
> >> On Fri, Oct 15, 2021 at 05:13:48PM -0700, Dan Williams wrote:
> >>> On Fri, Oct 15, 2021 at 4:53 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >>>>
> >>>> If nd_integrity_init() fails we'd get del_gendisk() called,
> >>>> but that's not correct as we should only call that if we're
> >>>> done with device_add_disk(). Fix this by providing unwinding
> >>>> prior to the devm call being registered and moving the devm
> >>>> registration to the very end.
> >>>>
> >>>> This should fix calling del_gendisk() if nd_integrity_init()
> >>>> fails. I only spotted this issue through code inspection. It
> >>>> does not fix any real world bug.
> >>>>
> >>>
> >>> Just fyi, I'm preparing patches to delete this driver completely as it
> >>> is unused by any shipping platform. I hope to get that removal into
> >>> v5.16.
> >>
> >> Curious if are you going to nuking it on v5.16? Otherwise it would stand
> >> in the way of the last few patches to add __must_check for the final
> >> add_disk() error handling changes.
> > 
> > True, I don't think I can get it nuked in time, so you can add my
> > Reviewed-by for this one.
> 
> Luis, I lost track of the nv* patches from this discussion. If you want
> them in 5.16 and they are reviewed, please do resend and I'll pick them
> up for the middle-of-merge-window push.

Sure thing, I'll resend whatever is left. I also noticed for some reason
I forgot to convert nvdimm/pmem and so I'll roll those new patches in,
but I suspect that those might be too late unless we get them reviewed
in time.

  Luis
