Return-Path: <linux-block+bounces-2838-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C59847D1D
	for <lists+linux-block@lfdr.de>; Sat,  3 Feb 2024 00:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45131C22B9B
	for <lists+linux-block@lfdr.de>; Fri,  2 Feb 2024 23:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9D683A07;
	Fri,  2 Feb 2024 23:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="2WTVHPKM"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4091412C7EF
	for <linux-block@vger.kernel.org>; Fri,  2 Feb 2024 23:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706916011; cv=none; b=aYch2CfDeudEbIOmvYUGSgO91hiRTCJlv3TyQ8/Ow4AGJBeqo4rPv+RpEm3w4nwHLGanG1EuDSsRReiM4nvq+xdkxgqocnY9PlMDqKn/P+RhRUvewaueOrvJmK747TNgo0KCDMIXK3IWzxIiTr3XFyx5eBn8HvO1kavbN0LBRSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706916011; c=relaxed/simple;
	bh=m5imoujHieSlll/R7/80QfAbBBvYLeN0YYCg+yUx2g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JX/ALLgCYyneKvBh2Z29e6iLTU33oFGBjuHqQx/PD3YPykKHFJvaSZ94SeeHOmzxT1WMvk2R97VATnLkZqBlQODbAihcILEUu1N3YMMIBxtTskHcWIddAWnr0RkYTRfLyquJZ8VZ10hB//ASfrm9E/2IJ20a+f8tcXfUSJ9DlD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=2WTVHPKM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40fccd09082so3299065e9.2
        for <linux-block@vger.kernel.org>; Fri, 02 Feb 2024 15:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1706916007; x=1707520807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PJW2NX3ivu7ZuQyATZOTjV2C0gtiDM/KDxHGq8DXoLw=;
        b=2WTVHPKMFWHUDYNVs89UxgWJd8XV5cfI/DTeZuELcsIAh4iu8UGUU+l7qJWmBI0XHO
         eIoJPPbg4pfJUB+b5RJwdZVj7R2zGu3yOkFRgx++Hp4AhTrb9iVnjpOjT3NUbXHvSRei
         7YS8OAdVpjKNNqNahyw6T4FW5GRFW4hpZFsiyPsI7dlu7kgMTn4gnxz+8hCA/kMneQp2
         T9X3kP8MPaw2vxjmHHae7DxvnP54iPoBsvodkG0Pw0t4zAp8Yanl9k8X+NZQIetd+ohs
         rRQMGGtXw+leYWhxVSnbUk638JZODtI8/CK447+f/Vf0+pF2oEyWP6TI4oA4BUhD4M2F
         iEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706916007; x=1707520807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJW2NX3ivu7ZuQyATZOTjV2C0gtiDM/KDxHGq8DXoLw=;
        b=IzHPP6As6Nkc6hhYqwxSms+enegoVYTNvXzyYc2q9lNuE7gs4AVLOXYjhDYob/CNzL
         N5wEOpzZdgrlBsP4vxirCjbMAYj9FTL0026JuetbNZVHUfC/P7Vdb8vLON60ccXiK8OL
         gnE4vnocSi5xq4fO1KQgceU6WN8UzBP4Q8qPy46A3Xf6xwPtdxmfqIXJkiSjVvOnQkXC
         QHD0i66asDK16UiOhqjddyWc7DHMtRjQ0EL2xcD7EQw/zX5yO8ARJvCenlzpNebT1q3P
         QV1XrYV1mlkjLahSlXd7m2eWE9yDoEFHe2JJZUgTnI/lV3t41AfexHjhgyrMHbyYp0xk
         HpHw==
X-Gm-Message-State: AOJu0Yxc0erSEyC22FSzBgVDBmipVfU8649Z2nvk/jjXKyOvojxrL8iS
	8shznFvziDQG4AUkxNCQ34v5brdw0bcle1AaBpGssAsn7YucdWZY0B84B7NmLyyuch6HxZxtu9C
	R
X-Google-Smtp-Source: AGHT+IEu8Izjydi9eb85F8z/WH8tfPLnzf+7Da3n3SJ54CPzPB8tvkvkBpNlYcGRvMtzaE1riep2WQ==
X-Received: by 2002:a05:600c:4f8f:b0:40e:f3ee:5622 with SMTP id n15-20020a05600c4f8f00b0040ef3ee5622mr2405674wmq.11.1706916007402;
        Fri, 02 Feb 2024 15:20:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUO5q0IhJ/o9kDFiSByTxgoMWZSpqbvgXqwRBcJEJ4y8QUOdW1FMngc6vX2Fxwdlj9VyyMfeUYT+AVbPRRyxC8Zn059V1fVZMrBhSMyBPxigHk/+gWxtQhNbFJig4z9UdCt5C6TmC1QlVWYgz+qg4LMPUdX2ho+11URW795IslkLrSa9wddfsRzqNyMOZTqA/bJBGgX6dwnZGPpqO/BEsphlTqx7W0ovinJa8nXVNrU/HBdYztld1rJ/DAhK6l0GBK2RUPHYRn/AUf5ivI9H/WqtGZI6bHxYu+R1Wd9+ob2XQNPVFMQnKKYV/J3TXi19Ev2FaRTltlp
Received: from airbuntu ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c1d9500b0040faf410320sm1160758wms.20.2024.02.02.15.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 15:20:06 -0800 (PST)
Date: Fri, 2 Feb 2024 23:20:05 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, Wei Wang <wvw@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] block/blk-mq: Don't complete locally if capacities are
 different
Message-ID: <20240202232005.bch5ibytkwbz4njg@airbuntu>
References: <20240122224220.1206234-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240122224220.1206234-1-qyousef@layalina.io>

On 01/22/24 22:42, Qais Yousef wrote:
> The logic in blk_mq_complete_need_ipi() assumes SMP systems where all
> CPUs have equal capacities and only LLC cache can make a different on
> perceived performance. But this assumption falls apart on HMP systems
> where LLC is shared, but the CPUs have different capacities. Staying
> local then can have a big performance impact if the IO request was done
> from a CPU with higher capacity but the interrupt is serviced on a lower
> capacity CPU.
> 
> Introduce new cpus_gte_capacity() function to enable do the additional
> check.

As I was preparing to send a new version. I thought it is worth noting here
that I initially had cpus_equal_capacity() to check if the performance on the
two cpus is equal, but then opted to change it to >= so that we favour perf.

But now I am having 2nd thoughts again.

If the interrupt was on a bigger core but the request comes from a little core,
is it better to move it to little core (which can save power) to match the
requester, or better honour the fact that someone has put the interrupt on
a bigger core and maybe they prefer to keep requests there by default?

I am leaning back towards cpus_equal_capacity() so we match the performance
level the requester is running at. irqbalancer can end up shuffling interrupts
potentially and I believe it is better for the scheduler to handle the
performance level the requester should be running at, and then here our job
should be to match that level without making more assumptions.


--
Qais Yousef

> 
> Without the patch I see the BLOCK softirq always running on little cores
> (where the hardirq is serviced). With it I can see it running on all
> cores.
> 
> This was noticed after the topology change [1] where now on a big.LITTLE
> we truly get that the LLC is shared between all cores where as in the
> past it was being misrepresented for historical reasons. The logic
> exposed a missing dependency on capacities for such systems where there
> can be a big performance difference between the CPUs.
> 
> This of course introduced a noticeable change in behavior depending on
> how the topology is presented. Leading to regressions in some workloads
> as the performance of the BLOCK softirq on littles can be noticeably
> worse.
> 
> [1] https://lpc.events/event/16/contributions/1342/attachments/962/1883/LPC-2022-Android-MC-Phantom-Domains.pdf
> 
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>  block/blk-mq.c                 | 5 +++--
>  include/linux/sched/topology.h | 6 ++++++
>  kernel/sched/core.c            | 8 ++++++++
>  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ac18f802c027..9b2d278a7ae7 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1163,10 +1163,11 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
>  	if (force_irqthreads())
>  		return false;
>  
> -	/* same CPU or cache domain?  Complete locally */
> +	/* same CPU or cache domain and capacity?  Complete locally */
>  	if (cpu == rq->mq_ctx->cpu ||
>  	    (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
> -	     cpus_share_cache(cpu, rq->mq_ctx->cpu)))
> +	     cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
> +	     cpus_gte_capacity(cpu, rq->mq_ctx->cpu)))
>  		return false;
>  
>  	/* don't try to IPI to an offline CPU */
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index a6e04b4a21d7..31cef5780ba4 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -176,6 +176,7 @@ extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>  cpumask_var_t *alloc_sched_domains(unsigned int ndoms);
>  void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms);
>  
> +bool cpus_gte_capacity(int this_cpu, int that_cpu);
>  bool cpus_share_cache(int this_cpu, int that_cpu);
>  bool cpus_share_resources(int this_cpu, int that_cpu);
>  
> @@ -226,6 +227,11 @@ partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>  {
>  }
>  
> +static inline bool cpus_gte_capacity(int this_cpu, int that_cpu)
> +{
> +	return true;
> +}
> +
>  static inline bool cpus_share_cache(int this_cpu, int that_cpu)
>  {
>  	return true;
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index db4be4921e7f..db5ab4b3cee7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3954,6 +3954,14 @@ void wake_up_if_idle(int cpu)
>  	}
>  }
>  
> +bool cpus_gte_capacity(int this_cpu, int that_cpu)
> +{
> +	if (this_cpu == that_cpu)
> +		return true;
> +
> +	return arch_scale_cpu_capacity(this_cpu) >= arch_scale_cpu_capacity(that_cpu);
> +}
> +
>  bool cpus_share_cache(int this_cpu, int that_cpu)
>  {
>  	if (this_cpu == that_cpu)
> -- 
> 2.34.1
> 

