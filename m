Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C692240AB1E
	for <lists+linux-block@lfdr.de>; Tue, 14 Sep 2021 11:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhINJuq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 14 Sep 2021 05:50:46 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3791 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhINJup (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 05:50:45 -0400
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H7z5j2htrz67n3k;
        Tue, 14 Sep 2021 17:47:05 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 14 Sep 2021 11:49:26 +0200
Received: from [10.47.80.114] (10.47.80.114) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 14 Sep
 2021 10:49:25 +0100
Subject: Re: [PATCH v2] scsi: bsg: Fix device unregistration
To:     Zenghui Yu <yuzenghui@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <fujita.tomonori@lab.ntt.co.jp>, <axboe@kernel.dk>,
        <martin.petersen@oracle.com>, <hch@lst.de>,
        <gregkh@linuxfoundation.org>, <johan@kernel.org>,
        <wanghaibin.wang@huawei.com>
References: <20210911105306.1511-1-yuzenghui@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b4ade32d-30b0-5b8d-5384-971b78fcfc6c@huawei.com>
Date:   Tue, 14 Sep 2021 10:53:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210911105306.1511-1-yuzenghui@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.114]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/09/2021 11:53, Zenghui Yu wrote:
> We use device_initialize() to take refcount for the device but forget to
> put_device() on device teardown, which ends up leaking private data of the
> driver core, dev_name(), etc. This is reported by kmemleak at boot time if
> we compile kernel with DEBUG_TEST_DRIVER_REMOVE.
> 
> Note that adding the missing put_device() is_not_  sufficient to fix device
> unregistration. As we don't provide the .release() method for device, which
> turned out to be typically wrong and will be complained loudly by the
> driver core.
> 
> Fix both of them.
> 
> Fixes: ead09dd3aed5 ("scsi: bsg: Simplify device registration")
> Signed-off-by: Zenghui Yu<yuzenghui@huawei.com>


FWIW,

Tested-by: John Garry <john.garry@huawei.com>
