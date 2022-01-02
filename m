Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766B9482A66
	for <lists+linux-block@lfdr.de>; Sun,  2 Jan 2022 08:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiABHEi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 2 Jan 2022 02:04:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54685 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229520AbiABHEi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 2 Jan 2022 02:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641107077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rNvgKa7RBKZAN1BbsQtt2iLEjXM+iSNPhCbUMTDF2yU=;
        b=JnyZpjm4z58EM+GregvUUe07O0h0UzXqtPPH1zHa8o/3GX3/BPq8PvXi3SV3rvTMEOKWbn
        tMxT9IpQX7qnHGqOcTUP0R626+3BdTBLV9mDLQOGexw+VseHgVlvnprgm6sjJ86xZFumtp
        72RuSF+E49wYtZgwDVii/aayO2EdI2c=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-aOL61EMUMZih1Ae7YTHZDQ-1; Sun, 02 Jan 2022 02:04:36 -0500
X-MC-Unique: aOL61EMUMZih1Ae7YTHZDQ-1
Received: by mail-ed1-f69.google.com with SMTP id z3-20020a05640240c300b003f9154816ffso11879266edb.9
        for <linux-block@vger.kernel.org>; Sat, 01 Jan 2022 23:04:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rNvgKa7RBKZAN1BbsQtt2iLEjXM+iSNPhCbUMTDF2yU=;
        b=1Mvs7H9co0BFspCENSd0fp9vvyzzlJPmrMHvJltX552UeJBhuXRLRpo0s9ANq51vsf
         PWTMxo4q64o6BWGG8q5++LaBsK9p/ydwoTQjUgHydEO25THzeDMJAd95AWi8ySjpMvm/
         ju1A7P19L6G/kXrUBi5YA2YO4J7ce37QD5nLLzAE0j2iqaCQGsGMQlGHC3CJiYq71U+k
         3FrhvSTWzR6qUphrl1VLOJt5ymsaOYTMLAKb5drtdhw4RZSpP8HKBlvQR/ErforHr83l
         vExW4kqx3uxgmLY/wKaE/MMum9iQ3JSricTKNDydk7IEbBJRfe2GMww1nlDqAVbAZM8F
         n0Dg==
X-Gm-Message-State: AOAM5302vW1fqmDDKDkvWZ65HxvNfkBEv6En2sKoN7yjdvnMo5NTn9fc
        SF4mIMnQ9ZP6qUlfxRGoKUBjKpNPxShsuWqKhJKRGwqE7ngOLMLEVma6cExggsR/10j2ol5X7lJ
        UoUzEE62AdcRbQrbziGO+xC3v0QrPmn9DGDJtRZo=
X-Received: by 2002:a17:907:8a0d:: with SMTP id sc13mr33324324ejc.498.1641107075673;
        Sat, 01 Jan 2022 23:04:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUIhr76bnjGItvqFPRFYIE+XdU78Fz4DGy60kqLhZt8/cvA7FCuOih75BkLEpO9m5Bs6UNO7PzGBT09Wbkddk=
X-Received: by 2002:a17:907:8a0d:: with SMTP id sc13mr33324314ejc.498.1641107075471;
 Sat, 01 Jan 2022 23:04:35 -0800 (PST)
MIME-Version: 1.0
References: <20211210160456.56816-1-colyli@suse.de> <20211210160456.56816-3-colyli@suse.de>
In-Reply-To: <20211210160456.56816-3-colyli@suse.de>
From:   Xiao Ni <xni@redhat.com>
Date:   Sun, 2 Jan 2022 15:04:24 +0800
Message-ID: <CALTww28HF2SPrrQAaLd+H_De5F8aOemBHfU03zMVAYatb7k19Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] badblocks: add helper routines for badblock ranges handling
To:     Coly Li <colyli@suse.de>
Cc:     nvdimm@lists.linux.dev, linux-raid <linux-raid@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        NeilBrown <neilb@suse.de>,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Dec 11, 2021 at 12:05 AM Coly Li <colyli@suse.de> wrote:
>
> This patch adds several helper routines to improve badblock ranges
> handling. These helper routines will be used later in the improved
> version of badblocks_set()/badblocks_clear()/badblocks_check().
>
> - Helpers prev_by_hint() and prev_badblocks() are used to find the bad
>   range from bad table which the searching range starts at or after.
>
> - The following helpers are to decide the relative layout between the
>   manipulating range and existing bad block range from bad table.
>   - can_merge_behind()
>     Return 'true' if the manipulating range can backward merge with the
>     bad block range.
>   - can_merge_front()
>     Return 'true' if the manipulating range can forward merge with the
>     bad block range.
>   - can_combine_front()
>     Return 'true' if two adjacent bad block ranges before the
>     manipulating range can be merged.
>   - overlap_front()
>     Return 'true' if the manipulating range exactly overlaps with the
>     bad block range in front of its range.
>   - overlap_behind()
>     Return 'true' if the manipulating range exactly overlaps with the
>     bad block range behind its range.
>   - can_front_overwrite()
>     Return 'true' if the manipulating range can forward overwrite the
>     bad block range in front of its range.
>
> - The following helpers are to add the manipulating range into the bad
>   block table. Different routine is called with the specific relative
>   layout between the manipulating range and other bad block range in the
>   bad block table.
>   - behind_merge()
>     Merge the manipulating range with the bad block range behind its
>     range, and return the number of merged length in unit of sector.
>   - front_merge()
>     Merge the manipulating range with the bad block range in front of
>     its range, and return the number of merged length in unit of sector.
>   - front_combine()
>     Combine the two adjacent bad block ranges before the manipulating
>     range into a larger one.
>   - front_overwrite()
>     Overwrite partial of whole bad block range which is in front of the
>     manipulating range. The overwrite may split existing bad block range
>     and generate more bad block ranges into the bad block table.
>   - insert_at()
>     Insert the manipulating range at a specific location in the bad
>     block table.
>
> All the above helpers are used in later patches to improve the bad block
> ranges handling for badblocks_set()/badblocks_clear()/badblocks_check().
>
> Signed-off-by: Coly Li <colyli@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Geliang Tang <geliang.tang@suse.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Vishal L Verma <vishal.l.verma@intel.com>
> ---
>  block/badblocks.c | 376 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 376 insertions(+)
>
> diff --git a/block/badblocks.c b/block/badblocks.c
> index d39056630d9c..30958cc4469f 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -16,6 +16,382 @@
>  #include <linux/types.h>
>  #include <linux/slab.h>
>
> +/*
> + * Find the range starts at-or-before 's' from bad table. The search
> + * starts from index 'hint' and stops at index 'hint_end' from the bad
> + * table.
> + */
> +static int prev_by_hint(struct badblocks *bb, sector_t s, int hint)
> +{
> +       int hint_end = hint + 2;
> +       u64 *p = bb->page;
> +       int ret = -1;
> +
> +       while ((hint < hint_end) && ((hint + 1) <= bb->count) &&
> +              (BB_OFFSET(p[hint]) <= s)) {
> +               if ((hint + 1) == bb->count || BB_OFFSET(p[hint + 1]) > s) {
> +                       ret = hint;
> +                       break;
> +               }
> +               hint++;
> +       }
> +
> +       return ret;
> +}
> +
> +/*
> + * Find the range starts at-or-before bad->start. If 'hint' is provided
> + * (hint >= 0) then search in the bad table from hint firstly. It is
> + * very probably the wanted bad range can be found from the hint index,
> + * then the unnecessary while-loop iteration can be avoided.
> + */
> +static int prev_badblocks(struct badblocks *bb, struct badblocks_context *bad,
> +                         int hint)
> +{
> +       sector_t s = bad->start;
> +       int ret = -1;
> +       int lo, hi;
> +       u64 *p;
> +
> +       if (!bb->count)
> +               goto out;
> +
> +       if (hint >= 0) {
> +               ret = prev_by_hint(bb, s, hint);
> +               if (ret >= 0)
> +                       goto out;
> +       }
> +
> +       lo = 0;
> +       hi = bb->count;
> +       p = bb->page;
> +
> +       while (hi - lo > 1) {
> +               int mid = (lo + hi)/2;
> +               sector_t a = BB_OFFSET(p[mid]);
> +
> +               if (a <= s)
> +                       lo = mid;
> +               else
> +                       hi = mid;
> +       }

Hi Coly

Does it need to stop the loop when "a == s". For example, there are
100 bad blocks.
The new bad starts equals offset(50). In the first loop, it can find
the result. It doesn't
need to go on running in the loop. If it still runs the loop, only the
hi can be handled.
It has no meaning.

> +
> +       if (BB_OFFSET(p[lo]) <= s)
> +               ret = lo;
> +out:
> +       return ret;
> +}
> +
> +/*
> + * Return 'true' if the range indicated by 'bad' can be backward merged
> + * with the bad range (from the bad table) index by 'behind'.
> + */
> +static bool can_merge_behind(struct badblocks *bb, struct badblocks_context *bad,
> +                            int behind)
> +{
> +       sector_t sectors = bad->len;
> +       sector_t s = bad->start;
> +       u64 *p = bb->page;
> +
> +       if ((s <= BB_OFFSET(p[behind])) &&

In fact, it can never trigger s == BB_OFFSET here. By the design, if s
== offset(pos), prev_badblocks
can find it. Then front_merge/front_overwrite can handle it.

> +           ((s + sectors) >= BB_OFFSET(p[behind])) &&
> +           ((BB_END(p[behind]) - s) <= BB_MAX_LEN) &&
> +           BB_ACK(p[behind]) == bad->ack)
> +               return true;
> +       return false;
> +}
> +
> +/*
> + * Do backward merge for range indicated by 'bad' and the bad range
> + * (from the bad table) indexed by 'behind'. The return value is merged
> + * sectors from bad->len.
> + */
> +static int behind_merge(struct badblocks *bb, struct badblocks_context *bad,
> +                       int behind)
> +{
> +       sector_t sectors = bad->len;
> +       sector_t s = bad->start;
> +       u64 *p = bb->page;
> +       int merged = 0;
> +
> +       WARN_ON(s > BB_OFFSET(p[behind]));
> +       WARN_ON((s + sectors) < BB_OFFSET(p[behind]));
> +
> +       if (s < BB_OFFSET(p[behind])) {
> +               WARN_ON((BB_LEN(p[behind]) + merged) >= BB_MAX_LEN);
> +
> +               merged = min_t(sector_t, sectors, BB_OFFSET(p[behind]) - s);

sectors must be >= BB_OFFSET(p[behind] - s) here? It's behind_merge, so the end
of bad should be >= BB_OFFSET(p[behind])

If we need to check merged value. The WARN_ON should be checked after merged

> +               p[behind] =  BB_MAKE(s, BB_LEN(p[behind]) + merged, bad->ack);
> +       } else {
> +               merged = min_t(sector_t, sectors, BB_LEN(p[behind]));
> +       }

If we don't need to consider s == offset(pos) situation, it only needs
to consider s < offset(pos) here
> +
> +       WARN_ON(merged == 0);
> +
> +       return merged;
> +}
> +
> +/*
> + * Return 'true' if the range indicated by 'bad' can be forward
> + * merged with the bad range (from the bad table) indexed by 'prev'.
> + */
> +static bool can_merge_front(struct badblocks *bb, int prev,
> +                           struct badblocks_context *bad)
> +{
> +       sector_t s = bad->start;
> +       u64 *p = bb->page;
> +
> +       if (BB_ACK(p[prev]) == bad->ack &&
> +           (s < BB_END(p[prev]) ||
> +            (s == BB_END(p[prev]) && (BB_LEN(p[prev]) < BB_MAX_LEN))))
> +               return true;
> +       return false;
> +}
> +
> +/*
> + * Do forward merge for range indicated by 'bad' and the bad range
> + * (from bad table) indexed by 'prev'. The return value is sectors
> + * merged from bad->len.
> + */
> +static int front_merge(struct badblocks *bb, int prev, struct badblocks_context *bad)
> +{
> +       sector_t sectors = bad->len;
> +       sector_t s = bad->start;
> +       u64 *p = bb->page;
> +       int merged = 0;
> +
> +       WARN_ON(s > BB_END(p[prev]));
> +
> +       if (s < BB_END(p[prev])) {
> +               merged = min_t(sector_t, sectors, BB_END(p[prev]) - s);
> +       } else {
> +               merged = min_t(sector_t, sectors, BB_MAX_LEN - BB_LEN(p[prev]));
> +               if ((prev + 1) < bb->count &&
> +                   merged > (BB_OFFSET(p[prev + 1]) - BB_END(p[prev]))) {
> +                       merged = BB_OFFSET(p[prev + 1]) - BB_END(p[prev]);
> +               }
> +
> +               p[prev] = BB_MAKE(BB_OFFSET(p[prev]),
> +                                 BB_LEN(p[prev]) + merged, bad->ack);
> +       }
> +
> +       return merged;
> +}
> +
> +/*
> + * 'Combine' is a special case which can_merge_front() is not able to
> + * handle: If a bad range (indexed by 'prev' from bad table) exactly
> + * starts as bad->start, and the bad range ahead of 'prev' (indexed by
> + * 'prev - 1' from bad table) exactly ends at where 'prev' starts, and
> + * the sum of their lengths does not exceed BB_MAX_LEN limitation, then
> + * these two bad range (from bad table) can be combined.
> + *
> + * Return 'true' if bad ranges indexed by 'prev' and 'prev - 1' from bad
> + * table can be combined.
> + */
> +static bool can_combine_front(struct badblocks *bb, int prev,
> +                             struct badblocks_context *bad)
> +{
> +       u64 *p = bb->page;
> +
> +       if ((prev > 0) &&
> +           (BB_OFFSET(p[prev]) == bad->start) &&
> +           (BB_END(p[prev - 1]) == BB_OFFSET(p[prev])) &&
> +           (BB_LEN(p[prev - 1]) + BB_LEN(p[prev]) <= BB_MAX_LEN) &&
> +           (BB_ACK(p[prev - 1]) == BB_ACK(p[prev])))
> +               return true;
> +       return false;
> +}

could you explain why BB_OFFSET(p[prev]) should == bad->start. If
bad(prev-1) and
bad(prev) are adjacent, can they be combine directly without
considering bad->start

Best Regards
Xiao

