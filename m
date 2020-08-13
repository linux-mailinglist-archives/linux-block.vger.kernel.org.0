Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6132432F9
	for <lists+linux-block@lfdr.de>; Thu, 13 Aug 2020 05:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgHMDxV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 12 Aug 2020 23:53:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9276 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726334AbgHMDxU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Aug 2020 23:53:20 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 52D9EFD50C6FEB740FE2;
        Thu, 13 Aug 2020 11:53:18 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 13 Aug 2020
 11:53:15 +0800
Subject: Re: [PATCH 2/3] nvme-core: delete the dependency on blk status
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <kbusch@kernel.org>, <axboe@fb.com>, <sagi@grimberg.me>
References: <20200812081844.22224-1-lengchao@huawei.com>
 <20200812151035.GB29544@lst.de>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <98a09d55-2a2e-fc2e-83ec-429843461bd6@huawei.com>
Date:   Thu, 13 Aug 2020 11:53:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200812151035.GB29544@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/8/12 23:10, Christoph Hellwig wrote:
> On Wed, Aug 12, 2020 at 04:18:44PM +0800, Chao Leng wrote:
>> nvme should not depend on blk status, just need check nvme status.
>> Just need do translating nvme status to blk status for returning error.
> 
> While this doesn't look wrong it also doesn't save us a single
> instruction and actually adds more lines of code.  Do you have a good
> reason for this change?

If need retry, save nvme_error_status. Of course, it doesn't matter.
There's no logical change, just want nvme do not care blk status when
check retry.
It is ok to change or not.
