Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 290978EB8A
	for <lists+linux-block@lfdr.de>; Thu, 15 Aug 2019 14:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbfHOM3V (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 15 Aug 2019 08:29:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731425AbfHOM3U (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 08:29:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E47846671;
        Thu, 15 Aug 2019 12:29:20 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 16B841E0;
        Thu, 15 Aug 2019 12:29:14 +0000 (UTC)
Date:   Thu, 15 Aug 2019 20:29:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        stable@vger.kernel.org, Mark Ray <mark.ray@hpe.com>
Subject: Re: [PATCH] blk-mq: avoid sysfs buffer overflow by too many CPU cores
Message-ID: <20190815122909.GA28032@ming.t460p>
References: <20190815121518.16675-1-ming.lei@redhat.com>
 <20190815122419.GA31891@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815122419.GA31891@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 15 Aug 2019 12:29:20 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 15, 2019 at 02:24:19PM +0200, Greg KH wrote:
> On Thu, Aug 15, 2019 at 08:15:18PM +0800, Ming Lei wrote:
> > It is reported that sysfs buffer overflow can be triggered in case
> > of too many CPU cores(>841 on 4K PAGE_SIZE) when showing CPUs in
> > one hctx.
> > 
> > So use snprintf for avoiding the potential buffer overflow.
> > 
> > Cc: stable@vger.kernel.org
> > Cc: Mark Ray <mark.ray@hpe.com>
> > Fixes: 676141e48af7("blk-mq: don't dump CPU -> hw queue map on driver load")
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  block/blk-mq-sysfs.c | 30 ++++++++++++++++++------------
> >  1 file changed, 18 insertions(+), 12 deletions(-)
> > 
> > diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> > index d6e1a9bd7131..e75f41a98415 100644
> > --- a/block/blk-mq-sysfs.c
> > +++ b/block/blk-mq-sysfs.c
> > @@ -164,22 +164,28 @@ static ssize_t blk_mq_hw_sysfs_nr_reserved_tags_show(struct blk_mq_hw_ctx *hctx,
> >  	return sprintf(page, "%u\n", hctx->tags->nr_reserved_tags);
> >  }
> >  
> > +/* avoid overflow by too many CPU cores */
> >  static ssize_t blk_mq_hw_sysfs_cpus_show(struct blk_mq_hw_ctx *hctx, char *page)
> >  {
> > -	unsigned int i, first = 1;
> > -	ssize_t ret = 0;
> > -
> > -	for_each_cpu(i, hctx->cpumask) {
> > -		if (first)
> > -			ret += sprintf(ret + page, "%u", i);
> > -		else
> > -			ret += sprintf(ret + page, ", %u", i);
> > -
> > -		first = 0;
> > +	unsigned int cpu = cpumask_first(hctx->cpumask);
> > +	ssize_t len = snprintf(page, PAGE_SIZE - 1, "%u", cpu);
> > +	int last_len = len;
> > +
> > +	while ((cpu = cpumask_next(cpu, hctx->cpumask)) < nr_cpu_ids) {
> > +		int cur_len = snprintf(page + len, PAGE_SIZE - 1 - len,
> > +				       ", %u", cpu);
> > +		if (cur_len >= PAGE_SIZE - 1 - len) {
> > +			len -= last_len;
> > +			len += snprintf(page + len, PAGE_SIZE - 1 - len,
> > +					"...");
> > +			break;
> > +		}
> > +		len += cur_len;
> > +		last_len = cur_len;
> >  	}
> >  
> > -	ret += sprintf(ret + page, "\n");
> > -	return ret;
> > +	len += snprintf(page + len, PAGE_SIZE - 1 - len, "\n");
> > +	return len;
> >  }
> >
> 
> What????
> 
> sysfs is "one value per file".  You should NEVER have to care about the
> size of the sysfs buffer.  If you do, you are doing something wrong.
> 
> What excatly are you trying to show in this sysfs file?  I can't seem to
> find the Documenatation/ABI/ entry for it, am I just missing it because
> I don't know the filename for it?

It is /sys/block/$DEV/mq/$N/cpu_list, all CPUs in this hctx($N) will be
shown via sysfs buffer. The buffer size is one PAGE, how can it hold when
there are too many CPUs(close to 1K)?


Thanks,
Ming
