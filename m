Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3585614A4
	for <lists+linux-block@lfdr.de>; Thu, 30 Jun 2022 10:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbiF3ISs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 30 Jun 2022 04:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbiF3IRg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jun 2022 04:17:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD73E43396
        for <linux-block@vger.kernel.org>; Thu, 30 Jun 2022 01:16:22 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LYWNd4Mfdz67wM8;
        Thu, 30 Jun 2022 16:15:29 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 10:16:17 +0200
Received: from [10.126.174.156] (10.126.174.156) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 09:16:16 +0100
Message-ID: <da262064-3952-0ded-03e3-9c0246960603@huawei.com>
Date:   Thu, 30 Jun 2022 09:16:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 0/2] blk-cgroup: duplicated code refactor
To:     Jens Axboe <axboe@kernel.dk>, Jason Yan <yanaijie@huawei.com>,
        <tj@kernel.org>, <jack@suse.cz>, <hch@lst.de>
CC:     <linux-block@vger.kernel.org>
References: <20220629070917.3113016-1-yanaijie@huawei.com>
 <2ba24ea6-df8f-3afb-1526-bfb5916f2fcf@kernel.dk>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <2ba24ea6-df8f-3afb-1526-bfb5916f2fcf@kernel.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.174.156]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 29/06/2022 18:09, Jens Axboe wrote:
> Like I told Yu, stop using the huawei email until your MTA
> misconfiguration issues are fixed. They end up in spam and risk getting
> lost. This series was one of them.

Hi Jens,

Just wondering - are there any of my mails in your spam folder?

thanks,
John
