Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C84A276E62
	for <lists+linux-block@lfdr.de>; Thu, 24 Sep 2020 12:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgIXKN6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 24 Sep 2020 06:13:58 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:14279 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgIXKN5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Sep 2020 06:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1600942437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dxq6kcZuD1yLhz83BdQaDBswf+r7H5Cw763TEiIA5Ks=;
  b=Il0jhs334bOK10DoEpusXfBPn17ZpuBu0s49b+IO38UC2Nst4woelFBN
   Kx21FFBQXQm6CKaMhTl9eY64+XmHP8UBVwEasemw82W3dZCh4rVSRUgOv
   i57VK9S8xsmUxzuN+tTcdIiIiYrWD8zVBU3fP5tPz3t7oOCWdnJvLCdS0
   s=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: aa9Yc5uXsNyZc4a3xJjI0PKxAR/Q972NX44zik2KmyXqKIBIwfskdtuxoCOTkpDzQqtPG5Ik68
 mWzavWg3o5Ena2knokLLhk07n2q6itSyIjuGpZBNMC3du2eDTN9uB00bOIIh2lBQEtzJ0KYZrC
 806XnxjNuw18wsK3GcVFFzAObva5+PihDMkZ8n3kuZIOl1MVqq6xhCLdv2LRIU4QPsAHgSTzXI
 dI7U6/tY5qSKfc4zjw+ra9KETYu+azT3zprazSO+RJqQzET1XibyqxZUlS635Pb+nk46w8yis4
 J6U=
X-SBRS: None
X-MesageID: 28460264
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,297,1596513600"; 
   d="scan'208";a="28460264"
Date:   Thu, 24 Sep 2020 12:13:44 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        SeongJae Park <sjpark@amazon.de>, <axboe@kernel.dk>,
        <aliguori@amazon.com>, <amit@kernel.org>, <mheyne@amazon.de>,
        <linux-block@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen-blkback: add a parameter for disabling of persistent
 grants
Message-ID: <20200924101344.GN19254@Air-de-Roger>
References: <20200922070125.27251-1-sjpark@amazon.com>
 <20200923200930.GB11767@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200923200930.GB11767@char.us.oracle.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 FTLPEX02CL06.citrite.net (10.13.108.179)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 23, 2020 at 04:09:30PM -0400, Konrad Rzeszutek Wilk wrote:
> On Tue, Sep 22, 2020 at 09:01:25AM +0200, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > Persistent grants feature provides high scalability.  On some small
> > systems, however, it could incur data copy overhead[1] and thus it is
> > required to be disabled.  But, there is no option to disable it.  For
> > the reason, this commit adds a module parameter for disabling of the
> > feature.
> 
> Would it be better suited to have it per guest?

I think having a per-backend policy that could be specified at the
toolstack level would be nice, but I see that as a further
improvement.

Having a global backend domain policy of whether persistent grants are
enabled or not seems desirable, and if someone wants even more fine
grained control this change is AFAICT not incompatible with a
per-backend option anyway.

Roger.
