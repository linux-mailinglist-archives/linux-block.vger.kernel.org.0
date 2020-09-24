Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD13227726D
	for <lists+linux-block@lfdr.de>; Thu, 24 Sep 2020 15:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgIXNeg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-block@lfdr.de>); Thu, 24 Sep 2020 09:34:36 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:50094 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727533AbgIXNeg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Sep 2020 09:34:36 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id D3D62AA4D460A7DFD8DC;
        Thu, 24 Sep 2020 21:12:29 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 24 Sep 2020 21:12:29 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Thu, 24 Sep 2020 21:12:29 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "tj@kernel.org" <tj@kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: Fix various comments
Thread-Topic: [PATCH] block: Fix various comments
Thread-Index: AdaSdCYyDcujaIPUTDS3EBwXCKkCoQ==
Date:   Thu, 24 Sep 2020 13:12:29 +0000
Message-ID: <73a2b5443a70443a9b10687c5f28120b@huawei.com>
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

> Fix various comments including wrong function names, global variable name and so on.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  block/bio.c          | 2 +-
>  block/blk-cgroup.c   | 2 +-
>  block/blk-mq.c       | 4 ++--
>  block/blk-throttle.c | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
