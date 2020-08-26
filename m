Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF39A2529C5
	for <lists+linux-block@lfdr.de>; Wed, 26 Aug 2020 11:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgHZJMt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 26 Aug 2020 05:12:49 -0400
Received: from smtprelay0204.hostedemail.com ([216.40.44.204]:49552 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727906AbgHZJMs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Aug 2020 05:12:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 5F9B0180A68C8;
        Wed, 26 Aug 2020 09:12:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2538:2559:2562:2828:2901:3138:3139:3140:3141:3142:3622:3865:3867:3870:4250:4321:4605:5007:6742:7875:7903:10004:10400:10848:11658:11914:12043:12297:12740:12760:12895:13019:13069:13311:13357:13439:14181:14659:14721:21080:21627:30012:30054:30067:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: field82_4a0e14027063
X-Filterd-Recvd-Size: 1581
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Wed, 26 Aug 2020 09:12:45 +0000 (UTC)
Message-ID: <8570915f668159f93ba2eb845a3bbc05f8ee3a99.camel@perches.com>
Subject: Re: [PATCH 17/19] z2ram: reindent
From:   Joe Perches <joe@perches.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Date:   Wed, 26 Aug 2020 02:12:43 -0700
In-Reply-To: <20200826062446.31860-18-hch@lst.de>
References: <20200826062446.31860-1-hch@lst.de>
         <20200826062446.31860-18-hch@lst.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2020-08-26 at 08:24 +0200, Christoph Hellwig wrote:
> reindent the driver using Lident as the code style was far away from
> normal Linux code.

Why?  Does anyone use this anymore?

 ** z2ram - Amiga pseudo-driver to access 16bit-RAM in ZorroII space
 **         as a block device, to be used as a RAM disk or swap space
 ** Copyright (C) 1994 by Ingo Wilken (Ingo.Wilken@informatik.uni-oldenburg.de)



