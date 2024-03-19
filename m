Return-Path: <linux-block+bounces-4710-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC3687F503
	for <lists+linux-block@lfdr.de>; Tue, 19 Mar 2024 02:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2801C2154F
	for <lists+linux-block@lfdr.de>; Tue, 19 Mar 2024 01:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20B164CC8;
	Tue, 19 Mar 2024 01:36:19 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4F4626CD;
	Tue, 19 Mar 2024 01:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710812179; cv=none; b=aUkUDyslrixPSdh1xJusZbjplTG5HNHZWsAcMpAuIl2G/tn9r4yQTq/O5pRQK7MSsmjcdC0J9/+QocFU1XyV8aklnPofx9S9Bnkaj7bWF3XyUE28X+sP1+qYi0j00EoTJtnRWXJj6TIpr/Q1HnH3t2La/UpA2VefIhSfZF29d/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710812179; c=relaxed/simple;
	bh=GzEBhKZ4LIu43FoyVX7+dAaGHt5sdgp1AOcuREBzOt0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=opGO0HTUWGQ21sSOcPAJlcz2UBuIlGG0u1Ya/sqYuKpKCaBd9oR3XIu3fjyHmH2PBBN87MxNvKDT0BOWsLziXlQtd7uRrhEI0eagSFWK7DIzmQWCoyGwPbp3o7t95+rtQdg8OJVijTeuyuvJCQVvnKxGfca8Km0Q2+Ftz+Eu2Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TzDPc5kTGz4f3kJq;
	Tue, 19 Mar 2024 09:18:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9BE671A0172;
	Tue, 19 Mar 2024 09:18:32 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxDm5_hltIiNHQ--.22830S3;
	Tue, 19 Mar 2024 09:18:32 +0800 (CST)
Subject: Re: [RFC v4 linux-next 00/19] fs & block: remove bdev->bd_inode
To: Christian Brauner <brauner@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <1324ffb5-28b6-34fb-014e-3f57df714095@huawei.com>
 <20240315-assoziieren-hacken-b43f24f78970@brauner>
 <ac0eb132-c604-9761-bce5-69158e73f256@huaweicloud.com>
 <20240318-mythisch-pittoresk-1c57af743061@brauner>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c9bfba49-9611-c965-713c-1ef0b1e305ce@huaweicloud.com>
Date: Tue, 19 Mar 2024 09:18:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240318-mythisch-pittoresk-1c57af743061@brauner>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxDm5_hltIiNHQ--.22830S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr47CFW3WF13JFWrWF48Zwb_yoWfCrgEvw
	4akFykG34DZw1jqanxKrs0yrWDCFy3Jry5JryrJF13XayDXF98GF4kJw1kZwnxGa13KF1f
	Cr4qqFy5ZrWfGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
	VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/03/18 17:39, Christian Brauner 写道:
> On Sat, Mar 16, 2024 at 10:49:33AM +0800, Yu Kuai wrote:
>> Hi, Christian
>>
>> 在 2024/03/15 21:54, Christian Brauner 写道:
>>> On Fri, Mar 15, 2024 at 08:08:49PM +0800, Yu Kuai wrote:
>>>> Hi, Christian
>>>> Hi, Christoph
>>>> Hi, Jan
>>>>
>>>> Perhaps now is a good time to send a formal version of this set.
>>>> However, I'm not sure yet what branch should I rebase and send this set.
>>>> Should I send to the vfs tree?
>>>
>>> Nearly all of it is in fs/ so I'd say yes.
>>> .
>>
>> I see that you just create a new branch vfs.fixes, perhaps can I rebase
>> this set against this branch?
> 
> Please base it on vfs.super. I'll rebase it to v6.9-rc1 on Sunday.

Okay, I just see that vfs.super doesn't contain commit
1cdeac6da33f("btrfs: pass btrfs_device to btrfs_scratch_superblocks()"),
and you might need to fix the conflict at some point.

Thanks,
Kuai

> .
> 


