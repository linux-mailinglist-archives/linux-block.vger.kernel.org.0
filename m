Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2A2728C6D
	for <lists+linux-block@lfdr.de>; Fri,  9 Jun 2023 02:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjFIA3H (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 8 Jun 2023 20:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFIA3G (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Jun 2023 20:29:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE92F132
        for <linux-block@vger.kernel.org>; Thu,  8 Jun 2023 17:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686270500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dZ0yORwAdXDCRd2fZyWQ1kLxeAr//tPmWz4kXkYhyTs=;
        b=L/cueAdDOzvLN/LhEGtJ8Q5NcTHkbb3qRA6MK0SvQUgzaCOn/wJpsAjC6PerGjvgheFAhO
        c6VW8nVvdJyj53ipHrlhSYBFeMWLW/eiVEptDgViNo9UAkimdV7Fh99t/FqH0GoXaLh/15
        kyJxDPW0trMEMUSqYXuGsMdqn5UiV80=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-vt6TsPAKM2G6KVnu0XAOIA-1; Thu, 08 Jun 2023 20:28:19 -0400
X-MC-Unique: vt6TsPAKM2G6KVnu0XAOIA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-75d8e5ddc93so150408385a.0
        for <linux-block@vger.kernel.org>; Thu, 08 Jun 2023 17:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686270498; x=1688862498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZ0yORwAdXDCRd2fZyWQ1kLxeAr//tPmWz4kXkYhyTs=;
        b=kSZlQJEi6pfm0WzU0NYBh5UC8sRJ+vkGdO+fqqT9Q6fvepfjk1XVZLyU4dvUnHyJlv
         PsgE5lJWz0T8Udra/W9m+MIhPOebPGdXMDpkcTwVYPm0Hq/lFlNoZVIweuQkMFCaNJ5L
         8gph/OkZ4rpTbQhwFKyENego9lcdOIZ0uFrkBFknbV7Z0/FmGw7QbJ0iLMpQPlmjx529
         fUFoYoqfHOB2jm5saDc0FWAXwJ6HioWTxQebq4wj1oovppt1lce9IHwCW53IHrHnjAf4
         8+obB+seB1K7wQSkMgtkMgCpYOzrwuIx9JYGTfnbGtCkmUhn05hBEldQ7Wa/PZiZGMf5
         wbmg==
X-Gm-Message-State: AC+VfDwoqZSM82e8+HbhbYNmrFmR/mUiVe6/iUwooH3T63MabrOxlpd4
        BY8N+paxf33k4bg1/JghoR04x5BD5xMdUU8PzY1H90tnUlnTBNdAfo5ynfEmjDNMMxyu2EYm6b/
        OmqIklLttqLk7P6fU7SVU5g==
X-Received: by 2002:a05:620a:2810:b0:75b:23a1:830c with SMTP id f16-20020a05620a281000b0075b23a1830cmr6973256qkp.7.1686270498616;
        Thu, 08 Jun 2023 17:28:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5VNYOErVU972i4sJBtGLp/lGfEdbBIVxwb21zSx3OzLfsQlP0gnu+6DNqAnZHJO5hi85SI6A==
X-Received: by 2002:a05:620a:2810:b0:75b:23a1:830c with SMTP id f16-20020a05620a281000b0075b23a1830cmr6973236qkp.7.1686270498360;
        Thu, 08 Jun 2023 17:28:18 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id m14-20020a05620a13ae00b0075da00ef114sm693183qki.46.2023.06.08.17.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 17:28:17 -0700 (PDT)
Date:   Thu, 8 Jun 2023 20:28:16 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>,
        Joe Thornber <ejt@redhat.com>,
        Brian Foster <bfoster@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Theodore Ts'o <tytso@mit.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH v7 4/5] dm-thin: Add REQ_OP_PROVISION support
Message-ID: <ZIJyIOIPx+jE9/iv@redhat.com>
References: <20230518223326.18744-1-sarthakkukreti@chromium.org>
 <20230518223326.18744-5-sarthakkukreti@chromium.org>
 <ZGeUYESOQsZkOQ1Q@redhat.com>
 <ZIJHH+ekx59+6Uu0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIJHH+ekx59+6Uu0@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 08 2023 at  5:24P -0400,
Mike Snitzer <snitzer@kernel.org> wrote:

> On Fri, May 19 2023 at 11:23P -0400,
> Mike Snitzer <snitzer@kernel.org> wrote:
> 
> > On Thu, May 18 2023 at  6:33P -0400,
> > Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:
> > 
> > > dm-thinpool uses the provision request to provision
> > > blocks for a dm-thin device. dm-thinpool currently does not
> > > pass through REQ_OP_PROVISION to underlying devices.
> > > 
> > > For shared blocks, provision requests will break sharing and copy the
> > > contents of the entire block. Additionally, if 'skip_block_zeroing'
> > > is not set, dm-thin will opt to zero out the entire range as a part
> > > of provisioning.
> > > 
> > > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > > ---
> > >  drivers/md/dm-thin.c | 74 +++++++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 70 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> > > index 2b13c949bd72..f1b68b558cf0 100644
> > > --- a/drivers/md/dm-thin.c
> > > +++ b/drivers/md/dm-thin.c
> > > @@ -1245,8 +1247,8 @@ static int io_overlaps_block(struct pool *pool, struct bio *bio)
> > >  
> > >  static int io_overwrites_block(struct pool *pool, struct bio *bio)
> > >  {
> > > -	return (bio_data_dir(bio) == WRITE) &&
> > > -		io_overlaps_block(pool, bio);
> > > +	return (bio_data_dir(bio) == WRITE) && io_overlaps_block(pool, bio) &&
> > > +	       bio_op(bio) != REQ_OP_PROVISION;
> > >  }
> > >  
> > >  static void save_and_set_endio(struct bio *bio, bio_end_io_t **save,
> > > @@ -1394,6 +1396,9 @@ static void schedule_zero(struct thin_c *tc, dm_block_t virt_block,
> > >  	m->data_block = data_block;
> > >  	m->cell = cell;
> > >  
> > > +	if (bio && bio_op(bio) == REQ_OP_PROVISION)
> > > +		m->bio = bio;
> > > +
> > >  	/*
> > >  	 * If the whole block of data is being overwritten or we are not
> > >  	 * zeroing pre-existing data, we can issue the bio immediately.
> > 
> > This doesn't seem like the best way to address avoiding passdown of
> > provision bios (relying on process_prepared_mapping's implementation
> > that happens to do the right thing if m->bio set).  Doing so cascades
> > into relying on complete_overwrite_bio() happening to _not_ actually
> > being specific to "overwrite" bios.
> > 
> > I don't have a better suggestion yet but will look closer.  Just think
> > this needs to be formalized a bit more rather than it happening to
> > "just work".
> > 
> > Cc'ing Joe to see what he thinks too.  This is something we can clean
> > up with a follow-on patch though, so not a show-stopper for this
> > series.
> 
> I haven't circled back to look close enough at this but
> REQ_OP_PROVISION bios _are_ being passed down to the thin-pool's
> underlying data device.
> 
> Brian Foster reported that if he issues a REQ_OP_PROVISION to a thin
> device after a snapshot (to break sharing), it'll fail with
> -EOPNOTSUPP (response is from bio being passed down to device that
> doesn't support it).  I was able to reproduce with:
> 
> # fallocate --offset 0 --length 1048576 /dev/test/thin
> # lvcreate -n snap --snapshot test/thin
> 
> # fallocate --offset 0 --length 1048576 /dev/test/thin
> fallocate: fallocate failed: Operation not supported
> 
> But reports success when retried:
> # fallocate --offset 0 --length 1048576 /dev/test/thin
> # echo $?
> 0
> 
> It's somewhat moot in that Joe will be reimplementing handling for
> REQ_OP_PROVISION _but_ in the meantime it'd be nice to have a version
> of this patch that doesn't error (due to passdown of REQ_OP_PROVISION)
> when breaking sharing.  Primarily so the XFS guys (Dave and Brian) can
> make progress.
> 
> I'll take a closer look tomorrow but figured I'd let you know.

This fixes the issue for me (causes process_prepared_mapping to end
the bio without REQ_OP_PROVISION passdown).

But like I said above back on May 19: needs cleanup to make it less of
a hack for the REQ_OP_PROVISION case. At a minimum
complete_overwrite_bio() would need renaming.

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 43a6702f9efe..434a3b37af2f 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -1324,6 +1324,9 @@ static void schedule_copy(struct thin_c *tc, dm_block_t virt_block,
 	m->data_block = data_dest;
 	m->cell = cell;
 
+	if (bio_op(bio) == REQ_OP_PROVISION)
+		m->bio = bio;
+
 	/*
 	 * quiesce action + copy action + an extra reference held for the
 	 * duration of this function (we may need to inc later for a

