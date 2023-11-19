Return-Path: <linux-block+bounces-260-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2537F0721
	for <lists+linux-block@lfdr.de>; Sun, 19 Nov 2023 16:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3994280DAB
	for <lists+linux-block@lfdr.de>; Sun, 19 Nov 2023 15:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C650613AC7;
	Sun, 19 Nov 2023 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aVcGvwwa"
X-Original-To: linux-block@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B71C2
	for <linux-block@vger.kernel.org>; Sun, 19 Nov 2023 07:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700407302; x=1731943302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GnI2ehbx0BkNTQXA+HiQpvK0fRAFd/MFz1r0HnZbmDU=;
  b=aVcGvwwaa/wJfM6x61fPW1BsGtpx9JWJeEzgIT3l0ViOzPIxc8q0WKVh
   05QykTlHTE0tM0eg1BSvKamNUSaeNmI+uTBM2NYkXhTvS3XL/k1rfrne7
   tWV9ZUJWYCX2r0a2UGgeWs6MiV0nGGSjj+7XU8Ih2ZcroQGUCAcgCQ5wJ
   sPUkKNWj23PwIFMuw7mlM3yUfRDxBBXHF84Ls4SHNwHQCE0RPZhkxe0OD
   EWv6g7kYFP+nP9fysyHrsVfWy8X2Qfmldk+ZAlxy/V0z6f1AWUZWN/n+N
   aWWsyKbABMNVvFFAFFyoQMOxAIXx0ueurB4vpe3Ihb1XK2LVMj4jm4E6+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="371680602"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="371680602"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 07:21:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="716000084"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="716000084"
Received: from kvehmane-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.44.109])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 07:21:39 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id DEA1510A33C; Sun, 19 Nov 2023 18:21:36 +0300 (+03)
Date: Sun, 19 Nov 2023 18:21:36 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Snitzer <snitzer@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Andrew Morton <akpm@linux-foundation.org>, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org, Alasdair G Kergon <agk@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [git pull] device mapper fixes for 6.7-rc2
Message-ID: <20231119152136.ntnl3sfulo4tgbw3@box.shutemov.name>
References: <ZVjgpLACW4/0NkBB@redhat.com>
 <CAHk-=wjV2S7xBcH2BGuDgfKcg3fjWwk5k74nq89SviMkH-YsJQ@mail.gmail.com>
 <CAHk-=wjCXvFme97sxix_zDfq4-oNRv7fNp+YzWEuUGH-gihA-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjCXvFme97sxix_zDfq4-oNRv7fNp+YzWEuUGH-gihA-g@mail.gmail.com>

On Sat, Nov 18, 2023 at 11:14:25AM -0800, Linus Torvalds wrote:
> On Sat, 18 Nov 2023 at 10:33, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > What are the alleged "number of bugs all over the kernel" that the old
> > MAX_ORDER definition had? In light of the other "MAX" definitions I
> > found from a second of grepping, I really think the argument for that
> > was just wrong.
> 
> Bah. I looked at the commits leading up to it, and I really think that
> "if that's the fallout from 24 years of history, then it wasn't a huge
> deal".

That's part that hit upstream and never got caught. I personally spend
some time debugging due MAX_ORDER-1 thing.

> Compared to the inevitable problems that the semantic change will
> cause for backports (and already caused for this merge window), I
> still think this was all likely a mistake.

I think the mistake I made is leaving the name the same. Just renaming it
to MAX_PAGE_ORDER or something would give a heads up to not-yet-upstream
code.

> In fact, the biggest takeaway from those patches is that we probably
> should have introduced some kind of "this is the max _size_ you can
> allocate", because a few of them were related to that particular
> calculation.
> 
> The floppy driver example is actually a good example, in that that is
> *exactly* what it wanted, but it had been just done wrong as
> 
>   #define MAX_LEN (1UL << MAX_ORDER << PAGE_SHIFT)
> 
> and variations of that is what half the fixes were..
> 
> IOW, I really think we should just have added a
> 
>   #define MAX_GFP_SIZE (1UL << (PAGE_SHIFT+MAX_ORDER-1))
> 
> and the rest were basically all just the trivial off-by-one things.
> 
> The __iommu_dma_alloc_pages() code is just so odd that any MAX_ORDER
> issues are more about "WTH is this code doing" And the "fix" is just
> more of the same.
> 
> The *whole* point of having the max for a power-of-two thing is that
> you can do things like
> 
>         mask = (1<<MAX)-1;
> 
> and that's exactly what the iommu code was trying to do. Except for
> some *unfathomable* reason the iommu code did
> 
>         order_mask &= (2U << MAX_ORDER) - 1;
> 
> and honestly, you can't blame MAX_ORDER for the confusion. What a
> strange off-by-one. MAX_ORDER was *literally* designed to be easy for
> this case, and people screwed it up.

Agreed.

> And no, it's *not* because "inclusive is more intuitive". As
> mentioned, this whole "it's past the end* is the common case for MAX
> values in the mm, for exactly these kinds of reasons. I already
> listted several other cases.
> 
> The reason there were 9 bugs is because MAX_ORDER is an old thing, and
> testing doesn't catch it because nobody triggers the max case. The
> crazy iommu code goes back to 2016, for example.
> 
> That
> 
>     84 files changed, 223 insertions(+), 253 deletions(-)
> 
> really seems bogus for the 9 fixes that had accumulated in this area
> in the last 24 years.
> 
> Oh well. Now we have places with 'MAX_ORDER + 1' instead of 'MAX_ORDER
> - 1'. I'm not seeing that it's a win, and I do think "semantic change
> after 24 years" is a loss and is going to cause problems.

I think it worth introducing NR_ORDERS for MAX_ORDER + 1 to define how
many page orders page allocator supports. Sounds good?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

