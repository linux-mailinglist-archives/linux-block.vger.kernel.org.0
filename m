Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C450D284E2D
	for <lists+linux-block@lfdr.de>; Tue,  6 Oct 2020 16:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgJFOmN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Oct 2020 10:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFOmN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 10:42:13 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90A2C0613D1
        for <linux-block@vger.kernel.org>; Tue,  6 Oct 2020 07:42:12 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id y13so13274114iow.4
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2020 07:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TVrG2g5CA3v0WpY4dsyKm3KYbRe2QU+7tte2z1GpqVE=;
        b=CDQuvq6Zm7HmhGmszFV40ZODkHSUiwbWqGs5Q8SBblBjcmh8ukb1A25SCX4EfqkwOI
         vsacAjq5v7cw5FBidGNgQmKIC4D1Sb5xA6Nefc5sbiEUsUY/T3pM3lDhz/7kq005kVzj
         STGsauohd6hmNFP8MuuhWJ64+0944m2Gvbul1/ZrdrwVQKEuhP5tKffwAfiUINLBMlIz
         11H0oVMnBGshPOY1Q+ykNNfPRYnPmWX/eycxxLQJ0M+IZXiL29AXsBlKip3XlcKxmUzc
         PGMEyUilRsqmsrMhfbMcANW2iD7T6ResPlH2tlyp/CLcf/+bbPmhgAzSxMeKU9P5edTL
         p+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TVrG2g5CA3v0WpY4dsyKm3KYbRe2QU+7tte2z1GpqVE=;
        b=d0YcbUj30GGPXHxLstiJr1IQtWTCMSvIFp8+rznd7QVttH47lkCxSC9tPA+MFBCye5
         RoeCTVdkP/48CuxOyd1spq9fwweiGztCLvSKLrzTR4rNvmWLDPZn6p7IIEcdkGOFB5ta
         9hsyunDdlc6RUPLBxBN3x6imWh3t8VeGry+SiRqTwawtyA6B9nnNyOspF9bpcvLeJzfQ
         7xO39PClunjsRU7TqiQi4v3wsVp8vIzmlFsRSxXtWKDjByW+qHf4eRbbPFviMjrhlwQ7
         yxCK0/1wHqJPMQM2XMcP32AAXTqyHf6F/m3sKt6FD7UbcZIlGvwIQMyJgeCqPslXXmlM
         cumQ==
X-Gm-Message-State: AOAM530uoHPuR0MSfBDJG3Pcwi43SWkDTsyZhuUBS9/XV0VdkfdL1Aoy
        n+K1teiPnX4DUwsjXLRhcls/La7/SDDKbw==
X-Google-Smtp-Source: ABdhPJygjfZEJbKl3yJKrQNm00LhEAizY1XQP/gmUV6L7/qiZaWBMLKe0GzKfvBexxs0ApHtu9KbUQ==
X-Received: by 2002:a5e:c70a:: with SMTP id f10mr1368119iop.178.1601995331737;
        Tue, 06 Oct 2020 07:42:11 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r19sm1547786ioc.15.2020.10.06.07.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 07:42:11 -0700 (PDT)
Subject: Re: [PATCH v8 00/18] blk-mq/scsi: Provide hostwide shared tags for
 SCSI HBAs
To:     John Garry <john.garry@huawei.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     jejb@linux.ibm.com, don.brace@microsemi.com, ming.lei@redhat.com,
        bvanassche@acm.org, dgilbert@interlog.com,
        paolo.valente@linaro.org, hare@suse.de, hch@lst.de,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, esc.storagedev@microsemi.com,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>,
        chenxiang66@hisilicon.com, luojiaxing@huawei.com
References: <1597850436-116171-1-git-send-email-john.garry@huawei.com>
 <df6a3bd3-a89e-5f2f-ece1-a12ada02b521@kernel.dk>
 <379ef8a4-5042-926a-b8a0-2d0a684a0e01@huawei.com>
 <yq1363xbtk7.fsf@ca-mkp.ca.oracle.com>
 <32def143-911f-e497-662e-a2a41572fe4f@huawei.com>
 <yq1imcdw6ni.fsf@ca-mkp.ca.oracle.com>
 <32574da3d8de863ff38347ef6ead9b35@mail.gmail.com>
 <1a7f30f3-d0bf-3703-2004-fba70cbe8212@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <31d84036-ce21-e1e7-35d3-5a629288c182@kernel.dk>
Date:   Tue, 6 Oct 2020 08:42:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1a7f30f3-d0bf-3703-2004-fba70cbe8212@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/6/20 8:24 AM, John Garry wrote:
> On 28/09/2020 17:11, Kashyap Desai wrote:
>>>
>>> John,
>>>
>>>> Have you had a chance to check these outstanding SCSI patches?
>>>>
>>>> scsi: megaraid_sas: Added support for shared host tagset for
>> cpuhotplug
>>>> scsi: scsi_debug: Support host tagset
>>>> scsi: hisi_sas: Switch v3 hw to MQ
>>>> scsi: core: Show nr_hw_queues in sysfs
>>>> scsi: Add host and host template flag 'host_tagset'
>>>
>>> These look good to me.
>>>
>>> Jens, feel free to merge.
>>
>> Hi Jens, Gentle ping. I am not able to find commits for above listed scsi
>> patches. I want to use your repo which has above mentioned patch for
>> <scsi:io_uring iopoll> patch submission.  Martin has Acked the scsi
>> patches.
>>
>>>
>>> Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
>>>
>>> --
>>> Martin K. Petersen	Oracle Linux Engineering
> 
> 
> Hi Jens,
> 
> Could you kindly pick up the following patches, to go along with the 
> blk-mq changes:
> 
> scsi: megaraid_sas: Added support for shared host tagset for
> cpuhotplug
> scsi: scsi_debug: Support host tagset
> scsi: hisi_sas: Switch v3 hw to MQ
> scsi: core: Show nr_hw_queues in sysfs
> scsi: Add host and host template flag 'host_tagset'

Sorry about the delay, picked up these 5 patches.

-- 
Jens Axboe

