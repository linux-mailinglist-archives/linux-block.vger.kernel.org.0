Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C2A2C3A32
	for <lists+linux-block@lfdr.de>; Wed, 25 Nov 2020 08:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgKYHgP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 25 Nov 2020 02:36:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21090 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726027AbgKYHgN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 02:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606289772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hCPkwGoXkBAlp7t4JLhYbkUTm9+RLSJqjI18VgzPKQU=;
        b=E3sDqi0y8Jk90TMeyX+9+H41PsbFLEfEZLHBaV1qIBwaoMXRyYF2cxsxNH1Opk3QarqXVY
        +Rk9wxMv1gmbwiererGyIkc5ISEe7hjZOQlScpxwGIbJouj/71pPHbUz1e873qym73I0B8
        qXEzo3/OqDxfbCUnhf/X0KClngpA4oQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-jovdcSbjNSS4Om5QtFXIxA-1; Wed, 25 Nov 2020 02:36:09 -0500
X-MC-Unique: jovdcSbjNSS4Om5QtFXIxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC3C918C89DA;
        Wed, 25 Nov 2020 07:36:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-67.pek2.redhat.com [10.72.12.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 026825C1A1;
        Wed, 25 Nov 2020 07:36:05 +0000 (UTC)
Subject: Re: [PATCH blktests 1/5] tests/srp/rc: update the ib_srpt module name
To:     Bart Van Assche <bvanassche@acm.org>, osandov@osandov.com
Cc:     linux-block@vger.kernel.org, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-2-yi.zhang@redhat.com>
 <7b6d00d7-2cf8-5a4b-f861-a7efe152843f@acm.org>
 <54f41dc8-41a5-e782-e135-dc7dc81209c0@redhat.com>
 <3e4208ef-3508-0db2-3b1d-96f055e1a37f@acm.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <3cdec4ab-37af-b55a-377a-17f2362e4575@redhat.com>
Date:   Wed, 25 Nov 2020 15:36:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3e4208ef-3508-0db2-3b1d-96f055e1a37f@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 11/25/20 11:47 AM, Bart Van Assche wrote:
> On 11/24/20 6:01 AM, Yi Zhang wrote:
>> On 11/24/20 11:23 AM, Bart Van Assche wrote:
>>> On 11/23/20 5:04 PM, Yi Zhang wrote:
>>>> -    insmod "/lib/modules/$(uname
>>>> -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt.ko" "${opts[@]}" ||
>>>> return $?
>>>> +    insmod "$(ls /lib/modules/"$(uname
>>>> -r)"/kernel/drivers/infiniband/ulp/srpt/ib_srpt.*)" "${opts[@]}" ||
>>>> return $?
>>> Is 'ls' needed here or is 'echo' sufficient?
>> Actually it doesn't work without ls
>> $ insmod "/lib/modules/"$(uname
>> -r)"/kernel/drivers/infiniband/ulp/srpt/ib_srpt.*"
>> insmod: ERROR: could not load module
>> /lib/modules/5.10.0-rc5/kernel/drivers/infiniband/ulp/srpt/ib_srpt.*: No
>> such file or directory
>>
>> and it works with echo, I can change to echo if you prefer
>> $ insmod "$(echo /lib/modules/"$(uname
>> -r)"/kernel/drivers/infiniband/ulp/srpt/ib_srpt.*)" "${opts[@]}" ||
>> return $?
> 'echo' is a shell built-in while ls is not built-in into bash, so echo
> is faster.
yeah, thanks for the info.
> How about insmod "/lib/modules/$(uname
> -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt."* (no echo, no ls,
> asterisk outside double quotes)?
This works, have updated to V2

> Thanks,
>
> Bart.
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

