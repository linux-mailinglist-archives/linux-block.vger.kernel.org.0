Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CDF2AA1B8
	for <lists+linux-block@lfdr.de>; Sat,  7 Nov 2020 01:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgKGARX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 6 Nov 2020 19:17:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26050 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728075AbgKGARX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 6 Nov 2020 19:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604708242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v6CWDfxUrEMSgCPHrZBAxJY/9eFy91aUYMF539q1D3E=;
        b=T9HKmXRKe67pbFsaCcTAW104pUN17vEURRQuRd012PoMLKujOrSkY1QvTfySt1rTjy1QLh
        ocGz4I9Inl+G75ZIc76RnBcQiwTT+g2L4NMQYz5kp4NO5g1qyuXD2ACQp1B4NaB/V4if+F
        qNvwjUjk6mZt/jFjZePpaRK9C/v+09s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-SaysXiQwMqSg95MfWo-BJA-1; Fri, 06 Nov 2020 19:17:18 -0500
X-MC-Unique: SaysXiQwMqSg95MfWo-BJA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30546185A0D2;
        Sat,  7 Nov 2020 00:17:15 +0000 (UTC)
Received: from ovpn-66-140.rdu2.redhat.com (ovpn-66-140.rdu2.redhat.com [10.10.66.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3414A5C1BD;
        Sat,  7 Nov 2020 00:17:09 +0000 (UTC)
Message-ID: <aaf849d38ca3cdd45151ffae9b6a99fe6f6ea280.camel@redhat.com>
Subject: Re: [PATCH v8 17/18] scsi: megaraid_sas: Added support for shared
 host tagset for cpuhotplug
From:   Qian Cai <cai@redhat.com>
To:     Sumit Saxena <sumit.saxena@broadcom.com>,
        John Garry <john.garry@huawei.com>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        don.brace@microsemi.com, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>, dgilbert@interlog.com,
        paolo.valente@linaro.org, Hannes Reinecke <hare@suse.de>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        esc.storagedev@microsemi.com,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>,
        chenxiang66@hisilicon.com, luojiaxing@huawei.com,
        Hannes Reinecke <hare@suse.com>
Date:   Fri, 06 Nov 2020 19:17:08 -0500
In-Reply-To: <CAL2rwxoAAGQDud1djb3_LNvBw95YoYUGhe22FwE=hYhy7XOLSw@mail.gmail.com>
References: <1597850436-116171-1-git-send-email-john.garry@huawei.com>
         <1597850436-116171-18-git-send-email-john.garry@huawei.com>
         <fe3dff7dae4494e5a88caffbb4d877bbf472dceb.camel@redhat.com>
         <385d5408-6ba2-6bb6-52d3-b59c9aa9c5e5@huawei.com>
         <193a0440eed447209c48bda042f0e4db102355e7.camel@redhat.com>
         <519e0d58-e73e-22ce-0ddb-1be71487ba6d@huawei.com>
         <d8fd51b11d5d54e6ec7e4e9a4f7dcc83f1215cd3.camel@redhat.com>
         <d4f86cccccc3bffccc4eda39500ce1e1fee2109a.camel@redhat.com>
         <7624d3fe1613f19af5c3a77f4ae8fe55@mail.gmail.com>
         <d1040c06-74ea-7016-d259-195fa52196a9@huawei.com>
         <CAL2rwxoAAGQDud1djb3_LNvBw95YoYUGhe22FwE=hYhy7XOLSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 2020-11-07 at 00:55 +0530, Sumit Saxena wrote:
> I am able to hit the boot hang and similar kind of stack traces as
> reported by Qian with shared .config on x86 machine.
> In my case the system boots after a hang of 40-45 mins. Qian, is it
> true for you as well ?
I don't know. I had never waited for that long.

