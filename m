Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BB8340BFA
	for <lists+linux-block@lfdr.de>; Thu, 18 Mar 2021 18:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhCRRi3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 Mar 2021 13:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhCRRiN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Mar 2021 13:38:13 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B6BC06174A
        for <linux-block@vger.kernel.org>; Thu, 18 Mar 2021 10:38:13 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id q11so1659555pld.11
        for <linux-block@vger.kernel.org>; Thu, 18 Mar 2021 10:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=68E1cDZixPgMLY4FrQ5EaomLpW3X7x8IB0bvEiCoHvs=;
        b=Z/pM8qllHpyfeI26heYZ9tNYRcuMk1mECWodpOwIZMfWn0yL9Gi7JAoTALydLhJQT/
         uGcy9Ii4pmM34b8DoR8+F4ubumxXIeZeW8xc+23hneQ23IVX5q7usWf4INNZH91s5vRU
         0+y0QVBb3btwnuNgPcIAVcHZi/i4MAqx3o9q/FYNa+XCVZl9mKWbqravvvi7P7eJa5kc
         HwB0L9T1sdaPS8aAqGZoupDh5bp7WEHIhig3ffrEaD5mZJeH0/7oecl/sj+7pMYn1Svp
         PtH42+5qyJE/noAtqD0VLmiGP2i0KFs5alVSMmnNrxc8f0gW6Dsb5hv2IeY8SbIzHl1z
         ERxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=68E1cDZixPgMLY4FrQ5EaomLpW3X7x8IB0bvEiCoHvs=;
        b=YgHfjmWDi/WlignDf0aaXUAsrbAAd5LdSKHkvzdi4gNadDuRcVGIm+EhHK4u8/7SZy
         eQBEUN9qIC3XijUE3DXs2nnY8TsOBo1Pl/pHBwUJyX/LxKIcyaeZw0wCAx81qgF+a0Hq
         5DkGDRi3iR8u3xo8vP1wb9g5i2D9aAKHrY2bCkPNhaCL7P08xQXi1v2P2zpd2ux6a2Au
         pwqwbOTgmHMioabwQ9+Eme2pz5+k3RVeSG9TvgMeYFd5VfFROnOu8FEWeBH6nMxTNCx1
         7LfvB1A6MruCzO4thUoiNmiHsNL0ipSfzblwYsErvc7NekiJ5vu5RGUEqibnMdFShlw3
         iMCg==
X-Gm-Message-State: AOAM5321UkgFzeWZ/tIE7lLsyZMCFkN6GWblEVlmiL4ybKCca2OI0jvA
        wfgEwg1MdbGNk0prWCOZiBTS9wjpPLzEigcPZtE=
X-Google-Smtp-Source: ABdhPJwm3zn3lrbX6RZ7o+mQNtwjI0dtEX6fJeVOtnK8ErdP6Ls3g8dUm0KqRP7qdmfJJALmC4/ENE5fhpPivzyRumg=
X-Received: by 2002:a17:90b:b0d:: with SMTP id bf13mr5465381pjb.7.1616089092711;
 Thu, 18 Mar 2021 10:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210318164827.1481133-1-ming.lei@redhat.com> <20210318164827.1481133-10-ming.lei@redhat.com>
 <20210318172622.GA3871@redhat.com>
In-Reply-To: <20210318172622.GA3871@redhat.com>
From:   Mike Snitzer <snitzer@gmail.com>
Date:   Thu, 18 Mar 2021 13:38:01 -0400
Message-ID: <CAMM=eLf628ua2oq1rB+3dV9sPW0qyiwJKVsO2PqbUWTC7jSXVw@mail.gmail.com>
Subject: Re: [dm-devel] [RFC PATCH V2 09/13] block: use per-task poll context
 to implement bio based io poll
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 18, 2021 at 1:26 PM Mike Snitzer <snitzer@redhat.com> wrote:
>
> On Thu, Mar 18 2021 at 12:48pm -0400,
> Ming Lei <ming.lei@redhat.com> wrote:
>
> > Currently bio based IO poll needs to poll all hw queue blindly, this way
> > is very inefficient, and the big reason is that we can't pass bio
> > submission result to io poll task.
> >
> > In IO submission context, track associated underlying bios by per-task
> > submission queue and save 'cookie' poll data in bio->bi_iter.bi_private_data,
> > and return current->pid to caller of submit_bio() for any bio based
> > driver's IO, which is submitted from FS.
> >
> > In IO poll context, the passed cookie tells us the PID of submission
> > context, and we can find the bio from that submission context. Moving
> > bio from submission queue to poll queue of the poll context, and keep
> > polling until these bios are ended. Remove bio from poll queue if the
> > bio is ended. Add BIO_DONE and BIO_END_BY_POLL for such purpose.
> >
> > In previous version, kfifo is used to implement submission queue, and
> > Jeffle Xu found that kfifo can't scale well in case of high queue depth.
> > So far bio's size is close to 2 cacheline size, and it may not be
> > accepted to add new field into bio for solving the scalability issue by
> > tracking bios via linked list, switch to bio group list for tracking bio,
> > the idea is to reuse .bi_end_io for linking bios into a linked list for
> > all sharing same .bi_end_io(call it bio group), which is recovered before
> > really end bio, since BIO_END_BY_POLL is added for enhancing this point.
> > Usually .bi_end_bio is same for all bios in same layer, so it is enough to
> > provide very limited groups, such as 32 for fixing the scalability issue.
> >
> > Usually submission shares context with io poll. The per-task poll context
> > is just like stack variable, and it is cheap to move data between the two
> > per-task queues.
> >
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/bio.c               |   5 ++
> >  block/blk-core.c          | 149 +++++++++++++++++++++++++++++++-
> >  block/blk-mq.c            | 173 +++++++++++++++++++++++++++++++++++++-
> >  block/blk.h               |   9 ++
> >  include/linux/blk_types.h |  16 +++-
> >  5 files changed, 348 insertions(+), 4 deletions(-)
> >
> > diff --git a/block/bio.c b/block/bio.c
> > index 26b7f721cda8..04c043dc60fc 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -1402,6 +1402,11 @@ static inline bool bio_remaining_done(struct bio *bio)
> >   **/
> >  void bio_endio(struct bio *bio)
> >  {
> > +     /* BIO_END_BY_POLL has to be set before calling submit_bio */
> > +     if (bio_flagged(bio, BIO_END_BY_POLL)) {
> > +             bio_set_flag(bio, BIO_DONE);
> > +             return;
> > +     }
> >  again:
> >       if (!bio_remaining_done(bio))
> >               return;
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index efc7a61a84b4..778d25a7e76c 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -805,6 +805,77 @@ static inline unsigned int bio_grp_list_size(unsigned int nr_grps)
> >               sizeof(struct bio_grp_list_data);
> >  }
> >
> > +static inline void *bio_grp_data(struct bio *bio)
> > +{
> > +     return bio->bi_poll;
> > +}
> > +
> > +/* add bio into bio group list, return true if it is added */
> > +static bool bio_grp_list_add(struct bio_grp_list *list, struct bio *bio)
> > +{
> > +     int i;
> > +     struct bio_grp_list_data *grp;
> > +
> > +     for (i = 0; i < list->nr_grps; i++) {
> > +             grp = &list->head[i];
> > +             if (grp->grp_data == bio_grp_data(bio)) {
> > +                     __bio_grp_list_add(&grp->list, bio);
> > +                     return true;
> > +             }
> > +     }
> > +
> > +     if (i == list->max_nr_grps)
> > +             return false;
> > +
> > +     /* create a new group */
> > +     grp = &list->head[i];
> > +     bio_list_init(&grp->list);
> > +     grp->grp_data = bio_grp_data(bio);
> > +     __bio_grp_list_add(&grp->list, bio);
> > +     list->nr_grps++;
> > +
> > +     return true;
> > +}
> > +
> > +static int bio_grp_list_find_grp(struct bio_grp_list *list, void *grp_data)
> > +{
> > +     int i;
> > +     struct bio_grp_list_data *grp;
> > +
> > +     for (i = 0; i < list->max_nr_grps; i++) {
> > +             grp = &list->head[i];
> > +             if (grp->grp_data == grp_data)
> > +                     return i;
> > +     }
> > +     for (i = 0; i < list->max_nr_grps; i++) {
> > +             grp = &list->head[i];
> > +             if (bio_grp_list_grp_empty(grp))
> > +                     return i;
> > +     }
> > +     return -1;
> > +}
> > +
> > +/* Move as many as possible groups from 'src' to 'dst' */
> > +void bio_grp_list_move(struct bio_grp_list *dst, struct bio_grp_list *src)
> > +{
> > +     int i, j, cnt = 0;
> > +     struct bio_grp_list_data *grp;
> > +
> > +     for (i = src->nr_grps - 1; i >= 0; i--) {
> > +             grp = &src->head[i];
> > +             j = bio_grp_list_find_grp(dst, grp->grp_data);
> > +             if (j < 0)
> > +                     break;
> > +             if (bio_grp_list_grp_empty(&dst->head[j]))
> > +                     dst->head[j].grp_data = grp->grp_data;
> > +             __bio_grp_list_merge(&dst->head[j].list, &grp->list);
> > +             bio_list_init(&grp->list);
> > +             cnt++;
> > +     }
> > +
> > +     src->nr_grps -= cnt;
> > +}
> > +
> >  static void bio_poll_ctx_init(struct blk_bio_poll_ctx *pc)
> >  {
> >       pc->sq = (void *)pc + sizeof(*pc);
> > @@ -866,6 +937,46 @@ static inline void blk_bio_poll_preprocess(struct request_queue *q,
> >               bio->bi_opf |= REQ_TAG;
> >  }
> >
> > +static bool blk_bio_poll_prep_submit(struct io_context *ioc, struct bio *bio)
> > +{
> > +     struct blk_bio_poll_ctx *pc = ioc->data;
> > +     unsigned int queued;
> > +
> > +     /*
> > +      * We rely on immutable .bi_end_io between blk-mq bio submission
> > +      * and completion. However, bio crypt may update .bi_end_io during
> > +      * submitting, so simply not support bio based polling for this
> > +      * setting.
> > +      */
> > +     if (likely(!bio_has_crypt_ctx(bio))) {
> > +             /* track this bio via bio group list */
> > +             spin_lock(&pc->sq_lock);
> > +             queued = bio_grp_list_add(pc->sq, bio);
> > +             spin_unlock(&pc->sq_lock);
> > +     } else {
> > +             queued = false;
> > +     }
> > +
> > +     /*
> > +      * Now the bio is added per-task fifo, mark it as END_BY_POLL,
> > +      * and the bio is always completed from the pair poll context.
> > +      *
> > +      * One invariant is that if bio isn't completed, blk_poll() will
> > +      * be called by passing cookie returned from submitting this bio.
> > +      */
> > +     if (!queued)
> > +             bio->bi_opf &= ~(REQ_HIPRI | REQ_TAG);
> > +     else
> > +             bio_set_flag(bio, BIO_END_BY_POLL);
> > +
> > +     return queued;
> > +}
> > +
> > +static void blk_bio_poll_post_submit(struct bio *bio, blk_qc_t cookie)
> > +{
> > +     bio->bi_iter.bi_private_data = cookie;
> > +}
> > +
> >  static noinline_for_stack bool submit_bio_checks(struct bio *bio)
> >  {
> >       struct block_device *bdev = bio->bi_bdev;
> > @@ -1020,7 +1131,7 @@ static blk_qc_t __submit_bio(struct bio *bio)
> >   * bio_list_on_stack[1] contains bios that were submitted before the current
> >   *   ->submit_bio_bio, but that haven't been processed yet.
> >   */
> > -static blk_qc_t __submit_bio_noacct(struct bio *bio)
> > +static blk_qc_t __submit_bio_noacct_int(struct bio *bio, struct io_context *ioc)
> >  {
> >       struct bio_list bio_list_on_stack[2];
> >       blk_qc_t ret = BLK_QC_T_NONE;
> > @@ -1043,7 +1154,16 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
> >               bio_list_on_stack[1] = bio_list_on_stack[0];
> >               bio_list_init(&bio_list_on_stack[0]);
> >
> > -             ret = __submit_bio(bio);
> > +             if (ioc && queue_is_mq(q) &&
> > +                             (bio->bi_opf & (REQ_HIPRI | REQ_TAG))) {
> > +                     bool queued = blk_bio_poll_prep_submit(ioc, bio);
> > +
> > +                     ret = __submit_bio(bio);
> > +                     if (queued)
> > +                             blk_bio_poll_post_submit(bio, ret);
> > +             } else {
> > +                     ret = __submit_bio(bio);
> > +             }
>
> So you're only supporting bio-based polling if the bio-based device is
> stacked _directly_ ontop of blk-mq?  Severely limits the utility of
> bio-based IO polling support if such shallow stacking is required.

Sorry, I was too focused on this core change, I didn't look far enough
to see you're returning current->pid for all the intermediate
bio-based layers in an arbitrarily deep bio-based IO device stack.

I think I understand it now, but I _do_ think we need a better name
than "__submit_bio_noacct_int"

Mike
