Return-Path: <linux-block+bounces-19411-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F7BA83E25
	for <lists+linux-block@lfdr.de>; Thu, 10 Apr 2025 11:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68DE7169DC7
	for <lists+linux-block@lfdr.de>; Thu, 10 Apr 2025 09:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004FF202F9A;
	Thu, 10 Apr 2025 09:11:17 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100AC20766D
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 09:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744276276; cv=none; b=IbrdZLdbr+SdImbHLDKagCps9yIuv+Xb6+nsoQIfUdeSI0JlX2iF7YJyt0qH4VXkxHK5dttfUyU859loefG0BTSDMa0U+5QBz/0cURWIfwNH1Dt5FRHv81bO6BtmPm0PLMz0cUGY0LeJwFcyCm46XPzYMhXDom0cJv1lnUXBi+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744276276; c=relaxed/simple;
	bh=lpcBAAAMtXAvRF5z9Pseb8tS/jIcMnWsdTKRQaycIm0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uxxiYVbommaBhJmW1yRE6PBcpfgS2+X3TGjzRRuPraB/mdIX3m2h5bTEsOYKuCNvxiuGIdC0g8ghVLJ9LqrQqwmCO0p9PiIfkk0CcvfGbC+ydcyJJ5EnfLovit2rzHu5zJzgBNVFOTaoQG1/3dRk4Tp3031qh1zmAHpo/XgMfWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZYDYw1tH9z4f3m74
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 17:10:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4988D1A1362
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 17:11:09 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgB3218pi_dnH984JA--.39933S3;
	Thu, 10 Apr 2025 17:11:06 +0800 (CST)
Subject: Re: [PATCH] block: Export __blk_flush_plug to modules
To: LongPing Wei <weilongping@oppo.com>, Christoph Hellwig <hch@infradead.org>
Cc: snitzer@kernel.org, mpatocka@redhat.com, axboe@kernel.dk,
 dm-devel@lists.linux.dev, linux-block@vger.kernel.org, guoweichao@oppo.com,
 sfr@canb.auug.org.au, "yukuai (C)" <yukuai3@huawei.com>
References: <20250410030903.3393536-1-weilongping@oppo.com>
 <Z_d07I1b71zQYS0M@infradead.org>
 <a3523b3c-4c89-44c5-867e-75378ebb652a@oppo.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <21aa6521-e814-d3f9-2ba7-eb511e4ae8d6@huaweicloud.com>
Date: Thu, 10 Apr 2025 17:11:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a3523b3c-4c89-44c5-867e-75378ebb652a@oppo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3218pi_dnH984JA--.39933S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFW8GF1kWr13XFy8Kw1UGFg_yoW8AFW5pw
	48Ga1j9r4vyryvkan5tw13ZFyagws3XFyYga45JrZ7u3yj9rn5JrWakrZagrWUWwn5Kay7
	Ka43W34UXa48GrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/04/10 16:06, LongPing Wei 写道:
> On 2025/4/10 15:36, Christoph Hellwig wrote:
>> On Thu, Apr 10, 2025 at 11:09:04AM +0800, LongPing Wei wrote:
>>> Fix the compile error when dm-bufio is built as a module.
>>>
>>> 1. dm-bufio module use blk_flush_plug();
>>> 2. blk_flush_plug is an inline function and it calls __blk_flush_plug.
>>
>> Then don't call blk_flush_plug from dm-bufio, as drivers should not
>> micro-manage plug flushing.
>>
>> Note that at least in current upstream and linux-next dm-bufio does
>> not actually call blk_flush_plug, so I'm not sure where your
>> report comes from.
>>
> Hi, Christoph
> 
> Stephen reported that a compile error happened when he tried merging
> device-mapper tree.
> 
>> Hi all,
>>
>> After merging the device-mapper tree, today's linux-next build (powerpc
>> ppc64_defconfig) failed like this:
>>
>> ERROR: modpost: "__blk_flush_plug" [drivers/md/dm-bufio.ko] undefined!
>>
>> Caused by commit
>>
>>   713ff5c782f5 ("dm-bufio: improve the performance of 
>> __dm_bufio_prefetch")
>>
>> I have used the device-mapper tree from next-20250409 for today.
> 
> 
> More details are here.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=for-next&id=713ff5c782f5a497bd0e93ca19607daf5bf34005 

So, this patch has compile problem, I think it should be removed from
dm tree.

BTW, I don't get it from commit message, why you need to flush plug when
bio is not contiguous. Other than bio merge, plug is also benefit from
batch submitting:

__blk_mq_flush_plug_list
  q->mq_ops->queue_rqs(&plug->mq_list)

Thanks,
Kuai

> 
> 
> https://lore.kernel.org/dm-devel/66bf8a8e-0a7d-47b8-9676-dc2e8c596bdb@oppo.com/T/#t 
> 
> 
> Thanks
> 
> LongPing
> 
> .
> 


