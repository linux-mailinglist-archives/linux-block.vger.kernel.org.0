Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165851E369E
	for <lists+linux-block@lfdr.de>; Wed, 27 May 2020 05:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbgE0Dgd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 26 May 2020 23:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728478AbgE0Dgd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 May 2020 23:36:33 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E715206F1;
        Wed, 27 May 2020 03:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590550593;
        bh=g795YNhpz6ErqnozUO1OAeEdQzAsLj/CkT7WEI/3mrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nYZuC7MwlQ3FF65kPaJSJ7FTDh+vyBA4Z4lSYtzXwdXOMFjvBYfDqqfdRKOUsBtoD
         qn/Z5vbTRwviVHd5fcvruTcirm2eylFM2z5ofcgk629O2UuzprOZudv+W8zujRxNqT
         zCwcAGqyIdbfirWVCzQ2ETphSaDeiO+2bPvjz5gY=
Date:   Wed, 27 May 2020 12:36:29 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: nvme double __blk_mq_complete_request() bugs
Message-ID: <20200527033629.GB24861@redsun51.ssa.fujisawa.hgst.com>
References: <c77b0998-5112-4d6b-b51c-41d2b901009d@default>
 <86a0321e-d260-ef8c-db9f-b804fc92c670@grimberg.me>
 <49f32df9-81a9-4c15-9950-aceff8fb291e@oracle.com>
 <20200525164516.GC73686@C02WT3WMHTD6>
 <d5c51f9c-3706-bc22-1a67-3695880d4918@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5c51f9c-3706-bc22-1a67-3695880d4918@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 26, 2020 at 06:04:27PM -0700, Dongli Zhang wrote:
> On 5/25/20 9:45 AM, Keith Busch wrote:
> > On Sun, May 24, 2020 at 07:33:02AM -0700, Dongli Zhang wrote:
> 3. In the context of blk_poll().
> 
> I do not find a mechanism to protect the race in this case.
> 
> By adding mdelay() to code, I am able to reproduce the below race on purpose.

Yeah, there's no other way to synchronize with a potential polling
thread, so locking within the driver looks like the right thing to do
for now.

It'd be great if we could temporarily halt polling while resetting,
though, as that is potentially a lot of wasted cpu cycles if requests
are requeued while the controller resets. But that's a different issue
than what you're addressing.
