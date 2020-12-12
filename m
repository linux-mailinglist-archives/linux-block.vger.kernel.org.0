Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331122D847A
	for <lists+linux-block@lfdr.de>; Sat, 12 Dec 2020 05:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391308AbgLLE25 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 11 Dec 2020 23:28:57 -0500
Received: from smtprelay0156.hostedemail.com ([216.40.44.156]:43902 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390895AbgLLE2e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Dec 2020 23:28:34 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 92A341802DA2D;
        Sat, 12 Dec 2020 04:27:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:4321:5007:6119:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12740:12760:12895:13069:13141:13230:13311:13357:13439:13972:14096:14097:14181:14659:14721:21080:21451:21627:30012:30054:30060:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: shoe55_600a68027406
X-Filterd-Recvd-Size: 2115
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat, 12 Dec 2020 04:27:50 +0000 (UTC)
Message-ID: <4257c266dd5edf3ad6617657331abcabfd59188f.camel@perches.com>
Subject: Re: [PATCH] block: drop dead assignments in loop_init()
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel-janitors@vger.kernel.org
Date:   Fri, 11 Dec 2020 20:27:49 -0800
In-Reply-To: <CAKXUXMxjtv5B4ekC58=Ww8R4Ju2MvT0pXbPi7XH+OU7JuYnP3w@mail.gmail.com>
References: <20201211181236.25755-1-lukas.bulwahn@gmail.com>
         <alpine.DEB.2.22.394.2012111923020.2669@hadrien>
         <CAKXUXMxjtv5B4ekC58=Ww8R4Ju2MvT0pXbPi7XH+OU7JuYnP3w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2020-12-11 at 19:40 +0100, Lukas Bulwahn wrote:
> On Fri, Dec 11, 2020 at 7:23 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> > On Fri, 11 Dec 2020, Lukas Bulwahn wrote:
> > > Commit 8410d38c2552 ("loop: use __register_blkdev to allocate devices on
> > > demand") simplified loop_init(); so computing the range of the block region
> > > is not required anymore and can be dropped.
> > > 
> > > Drop dead assignments in loop_init().
> > > 
> > > As compilers will detect these unneeded assignments and optimize this,
> > > the resulting object code is identical before and after this change.
> > > 
> > > No functional change. No change in object code.
> > 
> > It looks like some braces should be dropped too?

> I just rewrote it to:
> 
> nr = max_loop ? max_loop : CONFIG_BLK_DEV_LOOP_MIN_COUNT;

A relatively common gcc extension would use ?: like:

	nr = max_loop ?: CONFIG_BLK_DEV_LOOP_MIN_COUNT;


