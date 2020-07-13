Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE2821CB5E
	for <lists+linux-block@lfdr.de>; Sun, 12 Jul 2020 22:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgGLUiQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 12 Jul 2020 16:38:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53638 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729338AbgGLUiQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Jul 2020 16:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594586294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2qBve8P2iGMkyjOWMAQQIHIgHGMhCrdFQndb3uLOLP0=;
        b=RTbEEIQCnZzC1fggiH1DvwcEwif0Sd2Dtk1sxySxtA625HCUmhIOhDOSm4qG+NrfTUDWo9
        d5XMVIDqQ61OsQ2HyIjy0hgrmb3p1qiZzMmFswAL6mmti8AYuZUdYudbTdyXF5zeN1BgCz
        ryPdYO+OSU9puN0Bwa2+ODdN7Hzl9BQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-HqA4q7TTNYuAO4VsHGU3xA-1; Sun, 12 Jul 2020 16:38:12 -0400
X-MC-Unique: HqA4q7TTNYuAO4VsHGU3xA-1
Received: by mail-qk1-f198.google.com with SMTP id f79so9333023qke.9
        for <linux-block@vger.kernel.org>; Sun, 12 Jul 2020 13:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=2qBve8P2iGMkyjOWMAQQIHIgHGMhCrdFQndb3uLOLP0=;
        b=Wm1KEu6RPhEOpA5FXmQcwzPJgY29yg/c1Acf8Zvnt9hkreJYChXMXWfFHcZtovcz3+
         7TacihyXoOFeRKuoQIhRgw7s3ndxOmiyONJ+6McgMLJAZPCW1souPpQ9bRWB9eEt3JxR
         ivruu3/W3wg/olQshYPZHeB1xJi0hHQLgjJuf57BAjBZ/Mksg4A8TYtbEjkJz0HiMK5W
         gs8uQ14iw7zbfBkRV+3z/FGxXpM/kyPzQBbzp5qC4KcuuRwzM3ZttshM+QwYHlxBinFq
         SczxHngHqTIpPqFAieHIYwQNjJebfeRu0pC2E6SER3Hcm5e4e63TKz3X5W9EJfMozJFZ
         oQLA==
X-Gm-Message-State: AOAM531XIKozwxEbTsLaF70k2RSLMr2vd2UNFqEd/ZCkV7+tmAB0DhhW
        h7UyosrBkmJn/WcfTRoTU6AD6Rz+bJnYtnq6nlc4JW4wV6208nZbRyfqNm/av9EohYJU6F8YdjD
        KLXXK03bto4BWQfNUDhvT2Qs=
X-Received: by 2002:a37:a6ce:: with SMTP id p197mr77389771qke.211.1594586291878;
        Sun, 12 Jul 2020 13:38:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxu5vmq81STqIAWaA8vKj+4yrVNtB6fhaAqeiECOx5LnqlE72lt6VYPIxlLT4MvQlZKWCzZQ==
X-Received: by 2002:a37:a6ce:: with SMTP id p197mr77389763qke.211.1594586291593;
        Sun, 12 Jul 2020 13:38:11 -0700 (PDT)
Received: from [192.168.23.174] (c-73-253-167-23.hsd1.ma.comcast.net. [73.253.167.23])
        by smtp.gmail.com with ESMTPSA id o10sm16085503qtq.71.2020.07.12.13.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2020 13:38:10 -0700 (PDT)
Subject: Re: [PATCH 1/2] bcache: avoid nr_stripes overflow in
 bcache_device_init()
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        stable@vger.kernel.org
References: <20200712174736.9840-1-colyli@suse.de>
 <1011c22f-d186-6398-98e1-83f1c363dedd@suse.de>
From:   Ken Raeburn <raeburn@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <a504604d-ac8a-3276-e0b8-f42cb3782356@redhat.com>
Date:   Sun, 12 Jul 2020 16:38:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1011c22f-d186-6398-98e1-83f1c363dedd@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 7/12/20 1:49 PM, Coly Li wrote:
> On 2020/7/13 01:47, Coly Li wrote:
>> For some block devices which large capacity (e.g. 8TB) but small io_opt
>> size (e.g. 8 sectors), in bcache_device_init() the stripes number calcu-
>> lated by,
>> 	DIV_ROUND_UP_ULL(sectors, d->stripe_size);
>> might be overflow to the unsigned int bcache_device->nr_stripes.
>>
>> This patch uses an unsigned long variable to store DIV_ROUND_UP_ULL()
>> and after the value is checked to be available in unsigned int range,
>> sets it to bache_device->nr_stripes. Then the overflow is avoided.
> Hi Ken,
>
> Could you please to try whether these two patches may avoid the kernel
> panic ? I will post the overwhelm stripe_size patch later.
>
> Thanks.
>
> Coly Li
>
I will. But, from inspection: On a 32-bit system, "unsigned long" will 
still be 32 bits, but sector_t (u64) will still be 64 bits, so that 
assignment will still discard high bits before validation in that 
environment. I suggest "unsigned long long" or another specifically 
64-bit type.

Also, the VDO driver I work on doesn't support 32-bit platforms 
currently, so my own testing will be limited to 64-bit platforms.

Ken

