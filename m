Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E8F20DC50
	for <lists+linux-block@lfdr.de>; Mon, 29 Jun 2020 22:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgF2UOI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 29 Jun 2020 16:14:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36904 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726291AbgF2UOH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 16:14:07 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ABD5ECCB7585C2BB0B97;
        Mon, 29 Jun 2020 12:28:49 +0800 (CST)
Received: from [10.133.219.224] (10.133.219.224) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 29 Jun 2020 12:28:46 +0800
Subject: Re: [PATCH] virtio-blk: free vblk-vqs in error path of
 virtblk_probe()
To:     Jens Axboe <axboe@kernel.dk>
CC:     Stefano Garzarella <sgarzare@redhat.com>,
        <linux-block@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ming Lei <ming.lei@canonical.com>
References: <20200615041459.22477-1-houtao1@huawei.com>
 <20200615073219.eeydysnn3d3xkwzg@steredhat>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <92ff941c-c40a-2e59-3b97-d931e53cde11@huawei.com>
Date:   Mon, 29 Jun 2020 12:28:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20200615073219.eeydysnn3d3xkwzg@steredhat>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.224]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping ?

On 2020/6/15 15:32, Stefano Garzarella wrote:
> On Mon, Jun 15, 2020 at 12:14:59PM +0800, Hou Tao wrote:
>> Else there will be memory leak if alloc_disk() fails.
>>
>> Fixes: 6a27b656fc02 ("block: virtio-blk: support multi virt queues per virtio-blk device")
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  drivers/block/virtio_blk.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> index 9d21bf0f155e..980df853ee49 100644
>> --- a/drivers/block/virtio_blk.c
>> +++ b/drivers/block/virtio_blk.c
>> @@ -878,6 +878,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>>  	put_disk(vblk->disk);
>>  out_free_vq:
>>  	vdev->config->del_vqs(vdev);
>> +	kfree(vblk->vqs);
>>  out_free_vblk:
>>  	kfree(vblk);
>>  out_free_index:
>> -- 
>> 2.25.0.4.g0ad7144999
>>
> 
> The patch LGTM:
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> 
