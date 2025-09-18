Return-Path: <linux-block+bounces-25740-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4198B2611B
	for <lists+linux-block@lfdr.de>; Thu, 14 Aug 2025 11:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D675E177663
	for <lists+linux-block@lfdr.de>; Thu, 14 Aug 2025 09:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAE62EFD8D;
	Thu, 14 Aug 2025 09:31:12 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39332ED169
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163872; cv=none; b=s8DENkatxjzjRxsD9mc2iwCMXJczdj9SyYod5+KfGDjZMmXk8ET0cEy8iLcjGXZSrL2rHIBxklxr3MiG2gZud+S/6Hr4Uhpqb2q/JgwZJZpzdligLYIiFcS4sO0V3eqJDHtFqJ+bLz0NVxUkyvC0wOlE4EWbah1O5isHfSlnR8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163872; c=relaxed/simple;
	bh=/D1T9Juvk+zTF3bnIR9Ml5gvvd8FOX5anFoofKX12t8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=O1S2LIbR6lZ9WJOy3nzA38pfSQJcvzdyDkapM74mYRgMmHtmIqyik/hcXSTB8yePg8tbo95NFQOgOkpy+EaNn+y3djdYgmGjsBklYILuIo/kQTkLIOKnQif3ytBPYx6O6uhikznkSMz4or3u/bFIO6HB9XEBmTnAiWnzyKLvdiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c2g3J5X2zzYQv0F
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 17:31:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 625001A1B8B
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 17:31:07 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgA3sxPZrJ1o3ZyTDg--.6291S3;
	Thu, 14 Aug 2025 17:31:07 +0800 (CST)
Subject: Re: Question on setting IO polling behavior and documentations
To: Teng Qin <palmtenor@gmail.com>, linux-block@vger.kernel.org, hch@lst.de
Cc: inux-nvme@lists.infradead.org, axboe@kernel.dk, sagi@grimberg.me,
 "yukuai (C)" <yukuai3@huawei.com>
References: <CAHumS0BE_28D47d3Ls5PJBONTzVUCA54QwTV5UhJdDhnfCEi4A@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <36eb61d6-971a-4177-aa62-75197460c33d@huaweicloud.com>
Date: Thu, 14 Aug 2025 17:31:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHumS0BE_28D47d3Ls5PJBONTzVUCA54QwTV5UhJdDhnfCEi4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3sxPZrJ1o3ZyTDg--.6291S3
X-Coremail-Antispam: 1UD129KBjvdXoWrJF4kCr45GFWrJFyrJw1UKFg_yoWxWrbEkr
	W2yFn7tayqyryIyr48CanxGryI9a18Gr17Ja4xJr1Yq34jyrWkCF9Iq3s8Zw1UW3y5Zry5
	Crn2qFWSkF93ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUwl
	ksUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/08/14 13:14, Teng Qin 写道:
> Moreover, the block layer documentation at
>    Documentation/ABI/stable/sysfs-block
> still documents the legacy behavior of the io_poll sysfs file. This is
> confusing for users trying to figure out reason of the failed or
> unexpected behavior after writing to the file and seeing the dmesg,
> particularly because there are many articles on the Internet describing
> the legacy behavior.
> If the maintainers agree, I can help update these documentations.

Feel free to update the documentations, AFAIK, there are some out of
date descriptions and it's welcome to fix them.

Thanks,
Kuai


