Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7A228CF31
	for <lists+linux-block@lfdr.de>; Tue, 13 Oct 2020 15:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgJMNcw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 13 Oct 2020 09:32:52 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2976 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728487AbgJMNcv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 09:32:51 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 2B1DE986D246418F2178;
        Tue, 13 Oct 2020 14:32:47 +0100 (IST)
Received: from [127.0.0.1] (10.47.6.6) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 13 Oct
 2020 14:32:46 +0100
Subject: Re: [PATCH v2 06/24] blk-mq: docs: add kernel-doc description for a
 new struct member
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
 <408fac4661f48a7c0e937251880f51ae503d137b.1602590106.git.mchehab+huawei@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <38c2a5f6-74d7-b1fb-51d7-ecfe29880a2f@huawei.com>
Date:   Tue, 13 Oct 2020 14:29:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <408fac4661f48a7c0e937251880f51ae503d137b.1602590106.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.6.6]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 13/10/2020 13:14, Mauro Carvalho Chehab wrote:
> As reported by kernel-doc:
> 	./include/linux/blk-mq.h:267: warning: Function parameter or member 'active_queues_shared_sbitmap' not described in 'blk_mq_tag_set'
> 
> There is now a new member for struct blk_mq_tag_set. Add a
> description for it, based on the commit that introduced it.
> 
> Fixes: f1b49fdc1c64 ("blk-mq: Record active_queues_shared_sbitmap per tag_set for when using shared sbitmap")
> Signed-off-by: Mauro Carvalho Chehab<mchehab+huawei@kernel.org>

Reviewed-by: John Garry <john.garry@huawei.com>
