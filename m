Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC435004E2
	for <lists+linux-block@lfdr.de>; Thu, 14 Apr 2022 05:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239790AbiDNEAp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 14 Apr 2022 00:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiDNEAp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Apr 2022 00:00:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0199B1EAD6
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 20:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649908700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jg1rZH24EckI+v9QyBfJtar9AT8HpG0UvbbpNpJYo60=;
        b=GoBQSCV0Ku11/PJBCU0varaVXazJTIfWzORxbUkCWmTvOXLzOe4atYxLGK1M/nF8mYdFUN
        eNEBdZ2xh1LelBNpI9TYKnjrHgXRyq8NirFXz8bq3Fs7MY/+A5osUANWYAkd6eSqZhUlzc
        dEOvTRMssnymPeOhLE9u5FRN1x3k/OM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-9Nb3WGG7PACLD9L03PSN1Q-1; Wed, 13 Apr 2022 23:58:16 -0400
X-MC-Unique: 9Nb3WGG7PACLD9L03PSN1Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 687293806706;
        Thu, 14 Apr 2022 03:58:16 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E8E912166B4F;
        Thu, 14 Apr 2022 03:57:59 +0000 (UTC)
Date:   Thu, 14 Apr 2022 11:57:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 5/8] dm: always setup ->orig_bio in alloc_io
Message-ID: <YlebwjTKH2MU9tCD@T590>
References: <20220412085616.1409626-1-ming.lei@redhat.com>
 <20220412085616.1409626-6-ming.lei@redhat.com>
 <YlXmmB6IO7usz2c1@redhat.com>
 <YlYt2rzM0NBPARVp@T590>
 <YlZp3+VrP930VjIQ@redhat.com>
 <YlbBf0mJa/BPHSSq@T590>
 <YlcPXslr6Y7cHOSU@redhat.com>
 <Yldsqh2YsclXYl3s@T590>
 <YleGKbZiHeBIJidI@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YleGKbZiHeBIJidI@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 13, 2022 at 10:25:45PM -0400, Mike Snitzer wrote:
> On Wed, Apr 13 2022 at  8:36P -0400,
> Ming Lei <ming.lei@redhat.com> wrote:
> 
> > On Wed, Apr 13, 2022 at 01:58:54PM -0400, Mike Snitzer wrote:
> > > 
> > > The bigger issue with this patch is that you've caused
> > > dm_submit_bio_remap() to go back to accounting the entire original bio
> > > before any split occurs.  That is a problem because you'll end up
> > > accounting that bio for every split, so in split heavy workloads the
> > > IO accounting won't reflect when the IO is actually issued and we'll
> > > regress back to having very inaccurate and incorrect IO accounting for
> > > dm_submit_bio_remap() heavy targets (e.g. dm-crypt).
> > 
> > Good catch, but we know the length of mapped part in original bio before
> > calling __map_bio(), so io->sectors/io->offset_sector can be setup here,
> > something like the following delta change should address it:
> > 
> > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > index db23efd6bbf6..06b554f3104b 100644
> > --- a/drivers/md/dm.c
> > +++ b/drivers/md/dm.c
> > @@ -1558,6 +1558,13 @@ static int __split_and_process_bio(struct clone_info *ci)
> >  
> >  	len = min_t(sector_t, max_io_len(ti, ci->sector), ci->sector_count);
> >  	clone = alloc_tio(ci, ti, 0, &len, GFP_NOIO);
> > +
> > +	if (ci->sector_count > len) {
> > +		/* setup the mapped part for accounting */
> > +		dm_io_set_flag(ci->io, DM_IO_SPLITTED);
> > +		ci->io->sectors = len;
> > +		ci->io->sector_offset = bio_end_sector(ci->bio) - ci->sector;
> > +	}
> >  	__map_bio(clone);
> >  
> >  	ci->sector += len;
> > @@ -1603,11 +1610,6 @@ static void dm_split_and_process_bio(struct mapped_device *md,
> >  	if (error || !ci.sector_count)
> >  		goto out;
> >  
> > -	/* setup the mapped part for accounting */
> > -	dm_io_set_flag(ci.io, DM_IO_SPLITTED);
> > -	ci.io->sectors = bio_sectors(bio) - ci.sector_count;
> > -	ci.io->sector_offset = bio_end_sector(bio) - bio->bi_iter.bi_sector;
> > -
> >  	bio_trim(bio, ci.io->sectors, ci.sector_count);
> >  	trace_block_split(bio, bio->bi_iter.bi_sector);
> >  	bio_inc_remaining(bio);
> > 
> > -- 
> > Ming
> > 
> 
> Unfortunately we do need splitting after __map_bio() because a dm
> target's ->map can use dm_accept_partial_bio() to further reduce a
> bio's mapped part.
> 
> But I think dm_accept_partial_bio() could be trained to update
> tio->io->sectors?

->orig_bio is just for serving io accounting, but ->orig_bio isn't
passed to dm_accept_partial_bio(), and not gets updated after
dm_accept_partial_bio() is called.

If that is one issue, it must be one existed issue in dm io accounting
since ->orig_bio isn't updated when dm_accept_partial_bio() is called.

So do we have to update it?

> 
> dm_accept_partial_bio() has been around for a long time, it keeps
> growing BUG_ONs that are actually helpful to narrow its use to "normal
> IO", so it should be OK.
> 
> Running 'make check' in a built cryptsetup source tree should be a
> good test for DM target interface functionality.

Care to share the test tree?

> 
> But there aren't automated tests for IO accounting correctness yet.

I did verify io accounting by running dm-thin with blk-throttle, and the
observed throughput is same with expected setting. Running both small bs
and large bs, so non-split and split code path are covered.

Maybe you can add this kind of test into dm io accounting automated test.


Thanks,
Ming

