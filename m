Return-Path: <linux-block+bounces-12068-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0FE98E1DE
	for <lists+linux-block@lfdr.de>; Wed,  2 Oct 2024 19:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8E21F24246
	for <lists+linux-block@lfdr.de>; Wed,  2 Oct 2024 17:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C4228FF;
	Wed,  2 Oct 2024 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLV8EI87"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83081D1314
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 17:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727891402; cv=none; b=iQFNiTeh+kzkBqPUst2Tcgx56j+7WZzrT0Hv+FEJ0z8fa0Rvr8u5OOeK7bHEvnOpTVVPWklfWDypVIyggBt0M3LowxFvBvi2ipGFhVinkci3S+93NReJUJGEbFADHeF78GYlvf77W64Haokh+nZyOTSEKsJMnVEdCojfi9gLEP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727891402; c=relaxed/simple;
	bh=G8eUrZlIVG7TYV7RHOBVqOqjuGM0Hl73kKf4GgFiZiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHX3eEzMuePy2DgflHvOk7rsF0meDgx6EJlhYBztcPmlJiqes+2lh7RBAnt+9gFHGJFlmiFFRvV81IFyoJQ10wHCBgsh20JDdsdQPcbKKJYK5y8iRKXpBori7Jivapck1nfdrFBbcyXQDFDg0d07V/nUEE7MTqhi3lbQCzAz46o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JLV8EI87; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727891399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MwkeKst3DWJ0DI2DqyiFfxlozC5yjrQjEyPgNOk2nKM=;
	b=JLV8EI87FQPI1C7/OXqYO4anKc604V8w60SfG1UTnS7d3C6HSU8upCMJHh6J+KU8NOcP4L
	A3PjeEZsIWQ9yfKpZDmi0rNbHd3ZzbLOOhrbIGXJU4wSjt+hbB7XOGsPM3ci6IrVxwyLuS
	vagkDGeUYpmiS9w5hGTxvhZwceHDhVw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-YkkoW06CPkOED__BejJ5cA-1; Wed,
 02 Oct 2024 13:49:55 -0400
X-MC-Unique: YkkoW06CPkOED__BejJ5cA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7CCF71955D97;
	Wed,  2 Oct 2024 17:49:52 +0000 (UTC)
Received: from [10.2.16.89] (unknown [10.2.16.89])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CFCA9195605F;
	Wed,  2 Oct 2024 17:49:49 +0000 (UTC)
Message-ID: <0a8fe25b-9b72-496d-b1fc-e8f773151e0a@redhat.com>
Date: Wed, 2 Oct 2024 13:49:48 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk_iocost: remove some duplicate irq disable/enables
To: Dan Carpenter <dan.carpenter@linaro.org>, Yu Kuai <yukuai3@huawei.com>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <Zv0kudA9xyGdaA4g@stanley.mountain>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <Zv0kudA9xyGdaA4g@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 10/2/24 06:47, Dan Carpenter wrote:
> These are called from blkcg_print_blkgs() which already disables IRQs so
> disabling it again is wrong.  It means that IRQs will be enabled slightly
> earlier than intended, however, so far as I can see, this bug is harmless.
>
> Fixes: 35198e323001 ("blk-iocost: read params inside lock in sysfs apis")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
> v2: Fix typo in the subject
>
>   block/blk-iocost.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/block/blk-iocost.c b/block/blk-iocost.c
> index 9dc9323f84ac..384aa15e8260 100644
> --- a/block/blk-iocost.c
> +++ b/block/blk-iocost.c
> @@ -3166,7 +3166,7 @@ static u64 ioc_qos_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
>   	if (!dname)
>   		return 0;
>   
> -	spin_lock_irq(&ioc->lock);
> +	spin_lock(&ioc->lock);
>   	seq_printf(sf, "%s enable=%d ctrl=%s rpct=%u.%02u rlat=%u wpct=%u.%02u wlat=%u min=%u.%02u max=%u.%02u\n",
>   		   dname, ioc->enabled, ioc->user_qos_params ? "user" : "auto",
>   		   ioc->params.qos[QOS_RPPM] / 10000,
> @@ -3179,7 +3179,7 @@ static u64 ioc_qos_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
>   		   ioc->params.qos[QOS_MIN] % 10000 / 100,
>   		   ioc->params.qos[QOS_MAX] / 10000,
>   		   ioc->params.qos[QOS_MAX] % 10000 / 100);
> -	spin_unlock_irq(&ioc->lock);
> +	spin_unlock(&ioc->lock);
>   	return 0;
>   }
>   
> @@ -3366,14 +3366,14 @@ static u64 ioc_cost_model_prfill(struct seq_file *sf,
>   	if (!dname)
>   		return 0;
>   
> -	spin_lock_irq(&ioc->lock);
> +	spin_lock(&ioc->lock);
>   	seq_printf(sf, "%s ctrl=%s model=linear "
>   		   "rbps=%llu rseqiops=%llu rrandiops=%llu "
>   		   "wbps=%llu wseqiops=%llu wrandiops=%llu\n",
>   		   dname, ioc->user_cost_model ? "user" : "auto",
>   		   u[I_LCOEF_RBPS], u[I_LCOEF_RSEQIOPS], u[I_LCOEF_RRANDIOPS],
>   		   u[I_LCOEF_WBPS], u[I_LCOEF_WSEQIOPS], u[I_LCOEF_WRANDIOPS]);
> -	spin_unlock_irq(&ioc->lock);
> +	spin_unlock(&ioc->lock);
>   	return 0;
>   }
>   

I would suggest adding a "lockdep_assert_irqs_disabled()" call before 
spin_lock() to confirm that irq is indeed disabled just in case the 
callers are changed in the future.

Cheers,
Longman


