Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D46F7523B2
	for <lists+linux-block@lfdr.de>; Thu, 13 Jul 2023 15:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbjGMN06 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 13 Jul 2023 09:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbjGMN0k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jul 2023 09:26:40 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9870272C
        for <linux-block@vger.kernel.org>; Thu, 13 Jul 2023 06:26:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R1vyB3666z4f3nqs
        for <linux-block@vger.kernel.org>; Thu, 13 Jul 2023 21:06:42 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgBnhzHh9q9kbfaKNA--.19920S2;
        Thu, 13 Jul 2023 21:06:44 +0800 (CST)
Subject: Re: [PATCH v3] virtio_pmem: add the missing REQ_OP_WRITE for flush
 bio
To:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
        virtualization@lists.linux-foundation.org, houtao1@huawei.com,
        Vishal Verma <vishal.l.verma@intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <ZJL3+E5P+Yw5jDKy@infradead.org>
 <20230625022633.2753877-1-houtao@huaweicloud.com>
 <CAM9Jb+hrspvxXi87buwkUmhHczaC6qian36OxcMkXx=6pseOrQ@mail.gmail.com>
 <CAM9Jb+g5rrvmw8xCcwe3REK4x=RymrcqQ8cZavwWoWu7BH+8wA@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <7a2c321b-df98-618f-54d7-e93b7f4ebed6@huaweicloud.com>
Date:   Thu, 13 Jul 2023 21:06:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAM9Jb+g5rrvmw8xCcwe3REK4x=RymrcqQ8cZavwWoWu7BH+8wA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgBnhzHh9q9kbfaKNA--.19920S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYx7kC6x804xWl14x267AKxVW8JVW5JwAF
        c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
        c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
        3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
        VFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Pankaj,

On 7/13/2023 4:23 PM, Pankaj Gupta wrote:
> +Cc Vishal,
>
>>> Fixes: b4a6bb3a67aa ("block: add a sanity check for non-write flush/fua bios")
>>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> With 6.3+ stable Cc, Feel free to add:
> Hi Dan, Vishal,
>
> Do you have any suggestion on this patch? Or can we queue this please?
>
> Hi Hou,
>
> Could you please send a new version with Cc stable or as per any
> suggestions from maintainers.
Will add Cc stable for v6.3 in v4.
>
> Thanks,
> Pankaj
> .

