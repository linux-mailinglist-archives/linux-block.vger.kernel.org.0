Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51182244F42
	for <lists+linux-block@lfdr.de>; Fri, 14 Aug 2020 22:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgHNUoK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 14 Aug 2020 16:44:10 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41817 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgHNUoJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Aug 2020 16:44:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id f10so4696874plj.8
        for <linux-block@vger.kernel.org>; Fri, 14 Aug 2020 13:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C17o7d1MIphvyM5N3VMBFo6uXfTUhSV4ALkKc9r+fkk=;
        b=ZhAjLEIpTH64h3x4GvsCCqYv4zm5vCvExXTVUZw6cfcniVSV+zQP3gepFuwXG2op0o
         23T9FLaAGs/q7+l3Srid58s/0Er9opd25AtTBm/bKcfczYyMeGXklLo9lLtPudNEDbUh
         0MKm4uigXCtnB5GcZ5C5ayEgt87IMYPe6Yj3Gy+lsL8laNSXKW/MW3ssrmWkuk4hzfmy
         724KHdXSMQYURUhdF91EVf8TuCpOAOGkLl07mQG0z3TSYc9FtzLXLBwZpBnwumLjVCyP
         DnLWGJAQcdASittcg/fdH7ets6el3l9xbeyS2sUqaTzD1iZ8y51QlQoZo0BMU0xCX9WO
         layA==
X-Gm-Message-State: AOAM532LCV1eqp2FelkscgP5ZBLT2DQ7bl+FqM2kGbcRdpleoBdOesrj
        VN9I6P0O32pB3E50bxWlWm0=
X-Google-Smtp-Source: ABdhPJz4y/CuF6oXQcSSklsTDE+vGzRvVl3x9562QrM80uOlygk2X3UnOssEOBhMBYr/8zyr2Xp0Rg==
X-Received: by 2002:a17:902:ff03:: with SMTP id f3mr3189532plj.302.1597437849189;
        Fri, 14 Aug 2020 13:44:09 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:51f:3472:bc7:2f4f? ([2601:647:4802:9070:51f:3472:bc7:2f4f])
        by smtp.gmail.com with ESMTPSA id t33sm9470589pga.72.2020.08.14.13.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 13:44:08 -0700 (PDT)
Subject: Re: [PATCH v4 7/7] nvme: support rdma transport type
To:     Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200814061815.536540-1-sagi@grimberg.me>
 <20200814061815.536540-8-sagi@grimberg.me>
 <ffcaf9e2-083c-9601-16bd-054c3bd3b94c@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a0adbdf0-bdb2-00de-02b9-b47dfc57ec35@grimberg.me>
Date:   Fri, 14 Aug 2020 13:44:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ffcaf9e2-083c-9601-16bd-054c3bd3b94c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On 8/14/20 2:18 PM, Sagi Grimberg wrote:
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   tests/nvme/rc | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/tests/nvme/rc b/tests/nvme/rc
>> index 3e97801bbb30..675acbfa7012 100644
>> --- a/tests/nvme/rc
>> +++ b/tests/nvme/rc
>> @@ -5,6 +5,7 @@
>>   # Test specific to NVMe devices
>>   . common/rc
>> +. common/multipath-over-rdma
>>   def_traddr="127.0.0.1"
>>   def_adrfam="ipv4"
>> @@ -25,6 +26,12 @@ _nvme_requires() {
>>           _have_modules nvmet nvme-core nvme-tcp nvmet-tcp
>>           _have_configfs
>>           ;;
>> +    rdma)
>> +        _have_modules nvmet nvme-core nvme-rdma nvmet-rdma
>> +        _have_configfs
>> +        _have_program rdma
>> +        _have_modules rdma_rxe siw
> 
> start_soft_rdma can use siw or rdma_rxe(default one) module, but some 
> old distros may not support siw, but suppor rdma_rxe.
> how about:
> _have_modules rdma_rxe || _have_modules siw

OK
