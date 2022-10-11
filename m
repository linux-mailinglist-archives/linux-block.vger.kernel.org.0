Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD53C5FADFA
	for <lists+linux-block@lfdr.de>; Tue, 11 Oct 2022 10:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJKIGT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 11 Oct 2022 04:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJKIGS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Oct 2022 04:06:18 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ACC691B8;
        Tue, 11 Oct 2022 01:06:16 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MmpGB6TZFzl1rR;
        Tue, 11 Oct 2022 16:04:18 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgAHB8n0I0VjWTtiAA--.25173S3;
        Tue, 11 Oct 2022 16:06:14 +0800 (CST)
Subject: Re: [PATCH v4 0/6] blk-wbt: simple improvment to enable wbt correctly
To:     Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@infradead.org,
        ebiggers@kernel.org, paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20220930031906.4164306-1-yukuai1@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8a5333ea-361b-a9eb-2149-01f218260c0c@huaweicloud.com>
Date:   Tue, 11 Oct 2022 16:06:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220930031906.4164306-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHB8n0I0VjWTtiAA--.25173S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1UKFykWF1UuFyUCw43Awb_yoWDZrcEgF
        W0ka95W3WDXa1FkF9rJF10qFWj9rs5Zr15XasrtrZ0yry3JFyUtw4ktrWUua98Zan3C3Z8
        A3yUu3yfZr12qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3
        Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VU1a9aPUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

friendly ping ...

在 2022/09/30 11:19, Yu Kuai 写道:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> changes in v4:
>   - remove patch 3 from v3
>   - add patch 2,3 in v4
> 
> changes in v3:
>   - instead of check elevator name, add a flag in elevator_queue, as
>   suggested by Christoph.
>   - add patch 3 and patch 5 to this patchset.
> 
> changes in v2:
>   - define new api if wbt config is not enabled in patch 1.
> 
> Yu Kuai (6):
>    elevator: remove redundant code in elv_unregister_queue()
>    blk-wbt: remove unnecessary check in wbt_enable_default()
>    blk-wbt: make enable_state more accurate
>    blk-wbt: don't show valid wbt_lat_usec in sysfs while wbt is disabled
>    elevator: add new field flags in struct elevator_queue
>    blk-wbt: don't enable throttling if default elevator is bfq
> 
>   block/bfq-iosched.c |  2 ++
>   block/blk-sysfs.c   |  6 +++++-
>   block/blk-wbt.c     | 26 ++++++++++++++++++++++----
>   block/blk-wbt.h     | 17 ++++++++++++-----
>   block/elevator.c    |  8 ++------
>   block/elevator.h    |  5 ++++-
>   6 files changed, 47 insertions(+), 17 deletions(-)
> 

