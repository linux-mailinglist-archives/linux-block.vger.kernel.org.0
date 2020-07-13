Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0044521AC33
	for <lists+linux-block@lfdr.de>; Fri, 10 Jul 2020 02:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgGJAyL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 9 Jul 2020 20:54:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42437 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726311AbgGJAyK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Jul 2020 20:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594342449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EapRtSU2QNt1NzNhoxrX4bLoQr998x+J/E2XwR1l2wY=;
        b=Ql0Vnz3ccD5qIBsLwMqvYQTxACLRfXa1ADHL1fExQ2q8CxLupXD15nNk+mPQta6OwM+mRV
        Dbl2GNCdCvIbEM16Ns0cdAj+GNlhnNuIHj18I12EwaK/7Z+a0P197CCjZOpIK1SWrtrDEB
        cZHt+iQu+pThiM/Smm/aE/14Q1OX8ck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-cC4wDhvXNY-8nX_D1WALmA-1; Thu, 09 Jul 2020 20:54:05 -0400
X-MC-Unique: cC4wDhvXNY-8nX_D1WALmA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 645738015FB;
        Fri, 10 Jul 2020 00:54:04 +0000 (UTC)
Received: from T590 (ovpn-12-70.pek2.redhat.com [10.72.12.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B940E60C80;
        Fri, 10 Jul 2020 00:53:58 +0000 (UTC)
Date:   Fri, 10 Jul 2020 08:53:54 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Florian-Ewald Mueller <florian-ewald.mueller@cloud.ionos.com>
Subject: Re: [PATCH RFC 4/5] block: add a statistic table for io latency
Message-ID: <20200710005354.GA3395574@T590>
References: <20200708075819.4531-1-guoqing.jiang@cloud.ionos.com>
 <20200708075819.4531-5-guoqing.jiang@cloud.ionos.com>
 <20200708132958.GC3340386@T590>
 <eb2cf4d0-4260-8f10-0ba9-3cbf4ff85449@cloud.ionos.com>
 <b37dd9cd-aebc-88ee-2b09-ac4eb36ca0f7@cloud.ionos.com>
 <cc04e449-3d41-3ef7-10c2-c257512d7650@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc04e449-3d41-3ef7-10c2-c257512d7650@cloud.ionos.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Guoqing,

On Thu, Jul 09, 2020 at 08:48:08PM +0200, Guoqing Jiang wrote:
> Hi Ming,
> 
> On 7/8/20 4:06 PM, Guoqing Jiang wrote:
> > On 7/8/20 4:02 PM, Guoqing Jiang wrote:
> > > > Hi Guoqing,
> > > > 
> > > > I believe it isn't hard to write a ebpf based script(bcc or
> > > > bpftrace) to
> > > > collect this kind of performance data, so looks not necessary to do it
> > > > in kernel.
> > > 
> > > Hi Ming,
> > > 
> > > Sorry, I don't know well about bcc or bpftrace, but I assume they
> > > need to
> > > read the latency value from somewhere inside kernel. Could you point
> > > how can I get the latency value? Thanks in advance!
> > 
> > Hmm, I suppose biolatency is suitable for track latency, will look into
> > it.
> 
> I think biolatency can't trace data if it is not running,

Yeah, the ebpf prog is only injected when the trace is started.

> also seems no
> place
> inside kernel have recorded such information for ebpf to read, correct me
> if my understanding is wrong.

Just record the info by starting the bcc script in case you need that, is there
anything wrong with this usage? Always doing such stuff in kernel isn't fair for
users which don't care or need this info.

> 
> And as cloud provider,we would like to know data when necessary instead
> of collect data by keep script running because it is expensive than just
> read
> node IMHO.

It shouldn't be expensive. It might be a bit slow to inject the ebpf prog because
the code has to be verified, however once it is put inside kernel, it should have
been efficient enough. The kernel side prog only updates & stores the latency
summery data into bpf map, and the stored summery data can be read out anytime
by userspace.

Could you explain a bit why it is expensive? such as biolatency


Thanks, 
Ming

