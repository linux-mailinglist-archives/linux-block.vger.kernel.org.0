Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBAB255227
	for <lists+linux-block@lfdr.de>; Fri, 28 Aug 2020 03:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgH1BLK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 27 Aug 2020 21:11:10 -0400
Received: from smtprelay0247.hostedemail.com ([216.40.44.247]:36728 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726147AbgH1BLJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 21:11:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id B49D2181D3025;
        Fri, 28 Aug 2020 01:11:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1560:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3622:3867:3873:4321:5007:6742:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: can98_270b1e627071
X-Filterd-Recvd-Size: 1791
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Aug 2020 01:11:03 +0000 (UTC)
Message-ID: <32f16bf6137f8575f2b1d66258d77269ce0f9d28.camel@perches.com>
Subject: Re: [PATCH 17/19] z2ram: reindent
From:   Joe Perches <joe@perches.com>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Date:   Thu, 27 Aug 2020 18:11:02 -0700
In-Reply-To: <alpine.LNX.2.23.453.2008281052580.8@nippy.intranet>
References: <8570915f668159f93ba2eb845a3bbc05f8ee3a99.camel@perches.com>
                 <EF673A30-F88D-4E4E-8A2B-E942153830AC@physik.fu-berlin.de>
                 <b88538f92386f41b938c502ae2daec5800a85dcf.camel@perches.com>
                 <alpine.LNX.2.23.453.2008280859300.10@nippy.intranet>
         <5682daf68b94be288c05f859942ce06deec2b022.camel@perches.com>
         <alpine.LNX.2.23.453.2008281052580.8@nippy.intranet>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2020-08-28 at 10:57 +1000, Finn Thain wrote:
> On Thu, 27 Aug 2020, Joe Perches wrote:
> 
> > checkpatch already does this.
> > 
> 
> Did you use checkpatch to generate this patch?

Nope.

