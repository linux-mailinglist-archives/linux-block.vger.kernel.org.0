Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB64314F9D
	for <lists+linux-block@lfdr.de>; Tue,  9 Feb 2021 14:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhBIM7g (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 9 Feb 2021 07:59:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229988AbhBIM7e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Feb 2021 07:59:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612875487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2dpli5+gLSnBPf6sEUku4wzcfwLa1zWNbAJEkLA+hY=;
        b=icE69d++nY1VA8gx2Wyj/Ob8yjU/nqhiAJUGBfXMboCGgHXvMq2FrdF7amFvVhwOqm+ga5
        nbmCyL1fa3FYsPlzGLOOVB0eapDThQPMbwi4RhrtGKCnoC/oS3SJCRLJnuztAnJyv/eTqp
        WjYpJ96GR6J33FFc+FVNyePudRix3tc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-5VYmTVcON_WAMHtZiGoxlg-1; Tue, 09 Feb 2021 07:58:03 -0500
X-MC-Unique: 5VYmTVcON_WAMHtZiGoxlg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A41BD106BC6D;
        Tue,  9 Feb 2021 12:58:02 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-90.pek2.redhat.com [10.72.12.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 427DC5D6D7;
        Tue,  9 Feb 2021 12:57:58 +0000 (UTC)
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
To:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-block <linux-block@vger.kernel.org>
Cc:     axboe@kernel.dk, Rachel Sibley <rasibley@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        Chaitanya.Kulkarni@wdc.com, Ming Lei <ming.lei@redhat.com>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <a88fd4c8-8d5c-6934-39bc-5c864e3ed84f@grimberg.me>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <aec13f12-640c-77d5-bbdd-b4a3e18f1bf2@redhat.com>
Date:   Tue, 9 Feb 2021 20:57:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a88fd4c8-8d5c-6934-39bc-5c864e3ed84f@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2/9/21 6:25 PM, Sagi Grimberg wrote:
>
>> Hi Sagi
>>
>> On 2/8/21 5:46 PM, Sagi Grimberg wrote:
>>>
>>>> Hello
>>>>
>>>> We found this kernel NULL pointer issue with latest 
>>>> linux-block/for-next and it's 100% reproduced, let me know if you 
>>>> need more info/testing, thanks
>>>>
>>>> Kernel repo: 
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
>>>> Commit: 11f8b6fd0db9 - Merge branch 'for-5.12/io_uring' into for-next
>>>>
>>>> Reproducer: blktests nvme-tcp/012
>>>
>>> Thanks for reporting Ming, I've tried to reproduce this on my VM
>>> but did not succeed. Given that you have it 100% reproducible,
>>> can you try to revert commit:
>>>
>>> 0dc9edaf80ea nvme-tcp: pass multipage bvec to request iov_iter
>>>
>>
>> Revert this commit fixed the issue and I've attached the config. :)
>
> Hey Ming,
>
> Instead of revert, does this patch makes the issue go away?
Hi Sagi

Below patch fixed the issue, let me know if you need more testing. :)

Thanks
Yi

> -- 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 619b0d8f6e38..69f59d2c5799 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2271,7 +2271,7 @@ static blk_status_t 
> nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
>         req->data_len = blk_rq_nr_phys_segments(rq) ?
>                                 blk_rq_payload_bytes(rq) : 0;
>         req->curr_bio = rq->bio;
> -       if (req->curr_bio)
> +       if (req->curr_bio && req->data_len)
>                 nvme_tcp_init_iter(req, rq_data_dir(rq));
>
>         if (rq_data_dir(rq) == WRITE &&
> -- 
>

