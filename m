Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD4C2C3A35
	for <lists+linux-block@lfdr.de>; Wed, 25 Nov 2020 08:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgKYHhE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 25 Nov 2020 02:37:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30824 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727895AbgKYHhD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Nov 2020 02:37:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606289822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UE7tmWp3B3FPpWAh4AE1RxaTN+NE6wJBTbnmF01pz3M=;
        b=hICaeYXiuM9lEDSmAimwwHfQH9WgE4Yazw5QERddRu7bQW+IN7DQNY9jHxjX2TdhHmgboS
        rRkW88YRKXx7JZAVc5ulAx/Dc+JTIQQ/Yx49eloAjTaFDzVpjwXH1av2paFRzpS8/dT0A7
        z54iSLJxIaXD1cIsrZWGJmNhNSkZdeE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-z6liXsrFPQGLqE7u9Ir4bg-1; Wed, 25 Nov 2020 02:36:58 -0500
X-MC-Unique: z6liXsrFPQGLqE7u9Ir4bg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04F425226;
        Wed, 25 Nov 2020 07:36:57 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-67.pek2.redhat.com [10.72.12.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 07B1960C43;
        Wed, 25 Nov 2020 07:36:54 +0000 (UTC)
Subject: Re: [PATCH blktests 2/5] tests/nvmeof-mp/rc: run nvmeof-mp tests if
 we set multipath=N
To:     Bart Van Assche <bvanassche@acm.org>, osandov@osandov.com
Cc:     linux-block@vger.kernel.org, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-3-yi.zhang@redhat.com>
 <324d227a-7ba2-309f-4298-ea787dfb76c0@acm.org>
 <04404583-9b7c-571d-7680-9b5253258268@redhat.com>
 <3da24cd0-5127-a6e7-ec1d-848c61b12946@acm.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <98f3e7fa-d5a7-99f4-5778-72f74f5f3885@redhat.com>
Date:   Wed, 25 Nov 2020 15:36:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3da24cd0-5127-a6e7-ec1d-848c61b12946@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 11/25/20 11:51 AM, Bart Van Assche wrote:
> On 11/24/20 6:04 AM, Yi Zhang wrote:
>> Do you mean something like this, could you add more detail here, thanks.
>>
>> diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
>> index d7a7c87..af700d9 100755
>> --- a/tests/nvmeof-mp/rc
>> +++ b/tests/nvmeof-mp/rc
>> @@ -16,9 +16,9 @@ group_requires() {
>>
>>          # Since the nvmeof-mp tests are based on the dm-mpath driver, these
>>          # tests are incompatible with the NVME_MULTIPATH kernel
>> configuration
>> -       # option.
>> -       if _have_kernel_option NVME_MULTIPATH; then
>> -               SKIP_REASON="CONFIG_NVME_MULTIPATH has been set in .config"
>> +       # option and nvme_core: multipath set with Y.
>> +       if _have_kernel_option NVME_MULTIPATH &&
>> _have_module_param_value nvme_core multipath Y; then
>> +               SKIP_REASON="CONFIG_NVME_MULTIPATH has been set in
>> .config and nvme_core: multipath should be set with N"
>>                  return
>>          fi
> I may have sent you in the wrong direction. This is what I meant:
>
> 	if _have_kernel_option NVME_MULTIPATH &&
> 	    _have_module_param_value nvme_core multipath Y; then
> 	    SKIP_REASON="CONFIG_NVME_MULTIPATH has been set in .config and
> multipathing has been enabled in the nvme_core kernel module"
> 	    return
> 	fi
Updated on V2, thanks for the review.

> Thanks,
>
> Bart.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

