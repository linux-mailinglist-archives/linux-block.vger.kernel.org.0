Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A4727723D
	for <lists+linux-block@lfdr.de>; Thu, 24 Sep 2020 15:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgIXN3q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-block@lfdr.de>); Thu, 24 Sep 2020 09:29:46 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3619 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727985AbgIXN3h (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Sep 2020 09:29:37 -0400
Received: from dggeme702-chm.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id E393F87309E377949AB1;
        Thu, 24 Sep 2020 21:13:05 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme702-chm.china.huawei.com (10.1.199.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 24 Sep 2020 21:13:05 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Thu, 24 Sep 2020 21:13:05 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: Use helper function blk_mq_sched_needs_restart()
Thread-Topic: [PATCH] block: Use helper function blk_mq_sched_needs_restart()
Thread-Index: AdaSdGCyZRuUL/YQTE2dknY2s10wgA==
Date:   Thu, 24 Sep 2020 13:13:05 +0000
Message-ID: <d00f8b54615647389c53b014fc6608b8@huawei.com>
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
>
> Use helper function blk_mq_sched_needs_restart() to check if hardware queue needs restart.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  block/blk-mq-sched.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
