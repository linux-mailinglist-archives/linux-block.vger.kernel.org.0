Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A8B1B93E5
	for <lists+linux-block@lfdr.de>; Sun, 26 Apr 2020 22:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgDZUYN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 26 Apr 2020 16:24:13 -0400
Received: from smtprelay0052.hostedemail.com ([216.40.44.52]:50342 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726179AbgDZUYN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Apr 2020 16:24:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 1A6CC182CED28;
        Sun, 26 Apr 2020 20:24:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3866:3867:3870:3872:3874:4321:5007:8603:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13255:13311:13357:13439:14659:14721:21080:21627:21990:30034:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: scale38_5ebf617f6af44
X-Filterd-Recvd-Size: 2001
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sun, 26 Apr 2020 20:24:10 +0000 (UTC)
Message-ID: <b7c2d0f041ca7abcb5be7c1cb07b1162d4e170a6.camel@perches.com>
Subject: Re: [PATCH v2 1/3] floppy: add FD_AUTODETECT_SIZE define for struct
 floppy_drive_params
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org
Cc:     Willy Tarreau <w@1wt.eu>, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Date:   Sun, 26 Apr 2020 13:24:09 -0700
In-Reply-To: <20200426130728.63399-2-efremov@linux.com>
References: <20200426130728.63399-1-efremov@linux.com>
         <20200426130728.63399-2-efremov@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 2020-04-26 at 16:07 +0300, Denis Efremov wrote:
> Use FD_AUTODETECT_SIZE for autodetect buffer size in struct
> floppy_drive_params instead of a magic number.

trivia:

> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
[]
> @@ -2076,7 +2076,8 @@ static int next_valid_format(int drive)
>  
>  	probed_format = drive_state[drive].probed_format;
>  	while (1) {
> -		if (probed_format >= 8 || !drive_params[drive].autodetect[probed_format]) {
> +		if (probed_format >= FD_AUTODETECT_SIZE ||
> +			!drive_params[drive].autodetect[probed_format]) {

floppy.c almost exclusively uses multi-line statement
alignment to open parenthesis.  It'd be nicer to keep
using that style.


>  			drive_state[drive].probed_format = 0;
>  			return 1;
>  		}
> @@ -3445,13 +3446,13 @@ static int fd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
>  	return 0;
>  }
>  
> -static bool valid_floppy_drive_params(const short autodetect[8],
> +static bool valid_floppy_drive_params(const short autodetect[FD_AUTODETECT_SIZE],
>  		int native_format)
> 

