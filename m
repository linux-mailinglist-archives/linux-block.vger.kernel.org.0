Return-Path: <linux-block+bounces-17454-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 846D9A3F17E
	for <lists+linux-block@lfdr.de>; Fri, 21 Feb 2025 11:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6D319C2F0E
	for <lists+linux-block@lfdr.de>; Fri, 21 Feb 2025 10:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EC5204C39;
	Fri, 21 Feb 2025 10:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FK/STl0g"
X-Original-To: linux-block@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E42B204C37
	for <linux-block@vger.kernel.org>; Fri, 21 Feb 2025 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132593; cv=none; b=PR1zUyZbMrYNcSnYu0VhnAuvg8v65UPCl4UilpuwK6m/Ej3ttf6ggiA9YRm6XGq0ai8pW4AQGeAiRVVL/aOnK99Gr4q7JMsQPUO1RoX+DMRbdNW//9HUFH8s+qjrEFD9w65QB7DuYXwVgB/5pgpWLas79FjpS41uXTIEv3ovQoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132593; c=relaxed/simple;
	bh=rWGDeH3+byAdvrjidwsjwhpV85/U0HX+hboTidLOSps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4JMmhw3wUTeGSPmiIUhQOFZfdeNIt9mZxYxMY8LjMsMjd9yLixG/JedC3vTE75lsL2DupREd77qwK8ESegizGpd1UnhWIEKaskJ8dE1M7LRB0pMvJ3KtuNcmwUrAhGSJG2wGpJA3n0lOwOgY7EeCaVci6hfoSi4JgMD3wM8Fak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FK/STl0g; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f8ad5677-5fc9-468e-a888-8cd55c3a37d7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740132579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aW3oDRK1AYQyNuuKbR6ooYr7ixquPTNaTlNOorn591M=;
	b=FK/STl0gxI5X9bIYgx7V7pl3URExAJx6qPV+gBvyTFDa84QTTo4tM5nLqveDjStJAxPGYL
	Xe5WIK4t8mjvtwjAQGnJDFAFIR8SeX7Mf6fxKgaCBMc8SqE67H9kXj5+EuNDMja9AS7sTM
	TEZ0YWXFy3CE7OH2UXzkdJbr3impC6s=
Date: Fri, 21 Feb 2025 11:09:35 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 06/12] badblocks: fix the using of MAX_BADBLOCKS
To: Zheng Qixing <zhengqixing@huaweicloud.com>, axboe@kernel.dk,
 song@kernel.org, colyli@kernel.org, yukuai3@huawei.com,
 dan.j.williams@intel.com, vishal.l.verma@intel.com, dave.jiang@intel.com,
 ira.weiny@intel.com, dlemoal@kernel.org, kch@nvidia.com, hare@suse.de,
 zhengqixing@huawei.com, john.g.garry@oracle.com, geliang@kernel.org,
 xni@redhat.com, colyli@suse.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev, yi.zhang@huawei.com,
 yangerkun@huawei.com
References: <20250221081109.734170-1-zhengqixing@huaweicloud.com>
 <20250221081109.734170-7-zhengqixing@huaweicloud.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250221081109.734170-7-zhengqixing@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 21.02.25 09:11, Zheng Qixing wrote:
> From: Li Nan <linan122@huawei.com>
>
> The number of badblocks cannot exceed MAX_BADBLOCKS, but it should be
> allowed to equal MAX_BADBLOCKS.
>
> Fixes: aa511ff8218b ("badblocks: switch to the improved badblock handling code")
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>   block/badblocks.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/block/badblocks.c b/block/badblocks.c
> index a953d2e9417f..87267bae6836 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -700,7 +700,7 @@ static bool can_front_overwrite(struct badblocks *bb, int prev,
>   			*extra = 2;
>   	}
>   
> -	if ((bb->count + (*extra)) >= MAX_BADBLOCKS)
> +	if ((bb->count + (*extra)) > MAX_BADBLOCKS)
>   		return false;


In this commit,

commit c3c6a86e9efc5da5964260c322fe07feca6df782
Author: Coly Li <colyli@suse.de>
Date:   Sat Aug 12 01:05:08 2023 +0800

     badblocks: add helper routines for badblock ranges handling

     This patch adds several helper routines to improve badblock ranges
     handling. These helper routines will be used later in the improved
     version of badblocks_set()/badblocks_clear()/badblocks_check().

     - Helpers prev_by_hint() and prev_badblocks() are used to find the bad
       range from bad table which the searching range starts at or after.

The above is changed to MAX_BADBLOCKS. Thus, perhaps, the Fixes tag 
should include the above commit?

Except that, I am fine with this commit.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun


>   
>   	return true;
> @@ -1135,7 +1135,7 @@ static int _badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
>   		if ((BB_OFFSET(p[prev]) < bad.start) &&
>   		    (BB_END(p[prev]) > (bad.start + bad.len))) {
>   			/* Splitting */
> -			if ((bb->count + 1) < MAX_BADBLOCKS) {
> +			if ((bb->count + 1) <= MAX_BADBLOCKS) {
>   				len = front_splitting_clear(bb, prev, &bad);
>   				bb->count += 1;
>   				cleared++;

-- 
Best Regards,
Yanjun.Zhu


