Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3AEE2B68FD
	for <lists+linux-block@lfdr.de>; Tue, 17 Nov 2020 16:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgKQPqj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Nov 2020 10:46:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726569AbgKQPqj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Nov 2020 10:46:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605627998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FYTJCFMw3HBh+Maj7+5z3ky42cWoFclAuHWeLpHwgeI=;
        b=YR7hLuYkzDU7V+6B5Lj1EiUE8NxpzPrcEgxy0GTZHojgu8C+2ViiNkhB8UCn4LCfhGsWbB
        nfJE3DLSxIFzEhCgwHlloUaPXWHaFbGVTuvEd7sjBLCvRdVvvGLOLIk4tEf9noUCwxfE7F
        tmMh0O8sMEOWELNE0m/nBIkJ0uOZb2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-afiCGzq-PqS-qSDmKIcJxg-1; Tue, 17 Nov 2020 10:46:35 -0500
X-MC-Unique: afiCGzq-PqS-qSDmKIcJxg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F5441074653;
        Tue, 17 Nov 2020 15:46:34 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A9A0210013DB;
        Tue, 17 Nov 2020 15:46:30 +0000 (UTC)
Date:   Tue, 17 Nov 2020 10:46:29 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: misc struct block_device related driver cleanups
Message-ID: <20201117154629.GA27085@redhat.com>
References: <20201116212020.1099154-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116212020.1099154-1-hch@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 16 2020 at  4:20pm -0500,
Christoph Hellwig <hch@lst.de> wrote:

> Hi Jens, Minchan and Mike,
> 
> this series cleans up a few interactions of driver with struct
> block_device, in preparation for big changes to struct block_device
> that I plan to send soon.

Thanks, I've picked up 5 and 6 for 5.11.

