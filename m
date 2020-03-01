Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB827174F9C
	for <lists+linux-block@lfdr.de>; Sun,  1 Mar 2020 21:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgCAUof (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 1 Mar 2020 15:44:35 -0500
Received: from smtprelay0026.hostedemail.com ([216.40.44.26]:51379 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725895AbgCAUoe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 1 Mar 2020 15:44:34 -0500
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Mar 2020 15:44:34 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id D145718008030
        for <linux-block@vger.kernel.org>; Sun,  1 Mar 2020 20:35:03 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 647788384365;
        Sun,  1 Mar 2020 20:35:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1566:1593:1594:1711:1714:1730:1747:1777:1792:2198:2199:2393:2559:2562:2731:2828:2895:3138:3139:3140:3141:3142:3622:3865:3866:3867:3870:3871:3872:3873:4250:4321:4362:5007:6119:6120:7901:7903:10004:10400:10848:11232:11658:11914:12297:12679:12740:12760:12895:13069:13311:13357:13439:14659:21080:21627:30034:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: paste97_832d4b52ef958
X-Filterd-Recvd-Size: 1189
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sun,  1 Mar 2020 20:35:01 +0000 (UTC)
Message-ID: <03a2ea0b91ab61ba9a11230e82f1fb3bdf420a50.camel@perches.com>
Subject: Re: [PATCH v2 0/6] floppy: make use of the local/global fdc explicit
From:   Joe Perches <joe@perches.com>
To:     Willy Tarreau <w@1wt.eu>, Denis Efremov <efremov@linux.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Date:   Sun, 01 Mar 2020 12:33:25 -0800
In-Reply-To: <20200301195555.11154-1-w@1wt.eu>
References: <20200301195555.11154-1-w@1wt.eu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, 2020-03-01 at 20:55 +0100, Willy Tarreau wrote:
> This is an update to the first minimal cleanup of the floppy driver in
> order to make use of the FDC number explicit so as to avoid bugs like
> the one fixed by 2e90ca68 ("floppy: check FDC index for errors before
> assigning it").

Thanks Willy.

trivia: you could style check the patches using checkpatch.


