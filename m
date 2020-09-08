Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33FF26180F
	for <lists+linux-block@lfdr.de>; Tue,  8 Sep 2020 19:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgIHRsF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 8 Sep 2020 13:48:05 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2797 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731982AbgIHRsC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Sep 2020 13:48:02 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id C8C77FFD658B0BA32181;
        Tue,  8 Sep 2020 14:41:22 +0100 (IST)
Received: from [127.0.0.1] (10.47.6.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 8 Sep 2020
 14:41:21 +0100
Subject: Re: [PATCH v8 00/18] blk-mq/scsi: Provide hostwide shared tags for
 SCSI HBAs
To:     Hannes Reinecke <hare@suse.de>, <axboe@kernel.dk>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <don.brace@microsemi.com>, <kashyap.desai@broadcom.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <dgilbert@interlog.com>, <paolo.valente@linaro.org>, <hch@lst.de>
CC:     <sumit.saxena@broadcom.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <esc.storagedev@microsemi.com>, <megaraidlinux.pdl@broadcom.com>,
        <chenxiang66@hisilicon.com>, <luojiaxing@huawei.com>
References: <1597850436-116171-1-git-send-email-john.garry@huawei.com>
 <cef0e816-1b30-dd62-0f39-2842df766298@suse.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <51a599a0-0952-ced1-ad78-89012c46f5eb@huawei.com>
Date:   Tue, 8 Sep 2020 14:38:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <cef0e816-1b30-dd62-0f39-2842df766298@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.6.45]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08/09/2020 13:46, Hannes Reinecke wrote:
> Now that Jens merged the block bits in his tree, wouldn't it be better
> to re-send the SCSI bits only, thereby avoiding a potential merge error
> later on?
> 

Anything which I resend would need to be against Jens' tree (and not 
Martin's), assuming Jens will carry them also. So I am not sure how that 
will help.

JFYI, I just tested against today's linux-next, and the SCSI parts (hpsa 
and smartpqi omitted) still apply there without conflict.

Thanks,
John
