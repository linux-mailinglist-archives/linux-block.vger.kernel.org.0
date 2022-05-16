Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDEE5282A1
	for <lists+linux-block@lfdr.de>; Mon, 16 May 2022 12:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241714AbiEPKv4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 16 May 2022 06:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243000AbiEPKv3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 06:51:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C205FB498;
        Mon, 16 May 2022 03:51:27 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L1wvs6kvwz683mQ;
        Mon, 16 May 2022 18:48:25 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 16 May 2022 12:51:25 +0200
Received: from [10.47.25.151] (10.47.25.151) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 16 May
 2022 11:51:24 +0100
Message-ID: <102a4b9b-e0b8-d46f-6444-2d5f70d8f046@huawei.com>
Date:   Mon, 16 May 2022 11:51:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [bug report] IOMMU reports data translation fault for fio testing
From:   John Garry <john.garry@huawei.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>
CC:     "chenxiang66@hisilicon.com >> Xiang Chen" <chenxiang66@hisilicon.com>,
        "liyihang (E)" <liyihang6@hisilicon.com>
References: <2b7d091b-4caf-948f-b41a-29a7fcb9fc2a@huawei.com>
 <f5739f11-f07c-3bfe-451a-6d7a24550e61@acm.org>
 <0f274df2-e7e2-bfca-14b5-631fe78fc6da@huawei.com>
In-Reply-To: <0f274df2-e7e2-bfca-14b5-631fe78fc6da@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.25.151]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 14/05/2022 10:49, John Garry wrote:
>>> It could be an issue with the SCSI hba driver.
>>
>> That seems likely to me.
> 

Actually it is a LLDD problem. Sometimes it takes 45 minutes to trigger, 
though – not nice to bisect.

This looks to be the problematic patch:

author John Garry <john.garry@huawei.com> 2022-02-10 18:43:24 +0800
committer Martin K. Petersen <martin.petersen@oracle.com> 2022-02-11 
17:02:50 -0500
commit 26fc0ea74fcb9b76b41f5e9b89728cd1c01559cd (patch)
scsi: libsas: Drop SAS_TASK_AT_INITIATOR

If interested, this looks like the issue:

void hisi_sas_task_deliver(struct hisi_hba *hisi_hba,
break;
}

- spin_lock_irqsave(&task->task_state_lock, flags);
- task->task_state_flags |= SAS_TASK_AT_INITIATOR;
- spin_unlock_irqrestore(&task->task_state_lock, flags);
-
WRITE_ONCE(slot->ready, 1);

Losing the spinlock loses the barrier semantics as well, so a memory 
ordering issue.

> Sure, that would be common wisdom. However the commit before anything 
> related to driver was added for 5.18 is also bad. It could be 
> pre-existing, but that starts to seem unlikely. Or it could still be an 
> IOMMU issue - we already have a performance issue there.
> 
> This issue can take more than 15 minutes to occur, so is pretty painful 
> to bisect...

