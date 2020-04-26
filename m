Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453F71B93F1
	for <lists+linux-block@lfdr.de>; Sun, 26 Apr 2020 22:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgDZU2S (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 26 Apr 2020 16:28:18 -0400
Received: from smtprelay0208.hostedemail.com ([216.40.44.208]:50652 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726176AbgDZU2R (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Apr 2020 16:28:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id E605C182CED5B;
        Sun, 26 Apr 2020 20:28:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3872:4321:4605:5007:6119:6120:6248:7901:7903:10004:10400:10848:11026:11232:11473:11658:11914:12296:12297:12740:12760:12895:13069:13255:13311:13357:13439:14659:14721:14777:21080:21433:21524:21627:21990:30034:30054:30056:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bomb38_8261953751d37
X-Filterd-Recvd-Size: 1958
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sun, 26 Apr 2020 20:28:15 +0000 (UTC)
Message-ID: <6a051ca29c9017f1c6fefc5d2894c8dd4542a208.camel@perches.com>
Subject: Re: [PATCH v2 2/3] floppy: add defines for sizes of cmd & reply
 buffers of floppy_raw_cmd
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org
Cc:     Willy Tarreau <w@1wt.eu>, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Date:   Sun, 26 Apr 2020 13:28:14 -0700
In-Reply-To: <20200426130728.63399-3-efremov@linux.com>
References: <20200426130728.63399-1-efremov@linux.com>
         <20200426130728.63399-3-efremov@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 2020-04-26 at 16:07 +0300, Denis Efremov wrote:
> Use FD_RAW_CMD_SIZE, FD_RAW_REPLY_SIZE defines instead of magic numbers
> for cmd & reply buffers of struct floppy_raw_cmd. Remove local to
> floppy.c MAX_REPLIES define, as it is now FD_RAW_REPLY_SIZE.
> FD_RAW_CMD_FULLSIZE added as we allow command to also fill reply_count
> and reply fields.
[]
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
[]
> @@ -1847,7 +1846,7 @@ static void show_floppy(int fdc)
>  			output_log[(i + output_log_pos) % OLOGSIZE].jiffies);
>  	pr_info("last result at %lu\n", resultjiffies);
>  	pr_info("last redo_fd_request at %lu\n", lastredo);
> -	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1,
> +	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, FD_RAW_REPLY_SIZE, 1,
>  		       reply_buffer, resultsize, true);

FD_RAW_REPLY_SIZE happens to be 16, but it's misleading
to use it here.

This use of 16 is not for FD_RAW_REPLY_SIZE, but the
width of the line
being dumped, and this value must be
either 16 or 32.


