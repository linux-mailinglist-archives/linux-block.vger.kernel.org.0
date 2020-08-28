Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35F32553BC
	for <lists+linux-block@lfdr.de>; Fri, 28 Aug 2020 06:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgH1EZW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 28 Aug 2020 00:25:22 -0400
Received: from verein.lst.de ([213.95.11.211]:40833 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgH1EZW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Aug 2020 00:25:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1386A68BEB; Fri, 28 Aug 2020 06:25:19 +0200 (CEST)
Date:   Fri, 28 Aug 2020 06:25:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 17/19] z2ram: reindent
Message-ID: <20200828042518.GA29768@lst.de>
References: <8570915f668159f93ba2eb845a3bbc05f8ee3a99.camel@perches.com> <EF673A30-F88D-4E4E-8A2B-E942153830AC@physik.fu-berlin.de> <b88538f92386f41b938c502ae2daec5800a85dcf.camel@perches.com> <alpine.LNX.2.23.453.2008280859300.10@nippy.intranet> <5682daf68b94be288c05f859942ce06deec2b022.camel@perches.com> <alpine.LNX.2.23.453.2008281052580.8@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.23.453.2008281052580.8@nippy.intranet>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 28, 2020 at 10:57:46AM +1000, Finn Thain wrote:
> On Thu, 27 Aug 2020, Joe Perches wrote:
> 
> > 
> > checkpatch already does this.
> > 
> 
> Did you use checkpatch to generate this patch?

I used scripts/Lindent.
