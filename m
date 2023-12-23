Return-Path: <linux-block+bounces-1434-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE3C81D2BF
	for <lists+linux-block@lfdr.de>; Sat, 23 Dec 2023 07:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480321F2300F
	for <lists+linux-block@lfdr.de>; Sat, 23 Dec 2023 06:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1584E15BD;
	Sat, 23 Dec 2023 06:46:42 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C316AA0;
	Sat, 23 Dec 2023 06:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4SxvpL47jZz4f3kFf;
	Sat, 23 Dec 2023 14:46:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 701731A06EC;
	Sat, 23 Dec 2023 14:46:37 +0800 (CST)
Received: from [10.174.179.247] (unknown [10.174.179.247])
	by APP2 (Coremail) with SMTP id Syh0CgD3m0pJgoZlHQMXEg--.29897S3;
	Sat, 23 Dec 2023 14:46:35 +0800 (CST)
Message-ID: <914de4d4-0191-d812-778e-fc56b5898dc9@huaweicloud.com>
Date: Sat, 23 Dec 2023 14:46:33 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 0/6] badblocks improvement for multiple bad block
 ranges
To: Ira Weiny <ira.weiny@intel.com>, Coly Li <colyli@suse.de>,
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-block@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
 Geliang Tang <geliang.tang@suse.com>, Hannes Reinecke <hare@suse.de>,
 Jens Axboe <axboe@kernel.dk>, NeilBrown <neilb@suse.de>,
 Richard Fan <richard.fan@suse.com>, Vishal L Verma
 <vishal.l.verma@intel.com>, Wols Lists <antlists@youngman.org.uk>,
 Xiao Ni <xni@redhat.com>
References: <20230811170513.2300-1-colyli@suse.de>
 <6585dd1299942_ab808294c4@iweiny-mobl.notmuch>
From: Li Nan <linan666@huaweicloud.com>
In-Reply-To: <6585dd1299942_ab808294c4@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD3m0pJgoZlHQMXEg--.29897S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYQ7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY
	6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr
	0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxG
	rwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
	04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFfHjUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

Hi, Ira

在 2023/12/23 3:01, Ira Weiny 写道:

> 
> Just in case I missed anyone on this original thread I've found issues
> with this series which I emailed Coly about here:
> 
> https://lore.kernel.org/all/6585d5fda5183_9f731294b9@iweiny-mobl.notmuch/
> 
> Ira
> 


I have also noticed this issue recently and try to fix it in:

https://lore.kernel.org/linux-block/20231223063728.3229446-4-linan666@huaweicloud.com/T/#u

-- 
Thanks,
Nan


