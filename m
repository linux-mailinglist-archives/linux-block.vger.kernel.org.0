Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 150427DDAB
	for <lists+linux-block@lfdr.de>; Thu,  1 Aug 2019 16:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbfHAOTJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 1 Aug 2019 10:19:09 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39390 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731915AbfHAOTJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 10:19:09 -0400
Received: by mail-qt1-f196.google.com with SMTP id l9so70317610qtu.6
        for <linux-block@vger.kernel.org>; Thu, 01 Aug 2019 07:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hMA7vlwUroWdb0REjDf2neAobLqIjEsoQepgHkXMGQc=;
        b=M+yZ5LoJGbhm7g0i1sIHAJmyeoJlxlLUxNMBipkE5Gk2KmuVJyj40RCbT2OMJyeUYM
         zJHmHpLP79mwX+1GU1gaWmI+ZgMsrzh906sNv8d/eg/a5Xw25HKRKuFNgKcyKLM02Ww0
         rufqIlPpawx9cNcQ6Ahy2tSEtMjGQsDi0/1f8f63o7vcW+ionqvcAAZen0904J/Ypmil
         ZGhx4rO03KDS05ILM46VGBWJuCbsSKMR9WjJEMoOyUFc9cwx/Lc3OXwHZWF/4cg/Lo1f
         MMC8Huc/zfOSWQ3eMe0y7mSe9oVAGDhdbvvwgs3CG/GKyE01CIy0PPbv9CbdNkVNHI2q
         Ytxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hMA7vlwUroWdb0REjDf2neAobLqIjEsoQepgHkXMGQc=;
        b=dxH35+/LD8m3hsPgBI+uAtbQ+AlMufmrYEfm0KOSkbtG7MHJIQkE8X3cLIXHCfZHFh
         WSmXQkZ4hRVi5Ecaji0Lup9y9ge9yGQJGT+e+ZP4+QsfG7tsTtdldH/RHi8YF+Y19Lbp
         mGUere4BgdzCWsvpxFYGtLvGYzxfOLxbxGagTZjCZ50u1QGZNynEfh8eDJUFHYbNQBXB
         x1fL0+UK9rHpKX0ksH8Um+jNdCIaCtIYt2WIgahRGt0j+p6L+OkM1NA1xn1M7yYbRuXP
         lS/7kRyszmgO+NcfuQajAAqib4tixWG7gI1X7iSTOc/D+x3i4A7ZbhlcyYF3MCwf3dd0
         D0dQ==
X-Gm-Message-State: APjAAAUNhRxlbn+tcYmQL3G31iOwkDj3QSx8gHgUoE6TKyMLqhrrANkN
        3ZonPvUE+tXT86nJ6oHKEzAqDw==
X-Google-Smtp-Source: APXvYqwTQf1KGpY8PZ+10TO7pJmffd0/JJ0SGE6m65X5GOGwylr1cSmZUzuB803q9/jTvKSKgNYkxg==
X-Received: by 2002:a0c:aed0:: with SMTP id n16mr93783119qvd.101.1564669147681;
        Thu, 01 Aug 2019 07:19:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id s127sm30805414qkd.107.2019.08.01.07.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Aug 2019 07:19:07 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1htBv8-00084t-Lf; Thu, 01 Aug 2019 11:19:06 -0300
Date:   Thu, 1 Aug 2019 11:19:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v4 1/3] mm/gup: add make_dirty arg to
 put_user_pages_dirty_lock()
Message-ID: <20190801141906.GC23899@ziepe.ca>
References: <20190730205705.9018-1-jhubbard@nvidia.com>
 <20190730205705.9018-2-jhubbard@nvidia.com>
 <20190801060755.GA14893@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801060755.GA14893@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 01, 2019 at 08:07:55AM +0200, Christoph Hellwig wrote:
> On Tue, Jul 30, 2019 at 01:57:03PM -0700, john.hubbard@gmail.com wrote:
> > @@ -40,10 +40,7 @@
> >  static void __qib_release_user_pages(struct page **p, size_t num_pages,
> >  				     int dirty)
> >  {
> > -	if (dirty)
> > -		put_user_pages_dirty_lock(p, num_pages);
> > -	else
> > -		put_user_pages(p, num_pages);
> > +	put_user_pages_dirty_lock(p, num_pages, dirty);
> >  }
> 
> __qib_release_user_pages should be removed now as a direct call to
> put_user_pages_dirty_lock is a lot more clear.
> 
> > index 0b0237d41613..62e6ffa9ad78 100644
> > +++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
> > @@ -75,10 +75,7 @@ static void usnic_uiom_put_pages(struct list_head *chunk_list, int dirty)
> >  		for_each_sg(chunk->page_list, sg, chunk->nents, i) {
> >  			page = sg_page(sg);
> >  			pa = sg_phys(sg);
> > -			if (dirty)
> > -				put_user_pages_dirty_lock(&page, 1);
> > -			else
> > -				put_user_page(page);
> > +			put_user_pages_dirty_lock(&page, 1, dirty);
> >  			usnic_dbg("pa: %pa\n", &pa);
> 
> There is a pre-existing bug here, as this needs to use the sg_page
> iterator.  Probably worth throwing in a fix into your series while you
> are at it.

Sadly usnic does not use the core rdma umem abstraction but open codes
an old version of it.

In this version each sge in the sgl is exactly one page. See
usnic_uiom_get_pages - so I think this loop is not a bug?

Jason
