Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B86F2546E1
	for <lists+linux-block@lfdr.de>; Thu, 27 Aug 2020 16:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgH0Oav (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 27 Aug 2020 10:30:51 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:58787 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727885AbgH0Oaq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 10:30:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U7.leK6_1598538641;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U7.leK6_1598538641)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 27 Aug 2020 22:30:41 +0800
Date:   Thu, 27 Aug 2020 22:30:41 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] block: Add a new helper to attempt to merge a bio
Message-ID: <20200827143041.GA122928@VM20190228-100.tbsite.net>
Reply-To: Baolin Wang <baolin.wang@linux.alibaba.com>
References: <cover.1597727255.git.baolin.wang@linux.alibaba.com>
 <7749d6068b9e5404ef59bacfcb278d604f84af75.1597727255.git.baolin.wang@linux.alibaba.com>
 <20200827094415.GA16058@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827094415.GA16058@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 27, 2020 at 11:44:15AM +0200, Christoph Hellwig wrote:
> On Tue, Aug 18, 2020 at 01:45:29PM +0800, Baolin Wang wrote:
> > Meanwhile move the blk_mq_bio_list_merge() into blk-merge.c and
> > rename it as a generic name.
> 
> That should probably a separate patch.

Sure.

> 
> > +		if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) == BIO_MERGE_OK)
> > +			return true;
> 
> This adds an overly long line.

The checkpatch.pl has increased the default limit to 100 characters, so
I did not get a long line warning. Anyway I will change a new line if
you concern about this.

> > -		if (merged)
> > +		switch (blk_attempt_bio_merge(q, rq, bio, nr_segs, true)) {
> > +		default:
> > +		case BIO_MERGE_NONE:
> > +			continue;
> > +		case BIO_MERGE_OK:
> >  			return true;
> > +		case BIO_MERGE_FAILED:
> > +			return false;
> > +		}
> 
> I don't think we need a default statement here as we handle all
> possible values of the enum.

OK. Will remove it in next version. Thanks.
