Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 138B21934EF
	for <lists+linux-block@lfdr.de>; Thu, 26 Mar 2020 01:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgCZATO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 25 Mar 2020 20:19:14 -0400
Received: from smtprelay0055.hostedemail.com ([216.40.44.55]:40620 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727498AbgCZATN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 20:19:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id DD985100E8423;
        Thu, 26 Mar 2020 00:19:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3871:3872:3874:4321:4605:5007:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:14181:14659:14721:21080:21451:21627:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:7,LUA_SUMMARY:none
X-HE-Tag: basin81_8a8cb0808492b
X-Filterd-Recvd-Size: 2061
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu, 26 Mar 2020 00:19:11 +0000 (UTC)
Message-ID: <fcb60b1d27fb0120a5934d30481e15fa3f171310.camel@perches.com>
Subject: Re: [PATCH 2/9] block: mark part_in_flight and part_in_flight_rw
 static
From:   Joe Perches <joe@perches.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 25 Mar 2020 17:17:21 -0700
In-Reply-To: <20200325154843.1349040-3-hch@lst.de>
References: <20200325154843.1349040-1-hch@lst.de>
         <20200325154843.1349040-3-hch@lst.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2020-03-25 at 16:48 +0100, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Some people still ask for some commit description,
not just a sign-off line.

I do think that's unnecessary though when, as here,
the patch subject is descriptive and complete.

> diff --git a/block/genhd.c b/block/genhd.c
[]
> @@ -139,7 +139,8 @@ void part_dec_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
>  		part_stat_local_dec(&part_to_disk(part)->part0, in_flight[rw]);
>  }
>  
> -unsigned int part_in_flight(struct request_queue *q, struct hd_struct *part)
> +static unsigned int part_in_flight(struct request_queue *q,
> +		struct hd_struct *part)

genhd.c aligns multi-line arguments to open parenthesis,
it'd be nicer to maintain that style.

>  {
>  	int cpu;
>  	unsigned int inflight;
> @@ -159,8 +160,8 @@ unsigned int part_in_flight(struct request_queue *q, struct hd_struct *part)
>  	return inflight;
>  }
>  
> -void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
> -		       unsigned int inflight[2])
> +static void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
> +		unsigned int inflight[2])

etc.


