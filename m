Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E428D27E5C3
	for <lists+linux-block@lfdr.de>; Wed, 30 Sep 2020 11:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgI3J4w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-block@lfdr.de>); Wed, 30 Sep 2020 05:56:52 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:50296 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbgI3J4w (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Sep 2020 05:56:52 -0400
Received: from dggeme751-chm.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 4A6D2517AB59E70F5E9C;
        Wed, 30 Sep 2020 17:56:50 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme751-chm.china.huawei.com (10.3.19.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 30 Sep 2020 17:56:50 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Wed, 30 Sep 2020 17:56:49 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "hare@suse.de" <hare@suse.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] block: Fix potential page reference leak in
 __bio_iov_append_get_pages()
Thread-Topic: [PATCH v2] block: Fix potential page reference leak in
 __bio_iov_append_get_pages()
Thread-Index: AdaXD/GYebYJg7gnRyK05cQC2N0IMw==
Date:   Wed, 30 Sep 2020 09:56:49 +0000
Message-ID: <24dbab430cbb4464b0915f268229e077@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.109]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Friendly ping :)

> When bio_add_hw_page() failed, we left page reference still held in pages from iov_iter_get_pages(). Release these references and also advance the iov_iter according to what we have done successfully yet.
>
> Fixes: 0512a75b98f8 ("block: Introduce REQ_OP_ZONE_APPEND")
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  block/bio.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/block/bio.c b/block/bio.c
> index e113073958cb..a323a5446221 100644
> --- a/block/bio.c
