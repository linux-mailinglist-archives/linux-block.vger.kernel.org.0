Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EB82C2917
	for <lists+linux-block@lfdr.de>; Tue, 24 Nov 2020 15:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732909AbgKXOMP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 Nov 2020 09:12:15 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2146 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgKXOMP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Nov 2020 09:12:15 -0500
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CgQsK14sSz67H8y;
        Tue, 24 Nov 2020 22:10:29 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 24 Nov 2020 15:12:12 +0100
Received: from [10.210.169.36] (10.210.169.36) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 24 Nov 2020 14:12:11 +0000
Subject: Re: [PATCH v2 1/4] sbitmap: optimise sbitmap_deferred_clear()
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     <linux-kernel@vger.kernel.org>
References: <cover.1606058975.git.asml.silence@gmail.com>
 <ddfa166d93f38e812751b6ff986fd5403b7893b7.1606058975.git.asml.silence@gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e71a58b5-1315-d655-4e1e-cd7529acfd6b@huawei.com>
Date:   Tue, 24 Nov 2020 14:11:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <ddfa166d93f38e812751b6ff986fd5403b7893b7.1606058975.git.asml.silence@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.169.36]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 22/11/2020 15:35, Pavel Begunkov wrote:
> Because of spinlocks and atomics sbitmap_deferred_clear() have to reload
> &sb->map[index] on each access even though the map address won't change.
> Pass in sbitmap_word instead of {sb, index}, so it's cached in a
> variable. It also improves code generation of
> sbitmap_find_bit_in_index().
> 
> Signed-off-by: Pavel Begunkov<asml.silence@gmail.com>

Looks ok, even though a bit odd not be passing a struct sbitmap * now

Reviewed-by: John Garry <john.garry@huawei.com>
