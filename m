Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03171C1D35
	for <lists+linux-block@lfdr.de>; Fri,  1 May 2020 20:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbgEASbc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 1 May 2020 14:31:32 -0400
Received: from smtprelay0204.hostedemail.com ([216.40.44.204]:39068 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729975AbgEASbc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 May 2020 14:31:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 0A7B12C6D;
        Fri,  1 May 2020 18:31:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:1801:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3871:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4605:5007:9025:9149:10004:10400:10848:11232:11658:11914:12043:12296:12297:12663:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21433:21451:21611:21627:21660:21788:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: dogs64_818401b510b47
X-Filterd-Recvd-Size: 1813
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Fri,  1 May 2020 18:31:29 +0000 (UTC)
Message-ID: <ef9d8e0985364994b23abd0c757715690b18c27c.camel@perches.com>
Subject: Re: [PATCH v3 0/4] floppy: suppress UBSAN warning in
 setup_rw_floppy()
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org
Cc:     Willy Tarreau <w@1wt.eu>, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 01 May 2020 11:31:28 -0700
In-Reply-To: <2c506547-236e-02e2-53f1-9484ba6ae453@linux.com>
References: <20200501134416.72248-1-efremov@linux.com>
         <c05138cb12f43498299d2b438173d082be2ebf17.camel@perches.com>
         <2c506547-236e-02e2-53f1-9484ba6ae453@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2020-05-01 at 21:22 +0300, Denis Efremov wrote:
> On 5/1/20 9:02 PM, Joe Perches wrote:
> > On Fri, 2020-05-01 at 16:44 +0300, Denis Efremov wrote:
> > > These patches are based on Willy's cleanup patches
> > > https://lkml.org/lkml/2020/3/31/609.
> > 
> > Maybe add pr_fmt and clean up a few messages so
> > all the logging output is prefixed too.
> > 
> 
> Yes, I'm preparing next patchset with almost the same pr_fmt patch in it.
> However, simply adding pr_fmt is not enough. We need to remove DPRINT macro
> from the driver because it uses current_drive and this is wrong after Willy's cleanups.
> 
> #define DPRINT(format, args...) \                                                
>         pr_info("floppy%d: " format, current_drive, ##args)
> 
> I also don't like debug_dcl and how it is used.

great, thanks.


