Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E301B949F
	for <lists+linux-block@lfdr.de>; Mon, 27 Apr 2020 01:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgDZXT1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 26 Apr 2020 19:19:27 -0400
Received: from smtprelay0208.hostedemail.com ([216.40.44.208]:59630 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726196AbgDZXT1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Apr 2020 19:19:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 877ED1802926E;
        Sun, 26 Apr 2020 23:19:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2901:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4605:5007:6119:6248:7903:8603:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12555:12740:12760:12895:13069:13138:13231:13311:13357:13439:14659:14721:14777:21080:21433:21451:21524:21627:21660:30054:30069:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: mass24_18171631e960e
X-Filterd-Recvd-Size: 2230
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sun, 26 Apr 2020 23:19:25 +0000 (UTC)
Message-ID: <7835ce311322434328099d3c9a22b0a5b281c6e4.camel@perches.com>
Subject: Re: [PATCH v2 3/3] floppy: suppress UBSAN warning in
 setup_rw_floppy()
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org
Cc:     Willy Tarreau <w@1wt.eu>, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Date:   Sun, 26 Apr 2020 16:19:24 -0700
In-Reply-To: <20200426130728.63399-4-efremov@linux.com>
References: <20200426130728.63399-1-efremov@linux.com>
         <20200426130728.63399-4-efremov@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 2020-04-26 at 16:07 +0300, Denis Efremov wrote:
> UBSAN: array-index-out-of-bounds in drivers/block/floppy.c:1521:45
> index 16 is out of range for type 'unsigned char [16]'
[]
> This out-of-bounds access is intentional. The command in struct
> floppy_raw_cmd may take up the space initially intended for the reply
> and the reply count. It is needed for long 82078 commands such as
> RESTORE, which takes 17 command bytes. Initial cmd size is not enough
> and since struct setup_rw_floppy is a part of uapi we check that
> cmd_count is in [0:16+1+16] in raw_cmd_copyin().
> 
> The patch adds union with original cmd,reply_count,reply fields and
> fullcmd field of equivalent size. The cmd accesses are turned to
> fullcmd where appropriate to suppress UBSAN warning.
[]
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
[]
> @@ -1072,7 +1072,7 @@ static void setup_DMA(void)
>  
>  		pr_info("zero dma transfer size:");
>  		for (i = 0; i < raw_cmd->cmd_count; i++)
> -			pr_cont("%x,", raw_cmd->cmd[i]);
> +			pr_cont("%x,", raw_cmd->fullcmd[i]);
>  		pr_cont("\n");

slightly unrelated trivia: perhaps better as:

		print_hex_dump(KERN_INFO, "zero dma transfer size: ",
			       DUMP_PREFIX_NONE, 16, 1,
			       raw_cmd->fullcmd, raw_cmd->cmd_count, false);

to avoid pr_cont use.


