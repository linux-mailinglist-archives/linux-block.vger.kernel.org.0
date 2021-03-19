Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FE734122D
	for <lists+linux-block@lfdr.de>; Fri, 19 Mar 2021 02:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhCSBhJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 Mar 2021 21:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60012 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229820AbhCSBgy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Mar 2021 21:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616117813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zRgJe9Rsc8G4coUFBf1b1X9lpJZ6VRZ34Ftf5YfAc4I=;
        b=O2uhd3IZ6+QcexujHuD4cBiUM3FXgbU2I9ls/VzFBHwzd1jSE4xKUe5O+RUsfthvzzb60f
        GOqzcdLgPSqiYh4rcZSMWI//IdU3QGpFQrKEbBnTWtjtGSmtEexQPLce8FvJ4S+vw/tdyu
        WgVJVvg37kolEA1S7SONoNN1vWSxusE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-6qJJyMSuOeeHmwARgDvhyA-1; Thu, 18 Mar 2021 21:36:52 -0400
X-MC-Unique: 6qJJyMSuOeeHmwARgDvhyA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89B4D107ACCD;
        Fri, 19 Mar 2021 01:36:50 +0000 (UTC)
Received: from T590 (ovpn-12-90.pek2.redhat.com [10.72.12.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 732EF5D9DE;
        Fri, 19 Mar 2021 01:36:44 +0000 (UTC)
Date:   Fri, 19 Mar 2021 09:36:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jason Yan <yanaijie@huawei.com>, axboe@kernel.dk, hch@lst.de,
        keescook@chromium.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: do not copy data to user when bi_status is error
Message-ID: <YFQAKIjt5VzUNYDe@T590>
References: <20210318122621.330010-1-yanaijie@huawei.com>
 <20210318151305.GB31228@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318151305.GB31228@redsun51.ssa.fujisawa.hgst.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 19, 2021 at 12:13:05AM +0900, Keith Busch wrote:
> On Thu, Mar 18, 2021 at 08:26:21PM +0800, Jason Yan wrote:
> > When the user submitted a request with unaligned buffer, we will
> > allocate a new page and try to copy data to or from the new page.
> > If it is a reading request, we always copy back the data to user's
> > buffer, whether the result is good or error. So if the driver or
> > hardware returns an error, garbage data is copied to the user space.
> > This is a potential security issue which makes kernel info leaks.
> > 
> > So do not copy the uninitalized data to user's buffer if the
> > bio->bi_status is not BLK_STS_OK in bio_copy_kern_endio_read().
> 
> If we're using copy_kern routines, doesn't that mean it's a kernel
> request rather than user space?

It can be a kernel bounce buffer, which will be copied to user space
later, such as sg_scsi_ioctl(), but sg_scsi_ioctl() checks the request
result and not copy kernel buffer back in case of error.

Seems other cases are all kernel request.

-- 
Ming

