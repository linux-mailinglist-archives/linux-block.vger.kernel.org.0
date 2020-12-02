Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5DE2CC07D
	for <lists+linux-block@lfdr.de>; Wed,  2 Dec 2020 16:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgLBPMr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Dec 2020 10:12:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35977 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727116AbgLBPMq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Dec 2020 10:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606921880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BI29tL8haMOOy0hp46ljwCMGR3G48eRovDB8MadITvs=;
        b=Tanx0uce/dSE/N8PQ5f0mWNWppEo7igVg1qXZoPL4HByWAMQP3J/jCFasNIkZ1pDHJ3PTt
        t1Yg6MHsxPZHt/5zlVByF8SFDLg6fxaxv95j4vvRr66p7srfZOb5SrbMM4jROZ/UcBTgob
        q9aUriw+2II4yQL53uqIpxG6EI9aZRU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-nlBjB5GxPkG3Og55m4gtcQ-1; Wed, 02 Dec 2020 10:11:18 -0500
X-MC-Unique: nlBjB5GxPkG3Og55m4gtcQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5F5B805BE8;
        Wed,  2 Dec 2020 15:11:17 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CC246086F;
        Wed,  2 Dec 2020 15:11:13 +0000 (UTC)
Date:   Wed, 2 Dec 2020 10:11:12 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     dm-devel@redhat.com, joseph.qi@linux.alibaba.com,
        linux-block@vger.kernel.org
Subject: Re: dm: use gcd() to fix chunk_sectors limit stacking
Message-ID: <20201202151112.GD20535@redhat.com>
References: <20201201160709.31748-1-snitzer@redhat.com>
 <20201202033855.60882-1-jefflexu@linux.alibaba.com>
 <20201202033855.60882-2-jefflexu@linux.alibaba.com>
 <feb19a02-5ece-505f-e905-86dc84cdb204@linux.alibaba.com>
 <20201202050343.GA20535@redhat.com>
 <7326607a-b687-3989-dee7-cf469ab37ac4@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7326607a-b687-3989-dee7-cf469ab37ac4@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 02 2020 at  2:10am -0500,
JeffleXu <jefflexu@linux.alibaba.com> wrote:

> 
> 
> On 12/2/20 1:03 PM, Mike Snitzer wrote:
> > What you've done here is fairly chaotic/disruptive:
> > 1) you emailed a patch out that isn't needed or ideal, I dealt already
> >    staged a DM fix in linux-next for 5.10-rcX, see:
> >    https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.10-rcX&id=f28de262ddf09b635095bdeaf0e07ff507b3c41b
> 
> Then ti->type->io_hints() is still bypassed when type->iterate_devices()
> not defined?

Yes, the stacking of limits really is tightly coupled to device-based
influence.  Hypothetically some DM target that doesn't remap to any data
devices may want to override limits... in practice there isn't a need
for this.  If that changes we can take action to accommodate it.. but I'm
definitely not interested in modifying DM core in this area when there
isn't a demonstrated need.

Mike

