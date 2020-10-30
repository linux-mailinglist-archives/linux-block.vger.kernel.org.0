Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7B729FA80
	for <lists+linux-block@lfdr.de>; Fri, 30 Oct 2020 02:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725372AbgJ3BX2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 29 Oct 2020 21:23:28 -0400
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:52318 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725379AbgJ3BX1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Oct 2020 21:23:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id A389A18029210;
        Fri, 30 Oct 2020 01:23:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:973:988:989:1042:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2525:2538:2560:2563:2682:2685:2691:2734:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3855:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6117:6119:6742:9025:9108:10004:10400:10848:11232:11658:11914:12043:12297:12679:12740:12760:12895:13069:13161:13200:13229:13311:13357:13439:14096:14097:14659:14721:14819:21063:21067:21080:21451:21627:21772:30054:30067:30070:30079:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: teeth17_541127c27292
X-Filterd-Recvd-Size: 2939
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri, 30 Oct 2020 01:23:22 +0000 (UTC)
Message-ID: <0b286566394d2e65cf3977ce3a76c6bbc18cb947.camel@perches.com>
Subject: Re: [PATCH] z2ram: MODULE_LICENSE update and neatening
From:   Joe Perches <joe@perches.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Hannes Reinecke <hare@suse.de>
Date:   Thu, 29 Oct 2020 18:23:21 -0700
In-Reply-To: <202d1246a14617e4e7a4a7b723dc92191815d134.camel@HansenPartnership.com>
References: <20201029145841.144173-1-hch@lst.de>
         <20201029145841.144173-18-hch@lst.de>
         <4945b720d67e9f67b8c8ba02a29c6af1ffa15b08.camel@perches.com>
         <202d1246a14617e4e7a4a7b723dc92191815d134.camel@HansenPartnership.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2020-10-29 at 18:01 -0700, James Bottomley wrote:
> On Thu, 2020-10-29 at 17:11 -0700, Joe Perches wrote:
> > This file still does not have an SPDX line.  What should it be?
> 
> It's old style MIT with a slight variation:
> 
> https://fedoraproject.org/wiki/Licensing:MIT#Old_Style

Yes, it's quite similar.
But ", and sell" does not exist in this variant.

So I believe its use of MODULE_LICENSE("GPL") is not correct and
that MODULE_LICENSE("GPL and additional rights") might be the best
available option.

MIT Old style:

Permission to use, copy, modify, distribute, and sell this software and its
documentation for any purpose is hereby granted without fee, provided that
the above copyright notice appear in all copies and that both that
copyright notice and this permission notice appear in supporting
documentation.  No representations are made about the suitability of this
software for any purpose.  It is provided "as is" without express or
implied warranty.

License in the file:

 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose and without fee is hereby granted, provided
 * that the above copyright notice appear in all copies and that both that
 * copyright notice and this permission notice appear in supporting
 * documentation.  This software is provided "as is" without express or
 * implied warranty.


