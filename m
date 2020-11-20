Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712972BA4B3
	for <lists+linux-block@lfdr.de>; Fri, 20 Nov 2020 09:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgKTIdL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 20 Nov 2020 03:33:11 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2133 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgKTIdL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 03:33:11 -0500
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CcqX33bwdz67G7S;
        Fri, 20 Nov 2020 16:31:31 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 20 Nov 2020 09:33:08 +0100
Received: from [10.200.65.129] (10.200.65.129) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 20 Nov 2020 08:33:07 +0000
Subject: Re: [PATCH v1 2/3] megaraid_sas: iouring iopoll support
To:     Hannes Reinecke <hare@suse.de>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        <linux-scsi@vger.kernel.org>
CC:     <sumit.saxena@broadcom.com>, <chandrakanth.patil@broadcom.com>,
        <linux-block@vger.kernel.org>
References: <20201015133702.62879-1-kashyap.desai@broadcom.com>
 <494a87e9-2994-0965-e5d5-56f2a3b13f0b@suse.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2dae79b3-2083-75e0-73fc-ab52c5546bc8@huawei.com>
Date:   Fri, 20 Nov 2020 08:32:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <494a87e9-2994-0965-e5d5-56f2a3b13f0b@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.200.65.129]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 20/11/2020 07:14, Hannes Reinecke wrote:
>>
>>       struct rdpq_alloc_detail rdpq_tracker[RDPQ_MAX_CHUNK_COUNT];
>>
> The usage of atomic_add_unless() is a bit unusual; one might consider 
> using atomic_test_and_set(). Also it seems to be a bit of a waste using 
> an atomic counter here, seeing that the only values ever used are 0 and 
> 1. But this is largely cosmetic, so:

atomic_add_unless() is generally implemented with a cmpxchg(), which can 
be inefficient also.

John
