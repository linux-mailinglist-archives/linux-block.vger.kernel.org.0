Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26BF48D3EB
	for <lists+linux-block@lfdr.de>; Thu, 13 Jan 2022 09:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiAMIyd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 13 Jan 2022 03:54:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:31965 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231250AbiAMIyc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jan 2022 03:54:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642064072; x=1673600072;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=8Xlh4Hbvt79v2c/TU/hbl+S7X88tZU2xfJYXHN/OQXM=;
  b=P4zOyCaynLGZ58wZGOnNX3890684pFQWGQ54DFSjshOJfA5fgqhZXlHw
   kLKc5He+SVRRVYwnYUKvAU2rnhDJEN/Vyb3XM8weVB3LmTPjlbKiIOGYD
   s1GtuzMrPh6mg1vX9eq44Y25lEvuRZCLaxMotAhGbOefXqVSQf4rfAdvV
   E8olZmsKmjuUA35+iDlIRVVa7Y5mtIr/WIrvfrC6luEI7G5uD7juKOZ8Y
   Su+4W2NJHSfSeoMidTpZ6KnZ+pyQWUSCryEz5wHRf12u5qsWTMHsrB67g
   EQjcv+1ElTSpot/BRaOtj+QJ96me7WeX5hn1eAT0wMuyCH9Rl6OK8jQZ3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="241525136"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="241525136"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 00:54:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="473153575"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 00:54:29 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Mauricio Faria de Oliveira <mfo@canonical.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v2] mm: fix race between MADV_FREE reclaim and blkdev
 direct IO read
References: <20220105233440.63361-1-mfo@canonical.com>
        <Yd0oLWtVAyAexyQc@google.com>
        <87v8ypybdc.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Yd8Q7Cplp5xLTYlV@google.com>
        <CAO9xwp3cgdXRmogRReJW+_AKktWhYL74kzphKpz_8wh12BVzGA@mail.gmail.com>
        <Yd9YIGLWEeYBkTge@google.com>
Date:   Thu, 13 Jan 2022 16:54:28 +0800
In-Reply-To: <Yd9YIGLWEeYBkTge@google.com> (Minchan Kim's message of "Wed, 12
        Jan 2022 14:37:20 -0800")
Message-ID: <87zgo0t3qz.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Minchan Kim <minchan@kernel.org> writes:

> On Wed, Jan 12, 2022 at 06:53:07PM -0300, Mauricio Faria de Oliveira wrote:
>> Hi Minchan Kim,
>> 
>> Thanks for handling the hard questions! :)
>> 
>> On Wed, Jan 12, 2022 at 2:33 PM Minchan Kim <minchan@kernel.org> wrote:
>> >
>> > On Wed, Jan 12, 2022 at 09:46:23AM +0800, Huang, Ying wrote:
>> > > Yu Zhao <yuzhao@google.com> writes:
>> > >
>> > > > On Wed, Jan 05, 2022 at 08:34:40PM -0300, Mauricio Faria de Oliveira wrote:
>> > > >> diff --git a/mm/rmap.c b/mm/rmap.c
>> > > >> index 163ac4e6bcee..8671de473c25 100644
>> > > >> --- a/mm/rmap.c
>> > > >> +++ b/mm/rmap.c
>> > > >> @@ -1570,7 +1570,20 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>> > > >>
>> > > >>                    /* MADV_FREE page check */
>> > > >>                    if (!PageSwapBacked(page)) {
>> > > >> -                          if (!PageDirty(page)) {
>> > > >> +                          int ref_count = page_ref_count(page);
>> > > >> +                          int map_count = page_mapcount(page);
>> > > >> +
>> > > >> +                          /*
>> > > >> +                           * The only page refs must be from the isolation
>> > > >> +                           * (checked by the caller shrink_page_list() too)
>> > > >> +                           * and one or more rmap's (dropped by discard:).
>> > > >> +                           *
>> > > >> +                           * Check the reference count before dirty flag
>> > > >> +                           * with memory barrier; see __remove_mapping().
>> > > >> +                           */
>> > > >> +                          smp_rmb();
>> > > >> +                          if ((ref_count - 1 == map_count) &&
>> > > >> +                              !PageDirty(page)) {
>> > > >>                                    /* Invalidate as we cleared the pte */
>> > > >>                                    mmu_notifier_invalidate_range(mm,
>> > > >>                                            address, address + PAGE_SIZE);
>> > > >
>> > > > Out of curiosity, how does it work with COW in terms of reordering?
>> > > > Specifically, it seems to me get_page() and page_dup_rmap() in
>> > > > copy_present_pte() can happen in any order, and if page_dup_rmap()
>> > > > is seen first, and direct io is holding a refcnt, this check can still
>> > > > pass?
>> > >
>> > > I think that you are correct.
>> > >
>> > > After more thoughts, it appears very tricky to compare page count and
>> > > map count.  Even if we have added smp_rmb() between page_ref_count() and
>> > > page_mapcount(), an interrupt may happen between them.  During the
>> > > interrupt, the page count and map count may be changed, for example,
>> > > unmapped, or do_swap_page().
>> >
>> > Yeah, it happens but what specific problem are you concerning from the
>> > count change under race? The fork case Yu pointed out was already known
>> > for breaking DIO so user should take care not to fork under DIO(Please
>> > look at O_DIRECT section in man 2 open). If you could give a specific
>> > example, it would be great to think over the issue.
>> >
>> > I agree it's little tricky but it seems to be way other place has used
>> > for a long time(Please look at write_protect_page in ksm.c).
>> 
>> Ah, that's great to see it's being used elsewhere, for DIO particularly!
>> 
>> > So, here what we missing is tlb flush before the checking.
>> 
>> That shouldn't be required for this particular issue/case, IIUIC.
>> One of the things we checked early on was disabling deferred TLB flush
>> (similarly to what you've done), and it didn't help with the issue; also, the
>> issue happens on uniprocessor mode too (thus no remote CPU involved.)
>
> I guess you didn't try it with page_mapcount + 1 == page_count at tha
> time?  Anyway, I agree we don't need TLB flush here like KSM.
> I think the reason KSM is doing TLB flush before the check it to
> make sure trap trigger on the write from userprocess in other core.
> However, this MADV_FREE case, HW already gaurantees the trap.
> Please see below.
>
>> 
>> 
>> >
>> > Something like this.
>> >
>> > diff --git a/mm/rmap.c b/mm/rmap.c
>> > index b0fd9dc19eba..b4ad9faa17b2 100644
>> > --- a/mm/rmap.c
>> > +++ b/mm/rmap.c
>> > @@ -1599,18 +1599,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>> >
>> >                         /* MADV_FREE page check */
>> >                         if (!PageSwapBacked(page)) {
>> > -                               int refcount = page_ref_count(page);
>> > -
>> > -                               /*
>> > -                                * The only page refs must be from the isolation
>> > -                                * (checked by the caller shrink_page_list() too)
>> > -                                * and the (single) rmap (dropped by discard:).
>> > -                                *
>> > -                                * Check the reference count before dirty flag
>> > -                                * with memory barrier; see __remove_mapping().
>> > -                                */
>> > -                               smp_rmb();
>> > -                               if (refcount == 2 && !PageDirty(page)) {
>> > +                               if (!PageDirty(page) &&
>> > +                                       page_mapcount(page) + 1 == page_count(page)) {
>> 
>> In the interest of avoiding a different race/bug, it seemed worth following the
>> suggestion outlined in __remove_mapping(), i.e., checking PageDirty()
>> after the page's reference count, with a memory barrier in between.
>
> True so it means your patch as-is is good for me.

If my understanding were correct, a shared anonymous page will be mapped
read-only.  If so, will a private anonymous page be called
SetPageDirty() concurrently after direct IO case has been dealt with
via comparing page_count()/page_mapcount()?

Best Regards,
Huang, Ying
