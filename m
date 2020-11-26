Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE2E2C4EA2
	for <lists+linux-block@lfdr.de>; Thu, 26 Nov 2020 07:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbgKZGQ2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Nov 2020 01:16:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732249AbgKZGQ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 01:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606371387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=opxi3+VknEuLnVn5NroXrsP9PLuEVvPNB505Ha74F2s=;
        b=aYusROjXx0GUp9ZjTw+plBpEowOxPp7mVsLQJK0cG70nXmLCr8tv9bIiJLS0kLAZe44ynw
        L/89VJLprYtV6UmmCHqs/+rSAyfbujAd1qWjcYOjThFYU+k5HR0zUsYwx34Jz+ociW5zrr
        CkeXM4J7JC3UXeFH2piQUl01tZE+elI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-jhog46PbOmmLzZNNaQPcNA-1; Thu, 26 Nov 2020 01:16:25 -0500
X-MC-Unique: jhog46PbOmmLzZNNaQPcNA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C238110066FB;
        Thu, 26 Nov 2020 06:16:23 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-67.pek2.redhat.com [10.72.12.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C650960636;
        Thu, 26 Nov 2020 06:16:21 +0000 (UTC)
Subject: Re: [PATCH V2 blktests 3/5] nvmeof-mp/012, srp/012: fix the scheduler
 list
To:     Bart Van Assche <bvanassche@acm.org>, osandov@osandov.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
References: <20201125073205.8788-1-yi.zhang@redhat.com>
 <20201125073205.8788-4-yi.zhang@redhat.com>
 <7fb6260a-4e3d-f023-7471-266188771f39@acm.org>
From:   Yi Zhang <yi.zhang@redhat.com>
Message-ID: <86f0b36c-b484-ee4e-26cd-d5dde35a46eb@redhat.com>
Date:   Thu, 26 Nov 2020 14:16:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7fb6260a-4e3d-f023-7471-266188771f39@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 11/26/20 11:59 AM, Bart Van Assche wrote:
> On 11/24/20 11:32 PM, Yi Zhang wrote:
>> +# Get block dev scheduler list
>> +get_scheduler_list() {
>> +	local b=$1 p
>> +	p=/sys/block/"$b"/queue/scheduler
>> +	if [ -e "$p" ]; then
>> +		scheds=$(sed 's/[][]//g' /sys/block/"$b"/queue/scheduler)
>> +		echo "$scheds"
>> +	else
>> +		return 1
>> +	fi
>> +}
> Can the echo statement and the 'scheds' assignment be left out? This is
> what I have in mind:
Sure, will update with V3.

> 	sed 's/[][]//g' /sys/block/"$b"/queue/scheduler
>
> Otherwise this patch looks good to me.
>
> Thanks,
>
> Bart.
>

