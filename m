Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0E0672E63
	for <lists+linux-block@lfdr.de>; Thu, 19 Jan 2023 02:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjASBr4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 18 Jan 2023 20:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjASBpm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2023 20:45:42 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BE96CCD1;
        Wed, 18 Jan 2023 17:40:34 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Ny5166LGDz4f3v6d;
        Thu, 19 Jan 2023 09:40:26 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP1 (Coremail) with SMTP id cCh0CgCXAy6Ln8hj1mNwBw--.27187S2;
        Thu, 19 Jan 2023 09:40:29 +0800 (CST)
Subject: Re: [PATCH v4 07/14] blk-mq: make blk_mq_commit_rqs a general
 function for all commits
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com, jack@suse.cz
References: <20230118093726.3939160-1-shikemeng@huaweicloud.com>
 <20230118093726.3939160-7-shikemeng@huaweicloud.com>
 <20230118173745.GC12399@lst.de>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <f4dea0fc-5fcf-ceec-84d5-468b25c947ff@huaweicloud.com>
Date:   Thu, 19 Jan 2023 09:40:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230118173745.GC12399@lst.de>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: cCh0CgCXAy6Ln8hj1mNwBw--.27187S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFyDCr1xXr45JF1DJryxZrb_yoWkXFgE9F
        yakrykWw4DWws2kws2kF43XFW8Ka4kXF98tF4DtFyrGrykJrZ5GFyDXFn8Zay7Gw42yF1f
        AF9xZ3WUCrnFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
        1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



on 1/19/2023 1:37 AM, Christoph Hellwig wrote:
> On Wed, Jan 18, 2023 at 05:37:19PM +0800, Kemeng Shi wrote:
>> +/*
>> + * blk_mq_commit_rqs will notify driver using bd->last that there is no
>> + * more requests. (See comment in struct blk_mq_ops for commit_rqs for
>> + * details)
>> + * Attention, we should explicitly call this in unusual cases:
>> + *  1) did not queue everything initially scheduled to queue
>> + *  2) the last attempt to queue a request failed
>> + */
>> +static void blk_mq_commit_rqs(struct blk_mq_hw_ctx *hctx, int queued,
>> +			      bool from_schedule)
> 
> Isn't from_schedule always false here as well now?
Hi Christoph ,
Yes, it's always false now. As blk_mq_commit_rqs is a general function
for all commits now, I keep the from_schedule for commits where
from_schedule maybe true in future. We can remove from_schedule now
and add it back when from_schedule is indeed needed. Both way is
acceptable for me. Please let me know which way do you prefer and I
will send a new version if needed.
Thanks.
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 

-- 
Best wishes
Kemeng Shi

