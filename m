Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966BF1EE4E9
	for <lists+linux-block@lfdr.de>; Thu,  4 Jun 2020 15:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgFDNBS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 4 Jun 2020 09:01:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37568 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725926AbgFDNBR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Jun 2020 09:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591275676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gtLXYv6ZCAJSW7eelfy8t1HYBWt1FWeb7pUbPnXdRPo=;
        b=hhY4VCJwSjSmBjXCjDIn92TAyHMiXpzT1weJK16PomsytRy5602oAn1UTdGvRY786GaFpD
        8256Yfs3KB7yL3cmj2su9VPuTVjf64O/lv2Pf2+VHuNLhhkDoyB4Ju9YfVEMwXVTqVHxDS
        zTQeBr5H1uFK9hJ1f703Cjqu18bdy9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-7MF2_RbHMXeBSeiuTxDPqw-1; Thu, 04 Jun 2020 09:01:11 -0400
X-MC-Unique: 7MF2_RbHMXeBSeiuTxDPqw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10DB0107ACCD;
        Thu,  4 Jun 2020 13:01:10 +0000 (UTC)
Received: from T590 (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AD3A6AD0C;
        Thu,  4 Jun 2020 13:01:03 +0000 (UTC)
Date:   Thu, 4 Jun 2020 21:00:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] blk-mq: don't fail driver tag allocation because of
 inactive hctx
Message-ID: <20200604130058.GC2336493@T590>
References: <20200603105128.2147139-1-ming.lei@redhat.com>
 <20200603115347.GA8653@lst.de>
 <20200603133608.GA2149752@T590>
 <6b58e473-16a4-4ce2-a4ac-50b952d364d7@huawei.com>
 <6fbd3669-4358-6d9f-5c94-e1bc7acecb86@oracle.com>
 <b37b1f30-722b-4767-0627-103b94c7421c@huawei.com>
 <20200604112615.GA2336493@T590>
 <7291fd02-3c2c-f3f9-f3eb-725cd85d5523@huawei.com>
 <20200604120747.GB2336493@T590>
 <38b4c7a3-057f-c52c-993b-523660085e3c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38b4c7a3-057f-c52c-993b-523660085e3c@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 04, 2020 at 01:45:09PM +0100, John Garry wrote:
> 
> > > That's your patch - ok, I can try.
> > > 
> 
> I still get timeouts and sometimes the same driver tag message occurs:
> 
>  1014.232417] run queue from wrong CPU 0, hctx active
> [ 1014.237692] run queue from wrong CPU 0, hctx active
> [ 1014.243014] run queue from wrong CPU 0, hctx active
> [ 1014.248370] run queue from wrong CPU 0, hctx active
> [ 1014.253725] run queue from wrong CPU 0, hctx active
> [ 1014.259252] run queue from wrong CPU 0, hctx active
> [ 1014.264492] run queue from wrong CPU 0, hctx active
> [ 1014.269453] irq_shutdown irq146
> [ 1014.272752] CPU55: shutdown
> [ 1014.275552] psci: CPU55 killed (polled 0 ms)
> [ 1015.151530] CPU56: shutdownr=1621MiB/s,w=0KiB/s][r=415k,w=0 IOPS][eta
> 00m:00s]
> [ 1015.154322] psci: CPU56 killed (polled 0 ms)
> [ 1015.184345] CPU57: shutdown
> [ 1015.187143] psci: CPU57 killed (polled 0 ms)
> [ 1015.223388] CPU58: shutdown
> [ 1015.226174] psci: CPU58 killed (polled 0 ms)
> long sleep 8
> [ 1045.234781] scsi_times_out req=0xffff041fa13e6300[r=0,w=0 IOPS][eta
> 04m:30s]
> 
> [...]
> 
> > > 
> > > I thought that if all the sched tags are put, then we should have no driver
> > > tag for that same hctx, right? That seems to coincide with the timeout (30
> > > seconds later)
> > 
> > That is weird, if there is driver tag found, that means the request is
> > in-flight and can't be completed by HW.
> 
> In blk_mq_hctx_has_requests(), we iterate the sched tags (when
> hctx->sched_tags is set). So can some requests not have a sched tag (even
> for scheduler set for the queue)?

Every request must have a scheduler tag in case of io scheduler.

> 
>  I assume you have integrated
> > global host tags patch in your test,
> 
> No, but the LLDD does not use request->tag - it generates its own.

It isn't related with request->tag, what I meant is that you use
out-of-tree patch to enable multiple hw queue on hisi_sas, you have
to make the queue mapping correct, that said the exact queue mapping
from blk-mq's mapping has to be used, which is built from managed
interrupt affinity.

Please collect the following log:

1) ./dump-io-irq-affinity $PCI_ID_OF_HBA
http://people.redhat.com/minlei/tests/tools/dump-io-irq-affinity

2) ./dump-qmap /dev/sdN
http://people.redhat.com/minlei/tests/tools/dump-qmap


> 
>  and suggest you to double check
> > hisi_sas's queue mapping which has to be exactly same with blk-mq's
> > mapping.
> > 
> 
> scheduler=none is ok, so I am skeptical of a problem there.
> 
> > > 
> > > > 
> > > > If yes, can you collect debugfs log after the timeout is triggered?
> > > 
> > > Same limitation as before - once SCSI timeout happens, SCSI error handling
> > > kicks in and the shost no longer accepts commands, and, since that same
> > > shost provides rootfs, becomes unresponsive. But I can try.
> > 
> > Just wondering why not install two disks in your test machine, :-)
> 
> The shost becomes unresponsive for all disks. So I could try nfs, but I'm
> not a fan :)

Then it will take you extra effort in collecting log, and NFS root
should have been quite easy to setup, :-)


Thanks,
Ming

