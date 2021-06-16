Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081C03A9672
	for <lists+linux-block@lfdr.de>; Wed, 16 Jun 2021 11:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhFPJoH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Jun 2021 05:44:07 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7458 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbhFPJoH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 05:44:07 -0400
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G4g9v4KHLzZhjg;
        Wed, 16 Jun 2021 17:38:59 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by dggeme756-chm.china.huawei.com
 (10.3.19.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 16
 Jun 2021 17:41:54 +0800
Subject: Re: remove ->revalidate_disk (resend)
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, <martin.petersen@oracle.com>
References: <20210308074550.422714-1-hch@lst.de>
CC:     <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <96011dbd-084f-8a07-3506-fc7717122866@hisilicon.com>
Date:   Wed, 16 Jun 2021 17:41:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20210308074550.422714-1-hch@lst.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Before i reported a issue related to revalidate disk 
(https://www.spinics.net/lists/linux-scsi/msg151610.html), and no one 
replies, but the issue is still.

And i plan to resend it, but i find that revalidate_disk interface is 
completely removed in this patchset.

Do you have any idea about the above issue?

ÔÚ 2021/3/8 15:45, Christoph Hellwig Ð´µÀ:
> Hi Jens,
>
> with the previously merged patches all real users of ->revalidate_disk
> are gone.  This series removes the two remaining not actually required
> instances and the method itself.
>
> .
>


