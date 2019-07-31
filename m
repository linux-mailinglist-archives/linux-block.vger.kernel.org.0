Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 460AC7C64F
	for <lists+linux-block@lfdr.de>; Wed, 31 Jul 2019 17:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfGaPW1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 31 Jul 2019 11:22:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727992AbfGaPW1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 11:22:27 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67409208C3;
        Wed, 31 Jul 2019 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564586546;
        bh=ClRP/HKTVmek69IiWZvv0iKAUEF2zthVYhGN8lcKHbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UndKVLcl8gxM0PAVeerERGD6/6D/M0AsUn/31rcUUnQuHllW09Mfu/7wAWVoIq4le
         2miZGr9SkQgLw0kzv2DajEZIb/2rfpJbDCg/ryqWff6H8/5zBzTiQz717wYUkxIIYE
         iLFKRtsuuX59dCQAg+qspeUzrxc2Fpczl/XNLxPE=
Date:   Wed, 31 Jul 2019 16:22:21 +0100
From:   Will Deacon <will@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     efremov@linux.com, Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>, Greg KH <greg@kroah.com>,
        Alexander Popov <alex.popov@linux.com>, efremov@ispras.ru,
        linux-block@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: floppy: take over maintainership
Message-ID: <20190731152220.xgif4fwyqybb37pp@willie-the-truck>
References: <20190712185523.7208-1-efremov@ispras.ru>
 <20190713080726.GA19611@1wt.eu>
 <ec0a6c5e-bdee-3c26-f5d2-31b883c0de5d@ispras.ru>
 <CAHk-=wi=fHuiQg1fMzqAP9cuykBQSN_feD=eALDwRPmw27UwEg@mail.gmail.com>
 <nycvar.YFH.7.76.1907172355020.5899@cbobk.fhfr.pm>
 <57af5f3e-9cfe-b6d8-314c-f59855408cd5@linux.com>
 <431bd981-d81a-d4dd-75fe-96a29f8f1065@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431bd981-d81a-d4dd-75fe-96a29f8f1065@kernel.dk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 31, 2019 at 08:53:22AM -0600, Jens Axboe wrote:
> On 7/31/19 8:47 AM, Denis Efremov wrote:
> > Hi All,
> > 
> > On 18.07.2019 01:03, Jiri Kosina wrote:
> >> On Wed, 17 Jul 2019, Linus Torvalds wrote:
> >>
> >>> I don't think we really have a floppy maintainer any more,
> >>
> >> Yeah, I basically volunteered myself to maintain it quite some time
> >> ago back when I fixed the concurrency issues which exhibited itself
> >> only with VM-emulated devices, and at the same time I still had the
> >> physical 3.5" reader.
> >>
> >> The hardware doesn't work any more though. So I guess I should just
> >> remove myself as a maintainer to reflect the reality and mark floppy.c
> >> as Orphaned.
> > 
> > Well, without jokes about Thunderdome, I've got time, hardware and
> > would like to maintain the floppy. Except the for recent fixes,
> > I described floppy ioctls in syzkaller. I've already spent quite
> > a lot of time with this code. Thus, if nobody minds
> 
> Great, can't see anyone objecting to doling out some floppy love.

Whatever that involves, I don't like the sound of it.

> Applied, thanks.

Here's a belated Ack if you can add it:

Acked-by: Will Deacon <will@kernel.org>

Either way, thanks Denis.

Will
