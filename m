Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10F21BD197
	for <lists+linux-block@lfdr.de>; Wed, 29 Apr 2020 03:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgD2BRn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Apr 2020 21:17:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50772 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726353AbgD2BRn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 21:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588123062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a9rWN0ISEDMcvYISG0NzTefsKNinJfINEugf2xFfHd0=;
        b=eEBUF+Ayqw7LMuuNcHky22VWo9O/zkgfq51RPtDC2YT/I0Da0nPFVmBTZH4aGSB8KixuEu
        eod1QOBM2CsRFLFl+ps2wyWqXElKQ5LuECudh6Y2Jy7eGz+aBxCIBAcW8TuYgY0v8CsjfM
        KnuN/hkRzHi90qRqQI6hX0iZY5BuHbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-kQrsfha6M0iStoZNoGDQpA-1; Tue, 28 Apr 2020 21:17:40 -0400
X-MC-Unique: kQrsfha6M0iStoZNoGDQpA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 222DB107ACCA;
        Wed, 29 Apr 2020 01:17:39 +0000 (UTC)
Received: from T590 (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 46F1510013BD;
        Wed, 29 Apr 2020 01:17:32 +0000 (UTC)
Date:   Wed, 29 Apr 2020 09:17:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Salman Qazi <sqazi@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] block: add blk_default_io_timeout() for avoiding
 task hung in sync IO
Message-ID: <20200429011728.GA671522@T590>
References: <20200428074657.645441-1-ming.lei@redhat.com>
 <20200428074657.645441-2-ming.lei@redhat.com>
 <7e339c3d-8600-4a9b-99bf-24afb023c4dd@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e339c3d-8600-4a9b-99bf-24afb023c4dd@acm.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 28, 2020 at 07:19:33AM -0700, Bart Van Assche wrote:
> On 2020-04-28 00:46, Ming Lei wrote:
> > +/*
> > + * Used in sync IO for avoiding to triger task hung warning, which may
> > + * cause system panic or reboot.
> > + */
> > +static inline unsigned long blk_default_io_timeout(void)
> > +{
> > +	return sysctl_hung_task_timeout_secs * (HZ / 2);
> > +}
> > +
> >  #endif
> 
> This function is only used inside the block layer. Has it been
> considered to move this function from the public block layer API into a
> private header file, e.g. block/blk.h?

Please look at the commit log or the 2nd patch, and the helper will be
used in 2nd patch in dio code.

Thanks,
Ming

