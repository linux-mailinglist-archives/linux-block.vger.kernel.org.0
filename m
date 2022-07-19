Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09B657924D
	for <lists+linux-block@lfdr.de>; Tue, 19 Jul 2022 07:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbiGSFHB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 19 Jul 2022 01:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiGSFHA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jul 2022 01:07:00 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0AAB84E;
        Mon, 18 Jul 2022 22:06:59 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 093F068AA6; Tue, 19 Jul 2022 07:06:56 +0200 (CEST)
Date:   Tue, 19 Jul 2022 07:06:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 09/10] md: only delete entries from all_mddevs when the
 disk is freed
Message-ID: <20220719050655.GA26785@lst.de>
References: <20220718063410.338626-1-hch@lst.de> <20220718063410.338626-10-hch@lst.de> <b8521a53-fb41-279c-dc43-580e8d0de045@suse.de> <CAPhsuW6VYLt0hPsa667mr5+Zn1pxjY_670NaD8+No=2ZjoOzYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW6VYLt0hPsa667mr5+Zn1pxjY_670NaD8+No=2ZjoOzYg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 18, 2022 at 11:20:39AM -0700, Song Liu wrote:
> > >   static inline struct mddev *mddev_get(struct mddev *mddev)
> > >   {
> > > +     lockdep_assert_held(&all_mddevs_lock);
> > > +
> > > +     if (mddev->deleted)
> > > +             return NULL;
> > >       atomic_inc(&mddev->active);
> > >       return mddev;
> > >   }
> >
> > Why can't we use 'atomic_inc_unless_zero' here and do away with the
> > additional 'deleted' flag?

> I think atomic_inc_unless_zero() should work here. Alternatively, we can
> also grab a big from mddev->flags as MD_DELETED.

s/big/bit/ ?

Yes, this could use mddev->flags.  I don't think atomic_inc_unless_zero
would work, as an array can have a refcount of 0 but we still allow
to take new references to it, the deletion only happens if the other
conditions in mddev_put are met.

Do you want me to repin the series using a flag?
